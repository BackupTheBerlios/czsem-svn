package czsem.gate.learning;

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
import gate.persist.PersistenceException;
import gate.util.GateException;
import gate.util.profile.Profiler;

import java.io.File;
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URISyntaxException;
import java.util.Arrays;
import java.util.Enumeration;
import java.util.List;

import org.apache.log4j.Appender;
import org.apache.log4j.BasicConfigurator;
import org.apache.log4j.Level;
import org.apache.log4j.Logger;
import org.jdom.JDOMException;

import czsem.gate.GateUtils;
import czsem.gate.plugins.AnnotationDependencyRootMarker;
import czsem.gate.plugins.CrossValidation;
import czsem.gate.learning.MLEngine.ILPEngine;
import czsem.utils.Config;

public class MachineLearningExperimenter
{
	static Logger logger = Logger.getLogger(MachineLearningExperimenter.class);

	public interface TrainTest
	{
		List<PRSetup> getTrainControllerSetup() throws JDOMException, IOException;
		List<PRSetup> getTestControllerSetup() throws JDOMException, IOException;
	}
	
	public static abstract class ExperimentSetup implements TrainTest
	{
		protected String dataStore;
		protected String copusId;
		protected MLEngine[] engines;
		protected String learninigAnnotType;
		
		public ExperimentSetup(String dataStore, String copusId, MLEngine ... engines) {
			this.dataStore = dataStore;
			this.copusId = copusId;
			this.engines = engines;
		}
		
		protected void initEngines(String config_directory) throws MalformedURLException, JDOMException, IOException
		{
			learninigAnnotType = null;
			for (int i = 0; i < engines.length; i++)
			{
				engines[i].init(config_directory);
				
				//check if LearninigAnnotType matches among ML engines 
				String curLearninigAnnotType = engines[i].getLearninigAnnotType();				
				if (learninigAnnotType == null) learninigAnnotType = curLearninigAnnotType;
				else if (learninigAnnotType.equals(curLearninigAnnotType))
				{
					logger.warn(String.format(
							"Learninig annotation types do not match! %s: %s, %s: %s",
							engines[i].getClass().getName(),
							curLearninigAnnotType,
							engines[i-1].getClass().getName(),
							learninigAnnotType));
					
					learninigAnnotType = curLearninigAnnotType;					
				}
			}			
		}
		
		protected List<PRSetup> addTrainMLEngines(List<PRSetup> prs) throws JDOMException, IOException
		{
			for (int i = 0; i < engines.length; i++)
			{
				prs.addAll(engines[i].getTrainControllerSetup());				
			}
			return prs;
		}

		protected List<PRSetup> addTestMLEngines(List<PRSetup> prs) throws JDOMException, IOException
		{
			for (int i = 0; i < engines.length; i++)
			{
				prs.addAll(engines[i].getTestControllerSetup());				
			}
			return prs;
		}

		
		public Corpus getCorpus() throws PersistenceException, ResourceInstantiationException
		{
		    DataStore ds = GateUtils.openDataStore(dataStore);
		    Corpus corpus = GateUtils.loadCorpusFormDatastore(ds, copusId);			
		    return corpus; 
		}		
	}
	
	public interface PRSetup
	{
		public ProcessingResource createPR() throws ResourceInstantiationException;		
	}
	

	public static class SinglePRSetup implements PRSetup 
	{
		private Class<?> pr_class;
		FeatureMap fm;

		public SinglePRSetup(Class<?> cl)
		{
			pr_class = cl;
			fm = Factory.newFeatureMap();
		}
				
		public SinglePRSetup putFeature(Object key, Object value)
		{
			fm.put(key, value);
			return this;
		}
		public SinglePRSetup putFeatureList(Object key, String ... strig_list)
		{
			if (strig_list == null)
				fm.put(key, null);
			else
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
	
	public static void trainOnly(ExperimentSetup setup) throws ResourceInstantiationException, JDOMException, IOException, PersistenceException, ExecutionException
	{
	    SerialAnalyserController train_controller = buildGatePipeline(setup.getTrainControllerSetup());
	    
	    train_controller.setCorpus(setup.getCorpus());			    	    	    
	    train_controller.execute();
		
	}
	

	public static void runExperiment(ExperimentSetup setup, int number_of_folds) throws ResourceInstantiationException, ExecutionException, PersistenceException, JDOMException, IOException
	{
	    SerialAnalyserController train_controller = buildGatePipeline(setup.getTrainControllerSetup());
	    SerialAnalyserController test_controller = buildGatePipeline(setup.getTestControllerSetup());
	    
		new SinglePRSetup(CrossValidation.class)
			.putFeature("corpus", setup.getCorpus())
			.putFeature("numberOfFolds", number_of_folds)
			.putFeature("trainingPR", train_controller)
			.putFeature("testingPR", test_controller).createPR().execute();

	}
	
	public static void main(String [] args) throws GateException, URISyntaxException, IOException, JDOMException
	{
		BasicConfigurator.configure();
	    Logger logger = Logger.getRootLogger();
	    logger.setLevel(Level.ALL);

	    @SuppressWarnings("unchecked")
		Enumeration<Appender> apps = logger.getAllAppenders();
	    while (apps.hasMoreElements())
	    {
	    	Appender app = apps.nextElement();
	    	if (app.getName() == null)
	    	{
	    		logger.removeAppender(app);
	    	}
	    }

	    logger = Logger.getLogger(Profiler.class);
	    logger.setLevel(Level.OFF);
	    logger = Logger.getLogger(SerialController.class);
	    logger.setLevel(Level.OFF);
	    logger = Logger.getLogger(Gate.class);
	    logger.setLevel(Level.OFF);
	    logger = Logger.getLogger(AnnotationDependencyRootMarker.class);
	    logger.setLevel(Level.ALL);

		
	    Config.getConfig().setGateHome();
	    Gate.init();
//	    GateUtils.registerPluginDirectory("Parser_Stanford");
	    GateUtils.registerPluginDirectory("Machine_Learning");
	    GateUtils.registerPluginDirectory("ANNIE");
	    GateUtils.registerPluginDirectory("Tools");
	    GateUtils.registerPluginDirectory("Learning");
	    
	    GateUtils.registerPluginDirectory(new File("czsem_GATE_plugins"));
		    		    
//	    Corpus corpus = GateUtils.loadCorpusFormDatastore(ds, "ISWC___1274943456887___5663");
//	    Corpus corpus = GateUtils.loadCorpusFormDatastore(ds, "fatalities___1277473852041___7082");
	    
//	    runExperiment(new TrainTestAcquisitions(), 2);	    
//	    runExperiment(new TrainTestGateOnCzech(), 2);	    
//	    trainOnly(new TrainTestGateOnCzech(false, true));
//	    trainOnly(new TrainTestAcquisitions(new ILPEngine()));
	    trainOnly(new TrainTestCzechFireman(new ILPEngine()));
	}
}
