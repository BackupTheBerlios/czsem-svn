package czsem.gate.learning;

import gate.creole.annotdelete.AnnotationDeletePR;
import gate.creole.annotransfer.AnnotationSetTransfer;
import gate.util.GateException;

import java.io.IOException;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.jdom.JDOMException;

import czsem.gate.learning.MachineLearningExperimenter.*;

	
public class TrainTestCzechFireman extends ExperimentSetup
{
	static Logger logger = Logger.getLogger(TrainTestCzechFireman.class);
 
	public TrainTestCzechFireman(MLEngine ... engines) throws JDOMException, IOException
	{
		super(	"file:/C:/Users/dedek/AppData/GATE/ISWC",
				"ISWC___1274943456887___5663",
				engines);
		
		initEngines("gate-learning/czech_fireman");
	}
	
	@Override
	public List<PRSetup> getTestControllerSetup() throws JDOMException, IOException
	{
		List<PRSetup> prs = new ArrayList<PRSetup>();
		
		//TectoMT reset
		prs.add(new SinglePRSetup(AnnotationDeletePR.class)
			.putFeatureList("annotationTypes", learninigAnnotType, learninigAnnotType + "_root")
			.putFeatureList("setsToRemove", "TectoMT"));		
		//Reset Paum & ILP
		prs.add(new SinglePRSetup(AnnotationDeletePR.class)
			.putFeatureList("setsToRemove", "ILP", "Paum"));		
		
		return addTestMLEngines(prs);
	}
	
	@Override
	public List<PRSetup> getTrainControllerSetup() throws JDOMException, IOException
	{
		List<PRSetup> prs = new ArrayList<PRSetup>();
		
		//TectoMT reset
		prs.add(new SinglePRSetup(AnnotationDeletePR.class)
			.putFeatureList("annotationTypes", learninigAnnotType, learninigAnnotType + "_root")
			.putFeatureList("setsToRemove", "TectoMT"));
		//Training transfer
		prs.add(new SinglePRSetup(AnnotationSetTransfer.class)
			.putFeature("inputASName", "accident")
			.putFeature("outputASName", "TectoMT")
			.putFeature("copyAnnotations", true)
			.putFeatureList("annotationTypes", learninigAnnotType));

		return addTrainMLEngines(prs);
	}





	public static void main(String[] main_args) throws GateException, IOException, InterruptedException, URISyntaxException, JDOMException
	{
//		init();
		

/**	    
	    train_controller.setCorpus(corpus);
	    train_controller.execute();
	    
/**/
		
/*
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

