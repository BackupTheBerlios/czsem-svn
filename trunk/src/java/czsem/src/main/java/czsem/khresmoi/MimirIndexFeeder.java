package czsem.khresmoi;

import gate.Controller;
import gate.Corpus;
import gate.Document;
import gate.Factory;
import gate.Gate;
import gate.LanguageAnalyser;
import gate.creole.ConditionalSerialAnalyserController;
import gate.creole.ExecutionException;
import gate.creole.ResourceInstantiationException;
import gate.mimir.index.MimirConnector;
import gate.persist.PersistenceException;
import gate.util.GateException;
import gate.util.persistence.PersistenceManager;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URISyntaxException;
import java.net.URL;

import czsem.gate.GateUtils;
import czsem.utils.Config;
import czsem.utils.ProjectSetup;

public class MimirIndexFeeder {

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
	public static Boolean terminate_request = false;
	
	public static void start_terminate_request_detector()
	{
		Thread terminate_request_detector = new Thread() {
			@Override
			public void run()
			{
				BufferedReader in = new BufferedReader(new InputStreamReader(System.in));
				String input = "";
				do
				{
					try {
						input = in.readLine();
					} catch (IOException e) {
						e.printStackTrace();
					}
					
				} while (! input.equals("stop") && ! terminate_request);
				
				System.err.println("stop requsted!");
				terminate_request = true;
			}			
		};
		
		terminate_request_detector.start();
	}

	
	static String indexurl = "http://localhost:8080/mimir-demo/big";
	static String analyzed_dir = "C:\\Users\\dedek\\Desktop\\bmc\\analyzed\\";
	static String plain_files_dir = "C:\\Users\\dedek\\Desktop\\bmc\\filter_include";

	
	public static void main(String[] args) throws IOException, GateException, URISyntaxException
	{
		Config.getConfig().setGateHome();
		Gate.init();
		
		URL index_url = new URL(indexurl);
		
/*		
		CzechMeshDocumentAnalysis a = new CzechMeshDocumentAnalysis();
		a.initApp();
		System.err.println("-inint done-");
/**/		
		try {
		
			File dir = new File(analyzed_dir);
//			File dir = new File(plain_files_dir);
			File[] files = dir.listFiles();
			
			start_terminate_request_detector();
			
			int files_count = 0;
			for (File f : files)
			{
				files_count++;
				
/*
				if (new File(analyzed_dir+f.getName()).exists())
				{
					System.err.println(files_count);
					continue;
				}
/**/				
				System.err.println(String.format("%s file:%05d %s", ProjectSetup.makeTimeStamp(), files_count, f.getName()));
//				if (files_count++ <= 841) continue;
				Document doc = Factory.newDocument(f.toURI().toURL(), "utf8");			
//				a.anlyseDoc(doc);
				
//				GateUtils.saveDocumentToDirectory(doc, analyzed_dir, "bmcID");

/**/
//				if (testDoc(doc)) ...
				MimirConnector.defaultConnector().sendToMimir(doc, doc.getFeatures().get("gate.SourceURL").toString(), index_url);
/**/					
				Factory.deleteResource(doc);
				
				if (terminate_request) break;
			}
			System.err.println("end of file processing.");
		
		}
		finally
		{
//			a.close();
			terminate_request = true;
			
		}		
	}

	private static boolean testDoc(Document doc)
	{		
		return doc.getAnnotations("mimir").get("MeshTerm").size() >= 3;
	}

	public static void main2(String[] args) throws IOException, GateException, URISyntaxException
	{
		Config.getConfig().setGateHome();
		Gate.init();
				
		URL index_url = new URL(indexurl);

		
		Corpus corpus = Factory.newCorpus(null);
		corpus.populate(
				new File("C:\\Users\\dedek\\Desktop\\bmc50_analysed4").toURI().toURL(),
//				new File("C:\\Users\\dedek\\Desktop\\bmca_devel").toURI().toURL(),
				null, "utf8", false);
		
		System.err.println("populated");
				
		for (Object object : corpus)
		{
			Document doc = (Document) object;
			MimirConnector.defaultConnector().sendToMimir(doc, null, index_url);
			System.err.println(doc.getName());			
		}

		
		

	}

}
