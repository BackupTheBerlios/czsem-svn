package czsem.gate.learning;

import gate.Gate;
import gate.creole.SerialController;
import gate.learning.LogService;
import gate.util.GateException;
import gate.util.profile.Profiler;
import gate.util.reporting.exceptions.BenchmarkReportInputFileFormatException;

import java.io.File;
import java.io.IOException;
import java.net.URISyntaxException;
import java.util.Enumeration;

import org.apache.commons.lang.StringEscapeUtils;
import org.apache.log4j.Appender;
import org.apache.log4j.BasicConfigurator;
import org.apache.log4j.Level;
import org.apache.log4j.Logger;
import org.jdom.JDOMException;

import czsem.gate.GateUtils;
import czsem.gate.learning.DataSet.DataSetImpl.Acquisitions;
import czsem.gate.learning.DataSet.DataSetReduce;
import czsem.gate.learning.MLEngine.ILPEngine;
import czsem.gate.learning.MLEngine.PaumEngine;
import czsem.gate.learning.MLEngineEncapsulate.*;
import czsem.gate.learning.MLEngineEncapsulate.CreateTemporaryMentionsReferedMentionsPostprocessing;
import czsem.gate.learning.MLEngineEncapsulate.MLEvaluate;
import czsem.gate.plugins.AnnotationDependencyRootMarker;
import czsem.gate.plugins.CrossValidation;
import czsem.utils.Config;

public class MachineLearningExperimenter
{
/*	
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
		protected MLEngineOld[] engines;
		protected LearningSetup learningSetup;
		
		public ExperimentSetup(String dataStore, String copusId, MLEngineOld ... engines) {
			this.dataStore = dataStore;
			this.copusId = copusId;
			this.engines = engines;
		}
		
		protected void initEngines(String config_directory) throws MalformedURLException, JDOMException, IOException
		{
			learningSetup = null;
			for (int i = 0; i < engines.length; i++)
			{
				engines[i].init(config_directory);
				
				//check if LearninigAnnotType matches among ML engines 
				LearningSetup curLearninigSetup = engines[i].getLearninigSetup();
				
				if (learningSetup == null) learningSetup = curLearninigSetup;
				else if (! learningSetup.equals(curLearninigSetup))
				{
					logger.warn(String.format(
							"Learninig setups do not match! %s: %s, %s: %s",
							engines[i].getClass().getName(),
							curLearninigSetup.toString(),
							engines[i-1].getClass().getName(),
							learningSetup.toString()));
					
					learningSetup = curLearninigSetup;					
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
	
	
	
	public static void trainOnly(ExperimentSetup setup) throws ResourceInstantiationException, JDOMException, IOException, PersistenceException, ExecutionException
	{
	    SerialAnalyserController train_controller = buildGatePipeline(setup.getTrainControllerSetup());
	    
	    train_controller.setCorpus(setup.getCorpus());			    	    	    
	    train_controller.execute();
		
	}
	

	public static void runExperiment(ExperimentSetup setup, int number_of_folds) throws ResourceInstantiationException, ExecutionException, PersistenceException, JDOMException, IOException
	{
		
		measureResults(setup.learningSetup, setup.getCorpus());

	}
/**	
	protected static void measureResults(LearningSetup learningSetup, Corpus corpus) throws ResourceInstantiationException, ExecutionException
	{
		/*
	private String keyASName;
	private String responseASName;
	private String annotationType;
	private List<String> featureNames;
		 *//*
		
		
		PRSetup [] pr = {
			new SinglePRSetup(LearningEvaluator.class)
				.putFeature("keyASName", learningSetup.getKeyASName())
				.putFeature("responseASName", learningSetup.getResponseASName())
				.putFeature("annotationType", learningSetup.getLearninigAnnotType())
				.putFeatureList("featureNames", learningSetup.getClassFetureName())
		};

		SerialAnalyserController pl = buildGatePipeline(Arrays.asList(pr));
		pl.setCorpus(corpus);
		
		pl.execute();
		
/*		
//		pr.
		AnnotationDiffer differ = new AnnotationDiffer();
		differ.setSignificantFeaturesSet(new HashSet<String>(0));
		ClassificationMeasures classificationMeasures = new ClassificationMeasures();  
*//*		
	}
*/
	public static void main(String [] args) throws GateException, URISyntaxException, IOException, JDOMException, BenchmarkReportInputFileFormatException
	{
//		PropertyConfigurator.configure("C:\\Program Files\\gate\\GATE-6.0\\bin\\log4j.properties");
		

	    Logger logger = Logger.getRootLogger();
	    logger.setLevel(Level.ALL);
		BasicConfigurator.configure();

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
	    logger = Logger.getLogger(CrossValidation.class);
	    logger.setLevel(Level.INFO);

		
	    Config.getConfig().setGateHome();
	    Gate.init();

	    GateUtils.enableGateBenchmark();

//	    GateUtils.registerPluginDirectory("Parser_Stanford");
	    GateUtils.registerPluginDirectory("Machine_Learning");
	    GateUtils.registerPluginDirectory("ANNIE");
	    GateUtils.registerPluginDirectory("Tools");
	    GateUtils.registerPluginDirectory("Learning");
	    
	    GateUtils.registerPluginDirectory(new File("czsem_GATE_plugins"));
		    		    
//	    Corpus corpus = GateUtils.loadCorpusFormDatastore(ds, "ISWC___1274943456887___5663");
//	    Corpus corpus = GateUtils.loadCorpusFormDatastore(ds, "fatalities___1277473852041___7082");
	    
//	    runExperiment(new TrainTestAcquisitions(), 2);	    
//	    runExperiment(new TrainTestCzechFireman(new ILPEngine()), 2);
	    
	    LogService.minVerbosityLevel = 0;
	    
	    new MachineLearningExperiment(
	    		new DataSetReduce(new Acquisitions("acquired"), 0.1),
//	    		new CzechFireman("damage"),
//	    		new MLEvaluate(new CreateTemporaryMentions(new ILPEngine()))
	    		new MLEvaluate(new CreateTemporaryMentionsRootSubtree(new ILPEngine())),
	    		new MLEvaluate(
	    				new CreateTemporaryMentions(
	    	    				new MentionsSubtreePostprocessing(
	    	    						new ILPEngine("ILP_config_NE_roots_subtree.xml")))),	    		
	    		new MLEvaluate(
    	    				new CreateTemporaryMentionsReferedMentionsPostprocessing(
    	    						new ILPEngine("ILP_config_NE_roots.xml"))),
	    	    new MLEvaluate(new CreatePersistentMentions(new PaumEngine()))
//	    		new ILPEngine()
	    ).crossValidation(2);
	    
	    
	    
	    logger.info("time statistics:\n"+GateUtils.createGateBenchmarkReport());
	    
	    
	    

	    
	    
	    //	    trainOnly(new TrainTestGateOnCzech(false, true));
//	    trainOnly(new TrainTestAcquisitions(new ILPEngine()));
//	    trainOnly(new TrainTestCzechFireman(new ILPEngine()));
	}
	
	@SuppressWarnings("rawtypes")
	public static void jape_pok (gate.Document doc, java.util.Map bindings, 
			                     gate.AnnotationSet annotations, 
			                     gate.AnnotationSet inputAS, gate.AnnotationSet outputAS, 
			                     gate.creole.ontology.Ontology ontology)
	{
		gate.AnnotationSet binding_as = (gate.AnnotationSet) bindings.get("anot_tmp");
		gate.Annotation annot = binding_as.iterator().next();
		annot.getFeatures().put("rule", "damage_add_learninig_feature");
		
		
		
		String lemma = "lema";
		String form = "form";
		
		if (lemma.startsWith("&"))	
			lemma = StringEscapeUtils.unescapeXml(lemma);

		int slash =  lemma.indexOf('-', 1);
		int under =  lemma.indexOf('_', 1);
		
		int substr_end = lemma.length();
		
		if (slash > 0) substr_end = slash;
		if (under > 0) substr_end = Math.min(substr_end, under);

		
		char first_ch = lemma.charAt(0);
		
		if (Character.isUpperCase(form.charAt(0)))
		{
			first_ch = Character.toUpperCase(first_ch);			
		}

		//String clean_lemma = first_ch + lemma.substring(1, substr_end);

		
		
/*		
		gate.AnnotationSet binding_as = (gate.AnnotationSet) bindings.get("anot_tmp");
		gate.Annotation annot = binding_as.iterator().next();
		String typename = annot.getType();
		String new_typename = typename.replaceFirst("Dependecy", "Dependency");
		FeatureMap fm = annot.getFeatures();
		outputAS.add(annot.getStartNode(), annot.getEndNode(), new_typename, fm);
		inputAS.remove(annot);
/*
		gate.AnnotationSet b_as = (gate.AnnotationSet) bindings.get("dep_tmp");
		gate.Annotation dep_an = b_as.iterator().next();
		
		Object dep_kind = dep_an.getFeatures().get("kind");
		List<Integer> args = (List<Integer>) dep_an.getFeatures().get("args");
			
		gate.Annotation token_an = inputAS.get(args.get(1));
		gate.FeatureMap fm = token_an.getFeatures();
		fm.put("depency_type", dep_kind);
		*/		
	}

}
