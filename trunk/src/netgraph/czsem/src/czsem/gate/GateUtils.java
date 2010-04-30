package czsem.gate;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Set;

import gate.Annotation;
import gate.Corpus;
import gate.DataStore;
import gate.Document;
import gate.Factory;
import gate.FeatureMap;
import gate.Resource;
import gate.creole.ResourceInstantiationException;
import gate.persist.PersistenceException;

public class GateUtils
{
	@SuppressWarnings("unchecked")
	public static int[] decodeEdge(Annotation a)
	{
		int [] ret = new int[2];
		ArrayList<Integer> list = (ArrayList<Integer>) a.getFeatures().get("args");
		ret[0] = list.get(0);
		ret[1] = list.get(1);
		return ret;
	}
	
	public static FeatureMap createDependencyArgsFeatureMap(Integer id1, Integer id2)
	{
		FeatureMap fm = Factory.newFeatureMap();
		ArrayList<Integer> args = new ArrayList<Integer>(2);

		args.add(id1);
		args.add(id2);
		fm.put("args", args);
		
		return fm;
	}

	public static Document loadDocumentFormDatastore(DataStore ds, String docId) throws ResourceInstantiationException {
		return (Document) loadResourceFormDatastore(ds, "gate.corpora.DocumentImpl", docId);
	}

	public static Corpus loadCorpusFormDatastore(DataStore ds, String copusId) throws ResourceInstantiationException {
		return (Corpus) loadResourceFormDatastore(ds, "gate.corpora.SerialCorpusImpl", copusId);
	}

	public static DataStore openDataStore(String storage_url) throws PersistenceException
	{
		return Factory.openDataStore("gate.persist.SerialDataStore", storage_url); 
	}

	
	public static void printStoredIds(DataStore ds) throws PersistenceException
	{
		for (Object o : ds.getLrTypes())
		{
			System.err.println(o);			
			for (Object string : ds.getLrIds((String) o)) {
				System.err.print("     ");
				System.err.println(string);
			}
		}		
	}
	
	public static Resource loadResourceFormDatastore(DataStore ds, String calassName, String obj_id) throws ResourceInstantiationException
	{
		FeatureMap docFeatures = Factory.newFeatureMap();
		
		docFeatures.put(DataStore.LR_ID_FEATURE_NAME, obj_id);
		docFeatures.put(DataStore.DATASTORE_FEATURE_NAME, ds);		

		return Factory.createResource(calassName, docFeatures);
	}
	
	public static class CorpusDocumentCounter
	{
		protected Corpus copus;
		protected Set<String> seenDocuments;
		protected int numDocs; 

		public CorpusDocumentCounter(Corpus corpus) {
			this.copus = corpus;
			numDocs = corpus.size();
			
			seenDocuments = new HashSet<String>(numDocs);
		}
		
		public boolean isLastDocument()
		{
			return numDocs <= seenDocuments.size();			
		}

		/**
		 * @return false if the document is already present in the collection  
		 */
		public boolean addDocument(Document doc)
		{
			return addDocument(doc.getName());
		}

		/**
		 * @return false if the document is already present in the collection  
		 */
		public boolean addDocument(String name) {
			return seenDocuments.add(name);
		}

		
	}

}
