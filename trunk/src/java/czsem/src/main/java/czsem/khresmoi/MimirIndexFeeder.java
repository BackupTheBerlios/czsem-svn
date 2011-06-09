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

import java.io.File;
import java.io.IOException;
import java.net.URISyntaxException;
import java.net.URL;

import czsem.utils.Config;

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
	
	public static void main(String[] args) throws IOException, GateException, URISyntaxException
	{
		Config.getConfig().setGateHome();
		Gate.init();
		
		
		CzechMeshDocumentAnalysis a = new CzechMeshDocumentAnalysis();
		a.initApp();
		System.err.println("-inint done-");
		
		Document doc = Factory.newDocument("Krevní tlak stále roste.");
		
		a.anlyseDoc(doc);

		System.err.println("-analysis done-");
		
		System.err.println(doc.getAnnotations("mimir").get("MeshTerm"));
		System.err.println("--");
		
		a.close();
	}

	public static void main2(String[] args) throws IOException, GateException, URISyntaxException
	{
		Config.getConfig().setGateHome();
		Gate.init();
				
		
		String indexurl = "http://localhost:8080/mimir/8c9fe566-e6e4-4b71-826f-3f3d5e21370e";
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
