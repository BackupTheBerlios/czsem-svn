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

import czsem.gate.ILPSerializer;
import czsem.gate.learning.MachineLearningExperimenter.PRSetup;
import czsem.gate.learning.MachineLearningExperimenter.SinglePRSetup;
import czsem.gate.learning.MachineLearningExperimenter.TrainTest;
import czsem.gate.plugins.AnnotationDependencyRootMarker;
import czsem.gate.plugins.AnnotationDependencySubtreeMarker;
import czsem.gate.plugins.SubsequentAnnotationMerge;
import czsem.utils.JDomUtils;

public abstract class MLEngine implements TrainTest
{
	public static class LearningSetup
	{
		protected String learninigAnnotType;
		protected String classFetureName;
		protected boolean rootSubtreeLearninig;
		protected String[] inputAnnotationTypeNames;
		
		protected static String readLearninigAnnotType(Document config_dom)
		{
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
		
		protected static String readLearninigAnnotType(URL config_doc_url) throws JDOMException, IOException
		{		
			Document config_dom = JDomUtils.getJdomDoc(config_doc_url);
			return readLearninigAnnotType(config_dom);
		}

		
		public LearningSetup(URL config_file) throws JDOMException, IOException
		{
			String readAnnotType = readLearninigAnnotType(config_file);
			
			inputAnnotationTypeNames = 
				ILPSerializer.parseClassAttributeValuesFromSettingsFile(config_file);
			
			if (readAnnotType.endsWith("_root"))
			{
				rootSubtreeLearninig = true;
				learninigAnnotType = readAnnotType.substring(0, readAnnotType.length() - 5);				
			}
			else
			{
				rootSubtreeLearninig = false;
				learninigAnnotType = readAnnotType;
			}
		}
		public String getLearninigAnnotType() {
			return learninigAnnotType;
		}
		public String getClassFetureName() {
			return classFetureName;
		}
		public boolean getRootSubtreeLearninig() {
			return rootSubtreeLearninig;
		}

		@Override
		public boolean equals(Object obj) {
			// TODO Auto-generated method stub
			return super.equals(obj);
		}

		@Override
		public String toString() {
			// TODO Auto-generated method stub
			return super.toString();
		}

		public String[] getInputAnnotationTypeNames() {
			return inputAnnotationTypeNames;
		}		
	}
	
	protected LearningSetup learningSetup;
	protected URL config_file;
	
	
	public static class PaumEngine extends MLEngine
	{

		@Override
		public List<PRSetup> getTrainControllerSetup() throws JDOMException, IOException
		{
			List<PRSetup> prs = new ArrayList<PRSetup>(1);

			//Paum train
			prs.add(new SinglePRSetup(LearningAPIMain.class)
				.putFeature("inputASName", "TectoMT")
				.putFeature("outputASName", "Paum")
				.putFeature("configFileURL", config_file)
				.putFeature("learningMode", "TRAINING"));
			
			return prs;
		}

		@Override
		public List<PRSetup> getTestControllerSetup()
		{
			List<PRSetup> prs = new ArrayList<PRSetup>(1);

			//Paum Application
			prs.add(new SinglePRSetup(LearningAPIMain.class)
				.putFeature("configFileURL", config_file)
				.putFeature("inputASName", "TectoMT")
				.putFeature("outputASName", "Paum")
				.putFeature("learningMode", "APPLICATION"));

			return prs;
		}

		@Override
		public String getConfigFilenaMame() {
			return "Paum_config.xml";
		}
		
	}

	public static class ILPEngine extends MLEngine 
	{

		@Override
		public List<PRSetup> getTrainControllerSetup() throws JDOMException, IOException
		{
			List<PRSetup> prs = new ArrayList<PRSetup>(2);
			
			if (learningSetup.getRootSubtreeLearninig())
			{			
				//Training roots
				prs.add(new SinglePRSetup(AnnotationDependencyRootMarker.class)
					.putFeature("inputASName", "TectoMT")
					.putFeature("outputASName", "TectoMT")
					.putFeatureList("inputAnnotationTypeNames", learningSetup.getLearninigAnnotType()));
			}
			
			prs.add(new SinglePRSetup(MachineLearningPR.class)
				.putFeature("inputASName", "TectoMT")
				.putFeature("configFileURL", config_file)
				.putFeature("training", true));
			
			return prs;
			
			
		}

		@Override
		public List<PRSetup> getTestControllerSetup()
		{
			List<PRSetup> prs = new ArrayList<PRSetup>(3);

			//ILP Apply
			prs.add(new SinglePRSetup(MachineLearningPR.class)
				.putFeature("configFileURL", config_file)
				.putFeature("inputASName", "TectoMT")
				.putFeature("training", false));
			if (learningSetup.getRootSubtreeLearninig())
			{
				//Subtree for ILP results
				prs.add(new SinglePRSetup(AnnotationDependencySubtreeMarker.class)
					.putFeature("inputASName", "TectoMT")
					.putFeature("outputASName", "ILP")
					.putFeatureList("inputAnnotationTypeNames", learningSetup.getLearninigAnnotType() + "_root"));
				//ILP Output Transfer
				prs.add(new SinglePRSetup(AnnotationSetTransfer.class)
					.putFeature("inputASName", "TectoMT")
					.putFeature("outputASName", "ILP")
					.putFeature("copyAnnotations", false)
					.putFeatureList("annotationTypes", learningSetup.getLearninigAnnotType() + "_root"));
			} else
			{
				//Subsequent annotation merge
				prs.add(new SinglePRSetup(SubsequentAnnotationMerge.class)
					.putFeature("inputASName", "TectoMT")
					.putFeature("outputASName", "ILP")
					.putFeature("annotationTypeName", learningSetup.getLearninigAnnotType())
					.putFeature("deleteOriginalAnnotations", true));
			}
			
			return prs;
		}

		@Override
		public String getConfigFilenaMame() {
			return "ILP_config.xml";
		}
		
	}


	public void init(String config_directory) throws MalformedURLException, JDOMException, IOException
	{
		init(new File(config_directory + '/' +getConfigFilenaMame()).toURI().toURL()); 			
	}
	
	public abstract String getConfigFilenaMame();

	
	protected void init(URL config_file) throws JDOMException, IOException
	{
		this.config_file = config_file;
		learningSetup = new LearningSetup(config_file);
	}

	public LearningSetup getLearninigSetup() {
		return learningSetup;
	}

/**/	
/*
	public String getLearninigAnnotType() {
		return llearninigAnnotType;
	}

/*
	public String[] getInputAnnotationTypeNames() {
		return inputAnnotationTypeNames;		
	}
*/
}

