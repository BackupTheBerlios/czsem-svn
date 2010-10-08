package czsem.gate;

import gate.Corpus;
import gate.DataStore;
import gate.Factory;
import gate.FeatureMap;
import gate.Gate;
import gate.ProcessingResource;
import gate.creole.ExecutionException;
import gate.creole.ResourceInstantiationException;
import gate.creole.SerialAnalyserController;
import gate.creole.SerialController;
import gate.util.GateException;
import gate.util.profile.Profiler;

import java.io.File;
import java.io.IOException;
import java.net.URISyntaxException;
import java.util.Arrays;
import java.util.List;

import org.apache.log4j.BasicConfigurator;
import org.apache.log4j.Level;
import org.apache.log4j.Logger;
import org.jdom.JDOMException;

import czsem.gate.plugins.CrossValidation;
import czsem.utils.Config;

public class MachineLearningExperimenter
{
	public interface ExperimentSetup
	{
		List<PRSetup> getTrainControllerSetup();
		List<PRSetup> getTestControllerSetup();
	}
	
	public static class PRSetup
	{
		private Class<?> pr_class;
		FeatureMap fm;

		public PRSetup(Class<?> cl)
		{
			pr_class = cl;
			fm = Factory.newFeatureMap();
		}
				
		public PRSetup putFeature(Object key, Object value)
		{
			fm.put(key, value);
			return this;
		}
		public PRSetup putFeatureList(Object key, String ... strig_list)
		{
			fm.put(key, Arrays.asList(strig_list));
			return this;
		}

		public ProcessingResource createPR() throws ResourceInstantiationException
		{
			return(ProcessingResource) Factory.createResource(pr_class.getCanonicalName(), fm);			
		}				
	}
	
	public static SerialAnalyserController buildGatePipeline(List<PRSetup> prs) throws ResourceInstantiationException
	{
		SerialAnalyserController controller = (SerialAnalyserController)	    	   
			Factory.createResource(SerialAnalyserController.class.getCanonicalName());

		
		for (int i = 0; i < prs.size(); i++)
		{
			controller.add(prs.get(i).createPR());			
		}
		
		
		return controller;		
	}
	
	public static void runExperiment(ExperimentSetup setup, Corpus corpus, int number_of_folds) throws ResourceInstantiationException, ExecutionException
	{
	    SerialAnalyserController train_controller = buildGatePipeline(setup.getTrainControllerSetup());
	    SerialAnalyserController test_controller = buildGatePipeline(setup.getTestControllerSetup());
	    
		new PRSetup(CrossValidation.class)
			.putFeature("corpus", corpus)
			.putFeature("numberOfFolds", number_of_folds)
			.putFeature("trainingPR", train_controller)
			.putFeature("testingPR", test_controller).createPR().execute();

	}
	
	public static void main(String [] args) throws GateException, URISyntaxException, IOException, JDOMException
	{
		BasicConfigurator.configure();
	    Logger logger = Logger.getLogger(Profiler.class);
	    logger.setLevel(Level.OFF);
	    logger = Logger.getLogger(SerialController.class);
	    logger.setLevel(Level.OFF);
	    logger = Logger.getLogger(Gate.class);
	    logger.setLevel(Level.OFF);

		
	    Config.getConfig().setGateHome();
	    Gate.init();
//	    GateUtils.registerPluginDirectory("Parser_Stanford");
	    GateUtils.registerPluginDirectory("Machine_Learning");
	    GateUtils.registerPluginDirectory("ANNIE");
	    GateUtils.registerPluginDirectory("Tools");
	    GateUtils.registerPluginDirectory("Learning");
	    
	    GateUtils.registerPluginDirectory(new File("czsem_GATE_plugins"));
		    	
	    DataStore ds = GateUtils.openDataStore("file:/C:/Users/dedek/AppData/GATE/ISWC");
	    
	    Corpus corpus = GateUtils.loadCorpusFormDatastore(ds, "ISWC___1274943456887___5663");
//	    Corpus corpus = GateUtils.loadCorpusFormDatastore(ds, "fatalities___1277473852041___7082");
	    
	    runExperiment(new TrainTestGateOnCzech(), corpus, 2);	    
	}
}
