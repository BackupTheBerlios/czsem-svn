package czsem.gate.learning;

import gate.creole.annotdelete.AnnotationDeletePR;

import java.io.IOException;
import java.net.MalformedURLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.jdom.JDOMException;

import czsem.gate.learning.MLEngine.MLEngineConfig;
import czsem.gate.learning.MachineLearningExperimenter.PRSetup;
import czsem.gate.learning.MachineLearningExperimenter.SinglePRSetup;


public class MachineLearningExperiment
{
	public static interface TrainTest
	{
		List<PRSetup> getTrainControllerSetup(MLEngineConfig config) throws MalformedURLException;
		List<PRSetup> getTestControllerSetup(MLEngineConfig config) throws MalformedURLException;
		String getOutputAS();
	}

	protected String learninigAnnotType = "Mention";
	
	/** Usually TectoMT **/
	protected String inputLearninigAS;
	
	protected DataSet dataSet;
	protected TrainTest[] engines;
	
	public List<PRSetup> getTestControllerSetup() throws JDOMException, IOException
	{
		List<PRSetup> prs = new ArrayList<PRSetup>();
		
		//TectoMT reset
		prs.add(new SinglePRSetup(AnnotationDeletePR.class)
			.putFeatureList("annotationTypes", learninigAnnotType)
			.putFeatureList("setsToRemove", inputLearninigAS));		

		//Reset engines outASs		
		String [] outAS = new String[engines.length];
		for (int i = 0; i < outAS.length; i++) {
			outAS[i] = engines[i].getOutputAS();
		}
		prs.add(new SinglePRSetup(AnnotationDeletePR.class)
			.putFeature("setsToRemove", Arrays.asList(outAS)));		
		
		return addTestMLEngines(prs);
	}

	
	protected MLEngineConfig getMLEngineConfig(TrainTest engine)
	{
		MLEngineConfig ret = new MLEngineConfig();
		ret.experimentLearningConfigsDirectory = dataSet.learnigConfigDirectory;
		ret.inputAS = inputLearninigAS;
		ret.outputAS = engine.getOutputAS();
		ret.learnigAnnotationType = learninigAnnotType;
		return ret;
	}


	protected List<PRSetup> addTrainMLEngines(List<PRSetup> prs) throws JDOMException, IOException
	{
		for (int i = 0; i < engines.length; i++)
		{
			prs.addAll(engines[i].getTrainControllerSetup(getMLEngineConfig(engines[i])));				
		}
		return prs;
	}

	protected List<PRSetup> addTestMLEngines(List<PRSetup> prs) throws JDOMException, IOException
	{
		for (int i = 0; i < engines.length; i++)
		{
			prs.addAll(engines[i].getTestControllerSetup(getMLEngineConfig(engines[i])));				
		}
		return prs;
	}

	
	public void trainOnly() {};
	public void crossValidation(int numOfFolds) {};


}
