package czsem.gate.learning;

import gate.creole.annotdelete.AnnotationDeletePR;

import java.net.MalformedURLException;
import java.util.List;

import czsem.gate.learning.MLEngine.MLEngineConfig;
import czsem.gate.learning.MachineLearningExperiment.TrainTest;
import czsem.gate.learning.MachineLearningExperimenter.PRSetup;
import czsem.gate.learning.MachineLearningExperimenter.SinglePRSetup;
import czsem.gate.plugins.AnnotationDependencyRootMarker;
import czsem.gate.plugins.AnnotationDependencySubtreeMarker;
import czsem.gate.plugins.CreateMentionsPR;
import czsem.gate.plugins.SubsequentAnnotationMergePR;

public class MLEngineEncapsulate implements TrainTest
{
	protected TrainTest child;

	@Override
	public List<PRSetup> getTrainControllerSetup(MLEngineConfig config)	throws MalformedURLException
	{
		return child.getTrainControllerSetup(config);
	}

	@Override
	public List<PRSetup> getTestControllerSetup(MLEngineConfig config) throws MalformedURLException
	{
		return child.getTestControllerSetup(config);
	}

	@Override
	public String getOutputAS() {
		return child.getOutputAS();
	}

	public static class CreateTemporaryMentions  extends MLEngineEncapsulate
	{
		@Override
		public List<PRSetup> getTrainControllerSetup(MLEngineConfig config)	throws MalformedURLException
		{
			List<PRSetup> ret = super.getTrainControllerSetup(config);
						
			//CreateMentions
			ret.add(0, new SinglePRSetup(CreateMentionsPR.class)
				.putFeature("inputASName", config.keyAS)
				.putFeature("outputASName", config.inputAS)
				.putFeature("mentionAnntotationTypeName", config.learnigAnnotationType)
				//.putFeatureList("inputAnnotationTypeNames", new String [0]));
				.putFeature("inputAnnotationTypeNames", config.originalLearnigAnnotationTypes));

			//delete Mentions
			ret.add(new SinglePRSetup(AnnotationDeletePR.class)
				.putFeatureList("annotationTypes", config.learnigAnnotationType)
				.putFeatureList("setsToRemove", config.inputAS));		
			
			return ret;
		}
		
		@Override
		public List<PRSetup> getTestControllerSetup(MLEngineConfig config) throws MalformedURLException
		{
			List<PRSetup> ret = super.getTestControllerSetup(config);
			
			//CreateMentions inverse
			ret.add(new SinglePRSetup(CreateMentionsPR.class)
				.putFeature("inputASName", config.outputAS)
				.putFeature("outputASName", config.outputAS)
				.putFeature("inverseFunction", true)
				.putFeature("inputAnnotationTypeNames", config.originalLearnigAnnotationTypes));
			
			return ret;
		}



	}

	public static class CreateTemporaryMentionsRootSubtree extends MLEngineEncapsulate
	{
		@Override
		public List<PRSetup> getTrainControllerSetup(MLEngineConfig config)	throws MalformedURLException
		{
			List<PRSetup> ret = super.getTrainControllerSetup(config);

			//CreateMentions
			ret.add(0, new SinglePRSetup(CreateMentionsPR.class)
				.putFeature("inputASName", config.keyAS)
				.putFeature("outputASName", config.inputAS)
				.putFeature("mentionAnntotationTypeName", config.learnigAnnotationType + "_subtree")
				//.putFeatureList("inputAnnotationTypeNames", new String [0]));
				.putFeature("inputAnnotationTypeNames", config.originalLearnigAnnotationTypes));

			
			//Training roots
			ret.add(1, new SinglePRSetup(AnnotationDependencyRootMarker.class)
				.putFeature("inputASName", config.inputAS)
				.putFeature("outputASName", config.inputAS)
				.putFeatureList("inputAnnotationTypeNames", config.learnigAnnotationType + "_subtree"));
								
			//delete Mentions
			ret.add(new SinglePRSetup(AnnotationDeletePR.class)
				.putFeatureList("annotationTypes", 
						config.learnigAnnotationType,
						config.learnigAnnotationType + "_subtree")
				.putFeatureList("setsToRemove", config.inputAS));		

			return ret;
		}

		@Override
		public List<PRSetup> getTestControllerSetup(MLEngineConfig config) throws MalformedURLException
		{
			//output redirection
			String outputAS_backup = config.outputAS;
			config.outputAS = config.inputAS;			
			List<PRSetup> ret = super.getTestControllerSetup(config);
			config.outputAS = outputAS_backup;			

			//Subtree
			ret.add(new SinglePRSetup(AnnotationDependencySubtreeMarker.class)
				.putFeature("inputASName", config.inputAS)
				.putFeature("outputASName", config.outputAS)
				.putFeatureList("inputAnnotationTypeNames", config.learnigAnnotationType));
	
			//CreateMentions inverse
			ret.add(new SinglePRSetup(CreateMentionsPR.class)
				.putFeature("inputASName", config.outputAS)
				.putFeature("outputASName", config.outputAS)
				.putFeature("mentionAnntotationTypeName", config.learnigAnnotationType + "_subtree")
				.putFeature("inverseFunction", true)
				.putFeature("inputAnnotationTypeNames", config.originalLearnigAnnotationTypes));
			
			//delete working Mentions
			ret.add(new SinglePRSetup(AnnotationDeletePR.class)
				.putFeatureList("annotationTypes", config.learnigAnnotationType)
				.putFeatureList("setsToRemove", config.inputAS));		

			
			return ret;
		}

	}

	public static class SubsequentAnnotationMerge extends MLEngineEncapsulate
	{

		@Override
		public List<PRSetup> getTestControllerSetup(MLEngineConfig config) throws MalformedURLException
		{
			List<PRSetup> ret = super.getTestControllerSetup(config);
			
			ret.add(new SinglePRSetup(SubsequentAnnotationMergePR.class)
				.putFeature("inputASName", config.outputAS)
				.putFeature("outputASName", config.outputAS)
				.putFeature("annotationTypeName", config.learnigAnnotationType)
				.putFeature("deleteOriginalAnnotations", true));
			
			return ret;
		}
		
	}

}
