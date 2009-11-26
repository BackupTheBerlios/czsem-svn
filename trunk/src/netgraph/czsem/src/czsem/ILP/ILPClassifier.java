package czsem.ILP;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.HashSet;
import java.util.Set;

import sun.net.www.protocol.http.NegotiateCallbackHandler;

import czsem.ILP.Serializer.Relation;
import czsem.ILP.WekaSerializer.Condition;
import czsem.utils.ProjectSetup;
import weka.classifiers.Classifier;
import weka.core.Attribute;
import weka.core.Capabilities;
import weka.core.Instance;
import weka.core.Instances;
import weka.core.Capabilities.Capability;

public abstract class ILPClassifier extends Classifier
{
	protected Relation [] crisp_relations;
	protected String [] class_values = null;
	
	protected ProjectSetup project_setup = new ProjectSetup();
	
	protected void initClassValues(Instances instances)
	{
		Attribute class_attr = instances.classAttribute(); 
		if (class_attr.isNumeric())
		{
			Set<String> vals_set = new HashSet<String>();

			for (int i=0; i<instances.numInstances(); i++)
			{
				vals_set.add(instances.instance(i).toString(class_attr));
			}
						
			class_values = vals_set.toArray(new String[0]);
		}
		else	//non-numeric values
		{
			class_values = new String [class_attr.numValues()];
			
			for (int a=0; a<class_values.length; a++)
			{
				class_values[a] = class_attr.value(a);
			}
		}		
	}
	
	
	public Capabilities getCapabilities()
	{
		Capabilities result = super.getCapabilities();
		result.disableAll();

		// attributes
		result.enable(Capability.NOMINAL_ATTRIBUTES);
		result.enable(Capability.NUMERIC_ATTRIBUTES);
		result.enable(Capability.DATE_ATTRIBUTES);
		result.enable(Capability.MISSING_VALUES);

		// class
		result.enable(Capability.NUMERIC_CLASS);
		result.enable(Capability.NOMINAL_CLASS);
		result.enable(Capability.MISSING_CLASS_VALUES);

		// instances
		result.setMinimumNumberInstances(3);

		return result;
	}	
	
	protected void learnRules() throws IOException, InterruptedException
	{
		ILPExec exec = new ILPExec(project_setup);
		exec.startILPProcess();
		exec.startReaderThreads();
		exec.induceAndWriteRules();
		exec.close();
	}

	protected void setupProject(String project_name) throws FileNotFoundException, UnsupportedEncodingException
	{
		project_setup = new ProjectSetup();
		project_setup.dir_for_projects = "C:\\workspace\\czsem\\src\\ILP\\serious_corss\\";
		project_setup.project_name = project_name;
		project_setup.init_project();		
	}

	public void buildClassifier(String project_name, Instances instances) throws Exception
	{
		setupProject(project_name);
		
		initClassValues(instances);
		
		serializeToILP(instances);
		
		learnRules();
	}

	protected void putCripsModes(Serializer backg_ser)
	{
		backg_ser.putCommentLn("--- C R I S P     M O D E S ---");
		for (int i = 0; i < crisp_relations.length; i++)
		{
			backg_ser.putBinaryMode(crisp_relations[i], "1", '+', '#');

			//			monot.: "*" instead of "1"
			//			ilp_ser.putBinaryMode(atl_ser, "*", '+', '#');			
		}
	}
	
	protected void serializeToILP(Instances instances) throws FileNotFoundException, UnsupportedEncodingException
	{
		WekaSerializer backg_ser = new WekaSerializer(project_setup.renderProjectFileName(".b"));
		WekaSerializer pos_ser = new WekaSerializer(project_setup.renderProjectFileName(".f"));
		WekaSerializer neg_ser = new WekaSerializer(project_setup.renderProjectFileName(".n"));
		
		crisp_relations = backg_ser.addAttributeRelations(instances.firstInstance());
		
		pos_ser.addAttributeRelation(instances.classAttribute().name());
		neg_ser.addAttributeRelation(instances.classAttribute().name());
		

		putModes(backg_ser);
		putAxioms(backg_ser, instances.classIndex());
		putDeteminations(backg_ser, instances.classIndex());
		
		
		
		backg_ser.putCommentLn("");
		backg_ser.putCommentLn("--- T U P L E S ---");
		
		for (int i = 0; i < instances.numInstances(); i++)
		{
			backg_ser.putCommentLn("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
			backg_ser.putBkgTuplesForInstance(instances.instance(i), "id_"+i, crisp_relations);
			

			//E X A M P L E S	
			pos_ser.putInstanceExamples(
					instances.instance(i),
					class_values,
					"id_"+i,
					getTargetCalssRelation(instances.classIndex()),
					getPositiveExmplesCondition());

			neg_ser.putInstanceExamples(
					instances.instance(i),
					class_values,
					"id_"+i,
					getTargetCalssRelation(instances.classIndex()),
					new WekaSerializer.NegCondition(getPositiveExmplesCondition()));									
		}
		
				
		backg_ser.putCommentLn("");
		backg_ser.putCommentLn("--- V A L U E S ---");		
		backg_ser.outputAllTypes();		
	}
	

	protected void putDeteminations(WekaSerializer backg_ser, int class_index, Relation [] rels)
	{
		for (int i = 0; i < rels.length; i++)
		{						
			if (i == class_index) continue;
			backg_ser.putDetermination(rels[class_index], rels[i]);
		}				
	}
	
	@Override
	public double classifyInstance(Instance instance) throws Exception
	{		
		
		WekaSerializer test_ser = new WekaSerializer(project_setup.renderProjectFileName(".test"));
		crisp_relations = test_ser.addAttributeRelations(instance);

		test_ser.putBkgTuplesForInstance(instance, "id_test", crisp_relations);
		putAxioms(test_ser, instance.classIndex());
		
		test_ser.putTestClassClause("id_test", crisp_relations[instance.classIndex()]);
		test_ser.close();
		
		ILPExec test_exec = new ILPExec(project_setup);
		test_exec.startPrologProcess(test_exec.getRulesFileName());
		test_exec.startErrReaderThread();
		test_exec.consultFile(project_setup.project_name + ".b");
		test_exec.consultFile(project_setup.project_name + ".test");
				

		String predicted = test_exec.input_reader.readLine();
		System.out.println("predicted: "+ predicted);
		
		if (predicted.equals("END")) return Instance.missingValue();
		
		if (instance.classAttribute().isNumeric()) return Double.parseDouble(predicted);
		
		return instance.classAttribute().indexOfValue(predicted);
	}


	protected void putAxioms(WekaSerializer backg_ser, int class_attribute_index) {};
	protected abstract Condition getPositiveExmplesCondition();
	protected abstract void putDeteminations(WekaSerializer backg_ser, int class_index);
	protected abstract void putModes(WekaSerializer backg_ser);
	protected abstract Relation getTargetCalssRelation(int class_attribute_index);
}
