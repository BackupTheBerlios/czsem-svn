package czsem.gate;

import gate.Corpus;
import gate.DataStore;
import gate.Gate;
import gate.corpora.SerialCorpusImpl;
import gate.creole.ExecutionException;
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

public class GateApplicationRunner {
	
	public static class GateApplicationRunnerThread extends Thread implements StatusListener
	{

		public GateApplicationRunnerThread(URL app_url, Corpus corus) throws PersistenceException, ResourceInstantiationException, IOException {
			this.app = (SerialAnalyserController) PersistenceManager.loadObjectFromUrl(app_url);
			app.setCorpus(corus);
		}

		private SerialAnalyserController app;
		
		private void printID()
		{
			System.err.print("Thread");
			System.err.print(getId());			
			System.err.print(':');
		}
		
		@Override
		public void run()
		{
		    app.addStatusListener(this);
			
			try {
				app.execute();
			} catch (ExecutionException e) {
				printID();
				e.printStackTrace();
			}
			
			System.err.print("ending: ");
			printID();

		}

		@Override
		public void statusChanged(String text)
		{
			if (text.length() <= 0) return;
			
			printID();
			System.err.println(text);								
		}
		
	}

	public static void main(String[] args) throws GateException, MalformedURLException, IOException, InterruptedException
	{
	    System.err.println(args.length);
	    
		Gate.setNetConnected(false);
	    Gate.setLocalWebServer(false);
//	    Gate.setGateHome(new File("C:\\Program Files\\GATE-5.0"));

	    Gate.setGateHome(new File("C:/Program Files/GATE-5.1"));
	    Gate.init();
    
	    Gate.getCreoleRegister().registerDirectories( 
	    		    new File(Gate.getPluginsHome(), "Parser_Stanford").toURI().toURL() 
	    		  ); 
	    
		DataStore ds = CorpusTester.openDataStore("file:/C:/Users/dedek/AppData/GATE/tipster1/");
		SerialCorpusImpl corpus = (SerialCorpusImpl) TectoMTAnalyser
		.loadResourceFormDatastore(ds, "gate.corpora.SerialCorpusImpl", "tipster1___1270027809902___3839");
		
		SerialCorpusImpl corpus1 = (SerialCorpusImpl) TectoMTAnalyser
		.loadResourceFormDatastore(ds, "gate.corpora.SerialCorpusImpl", "working___1270115854868___6134");

		SerialCorpusImpl corpus2 = (SerialCorpusImpl) TectoMTAnalyser
		.loadResourceFormDatastore(ds, "gate.corpora.SerialCorpusImpl", "working2___1270130407001___3504");
				
		corpus1.clear();
		corpus2.clear();
		
		int cid = 0; 
		for (int index=1087; index<=4000; index+=2)
		{
			corpus1.add(cid, corpus.get(index));
			corpus.unloadDocument(index, false);			
			corpus1.unloadDocument(cid, false);			

			corpus2.add(cid, corpus.get(index+1));
			corpus.unloadDocument(index+1, false);			
			corpus2.unloadDocument(cid, false);
			
			cid ++;
		}
		
		corpus1.sync();
		corpus2.sync();
				

/**/		
		
//		org.apache.log4j.BasicConfigurator.configure();
	    	    	    	    
	    
	    URL app_url = new URL("file:/C:/Users/dedek/AppData/GATE/tipster_gate_app");
	    	    
	    Corpus corp = args.length >= 1 ? corpus2 : corpus1;
	    
	    GateApplicationRunnerThread thread = new GateApplicationRunnerThread(app_url, corp);
	    
	    thread.start();
	    thread.join();
	    	    	    
/***/	    
	}

}
