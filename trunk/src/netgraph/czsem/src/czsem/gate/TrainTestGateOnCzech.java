package czsem.gate;

import gate.Corpus;
import gate.DataStore;
import gate.Factory;
import gate.FeatureMap;
import gate.Gate;
import gate.ProcessingResource;
import gate.creole.ResourceInstantiationException;
import gate.creole.SerialAnalyserController;
import gate.creole.SerialController;
import gate.creole.annotdelete.AnnotationDeletePR;
import gate.creole.annotransfer.AnnotationSetTransfer;
import gate.creole.ml.MachineLearningPR;
import gate.util.GateException;
import gate.util.profile.Profiler;

import java.io.File;
import java.io.IOException;
import java.net.MalformedURLException;
import java.util.Arrays;

import org.apache.log4j.BasicConfigurator;
import org.apache.log4j.Level;
import org.apache.log4j.Logger;

import czsem.gate.plugins.AnnotationDependencyRootMarker;
import czsem.gate.plugins.AnnotationDependencySubtreeMarker;
import czsem.gate.plugins.CrossValidation;
import czsem.gate.plugins.SubsequentAnnotationMerge;
	
public class TrainTestGateOnCzech {
	
	public static final String learninigAnnotType = "fatalities";
//	public static final String learninigAnnotType = "damage";
	public static final boolean rootSubtreeLearninig = false;
	public static final boolean runPaum = true;
	public static final boolean runILP = true;
	
	
	protected static ProcessingResource tectoMTReset;

	public static SerialAnalyserController constructTestController() throws ResourceInstantiationException, MalformedURLException
	{
		SerialAnalyserController test_controller = (SerialAnalyserController)	    	   
			Factory.createResource(SerialAnalyserController.class.getCanonicalName());
		
		FeatureMap fm;


		
		//TectoMT reset
		test_controller.add(tectoMTReset);

		
		
		
		//Reset Paum & ILP
		fm = Factory.newFeatureMap();
		fm.put("setsToRemove", Arrays.asList(new String [] {"ILP", "Paum"}));
		ProcessingResource resetPaumAndILP = (ProcessingResource) 
			Factory.createResource(AnnotationDeletePR.class.getCanonicalName(), fm);
		test_controller.add(resetPaumAndILP);
		
		
		
		
		if (runILP)
		{
			//ILP Apply
			fm = Factory.newFeatureMap();
			fm.put("configFileURL", new File("gate-learning/sampleConfigILP.xml").toURI().toURL());
			fm.put("inputASName", "TectoMT");
			fm.put("training", false);		
			ProcessingResource ilpApply = (ProcessingResource) 
				Factory.createResource(MachineLearningPR.class.getCanonicalName(), fm);
			test_controller.add(ilpApply);
			
	
			
			if (rootSubtreeLearninig)
			{
				//Subtree for ILP results
				fm = Factory.newFeatureMap();
				fm.put("inputASName", "TectoMT");
				fm.put("outputASName", "ILP");
				fm.put("inputAnnotationTypeNames", Arrays.asList(new String [] {learninigAnnotType + "_root"}));
				ProcessingResource subtreeForILPresults = (ProcessingResource) 
					Factory.createResource(AnnotationDependencySubtreeMarker.class.getCanonicalName(), fm);
				test_controller.add(subtreeForILPresults);
	
				
				
				//ILP Output Transfer
				fm = Factory.newFeatureMap();
				fm.put("inputASName", "TectoMT");
				fm.put("outputASName", "ILP");
				fm.put("annotationTypes", Arrays.asList(new String [] {learninigAnnotType + "_root"}));		
				fm.put("copyAnnotations", false);		
				ProcessingResource ILPoutputTransfer = (ProcessingResource) 
					Factory.createResource(AnnotationSetTransfer.class.getCanonicalName(), fm);
				test_controller.add(ILPoutputTransfer);
							
			}
			else
			{
				//Subsequent annotation merge
				fm = Factory.newFeatureMap();
				fm.put("inputASName", "TectoMT");
				fm.put("outputASName", "ILP");
				fm.put("annotationTypeName", learninigAnnotType);
				fm.put("deleteOriginalAnnotations", true);
				ProcessingResource mergeILPresults = (ProcessingResource) 
					Factory.createResource(SubsequentAnnotationMerge.class.getCanonicalName(), fm);
				test_controller.add(mergeILPresults);			
			}
		}

		
		if (runPaum)
		{
			//Paum Application
			fm = Factory.newFeatureMap();
			fm.put("configFileURL", new File("gate-learning/ml-config-file.xml").toURI().toURL());
			fm.put("inputASName", "TectoMT");
			fm.put("outputASName", "Paum");
			fm.put("learningMode", "APPLICATION");		
			ProcessingResource paumApplication = (ProcessingResource) 
				Factory.createResource("gate.learning.LearningAPIMain", fm);
			test_controller.add(paumApplication);
		}

		
		return test_controller;
	}

	
	public static SerialAnalyserController constructTrainController() throws ResourceInstantiationException, MalformedURLException
	{
		SerialAnalyserController train_controller = (SerialAnalyserController)	    	   
			Factory.createResource(SerialAnalyserController.class.getCanonicalName());
		
		FeatureMap fm;
		
		
		
		//TectoMT reset
		fm = Factory.newFeatureMap();
		fm.put("annotationTypes", Arrays.asList(new String [] {
				learninigAnnotType, learninigAnnotType + "_root"}));
		fm.put("setsToRemove", Arrays.asList(new String [] {"TectoMT"}));
		tectoMTReset = (ProcessingResource) 
			Factory.createResource(AnnotationDeletePR.class.getCanonicalName(), fm);
		train_controller.add(tectoMTReset);
		
		
		
		//Training transfer
		fm = Factory.newFeatureMap();
		fm.put("inputASName", "accident");
		fm.put("outputASName", "TectoMT");
		fm.put("annotationTypes", Arrays.asList(new String [] {learninigAnnotType}));
		fm.put("copyAnnotations", true);		
		ProcessingResource trainingTransfer = (ProcessingResource) 
			Factory.createResource(AnnotationSetTransfer.class.getCanonicalName(), fm);
		train_controller.add(trainingTransfer);
		
		
		if (rootSubtreeLearninig)
		{
		
			//Training roots
			fm = Factory.newFeatureMap();
			fm.put("inputASName", "TectoMT");
			fm.put("outputASName", "TectoMT");
			fm.put("inputAnnotationTypeNames", Arrays.asList(new String [] {learninigAnnotType}));
			ProcessingResource trainingRoots = (ProcessingResource) 
				Factory.createResource(AnnotationDependencyRootMarker.class.getCanonicalName(), fm);
			train_controller.add(trainingRoots);
		}
		
		
		if (runILP)
		{
			//ILP train
			fm = Factory.newFeatureMap();
			fm.put("configFileURL", new File("gate-learning/sampleConfigILP.xml").toURI().toURL());
			fm.put("inputASName", "TectoMT");
			fm.put("training", true);		
			ProcessingResource ilpTrain = (ProcessingResource) 
				Factory.createResource(MachineLearningPR.class.getCanonicalName(), fm);
			train_controller.add(ilpTrain);
		}
		
		
		
		if (runPaum)
		{
			//Paum train
			fm = Factory.newFeatureMap();
			fm.put("configFileURL", new File("gate-learning/ml-config-file.xml").toURI().toURL());
			fm.put("inputASName", "TectoMT");
			fm.put("outputASName", "Paum");
			fm.put("learningMode", "TRAINING");		
			ProcessingResource paumTrain = (ProcessingResource) 
				Factory.createResource("gate.learning.LearningAPIMain", fm);
			train_controller.add(paumTrain);
		}

		
		return train_controller;				
	}

	public static void main(String[] main_args) throws GateException, IOException, InterruptedException
	{		
		BasicConfigurator.configure();
	    Logger logger = Logger.getLogger(Profiler.class);
	    logger.setLevel(Level.OFF);
	    logger = Logger.getLogger(SerialController.class);
	    logger.setLevel(Level.OFF);
	    logger = Logger.getLogger(Gate.class);
	    logger.setLevel(Level.OFF);

		
	    Gate.setGateHome(new File("C:\\Program Files\\GATE-5.2.1"));
	    Gate.init();
	    GateUtils.registerPluginDirectory("Parser_Stanford");
	    GateUtils.registerPluginDirectory("Machine_Learning");
	    GateUtils.registerPluginDirectory("ANNIE");
	    GateUtils.registerPluginDirectory("Tools");
	    GateUtils.registerPluginDirectory("Learning");
	    
	    GateUtils.registerPluginDirectory(new File("GATE_plugins"));
		    	
	    DataStore ds = GateUtils.openDataStore("file:/C:/Users/dedek/AppData/GATE/ISWC");
	    
//	    Corpus corpus = GateUtils.loadCorpusFormDatastore(ds, "ISWC___1274943456887___5663");
	    Corpus corpus = GateUtils.loadCorpusFormDatastore(ds, "fatalities___1277473852041___7082");
	    
	    SerialAnalyserController train_controller = constructTrainController();
/**/    SerialAnalyserController test_controller = constructTestController(); /**/

/**	    
	    train_controller.setCorpus(corpus);
	    train_controller.execute();
	    
/**/
		FeatureMap fm = Factory.newFeatureMap();
		fm.put("corpus", corpus);
		fm.put("numberOfFolds", 9);
		fm.put("trainingPR", train_controller);
		fm.put("testingPR", test_controller);
		ProcessingResource crossValid = (ProcessingResource) 
			Factory.createResource(CrossValidation.class.getCanonicalName(), fm);
		
		SerialController run = (SerialController) Factory.createResource(SerialController.class.getCanonicalName());
		run.add(crossValid);
		run.execute();
/**/
	    
	    
		
/**
		ArrayList<String> types = new ArrayList<String>();
		ArrayList<String> features = new ArrayList<String>();

		types.add("Token");
		types.add("PosNeg");
		features.add("category");
		features.add("string");
		features.add("root");
		features.add("isPositve");
		
		ilp_ser.setAnnotationTypesToSerialze(types);			
		ilp_ser.setFeatureNamesToSerialze(features);			
		
/**		

		ilp_ser.project_setup.dir_for_projects = Config.getConfig().getIlpProjestsPath()+'/';
		ilp_ser.project_setup.project_name = "serialized_exp";
		ilp_ser.project_setup.init_project();
		
//		as.removeAll(as.get("FOUND"));
		ilp_ser.serializeAnnotationSet(doc.getAnnotations("TectoMT"));
		
		ilp_ser.execILP();
		/**/		
	
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
