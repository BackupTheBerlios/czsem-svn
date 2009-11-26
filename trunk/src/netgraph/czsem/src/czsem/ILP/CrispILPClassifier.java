package czsem.ILP;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.HashSet;
import java.util.Set;

import czsem.ILP.Serializer.Relation;
import czsem.ILP.WekaSerializer.Condition;
import czsem.utils.ProjectSetup;

import weka.classifiers.Classifier;
import weka.core.Attribute;
import weka.core.Capabilities;
import weka.core.Instance;
import weka.core.Instances;
import weka.core.Capabilities.Capability;

public class CrispILPClassifier extends ILPClassifier {

	private static final long serialVersionUID = 6391819097164332129L;

	
	@Override
	public void buildClassifier(Instances instances) throws Exception
	{
		buildClassifier("crisp_" + instances.relationName(), instances);
	}

	@Override
	protected void putModes(WekaSerializer backgSer)
	{
		putCripsModes(backgSer);
	}

	@Override
	protected void putDeteminations(WekaSerializer backg_ser, int class_index)
	{
		
		backg_ser.putCommentLn("");
		backg_ser.putCommentLn("--- C R I S P      D E T E R M I N A T I O N S ---");

		putDeteminations(backg_ser, class_index, crisp_relations);
	}

	@Override
	protected Condition getPositiveExmplesCondition() {
		
		return new Condition()
		{			
			@Override
			public boolean evaluate(String currentInstanceValue, String alternativeValueFormAttributeDomain)
			{
				return currentInstanceValue.equals(alternativeValueFormAttributeDomain);
			}
		};
	}

	@Override
	protected Relation getTargetCalssRelation(int class_attribute_index) {
		return crisp_relations[class_attribute_index];
	}

			
}
