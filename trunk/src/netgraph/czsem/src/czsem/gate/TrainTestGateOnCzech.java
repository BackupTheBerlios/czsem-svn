package czsem.gate;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.util.ArrayList;

import czsem.utils.Config;

import gate.DataStore;
import gate.Document;
import gate.Gate;
import gate.util.GateException;

public class TrainTestGateOnCzech {

	public static void main(String[] args) throws GateException, IOException, InterruptedException
	{
	    Gate.init();
	    Gate.getCreoleRegister().registerDirectories( 
    		    new File(Gate.getPluginsHome(), "Parser_Stanford").toURI().toURL()); 
    
	
	    DataStore ds = GateUtils.openDataStore("file:/C:/Users/dedek/AppData/GATE/indexed_store/store/");
	    
	    Document doc = GateUtils.loadDocumentFormDatastore(ds, "jihomoravsky47460.txt.xml_00045___1268665562431___957");
	    
	    
	    
	    
	    
		ILPSerializer ilp_ser = new ILPSerializer();
		
		ArrayList<String> types = new ArrayList<String>();
		ArrayList<String> features = new ArrayList<String>();

/**/
		types.add("Token");
		types.add("PosNeg");
		features.add("category");
		features.add("string");
		features.add("root");
		features.add("isPositve");
		
/**/		
		ilp_ser.setAnnotationTypesToSerialze(types);			
		ilp_ser.setFeatureNamesToSerialze(features);			
		

		ilp_ser.project_setup.dir_for_projects = Config.getConfig().getIlpProjestsPath()+'/';
		ilp_ser.project_setup.project_name = "serialized_exp";
		ilp_ser.project_setup.init_project();
		
//		as.removeAll(as.get("FOUND"));
		ilp_ser.serializeAnnotationSet(doc.getAnnotations("TectoMT"));
		
		ilp_ser.execILP();


	}

}
