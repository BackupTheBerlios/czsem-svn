package czsem.gate.learning;

import gate.Gate;
import gate.creole.ExecutionException;
import gate.creole.ResourceInstantiationException;
import gate.creole.SerialController;
import gate.learning.LogService;
import gate.persist.PersistenceException;
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
import czsem.gate.learning.DataSet.DataSetImpl.*;
import czsem.gate.learning.DataSet.DataSetReduce;
import czsem.gate.learning.MLEngine.ILPEngine;
import czsem.gate.learning.MLEngine.PaumEngine;
import czsem.gate.learning.MLEngineEncapsulate.*;
import czsem.gate.plugins.AnnotationDependencyRootMarker;
import czsem.gate.plugins.CrossValidation;
import czsem.gate.plugins.LearningEvaluator;
import czsem.utils.Config;

public class MachineLearningExperimenter
{
	
	public static MachineLearningExperiment acquisitions() throws URISyntaxException, IOException
	{
		return
			new MachineLearningExperiment(
	    		new DataSetReduce(new Acquisitions("acquired"), 0.1),
//	    		new MLEvaluate(new CreateTemporaryMentions(new ILPEngine()))
	    		new MLEvaluate(new CreateTemporaryMentionsRootSubtree(new ILPEngine())),
	    		new MLEvaluate(
	    				new CreateTemporaryMentions(
	    	    				new MentionsSubtreePostprocessing(
	    	    						new ILPEngine("ILP_config_NE_roots_subtree.xml")))),	    		
	    		new MLEvaluate(
    	    				new CreateTemporaryMentionsReferedMentionsPostprocessing(
    	    						new ILPEngine("ILP_config_NE_roots.xml"))),
	    	    new MLEvaluate(new CreatePersistentMentions(new PaumEngine())));
//	    		new ILPEngine()

		
	}
	
	public static MachineLearningExperiment czechFiremanSimple() throws URISyntaxException, IOException
	{
		return 	    
			new MachineLearningExperiment(
	    		new CzechFireman("cars"),
//	    		new MLEvaluate(new CreateTemporaryMentions(new ILPEngine())),
	    		new MLEvaluate(new CreateTemporaryMentionsRootSubtree(new ILPEngine("ILP_root_subtree.xml"))),
/*
	    		new MLEvaluate(
	    				new CreateTemporaryMentions(
	    	    				new MentionsSubtreePostprocessing(
	    	    						new ILPEngine("ILP_config_NE_roots_subtree.xml")))),	    		
	    		new MLEvaluate(
    	    				new CreateTemporaryMentionsReferedMentionsPostprocessing(
    	    						"Lookup_root.origRootID",
    	    						new ILPEngine("ILP_config_NE_roots.xml"))),
/**/    	    						
	    		new MLEvaluate(new CreateTemporaryMentions(new SubsequentAnnotationMerge(new ILPEngine()))),
	    	    new MLEvaluate(new CreatePersistentMentions(new PaumEngine()))

/*
	    		new MLEvaluate(
	    				new CreateTemporaryMentions(
	    	    				new MentionsSubtreePostprocessing(
	    	    						new ILPEngine("ILP_config_NE_roots_subtree.xml")))),	    		
	    		new MLEvaluate(
    	    				new CreateTemporaryMentionsReferedMentionsPostprocessing(
    	    						new ILPEngine("ILP_config_NE_roots.xml"))),
	    	    new MLEvaluate(new CreatePersistentMentions(new PaumEngine()))
*/	    	    
//	    		new ILPEngine()
			);

		
	}
	
/*
	public static void main(String [] args) throws GateException, URISyntaxException, IOException, JDOMException, BenchmarkReportInputFileFormatException
	{
		for (int i = 0; i < 5; i++)
		{
			main2(args);			
		}
	}
/**/
	
    static Logger logger = Logger.getLogger(MachineLearningExperimenter.class);

    public static void initEnvironment() throws GateException, URISyntaxException, IOException
	{
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

	    GateUtils.registerPluginDirectory("Machine_Learning");
	    GateUtils.registerPluginDirectory("ANNIE");
	    GateUtils.registerPluginDirectory("Tools");
	    GateUtils.registerPluginDirectory("Learning");
	    
	    GateUtils.registerCzsemPlugin();
		    		    
	    	    
	    LogService.minVerbosityLevel = 0;		
	}

	
	public static void saveResults(String results_file_name) throws BenchmarkReportInputFileFormatException, URISyntaxException, IOException
	{
	    WekaResultExporter ex = new WekaResultExporter();
	    ex.initFromLearningEvaluatorCentralResultsRepository();
	    ex.addInfoFromTimeBechmark();
	    ex.saveAll(results_file_name);		    		
	}
	
	public static void bigAcquisitionsExperiment(String results_file_name) throws BenchmarkReportInputFileFormatException, URISyntaxException, IOException, ExecutionException, ResourceInstantiationException, PersistenceException, JDOMException
	{
		for (String annot_type : Acquisitions.eval_annot_types)
		{
		    LearningEvaluator.CentralResultsRepository.repository.clear();
		    
//		    GateUtils.deleteGateTimeBenchmarkFile();
		    GateUtils.enableGateTimeBenchmark();
		    
//			DataSet dataset = new Acquisitions(annot_type);
			DataSet dataset = new DataSetReduce(new Acquisitions(annot_type), 0.1);
			dataset.clearSevedFilesDirectory();
			
			MachineLearningExperiment experiment = new MachineLearningExperiment(
		    		dataset,
		    		new MLEvaluate(
		    				new CreateTemporaryMentionsReferedMentionsPostprocessing(
		    						new ILPEngine("ILP_config_NE_roots.xml"))),
		    		/*
		    		new MLEvaluate(
		    				new CreateTemporaryMentions(
		    	    				new MentionsSubtreePostprocessing(
		    	    						new ILPEngine("ILP_config_NE_roots_subtree.xml")))),	    		
    	    		new MLEvaluate(new CreateTemporaryMentions(
		    	    		new SubsequentAnnotationMerge(new ILPEngine()))),
/**/
		    	    new MLEvaluate(new CreatePersistentMentions(new PaumEngine()))
		    );
			experiment.crossValidation(2);
			
			
		    logger.info("saving results, counting time statistics...");
		    saveResults(results_file_name);
			
		   
		    GateUtils.deleteAllPublicGateResources();
		}		
	}
    
    public static void main(String [] args) throws Exception
	{
		initEnvironment();
		
		String results_file_name = "weka_results.csv";
		
		new File(results_file_name).delete();
		
		bigAcquisitionsExperiment(results_file_name);
		
		WekaResultTests t = new WekaResultTests(System.err);
		t.loadInstances(results_file_name);
		t.testsAttr(6); //F1

		
	}

/*	    
	    new MachineLearningExperiment(
	    		new Acquisitions("acquired"),
//	    		new DataSetReduce(new Acquisitions("acquired"), 0.05),
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
/**/	    
	    
//	    czechFiremanSimple().crossValidation(10);
	    
	    
//	    logger.info("time statistics:\n"+GateUtils.createGateTimeBenchmarkReport());	    
	    
	    

	    
	    
	    //	    trainOnly(new TrainTestGateOnCzech(false, true));
//	    trainOnly(new TrainTestAcquisitions(new ILPEngine()));
//	    trainOnly(new TrainTestCzechFireman(new ILPEngine()));
//	}
	
	
	
	
	
	
	
	
	
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
