package czsem.gate;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.util.ArrayList;
import java.util.List;

import czsem.utils.Config;

import gate.AnnotationSet;
import gate.DataStore;
import gate.Document;
import gate.Factory;
import gate.FeatureMap;
import gate.Gate;
import gate.SimpleAnnotationSet;
import gate.creole.ANNIEConstants;
import gate.util.GateException;

public class TrainTestGateOnCzech {

	public static void main(String[] main_args) throws GateException, IOException, InterruptedException
	{
	    Gate.init();
	    Gate.getCreoleRegister().registerDirectories( 
    		    new File(Gate.getPluginsHome(), "Parser_Stanford").toURI().toURL()); 
	    
	    Gate.getCreoleRegister().registerDirectories(new File("GATE_plugins").toURI().toURL());
    
	
	    DataStore ds = GateUtils.openDataStore("file:/C:/Users/dedek/AppData/GATE/indexed_store/store/");
	    
	    Document doc = GateUtils.loadDocumentFormDatastore(ds, "jihomoravsky47460.txt.xml_00045___1268665562431___957");
	    
	    
	    	    
		ILPSerializer ilp_ser = (ILPSerializer) Factory.createResource("czsem.gate.ILPSerializer", Factory.newFeatureMap()); 
		
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
		

		ilp_ser.project_setup.dir_for_projects = Config.getConfig().getIlpProjestsPath()+'/';
		ilp_ser.project_setup.project_name = "serialized_exp";
		ilp_ser.project_setup.init_project();
/**/		
		
//		as.removeAll(as.get("FOUND"));
		ilp_ser.serializeAnnotationSet(doc.getAnnotations("TectoMT"));
		
		ilp_ser.execILP();
		
		AnnotationSet inputAS = null;
		java.util.Map bindings = null;
		
		
		gate.AnnotationSet b_as = (gate.AnnotationSet) bindings.get("dep_tmp");
		gate.Annotation dep_an = b_as.iterator().next();
		Object dep_kind = dep_an.getFeatures().get("kind");
		List<Integer> args = (List<Integer>) dep_an.getFeatures().get("args");
			
		gate.Annotation token_an = inputAS.get(args.get(1));
		gate.FeatureMap fm = token_an.getFeatures();
		fm.put("depency_type", dep_kind);



	}

}
