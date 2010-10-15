package czsem.gate;

import gate.creole.annotdelete.AnnotationDeletePR;
import gate.creole.annotransfer.AnnotationSetTransfer;
import gate.creole.ml.MachineLearningPR;
import gate.learning.LearningAPIMain;
import gate.util.GateException;

import java.io.File;
import java.io.IOException;
import java.net.URISyntaxException;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.jdom.Document;
import org.jdom.Element;
import org.jdom.JDOMException;
import org.jdom.input.SAXBuilder;

import czsem.gate.MachineLearningExperimenter.ExperimentSetup;
import czsem.gate.MachineLearningExperimenter.PRSetup;
import czsem.gate.plugins.AnnotationDependencyRootMarker;
import czsem.gate.plugins.AnnotationDependencySubtreeMarker;
import czsem.gate.plugins.SubsequentAnnotationMerge;
	
public class TrainTestGateOnCzech extends ExperimentSetup
{
	
	/*!!!!!!!!! Don't forget to change the XML configuration files  !!!!!!!!!*/
	public static String learninigAnnotType = null;
//	public static final String learninigAnnotType = "injuries";
//	public static final String learninigAnnotType = "damage";
	public static final boolean rootSubtreeLearninig = true;
	public static final boolean runPaum = true;
	public static final boolean runILP = true;
	
	static Logger logger = Logger.getLogger(TrainTestGateOnCzech.class);
 
	
	
	protected URL ILP_config_file;
	protected URL Paum_config_file;
	
	protected static String readLearninigAnnotType(URL config_doc_url) throws JDOMException, IOException
	{
		SAXBuilder parser = new SAXBuilder();
		Document ilp_dom = parser.build(config_doc_url);
		
		@SuppressWarnings("unchecked")
		List<Element> ch = ilp_dom.getRootElement().getChild("DATASET").getChildren("ATTRIBUTE");
		for (Element element : ch)
		{
			if (element.getChild("CLASS") != null)
			{
				return element.getChildText("TYPE");				
			}
			
		}
		return null;		
	}
	
	public TrainTestGateOnCzech() throws JDOMException, IOException
	{
		super(	"file:/C:/Users/dedek/AppData/GATE/ISWC",
				"ISWC___1274943456887___5663");
		
		ILP_config_file = new File("gate-learning/czech_fireman/ILP_config.xml").toURI().toURL();
		Paum_config_file = new File("gate-learning/czech_fireman/Paum_config.xml").toURI().toURL();
		
		String paum_at = learninigAnnotType = readLearninigAnnotType(Paum_config_file);
		String ilp_at = readLearninigAnnotType(ILP_config_file);
		if (rootSubtreeLearninig) paum_at += "_root";
		if (! paum_at.equals(ilp_at))
		{
			logger.warn(String.format(
					"Learninig annotation types do not match! Paum: %s, ILP: %s",
					paum_at, ilp_at));
		}
		
		
	}
	
	@Override
	public List<PRSetup> getTestControllerSetup()
	{
		List<PRSetup> prs = new ArrayList<PRSetup>();
		
		//TectoMT reset
		prs.add(new PRSetup(AnnotationDeletePR.class)
			.putFeatureList("annotationTypes", learninigAnnotType, learninigAnnotType + "_root")
			.putFeatureList("setsToRemove", "TectoMT"));		
		//Reset Paum & ILP
		prs.add(new PRSetup(AnnotationDeletePR.class)
			.putFeatureList("setsToRemove", "ILP", "Paum"));		
		if (runILP)
		{
			//ILP Apply
			prs.add(new PRSetup(MachineLearningPR.class)
				.putFeature("configFileURL", ILP_config_file)
				.putFeature("inputASName", "TectoMT")
				.putFeature("training", false));
			if (rootSubtreeLearninig)
			{
				//Subtree for ILP results
				prs.add(new PRSetup(AnnotationDependencySubtreeMarker.class)
					.putFeature("inputASName", "TectoMT")
					.putFeature("outputASName", "ILP")
					.putFeatureList("inputAnnotationTypeNames", learninigAnnotType + "_root"));
				//ILP Output Transfer
				prs.add(new PRSetup(AnnotationSetTransfer.class)
					.putFeature("inputASName", "TectoMT")
					.putFeature("outputASName", "ILP")
					.putFeature("copyAnnotations", false)
					.putFeatureList("annotationTypes", learninigAnnotType + "_root"));
			} else
			{
				//Subsequent annotation merge
				prs.add(new PRSetup(SubsequentAnnotationMerge.class)
					.putFeature("inputASName", "TectoMT")
					.putFeature("outputASName", "ILP")
					.putFeature("annotationTypeName", learninigAnnotType)
					.putFeature("deleteOriginalAnnotations", true));
			}
		}
		if (runPaum)
		{
			//Paum Application
			prs.add(new PRSetup(LearningAPIMain.class)
				.putFeature("configFileURL", Paum_config_file)
				.putFeature("inputASName", "TectoMT")
				.putFeature("outputASName", "Paum")
				.putFeature("learningMode", "APPLICATION"));
		}
		return prs;
	}

	
	@Override
	public List<PRSetup> getTrainControllerSetup()
	{
		List<PRSetup> prs = new ArrayList<PRSetup>();
		
		//TectoMT reset
		prs.add(new PRSetup(AnnotationDeletePR.class)
			.putFeatureList("annotationTypes", learninigAnnotType, learninigAnnotType + "_root")
			.putFeatureList("setsToRemove", "TectoMT"));
		//Training transfer
		prs.add(new PRSetup(AnnotationSetTransfer.class)
			.putFeature("inputASName", "accident")
			.putFeature("outputASName", "TectoMT")
			.putFeature("copyAnnotations", true)
			.putFeatureList("annotationTypes", learninigAnnotType));
		if (rootSubtreeLearninig)
		{
			//Training roots
			prs.add(new PRSetup(AnnotationDependencyRootMarker.class)
				.putFeature("inputASName", "TectoMT")
				.putFeature("outputASName", "TectoMT")
				.putFeatureList("inputAnnotationTypeNames", learninigAnnotType));
		}
		if (runILP)
		{
			//ILP train
			prs.add(new PRSetup(MachineLearningPR.class)
				.putFeature("inputASName", "TectoMT")
				.putFeature("configFileURL", ILP_config_file)
				.putFeature("training", true));
		}
		if (runPaum)
		{
			//Paum train
			prs.add(new PRSetup(LearningAPIMain.class)
				.putFeature("inputASName", "TectoMT")
				.putFeature("outputASName", "Paum")
				.putFeature("configFileURL", Paum_config_file)
				.putFeature("learningMode", "TRAINING"));
		}
		return prs;
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

