package czsem.ILP;

import java.io.FileNotFoundException;
import java.io.UnsupportedEncodingException;

import weka.core.Attribute;
import weka.core.Instance;

public class WekaSerializer extends Serializer {

	public WekaSerializer(String output_filename) throws FileNotFoundException, UnsupportedEncodingException
	{
		super(output_filename);
	}
	
	protected void putNegativeExamples(Instance instance, String id, Relation rel)
	{
		String value = instance.toString(instance.classIndex());
//		if (value.compareTo("?") == 0) continue;
		if (value.equals("?")) value = "unknown";
		
		Attribute class_atr = instance.classAttribute(); 
		
		for (int a=0; a<class_atr.numValues(); a++)
		{
			String neg_val;			
			if (class_atr.isNumeric()) neg_val = Double.toString(instance.value(class_atr));
			else neg_val = class_atr.value(a);
			
			if (neg_val.equals(value)) continue;

			
			putBinTuple(rel, id, neg_val);
		}
	}

	protected static String getStringValue(Instance instance, int attr_index)
	{
		String value = instance.toString(attr_index);
//		if (value.compareTo("?") == 0) continue;
		if (value.equals("?")) value = "unknown";
		
		return value;		
	}
	
	protected void putBkgTuplesForInstance(Instance instance, String id, Relation [] relations)
	{
		for (int r = 0; r < relations.length; r++)
		{				
			if (r == instance.classIndex()) continue;
			putBinTuple(relations[r], id, getStringValue(instance, r));						
		}		
	}

/*
	protected void assertBkgTuplesForInstance(Instance instance, String id, Relation [] relations)
	{
		for (int r = 0; r < relations.length; r++)
		{				
			if (r == instance.classIndex()) continue;
			putBinTuple(relations[r], id, getStringValue(instance, r));						
		}		
	}
*/	
	protected Relation addAttributeRelation(String attr_name)
	{
		return addBinRelation("has_" + attr_name, "id", attr_name);						
	}

	protected Relation [] addAttributeRelations(Instance instance)
	{
		Relation [] relations = new Relation[instance.numAttributes()];

		for (int i = 0; i < relations.length; i++)
		{			
			relations[i] = addAttributeRelation(instance.attribute(i).name());
		}
		
		return relations;
	}
	
	protected void putTestClassClause(String test_id, Relation rel)
	{
		output.print(":-");
		renderInlineTupleWithoutValueCheck(rel.getName(), new String[] {test_id, "X"});
		output.println(",print(X),print('\\n').");
		output.println(":-print('END\\n').");
	}
}
