package czsem.gate;

import gate.Corpus;
import gate.DataStore;
import gate.Factory;
import gate.FeatureMap;
import gate.Gate;
import gate.ProcessingResource;
import gate.creole.SerialAnalyserController;
import gate.util.GateException;
import gate.util.profile.Profiler;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.apache.log4j.BasicConfigurator;
import org.apache.log4j.Level;
import org.apache.log4j.Logger;

public class TrainTestGateOnCzech {

	public static void main(String[] main_args) throws GateException, IOException, InterruptedException
	{		
	    Gate.init();
	    Gate.getCreoleRegister().registerDirectories( 
    		    new File(Gate.getPluginsHome(), "Parser_Stanford").toURI().toURL());
	    Gate.getCreoleRegister().registerDirectories( 
    		    new File(Gate.getPluginsHome(), "Machine_Learning").toURI().toURL());
	    
	    
	    
	    Gate.getCreoleRegister().registerDirectories(new File("GATE_plugins").toURI().toURL());
    
	
	    DataStore ds = GateUtils.openDataStore("file:/C:/Users/dedek/AppData/GATE/indexed_store/store/");
	    
//	    Document doc = GateUtils.loadDocumentFormDatastore(ds, "jihomoravsky47460.txt.xml_00045___1268665562431___957");
	    
	    Corpus corpus = GateUtils.loadCorpusFormDatastore(ds, "Corpus for jihomoravsky48461.txt.xml_00046___1272881652267___7395");
//	    Corpus corpus = GateUtils.loadCorpusFormDatastore(ds, "50msg_index___1268665232288___6956");
	    
	    
	    	    
//		ILPSerializer ilp_ser = (ILPSerializer) Factory.createResource("czsem.gate.ILPSerializer", Factory.newFeatureMap()); 
		FeatureMap fm = Factory.newFeatureMap();
		fm.put("configFileURL", new File("gate-learning/sampleConfigILP.xml").toURI().toURL());
		fm.put("inputASName", "Learning");
		
	    ProcessingResource learning = (ProcessingResource) 
	    	Factory.createResource("gate.creole.ml.MachineLearningPR", fm);
	    
	    SerialAnalyserController controller = (SerialAnalyserController)	    	   
	    	Factory.createResource("gate.creole.SerialAnalyserController");
	    
	    controller.add(learning);
	    
	    controller.setCorpus(corpus);
	    	    	    
	    BasicConfigurator.configure();
	    Logger logger = Logger.getLogger(Profiler.class);
	    logger.setLevel(Level.OFF);

	    controller.execute();
	    
	    
		
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
	
	@SuppressWarnings({ "unchecked" })
	public static void jape_pok (gate.Document doc, java.util.Map bindings, 
			                     gate.AnnotationSet annotations, 
			                     gate.AnnotationSet inputAS, gate.AnnotationSet outputAS, 
			                     gate.creole.ontology.Ontology ontology)
	{		
		
		gate.AnnotationSet b_as = (gate.AnnotationSet) bindings.get("dep_tmp");
		gate.Annotation dep_an = b_as.iterator().next();
		Object dep_kind = dep_an.getFeatures().get("kind");
		List<Integer> args = (List<Integer>) dep_an.getFeatures().get("args");
			
		gate.Annotation token_an = inputAS.get(args.get(1));
		gate.FeatureMap fm = token_an.getFeatures();
		fm.put("depency_type", dep_kind);		
	}

}
