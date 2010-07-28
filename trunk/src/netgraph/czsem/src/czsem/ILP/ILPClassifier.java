package czsem.ILP;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Enumeration;
import java.util.HashSet;
import java.util.Set;

import weka.classifiers.Classifier;
import weka.core.Attribute;
import weka.core.Capabilities;
import weka.core.Instance;
import weka.core.Instances;
import weka.core.Option;
import weka.core.Capabilities.Capability;
import czsem.ILP.Serializer.Relation;
import czsem.ILP.WekaSerializer.Condition;
import czsem.utils.Config;
import czsem.utils.ProjectSetup;

public abstract class ILPClassifier extends Classifier
{
	private static final long serialVersionUID = 2895303597421297747L;

	protected Relation [] crisp_relations;
	
	/** used for positive examples generation **/
	protected String [] class_values = null;
	
	protected ProjectSetup project_setup = null;
	
	protected int last_test_id = 10000;
	
	protected transient ILPExec testing_ILP_proecess = null;
	
	protected final String options[] = 
	{
			":- set(noise,0).",//0 
			":- set(i,2).",//1 
			":- set(depth,10).",//2 
			":- set(clauselength,4).",//3 
			":- set(search,bf).",//4 
			"",//5 
			"",//6 
			"",//7 
			"",//8 
			":- set(verbosity,0).",//9 
	};
			
	/** Initializes class_values array, which is alter used for positive examples generation. **/
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
		result.setOwner(this);

		return result;
	}	
	
	protected void learnRules() throws IOException, InterruptedException
	{
		ILPExec exec = new ILPExec(project_setup);
		exec.startILPProcess();
		exec.startReaderThreads("learning");
		exec.induceAndWriteRules();
		exec.close();
	}

	protected void setupProject(String project_name) throws FileNotFoundException, UnsupportedEncodingException
	{
		project_setup = new ProjectSetup();
		project_setup.dir_for_projects = Config.getConfig().getIlpProjestsPath()+'/';
		project_setup.project_name = project_name;
		project_setup.init_project();		
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
		
		
		StringBuilder learn_set_sb = new StringBuilder();
		for (int i = 0; i < options.length; i++)
		{
			learn_set_sb.append(options[i]);
			learn_set_sb.append('\n');			
		}
		
		backg_ser.putLearningSettings(learn_set_sb.toString());
		putModes(backg_ser);
		putLearningAxioms(backg_ser, instances.classIndex());
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
	
	protected void startILPProcess(int class_index) throws IOException
	{
		WekaSerializer test_ser = new WekaSerializer(project_setup.renderProjectFileName(".test"));
		putTestingAxioms(test_ser, class_index);
		
		testing_ILP_proecess = new ILPExec(project_setup);
		testing_ILP_proecess.startPrologProcess(testing_ILP_proecess.getRulesFileName());
		testing_ILP_proecess.startErrReaderThread("run_test");
		testing_ILP_proecess.consultFile(project_setup.project_name + ".test");

		
	}
	
	@Override
	public double classifyInstance(Instance instance) throws Exception
	{
		if (testing_ILP_proecess == null) startILPProcess(instance.classIndex());
				
		String test_id = "test_id_" + last_test_id++;

		WekaSerializer test_ser = new WekaSerializer(testing_ILP_proecess.getOutputStream());
		test_ser.assertBkgTuplesForInstance(instance, test_id, crisp_relations);
		
		test_ser.putTestClassPredicate(test_id, crisp_relations[instance.classIndex()]);
						
		String predicted = testing_ILP_proecess.readLine();
		
//		System.out.println("predicted: "+ predicted);
		
		if (predicted.equals("END")) return Instance.missingValue();
		
		if (instance.classAttribute().isNumeric()) return Double.parseDouble(predicted);
		
		return instance.classAttribute().indexOfValue(predicted);
	}

	@Override
	public String toString()
	{
		StringBuilder sb = new StringBuilder(super.toString());
		sb.append('\n');
		
		try
		{		
			sb.append(project_setup.renderProjectFileName(""));
			sb.append('\n');
		
			//print rules
			char [] buf = new char[1000];
			BufferedReader is = new BufferedReader(new FileReader(ILPExec.renderRulesFilePathName(project_setup)));
			for (int i=is.read(buf); i>=0; i=is.read(buf))
			{
				sb.append(buf, 0, i);
			}
			is.close();
		}
		catch (Exception e)
		{
			sb.append(e.toString());
		}
						
		return sb.toString();
	}


	protected void putTestingAxioms(WekaSerializer testSer, int classIndex) {}


	protected void putLearningAxioms(WekaSerializer backg_ser, int class_attribute_index) {};
	protected abstract Condition getPositiveExmplesCondition();
	protected abstract void putDeteminations(WekaSerializer backg_ser, int class_index);
	protected abstract void putModes(WekaSerializer backg_ser);
	protected abstract Relation getTargetCalssRelation(int class_attribute_index);


	@Override
	public abstract void buildClassifier(Instances data) throws Exception;

	public void buildClassifier(String project_name, Instances instances) throws Exception
	{
		last_test_id =  (int) Math.pow(10, ((int) Math.log10(instances.numInstances())) +1)   ;
		
		setupProject(project_name);
		
		initClassValues(instances);
		
		serializeToILP(instances);
		
		learnRules();
	}



	@Override
	protected void finalize() throws Throwable
	{
		if (testing_ILP_proecess != null) testing_ILP_proecess.close();
	}
	
	

	@Override
	public String[] getOptions()
	{
		String [] ret = new String [11];
		for (int i = 1; i < ret.length; i++)
		{
			ret[i] = options[i-1];			
		}
		ret[0] = "-O";
		return ret;
	}

	@Override
	public void setOptions(String[] new_options) throws Exception
	{
		for (int i = 0; i < options.length; i++) {
			options[i] = "";
		}

		if (new_options.length < 2) 
		{
			return;
		}
	    
		assert new_options[0].equals("-O");

		for (int i = 1; i < new_options.length; i++) {
			options[i-1] = new_options[i];
		}
	}

	@Override
	public Enumeration<Option> listOptions()
	{			
		return new Enumeration<Option>() {
			@Override
			public Option nextElement() {				
				return new Option(
						"Arbitratry options for ILP learner. e.g.: ':-set(noise,3).'",
						"O", 10, "-O <options>");
			}			
			boolean more = true; 
			@Override
			public boolean hasMoreElements() {
				boolean ret = more;
				more = false;
				return ret;
			}
		};
	}
	
	public String opt0TipText() { return "Arbitratry options for ILP learner. e.g.: ':-set(noise,3).'"; }
	public String opt1TipText() { return "Arbitratry options for ILP learner. e.g.: ':-set(noise,3).'"; }
	public String opt2TipText() { return "Arbitratry options for ILP learner. e.g.: ':-set(noise,3).'"; }
	public String opt3TipText() { return "Arbitratry options for ILP learner. e.g.: ':-set(noise,3).'"; }
	public String opt4TipText() { return "Arbitratry options for ILP learner. e.g.: ':-set(noise,3).'"; }
	public String opt5TipText() { return "Arbitratry options for ILP learner. e.g.: ':-set(noise,3).'"; }
	public String opt6TipText() { return "Arbitratry options for ILP learner. e.g.: ':-set(noise,3).'"; }
	public String opt7TipText() { return "Arbitratry options for ILP learner. e.g.: ':-set(noise,3).'"; }
	public String opt8TipText() { return "Arbitratry options for ILP learner. e.g.: ':-set(noise,3).'"; }
	public String opt9TipText() { return "Arbitratry options for ILP learner. e.g.: ':-set(noise,3).'"; }

	public String getOpt0() { return options[0]; }
	public String getOpt1() { return options[1]; }
	public String getOpt2() { return options[2]; }
	public String getOpt3() { return options[3]; }
	public String getOpt4() { return options[4]; }
	public String getOpt5() { return options[5]; }
	public String getOpt6() { return options[6]; }
	public String getOpt7() { return options[7]; }
	public String getOpt8() { return options[8]; }
	public String getOpt9() { return options[9]; }
	
	public void   setOpt0(String new_val) { options[0] = new_val; }
	public void   setOpt1(String new_val) { options[1] = new_val; }
	public void   setOpt2(String new_val) { options[2] = new_val; }
	public void   setOpt3(String new_val) { options[3] = new_val; }
	public void   setOpt4(String new_val) { options[4] = new_val; }
	public void   setOpt5(String new_val) { options[5] = new_val; }
	public void   setOpt6(String new_val) { options[6] = new_val; }
	public void   setOpt7(String new_val) { options[7] = new_val; }
	public void   setOpt8(String new_val) { options[8] = new_val; }
	public void   setOpt9(String new_val) { options[9] = new_val; }

	
	public static void main(String[] args)	
	{		
		weka.gui.GUIChooser.main(args);	
	}

}
