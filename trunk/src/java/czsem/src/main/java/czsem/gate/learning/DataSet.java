package czsem.gate.learning;

import gate.Corpus;
import gate.DataStore;
import gate.creole.ResourceInstantiationException;
import gate.persist.PersistenceException;

import java.io.IOException;
import java.net.URISyntaxException;

import czsem.gate.GateUtils;
import czsem.utils.Config;

public class DataSet
{
	public DataSet(String dataStore, String copusId, String keyAS, String tectoMTAS, String learnigConfigDirectory) throws URISyntaxException, IOException {
		this.dataStore = dataStore;
		this.copusId = copusId;
		this.keyAS = keyAS;
		this.tectoMTAS = tectoMTAS;
		this.learnigConfigDirectory = Config.getConfig().getLearnigConfigDirectoryForGate() + "/" + learnigConfigDirectory;
	}

	protected String dataStore;
	protected String copusId;
	protected String keyAS;
	protected String tectoMTAS;
	protected String learnigConfigDirectory;
	
	protected Corpus getCorpus() throws PersistenceException, ResourceInstantiationException
	{
	    DataStore ds = GateUtils.openDataStore(dataStore);
	    Corpus corpus = GateUtils.loadCorpusFormDatastore(ds, copusId);			
	    return corpus; 
	}		

	
	public static class CzechFireman extends DataSet
	{
		public CzechFireman() throws URISyntaxException, IOException
		{
			super(
					"file:/C:/Users/dedek/AppData/GATE/ISWC",
					"ISWC___1274943456887___5663",
					"accident",
					"TectoMT",
					"czech_fireman");
		}		
	}

	public static class Acquisitions extends DataSet
	{
		public Acquisitions() throws URISyntaxException, IOException
		{
			super(
					"file:/C:/Users/dedek/AppData/GATE/Acquisitions-v1.1",
					"Acquisitions-v1.1___1284475684516___2218",
					"Key",
					"TectoMT",
					"acquisitions-v1.1");
		}		
	}


}
