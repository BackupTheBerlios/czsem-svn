package czsem.ILP;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.UnsupportedEncodingException;

import czsem.ILP.Serializer.Relation;
import czsem.utils.ProjectSetup;

import weka.classifiers.Classifier;
import weka.core.Attribute;
import weka.core.Instance;
import weka.core.Instances;

public class CrispILPClassifier extends Classifier {

	private static final long serialVersionUID = 6391819097164332129L;
	
	protected ProjectSetup project_setup = new ProjectSetup();
	
	@Override
	public double classifyInstance(Instance instance) throws Exception
	{
		System.out.println("****");
		return 0;
	}

	@Override
	public void buildClassifier(Instances instances) throws Exception
	{
		setupProject(instances.relationName());
		
		serializeToILP(instances);
		
		learnRules();
		
		System.out.println("xxxx");
	}

	protected void learnRules() throws IOException
	{
		ILPExec exec = new ILPExec(project_setup);
		exec.startILPProcess();
		exec.startReaderThreads();
		exec.induceAndWriteRules();
	}
		
	protected void putNegativeExamples(Serializer ser, Instance instance, String id, Relation rel)
	{
		String value = instance.toString(instance.classIndex());
//		if (value.compareTo("?") == 0) continue;
		if (value.compareTo("?") == 0) value = "unknown";
		
		Attribute class_atr = instance.classAttribute(); 
		
		for (int a=0; a<class_atr.numValues(); a++)
		{
			String neg_val;			
			if (class_atr.isNumeric()) neg_val = Double.toString(instance.value(class_atr));
			else neg_val = class_atr.value(a);
			
			if (neg_val.equals(value)) continue;

			
			ser.putBinTuple(rel, id, neg_val);
		}
		
		
		
		
	}
	
	protected Relation addAttributeRelation(Serializer ser, String attr_name)
	{
		return ser.addBinRelation("has_" + attr_name, "id", attr_name);						
	}

	protected Relation [] addAttributeRelations(Serializer ser, Instance instance)
	{
		Relation [] relations = new Relation[instance.numAttributes()];

		for (int i = 0; i < relations.length; i++)
		{			
			relations[i] = addAttributeRelation(ser, instance.attribute(i).name());
		}
		
		return relations;
	}
	
	protected void serializeToILP(Instances instances) throws FileNotFoundException, UnsupportedEncodingException
	{
		Serializer backg_ser = new Serializer(project_setup.renderProjectFileName(".b"));
		Serializer pos_ser = new Serializer(project_setup.renderProjectFileName(".f"));
		Serializer neg_ser = new Serializer(project_setup.renderProjectFileName(".n"));
		
		Relation [] crisp_relations = new Relation[instances.numAttributes()];


		backg_ser.putCommentLn("--- C R I S P     M O D E S ---");
		for (int i = 0; i < crisp_relations.length; i++)
		{
			
			if (i == instances.classIndex())
			{
				pos_ser.addBinRelation("has_" + instances.attribute(i).name(), "file_id", instances.attribute(i).name());				
				neg_ser.addBinRelation("has_" + instances.attribute(i).name(), "file_id", instances.attribute(i).name());
			}

			crisp_relations[i] = backg_ser.addBinRelation("has_" + instances.attribute(i).name(), "file_id", instances.attribute(i).name());
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
			for (int r = 0; r < crisp_relations.length; r++)
			{
				
				String value = instances.instance(i).toString(r);
//				if (value.compareTo("?") == 0) continue;
				if (value.compareTo("?") == 0) value = "unknown";
				
				if (r == instances.classIndex())
					// positive example
					pos_ser.putBinTuple(crisp_relations[r], "id_" + i, value);
				else
					backg_ser.putBinTuple(crisp_relations[r], "id_" + i, value);
			}
			
			putNegativeExamples(neg_ser, instances.instance(i), "id_" + i,crisp_relations[instances.classIndex()]);
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
