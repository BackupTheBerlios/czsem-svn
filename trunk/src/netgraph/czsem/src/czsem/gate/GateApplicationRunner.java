package czsem.gate;

import gate.Corpus;
import gate.DataStore;
import gate.Document;
import gate.Gate;
import gate.LanguageAnalyser;
import gate.corpora.SerialCorpusImpl;
import gate.creole.ResourceInstantiationException;
import gate.creole.SerialAnalyserController;
import gate.event.StatusListener;
import gate.persist.PersistenceException;
import gate.util.GateException;
import gate.util.persistence.PersistenceManager;

import java.io.File;
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;


import czsem.utils.ProjectSetup;

public class GateApplicationRunner {
	
	public static class GateApplicationRunnerThread extends Thread implements StatusListener
	{

		public GateApplicationRunnerThread(URL app_url, Corpus corus) throws PersistenceException, ResourceInstantiationException, IOException {
			this.app = (SerialAnalyserController) PersistenceManager.loadObjectFromUrl(app_url);
			app.setCorpus(corus);
		}

		private SerialAnalyserController app;
		private Document doc = null;
		private LanguageAnalyser pr = null;
		int files = 0;
		
		private void printID()
		{
			System.err.print("Thread");
			System.err.print(getId());			
			System.err.print(": ");
		}
		
		@Override
		public void run()
		{
			pr = (LanguageAnalyser) app.getPRs().iterator().next();
		    app.addStatusListener(this);
		    			
		    try {
				app.execute();
			} catch (Throwable e) {
				printID();
				e.printStackTrace();
				
				//do garbage collection!
				System.err.print("free memory: ");
				System.err.println(Runtime.getRuntime().freeMemory());
				app = null;
				System.gc();
				System.err.print("free memory: ");
				System.err.println(Runtime.getRuntime().freeMemory());
			}
			
			System.err.print("ending: ");
			printID();
			System.err.print(" files: ");
			System.err.print(files);
			System.err.print(" timestamp: ");
		    System.err.println(ProjectSetup.makeTimeStamp());
		}

		@Override
		public void statusChanged(String text)
		{
			Document new_doc = pr.getDocument();
			if (doc != new_doc)
			{
				doc = new_doc;
				System.err.print("************************************");
				System.err.print(doc.getName());
				System.err.print(" files: ");
				System.err.print(files);
				System.err.println("************************************");
				files ++;
			}
			if (text.length() <= 0) return;
			
			printID();
			System.err.println(text);								
		}
		
	}

	public static void main(String[] args) throws GateException, MalformedURLException, IOException, InterruptedException
	{
	    System.err.print("arg num: ");
	    System.err.println(args.length);

	    System.err.print("args: ");
	    for (String arg : args)
	    {
	    	System.err.print("'");
	    	System.err.print(arg);
	    	System.err.print("' ");
	    }
	    System.err.println();
	    
	    if (args.length < 2)
	    {
	    	System.err.println("Usage: arg1 arg2");
	    	System.err.println("arg1=start index");
	    	System.err.println("arg2=end index");
	    	System.err.println("It selects only odd or even files (depending on if the start index is odd or even)");
	    	return;	    	
	    }
	    
	    int start = Integer.parseInt(args[0]);
	    int end = Integer.parseInt(args[1]);
	    
		Gate.setNetConnected(false);
	    Gate.setLocalWebServer(false);
//	    Gate.setGateHome(new File("C:\\Program Files\\GATE-5.0"));

	    Gate.setGateHome(new File("C:/Program Files/GATE-5.1"));
	    Gate.init();
    
	    Gate.getCreoleRegister().registerDirectories( 
	    		    new File(Gate.getPluginsHome(), "Parser_Stanford").toURI().toURL() 
	    		  ); 
	    
		DataStore ds = GateUtils.openDataStore("file:/C:/Users/dedek/AppData/GATE/tipster1/");
		SerialCorpusImpl corpus = (SerialCorpusImpl) GateUtils
		.loadResourceFormDatastore(ds, "gate.corpora.SerialCorpusImpl", "tipster1___1270027809902___3839");
		
		String [] corpss = {"working___1270115854868___6134", "working2___1270130407001___3504"};  
		
		
		
		
		String corpus_string = corpss[start % 2]; 
		
		
		
		
		SerialCorpusImpl corpus1 = (SerialCorpusImpl) GateUtils
			.loadResourceFormDatastore(ds, "gate.corpora.SerialCorpusImpl", corpus_string);

				
		GateApplicationRunnerThread thread = null;
		while (start < end)
		{
			corpus1.clear();
			
			int cid = 0; 
			for (int index=start; index<=end; index+=2)
			{
				corpus1.add(cid, corpus.get(index));
				corpus.unloadDocument(index, false);			
				corpus1.unloadDocument(cid, false);			
	
				cid ++;
			}
			
			corpus1.sync();
					
	
	/**/		
			
	//		org.apache.log4j.BasicConfigurator.configure();
		    	    	    	    
		    
		    URL app_url = new URL("file:/C:/Users/dedek/AppData/GATE/tipster_gate_app");
		    	        
		    thread = new GateApplicationRunnerThread(app_url, corpus1);
		    
		    thread.start();
		    thread.join();
		    
		    start += thread.files*2;
		    System.err.print("new start: ");
		    System.err.println(start);
		}
	    	    	    
/***/	    
	}

}
