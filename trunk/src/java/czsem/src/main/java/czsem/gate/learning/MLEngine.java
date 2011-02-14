package czsem.gate.learning;

import gate.creole.annotransfer.AnnotationSetTransfer;
import gate.creole.ml.MachineLearningPR;
import gate.learning.LearningAPIMain;

import java.io.File;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

import czsem.gate.learning.MachineLearningExperiment.TrainTest;
import czsem.gate.learning.MachineLearningExperimenter.PRSetup;
import czsem.gate.learning.MachineLearningExperimenter.SinglePRSetup;

public abstract class MLEngine implements TrainTest
{
	private String outputAS;
	protected String configFileName;

	public MLEngine(String outputAS, String configFileName)
	{
		this.setOutputAS(outputAS);
		this.configFileName = configFileName;
	}

	public static class MLEngineConfig
	{
		public String experimentLearningConfigsDirectory; 
		public String inputAS;
		public String outputAS;
		public String keyAS;
		public String learnigAnnotationType = "Mention";
		/** To be translated to the 'class' feature of the 'Mention' learning annotation type. **/
		public List<String> originalLearnigAnnotationTypes;
	}
		
	protected URL getConfigURL(String experimentDirectory) throws MalformedURLException
	{
		
		return new File(experimentDirectory + '/' + configFileName).toURI().toURL(); 			

	}
	
	protected void setOutputAS(String outputAS) {
		this.outputAS = outputAS;
	}
	
	@Override
	public String getOutputAS() {
		return outputAS;
	}

	public static class PaumEngine extends MLEngine
	{

		public PaumEngine() {
			super("Paum", "Paum_config.xml");
		}

		@Override
		public List<PRSetup> getTrainControllerSetup(MLEngineConfig config) throws MalformedURLException
		{
			List<PRSetup> prs = new ArrayList<PRSetup>();

			//Paum train
			prs.add(new SinglePRSetup(LearningAPIMain.class)
				.putFeature("inputASName", config.inputAS)
				.putFeature("outputASName", config.outputAS)
				.putFeature("configFileURL", getConfigURL(config.experimentLearningConfigsDirectory))
				.putFeature("learningMode", "TRAINING"));
			
			return prs;
		}

		@Override
		public List<PRSetup> getTestControllerSetup(MLEngineConfig config) throws MalformedURLException
		{
			List<PRSetup> prs = new ArrayList<PRSetup>();

			//Paum Application
			prs.add(new SinglePRSetup(LearningAPIMain.class)
				.putFeature("configFileURL", getConfigURL(config.experimentLearningConfigsDirectory))
				.putFeature("inputASName", config.inputAS)
				.putFeature("outputASName", config.outputAS)
				.putFeature("learningMode", "APPLICATION"));

			return prs;
		}
		
	}

	public static class ILPEngine extends MLEngine
	{

		public ILPEngine() {
			super("ILP", "ILP_config.xml");
		}

		@Override
		public List<PRSetup> getTrainControllerSetup(MLEngineConfig config) throws MalformedURLException
		{
			List<PRSetup> prs = new ArrayList<PRSetup>();
						
			prs.add(new SinglePRSetup(MachineLearningPR.class)
				.putFeature("inputASName", config.inputAS)
				.putFeature("configFileURL", getConfigURL(config.experimentLearningConfigsDirectory))
				.putFeature("training", true));
			
			return prs;

		}

		@Override
		public List<PRSetup> getTestControllerSetup(MLEngineConfig config)	throws MalformedURLException
		{
			List<PRSetup> prs = new ArrayList<PRSetup>();

			//ILP Apply
			prs.add(new SinglePRSetup(MachineLearningPR.class)
				.putFeature("configFileURL", getConfigURL(config.experimentLearningConfigsDirectory))
				.putFeature("inputASName", config.inputAS)
				.putFeature("training", false));
			
			if (! config.inputAS.equals(config.outputAS))
			{
				prs.add(new SinglePRSetup(AnnotationSetTransfer.class)
					.putFeature("inputASName", config.inputAS)
					.putFeature("outputASName", config.outputAS)
					.putFeature("copyAnnotations", false)
					.putFeatureList("annotationTypes", config.learnigAnnotationType));
			}
			
			return prs;
		}
		
	}


		

}
