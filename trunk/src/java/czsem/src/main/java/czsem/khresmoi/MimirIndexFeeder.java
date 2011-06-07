package czsem.khresmoi;

import gate.Corpus;
import gate.Document;
import gate.Factory;
import gate.Gate;
import gate.mimir.index.MimirConnector;
import gate.util.GateException;

import java.io.File;
import java.io.IOException;
import java.net.URISyntaxException;
import java.net.URL;

import czsem.utils.Config;

public class MimirIndexFeeder {

	public static void main(String[] args) throws IOException, GateException, URISyntaxException
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
