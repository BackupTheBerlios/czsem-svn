package czsem.gate;

import java.util.SortedMap;
import java.util.TreeMap;


import gate.AnnotationSet;
import gate.DataStore;
import gate.Document;
import gate.corpora.SerialCorpusImpl;
import gate.creole.ResourceInstantiationException;
import gate.persist.PersistenceException;

public class CorpusTester
{
	private DataStore ds;
	
	private SortedMap<String, Integer> annot_mutiset = new TreeMap<String, Integer>();
	
	
	public CorpusTester(DataStore ds) {
		this.ds = ds;
	}
	
	public CorpusTester(String storageURL) throws PersistenceException
	{
	    ds = GateUtils.openDataStore(storageURL);
	}


	private int addAnntoToMultiset(String key)
	{
		Integer count = annot_mutiset.get(key);
		if (count == null) count = 0;		
		count ++;
		annot_mutiset.put(key, count);
		return count;		
	}
	
	public void testAnnotationSet(AnnotationSet as)
	{
		for (String type : as.getAllTypes())
		{
			System.err.print("     ");
			System.err.print("     ");
			System.err.print("     ");
			System.err.println(type);
			
			addAnntoToMultiset(as.getName()+'.'+type);
		}
		
	}

	public void testDocument(Document doc)
	{
		System.err.print("     ");
		System.err.println(doc.getName());
		for (Object obj_as_name : doc.getAnnotationSetNames())
		{
			System.err.print("     ");
			System.err.print("     ");
			System.err.println(obj_as_name);
			
			testAnnotationSet(doc.getAnnotations((String) obj_as_name));
		}
		System.err.print("     ");
		System.err.print("     ");
		System.err.println("*default*");
		testAnnotationSet(doc.getAnnotations());
			
	}

	public void testCorpus(SerialCorpusImpl corpus) throws ResourceInstantiationException
	{
		System.err.print("     ");
		System.err.println(corpus.getName());
		
		for (Object obj_doc_id : corpus.getDocumentPersistentIDs())
		{
			String doc_id = (String) obj_doc_id;
			System.err.print("     ");
			System.err.println(doc_id);
			
			testDocument(GateUtils.loadDocumentFormDatastore(ds, doc_id));
		}		
	}

	public void open() throws PersistenceException
	{
		ds.open();
	}

	public void close() throws PersistenceException
	{
		ds.close();
	}

	public void testDatastore() throws PersistenceException, ResourceInstantiationException
	{
		System.err.println("open");			
		open();
		
		GateUtils.printStoredIds(ds);
		
		for (Object obj_corpus_id : ds.getLrIds("gate.corpora.SerialCorpusImpl"))
		{
			SerialCorpusImpl corpus = (SerialCorpusImpl) GateUtils.loadResourceFormDatastore(ds, "gate.corpora.SerialCorpusImpl", (String) obj_corpus_id);
			
			testCorpus(corpus);			
		}
		
		printAnnotMultiset();
		
		close();
		System.err.println("closed");			
	}

	private void printAnnotMultiset()
	{
		for (String key: annot_mutiset.keySet())
		{
			System.err.print(key);
			System.err.print(": ");
			System.err.println(annot_mutiset.get(key));					
		}
		
	}
}
