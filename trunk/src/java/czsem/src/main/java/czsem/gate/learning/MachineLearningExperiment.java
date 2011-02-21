package czsem.gate.learning;

import gate.creole.ExecutionException;
import gate.creole.ResourceInstantiationException;
import gate.creole.SerialAnalyserController;
import gate.creole.annotdelete.AnnotationDeletePR;
import gate.persist.PersistenceException;

import java.io.IOException;
import java.net.MalformedURLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.jdom.JDOMException;

import czsem.gate.learning.MLEngine.MLEngineConfig;
import czsem.gate.plugins.CrossValidation;
import czsem.gate.plugins.LearningEvaluator;


public class MachineLearningExperiment
{
	public static interface TrainTest
	{
		List<PRSetup> getTrainControllerSetup(MLEngine.MLEngineConfig config) throws MalformedURLException;
		List<PRSetup> getTestControllerSetup(MLEngine.MLEngineConfig config) throws MalformedURLException;
		String getDefaultOutputAS();
		String getDefaultLearningAnnotationType();
	}

	
	/** Usually TectoMT, loaded form dataSet.tectoMTAS **/
	protected String inputLearninigAS;
	
	protected DataSet dataSet;
	protected MachineLearningExperiment.TrainTest[] engines;
	
	public MachineLearningExperiment(DataSet dataSet, MachineLearningExperiment.TrainTest ... engines)
	{
		this.dataSet = dataSet;
		this.engines = engines;
		
		inputLearninigAS = dataSet.getTectoMTAS();
	}

	
	public List<PRSetup> getTrainControllerSetup() throws JDOMException, IOException
	{
		List<PRSetup> prs = new ArrayList<PRSetup>();
		

		return addTrainMLEngines(prs);
	}
	
	public List<PRSetup> getTestControllerSetup() throws JDOMException, IOException
	{
		List<PRSetup> prs = new ArrayList<PRSetup>();
		
		//Reset engines outASs		
		String [] outAS = new String[engines.length];
		for (int i = 0; i < outAS.length; i++) {
			outAS[i] = engines[i].getDefaultOutputAS();
		}
		prs.add(new PRSetup.SinglePRSetup(AnnotationDeletePR.class)
			.putFeature("setsToRemove", Arrays.asList(outAS)));		
		
		return addTestMLEngines(prs);
	}

	
	protected MLEngineConfig getMLEngineConfig(MachineLearningExperiment.TrainTest engine)
	{
		MLEngineConfig ret = new MLEngineConfig();
		ret.experimentLearningConfigsDirectory = dataSet.getLearnigConfigDirectory();
		ret.inputAS = inputLearninigAS;
		ret.outputAS = engine.getDefaultOutputAS();
		ret.learnigAnnotationType = engine.getDefaultLearningAnnotationType();
		ret.keyAS = dataSet.getKeyAS();
		ret.originalLearnigAnnotationTypes = Arrays.asList(dataSet.getLearnigAnnotationTypes()); 
		return ret;
	}


	protected List<PRSetup> addTrainMLEngines(List<PRSetup> prs) throws JDOMException, IOException
	{
		for (int i = 0; i < engines.length; i++)
		{
			//TectoMT reset
			prs.add(new PRSetup.SinglePRSetup(AnnotationDeletePR.class)
				.putFeatureList("annotationTypes", engines[i].getDefaultLearningAnnotationType())
				.putFeatureList("setsToRemove", inputLearninigAS));		

			prs.addAll(engines[i].getTrainControllerSetup(getMLEngineConfig(engines[i])));				
		}
		return prs;
	}

	protected List<PRSetup> addTestMLEngines(List<PRSetup> prs) throws JDOMException, IOException
	{
		for (int i = 0; i < engines.length; i++)
		{
			//TectoMT reset
			prs.add(new PRSetup.SinglePRSetup(AnnotationDeletePR.class)
				.putFeatureList("annotationTypes", engines[i].getDefaultLearningAnnotationType())
				.putFeatureList("setsToRemove", inputLearninigAS));		

			
			prs.addAll(engines[i].getTestControllerSetup(getMLEngineConfig(engines[i])));				
		}
		return prs;
	}

	
	public void trainOnly() throws PersistenceException, ResourceInstantiationException, JDOMException, IOException, ExecutionException
	{
	    SerialAnalyserController train_controller = PRSetup.buildGatePipeline(getTrainControllerSetup());
	    
	    train_controller.setCorpus(dataSet.getCorpus());			    	    	    
	    train_controller.execute();
	}
	
	public void testOnly() throws ResourceInstantiationException, JDOMException, IOException, PersistenceException, ExecutionException
	{
	    SerialAnalyserController train_controller = PRSetup.buildGatePipeline(getTestControllerSetup());
	    
	    train_controller.setCorpus(dataSet.getCorpus());			    	    	    
	    train_controller.execute();
	}

	
	public void crossValidation(int numOfFolds) throws ExecutionException, ResourceInstantiationException, PersistenceException, JDOMException, IOException
	{
	    SerialAnalyserController train_controller = PRSetup.buildGatePipeline(getTrainControllerSetup());
	    SerialAnalyserController test_controller = PRSetup.buildGatePipeline(getTestControllerSetup());
	    
		new PRSetup.SinglePRSetup(CrossValidation.class)
			.putFeature("corpus", dataSet.getCorpus())
			.putFeature("numberOfFolds", numOfFolds)
			.putFeature("trainingPR", train_controller)
			.putFeature("testingPR", test_controller).createPR().execute();
		
		LearningEvaluator.CentralResultsRepository.repository.logAll();
	}


}