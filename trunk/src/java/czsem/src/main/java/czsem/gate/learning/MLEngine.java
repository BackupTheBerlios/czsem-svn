package czsem.gate.learning;

import gate.creole.annotransfer.AnnotationSetTransfer;
import gate.creole.ml.MachineLearningPR;
import gate.learning.LearningAPIMain;

import java.io.File;
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

import org.jdom.Document;
import org.jdom.Element;
import org.jdom.JDOMException;

import czsem.gate.learning.MachineLearningExperiment.TrainTest;
import czsem.utils.JDomUtils;

public abstract class MLEngine implements TrainTest
{
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
		
	private String outputAS;
	protected String configFileName;

	public MLEngine(String outputAS, String configFileName)
	{
		this.setOutputAS(outputAS);
		this.configFileName = configFileName;
	}

	protected URL getConfigURL(String experimentDirectory) throws MalformedURLException
	{
		
		return new File(experimentDirectory + '/' + configFileName).toURI().toURL(); 			

	}
	
	protected void setOutputAS(String outputAS) {
		this.outputAS = outputAS;
	}
	
	@Override
	public String getDefaultOutputAS() {
		return outputAS;
	}

	@Override
	public String getDefaultLearningAnnotationType() {
		return "Mention";
	}
	
	public String getName()
	{
		return "MLEngine" + getDefaultOutputAS() + "_" + configFileName;
	}
	
	public static String readLearninigAnnotType(URL config_doc_url) throws JDOMException, IOException
	{
		Document config_dom = JDomUtils.getJdomDoc(config_doc_url);
		@SuppressWarnings("unchecked")
		List<Element> ch = config_dom .getRootElement().getChild("DATASET").getChildren("ATTRIBUTE");
		for (Element element : ch)
		{
			if (element.getChild("CLASS") != null)
			{
				return element.getChildText("TYPE");				
			}
			
		}
		return null;				
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
			prs.add(new PRSetup.SinglePRSetup(LearningAPIMain.class, getName()+"_train")
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
			prs.add(new PRSetup.SinglePRSetup(LearningAPIMain.class, getName()+"_apply")
				.putFeature("configFileURL", getConfigURL(config.experimentLearningConfigsDirectory))
				.putFeature("inputASName", config.inputAS)
				.putFeature("outputASName", config.outputAS)
				.putFeature("learningMode", "APPLICATION"));

			return prs;
		}

		@Override
		public String getDefaultLearningAnnotationType() {
			return "MentionPaum";
		}
		
	}

	public static class ILPEngine extends MLEngine
	{

		public ILPEngine(String configFileName)
		{			
//			super("ILP", configFileName);
			super(configFileName.substring(0, configFileName.indexOf('.')), configFileName);
			
		}

		public ILPEngine() {
			this("ILP_config.xml");
		}

		@Override
		public List<PRSetup> getTrainControllerSetup(MLEngineConfig config) throws MalformedURLException
		{
			List<PRSetup> prs = new ArrayList<PRSetup>();
						
			prs.add(new PRSetup.SinglePRSetup(MachineLearningPR.class, getName()+"_train")
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
			prs.add(new PRSetup.SinglePRSetup(MachineLearningPR.class, getName()+"_apply")
				.putFeature("configFileURL", getConfigURL(config.experimentLearningConfigsDirectory))
				.putFeature("inputASName", config.inputAS)
				.putFeature("training", false));
			
			if (! config.inputAS.equals(config.outputAS))
			{
				prs.add(new PRSetup.SinglePRSetup(AnnotationSetTransfer.class)
					.putFeature("inputASName", config.inputAS)
					.putFeature("outputASName", config.outputAS)
					.putFeature("copyAnnotations", false)
					.putFeatureList("annotationTypes", config.learnigAnnotationType));
			}
			
			return prs;
		}
		
	}
}
