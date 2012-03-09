package cuni.khresmoi.mimir;

import gate.Document;
import gate.Factory;
import gate.Gate;
import gate.mimir.index.MimirConnector;
import gate.util.GateException;

import java.io.File;
import java.io.IOException;
import java.net.URISyntaxException;
import java.net.URL;

import czsem.Utils;
import czsem.Utils.StopRequestDetector;
import cuni.khresmoi.InformationExtractionAnalysis;
import czsem.utils.Config;
import czsem.utils.ProjectSetup;

public class MimirIndexFeeder {

/*
	public static class CzechMeshDocumentAnalysis
	{
		public static interface LanguageAnalyserController extends Controller, LanguageAnalyser {}

		ConditionalSerialAnalyserController app;

		public void initApp() throws URISyntaxException, IOException, PersistenceException, ResourceInstantiationException
		{
			
			
			app = (ConditionalSerialAnalyserController) PersistenceManager.loadObjectFromFile(
					new File(
							Config.getConfig().getCzsemPluginDir()+
							"/resources/mimir/CzechMeshAnalysis.gapp"));
			
		}

		public void anlyseDoc(Document doc) throws ExecutionException
		{
			app.setDocument(doc);
			app.execute();
		}

		public void close()
		{
			app.cleanup();			
		}
		
		
	}
/**/
	
	static String indexurl = "http://localhost:8080/mimir-demo/mesh_final";
//	static String indexurl = "http://195.113.17.17:8080/mimir-demo-3.2.1-snapshot/pok2_local";
	
	
	public static void main(String[] args) throws IOException, GateException, URISyntaxException
	{
		Config.getConfig().setGateHome();
		Gate.init();
		
		URL index_url = new URL(indexurl);
				
		StopRequestDetector stop_request_detector = new StopRequestDetector();
		
		try {
		
			File dir = new File(InformationExtractionAnalysis.default_outputdir);
			File[] files = dir.listFiles();
			
			stop_request_detector.startDetector();
			
			int files_count = 0;
			for (File f : files)
			{
				files_count++;
				
				System.err.println(String.format("%s file:%05d %s", ProjectSetup.makeTimeStamp(), files_count, f.getName()));
//				if (files_count++ <= 841) continue;
				Document doc = Factory.newDocument(f.toURI().toURL(), "utf8");
				doc.setName(Utils.fileNameWithoutExtensions(f));
				
				MimirConnector.defaultConnector().sendToMimir(doc, doc.getFeatures().get("gate.SourceURL").toString(), index_url);
				Factory.deleteResource(doc);
				
				if (stop_request_detector.stop_requested) break;
			}
			System.err.println("end of file processing.");
		
		}
		finally
		{
			stop_request_detector.stop_requested = true;
			
		}		
	}
}
