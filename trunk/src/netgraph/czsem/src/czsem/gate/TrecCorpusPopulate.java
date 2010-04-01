package czsem.gate;

import java.io.File;
import java.io.IOException;
import java.net.MalformedURLException;
import java.util.ListIterator;

import gate.DataStore;
import gate.Document;
import gate.Gate;
import gate.corpora.SerialCorpusImpl;
import gate.util.GateException;

public class TrecCorpusPopulate {

	public static void main(String[] args) throws GateException, MalformedURLException, IOException
	{
		Gate.setNetConnected(false);
	    Gate.setLocalWebServer(false);
//	    Gate.setGateHome(new File("C:\\Program Files\\GATE-5.0"));

	    Gate.init();
	    	    
//	    Gate.getCreoleRegister().registerDirectories(new URL("file:/C:/Program%20Files/GATE-5.0/plugins/Stanford/"));
	    				
		DataStore ds = CorpusTester.openDataStore("file:/C:/Users/dedek/AppData/GATE/tipster1/");
		CorpusTester.printStoredIds(ds);
		
		SerialCorpusImpl corpus = (SerialCorpusImpl) TectoMTAnalyser
			.loadResourceFormDatastore(ds, "gate.corpora.SerialCorpusImpl", "tipster1___1270027809902___3839");
		
		int a = 0;
		for (Object object : corpus.getDocumentPersistentIDs()) {
			
			if (a== 1088) break;
			
			System.err.format("%6d", a++);			
			System.err.println(object);
		}
		
		
/*		

		File dir = new File("C:/data/tipster1/AP");
		
		for (File file : dir.listFiles())
		{
			System.out.println(file.getCanonicalFile());
			corpus.populate(file.toURI().toURL(), null, -1);			
		}

		corpus.sync();
		ds.close();
		
		for (Object string : ds.getLrIds("gate.corpora.DocumentImpl")) {
			System.err.println(string);
			ds.delete("gate.corpora.DocumentImpl", string);
//			Document doc = CorpusTester.loadDocumentFormDatastore(ds, (String) string);
//			corpus.add(doc);
		}
		
		corpus.sync();
		ds.close();
*/		


	}

}
