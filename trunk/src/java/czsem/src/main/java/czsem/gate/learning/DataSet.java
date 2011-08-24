package czsem.gate.learning;

import gate.Corpus;
import gate.DataStore;
import gate.Factory;
import gate.creole.ResourceInstantiationException;
import gate.persist.PersistenceException;

import java.io.IOException;
import java.net.URISyntaxException;

import czsem.Utils;
import czsem.gate.GateUtils;
import czsem.utils.Config;

public interface DataSet
{
	String getKeyAS();
	String getLearnigConfigDirectory();
	String [] getLearnigAnnotationTypes();
	String getTectoMTAS();
	Corpus getCorpus() throws PersistenceException, ResourceInstantiationException;

	public static class DataSetReduce implements DataSet
	{
		public DataSetReduce(DataSet child, double reduceRatio)
		{
			assert(reduceRatio <= 1);
			
			this.child = child;
			this.reduceRatio = reduceRatio;
		}

		protected DataSet child; 
		protected double reduceRatio; 

		@Override
		public String getKeyAS() {return child.getKeyAS();}

		@Override
		public String getLearnigConfigDirectory() {return child.getLearnigConfigDirectory();}

		@Override
		public String[] getLearnigAnnotationTypes() {return child.getLearnigAnnotationTypes();}

		@Override
		public String getTectoMTAS() {return child.getTectoMTAS();}

		@SuppressWarnings("unchecked")
		@Override
		public Corpus getCorpus() throws PersistenceException, ResourceInstantiationException
		{
			Corpus corpus = child.getCorpus();
			int[] perm = Utils.createRandomPermutation(corpus.size());
			
			Corpus new_corp = Factory.newCorpus(null);
			
			for (int i = 0; i <= perm.length*reduceRatio; i++)
			{
				new_corp.add(corpus.get(perm[i]));								
			}
			
			return new_corp;
		}
		
	}

	public static class DataSetImpl implements DataSet
	{					
		public DataSetImpl(String dataStore, String copusId, String keyAS, String tectoMTAS, String learnigConfigDirectory, String [] learnigAnnotationTypes) throws URISyntaxException, IOException {
			this.dataStore = dataStore;
			this.copusId = copusId;
			this.keyAS = keyAS;
			this.tectoMTAS = tectoMTAS;
			this.learnigConfigDirectory = Config.getConfig().getLearnigConfigDirectoryForGate() + "/" + learnigConfigDirectory;
			this.learnigAnnotationTypes = learnigAnnotationTypes;
		}
	
		protected String dataStore;
		protected String copusId;
		protected String keyAS;
		protected String tectoMTAS;
		protected String learnigConfigDirectory;
		protected String [] learnigAnnotationTypes;
		
		@Override
		public String getKeyAS() {return keyAS;}

		@Override
		public String getLearnigConfigDirectory() {return learnigConfigDirectory;}

		@Override
		public String[] getLearnigAnnotationTypes() {return learnigAnnotationTypes;}

		@Override
		public String getTectoMTAS() {return tectoMTAS;}

		
		public Corpus getCorpus() throws PersistenceException, ResourceInstantiationException
		{
		    DataStore ds = GateUtils.openDataStore(dataStore);
		    Corpus corpus = GateUtils.loadCorpusFormDatastore(ds, copusId);			
		    return corpus; 
		}		
	
		
		public static class CzechFireman extends DataSetImpl
		{
			public static final String [] all_annot_types =
			{
				"amateur_unit",
				"amateur_units",
				"aqualung",
				"cars",
				"damage",
				"damageNumber",
				"duration",
				"end",
				"end_subtree",
				"fan",
				"fatalities",
				"injuries",
				"lather",
				"pipes",
				"profesional_unit",
				"profesional_units",
				"start",
				"units",
			};

			public CzechFireman(String ... learnigAnnotationTypes) throws URISyntaxException, IOException
			{
				super(
						"file:/C:/Users/dedek/AppData/GATE/ISWC",
						"ISWC___1274943456887___5663",
						"accident",
						"TectoMT",
						"czech_fireman",
						learnigAnnotationTypes);
			}		
		}
	
		public static class Acquisitions extends DataSetImpl
		{
			public static final String [] all_annot_types =
			{
				"acqabr",
				"acqbus",
				"acqcode",
				"acqloc",
				"acquired",
				"dlramt",
				"purchabr",
				"purchaser",
				"purchcode",
				"seller",
				"sellerabr",
				"sellercode",
				"status",
			};
			
			public Acquisitions(String ... learnigAnnotationTypes) throws URISyntaxException, IOException
			{
				super(
						"file:/C:/Users/dedek/AppData/GATE/Acquisitions-v1.1",
						"Acquisitions-v1.1___1284475684516___2218",
						"Key",
						"TectoMT",
						"acquisitions-v1.1",
						learnigAnnotationTypes);
			}		
		}
	}
}
