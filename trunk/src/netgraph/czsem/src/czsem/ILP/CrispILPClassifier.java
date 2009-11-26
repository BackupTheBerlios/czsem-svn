package czsem.ILP;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.UnsupportedEncodingException;

import czsem.ILP.Serializer.Relation;
import czsem.utils.ProjectSetup;

import weka.classifiers.Classifier;
import weka.core.Capabilities;
import weka.core.Instance;
import weka.core.Instances;
import weka.core.Capabilities.Capability;

public class CrispILPClassifier extends Classifier {

	private static final long serialVersionUID = 6391819097164332129L;

	protected Relation [] crisp_relations;
	
	protected ProjectSetup project_setup = new ProjectSetup();
	
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
	
	@Override
	public double classifyInstance(Instance instance) throws Exception
	{		
		
		WekaSerializer test_ser = new WekaSerializer(project_setup.renderProjectFileName(".test"));
		test_ser.putBkgTuplesForInstance(instance, "id_test", crisp_relations);
		test_ser.putTestClassClause("id_test", crisp_relations[instance.classIndex()]);
		test_ser.close();
		
		ILPExec test_exec = new ILPExec(project_setup);
		test_exec.startPrologProcess(test_exec.getRulesFileName());
//		test_exec.startReaderThreads();
		test_exec.consultFile(project_setup.project_name + ".test");
		

		String predicted = test_exec.input_reader.readLine();
		System.out.println("predicted: "+ predicted);
		
		if (predicted.equals("END")) return Instance.missingValue();
		
		if (instance.classAttribute().isNumeric()) return Double.parseDouble(predicted);
		
		return instance.classAttribute().indexOfValue(predicted);
	}

	@Override
	public void buildClassifier(Instances instances) throws Exception
	{
		setupProject(instances.relationName());
		
		serializeToILP(instances);
		
		learnRules();
		
		System.out.println("xxxx");
	}

	protected void learnRules() throws IOException, InterruptedException
	{
		ILPExec exec = new ILPExec(project_setup);
		exec.startILPProcess();
		exec.startReaderThreads();
		exec.induceAndWriteRules();
		exec.close();
	}
		
	
	protected void serializeToILP(Instances instances) throws FileNotFoundException, UnsupportedEncodingException
	{
		WekaSerializer backg_ser = new WekaSerializer(project_setup.renderProjectFileName(".b"));
		WekaSerializer pos_ser = new WekaSerializer(project_setup.renderProjectFileName(".f"));
		WekaSerializer neg_ser = new WekaSerializer(project_setup.renderProjectFileName(".n"));
		
		crisp_relations = backg_ser.addAttributeRelations(instances.firstInstance());
		
		pos_ser.addAttributeRelation(instances.classAttribute().name());
		neg_ser.addAttributeRelation(instances.classAttribute().name());


		backg_ser.putCommentLn("--- C R I S P     M O D E S ---");
		for (int i = 0; i < crisp_relations.length; i++)
		{
			backg_ser.putBinaryMode(crisp_relations[i], "1", '+', '#');

			//			monot.: "*" instead of "1"
			//			ilp_ser.putBinaryMode(atl_ser, "*", '+', '#');			
		}
		
		
		backg_ser.putCommentLn("");
		backg_ser.putCommentLn("--- D E T E R M I N A T I O N S ---");

		for (int i = 0; i < crisp_relations.length; i++)
		{
			if (i == instances.classIndex()) continue;
			backg_ser.putDetermination(crisp_relations[instances.classIndex()], crisp_relations[i]);
		}
		
		
		backg_ser.putCommentLn("");
		backg_ser.putCommentLn("--- T U P L E S ---");
		
		for (int i = 0; i < instances.numInstances(); i++)
		{
			backg_ser.putCommentLn("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
			backg_ser.putBkgTuplesForInstance(instances.instance(i), "id_"+i, crisp_relations);
			

			//E X A M P L E S
			pos_ser.putBinTuple(crisp_relations[instances.classIndex()], "id_"+i, WekaSerializer.getStringValue(instances.instance(i), instances.classIndex()));
			neg_ser.putNegativeExamples(instances.instance(i), "id_"+i,crisp_relations[instances.classIndex()]);
		}
		
				
		backg_ser.putCommentLn("");
		backg_ser.putCommentLn("--- V A L U E S ---");		
		backg_ser.outputAllTypes();		
	}
	
	protected void setupProject(String project_name) throws FileNotFoundException, UnsupportedEncodingException
	{
		project_setup = new ProjectSetup();
		project_setup.dir_for_projects = "C:\\workspace\\czsem\\src\\ILP\\serious_corss\\";
		project_setup.project_name = project_name;
		project_setup.init_project();		
	}

}
