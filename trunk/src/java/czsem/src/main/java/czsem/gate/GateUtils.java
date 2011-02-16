package czsem.gate;

import java.io.File;
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URISyntaxException;
import java.net.URL;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Random;
import java.util.Set;

import gate.Annotation;
import gate.Controller;
import gate.Corpus;
import gate.DataStore;
import gate.Document;
import gate.Factory;
import gate.FeatureMap;
import gate.Gate;
import gate.ProcessingResource;
import gate.Resource;
import gate.creole.ResourceInstantiationException;
import gate.persist.PersistenceException;
import gate.util.GateException;

public class GateUtils
{
	@SuppressWarnings("unchecked")
	public static Integer[] decodeEdge(Annotation a)
	{
		Integer [] ret = new Integer[2];
		ArrayList<Integer> list = (ArrayList<Integer>) a.getFeatures().get("args");
		ret[0] = list.get(0);
		ret[1] = list.get(1);
		return ret;
	}
	
	public static FeatureMap createDependencyArgsFeatureMap(Integer parent_id, Integer child_id)
	{
		FeatureMap fm = Factory.newFeatureMap();
		ArrayList<Integer> args = new ArrayList<Integer>(2);

		args.add(parent_id);
		args.add(child_id);
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
		
		public Set<String> getDocumentSet()		
		{
			return seenDocuments;
		}

		
	}
	
	public static class Evidence<EvidenceElement> implements Comparable<Evidence<EvidenceElement>>
	{
		public Evidence(EvidenceElement doc, int random) {
			this.element = doc;
			this.random = random;
		}
		public EvidenceElement element;
		int random;
		
		@Override
		public int compareTo(Evidence<EvidenceElement> o)
		{
			return new Integer(random).compareTo(o.random);
		}
	}

	public static void safeDeepReInitPR_or_Controller(ProcessingResource processingResource) throws ResourceInstantiationException
	{
		if (processingResource instanceof Controller)
			deepReInitController((Controller) processingResource);
		else
			processingResource.reInit();
	}

	@SuppressWarnings("unchecked")
	public static void deepReInitController(Controller contoler) throws ResourceInstantiationException
	{
		Collection<ProcessingResource> prs = contoler.getPRs();
		for (ProcessingResource processingResource : prs)
		{
			safeDeepReInitPR_or_Controller(processingResource);
			//processingResource.reInit();			
		}		
	}

	public static void registerPluginDirectory(File pluginDirectory) throws MalformedURLException, GateException
	{
	    Gate.getCreoleRegister().registerDirectories( 
	    		pluginDirectory.toURI().toURL());		
	}

	public static void registerPluginDirectory(String pluginDirectoryName) throws MalformedURLException, GateException
	{
		registerPluginDirectory(
    		    new File(Gate.getPluginsHome(), pluginDirectoryName));		
	}
	

	public static Set<String> setFromList(List<String> list)
	{		
		return new HashSet<String>(list);
	}

	public static Set<String> setFromArray(String[] array)
	{		
		return setFromList(Arrays.asList(array));
	}
	
	public static String [] arrayConcatenate(String [] first, String [] second)
	{
		String [] ret = new String[first.length + second.length];
		System.arraycopy(first, 0, ret, 0, first.length);
		System.arraycopy(second, 0, ret, first.length, second.length);
		return ret;		
	}

	public static String findAvailableFileName(String destFileURI)
	{
	    String destFileName = destFileURI.substring(0,destFileURI.lastIndexOf("."));
	    String destFileExt = destFileURI.substring(destFileURI.lastIndexOf(".")+1);
	    int count = 1;      
	    File f;
	    while ((f=new File(destFileURI)).exists())
	    {
	        destFileURI=destFileName+"("+(count++)+")"+"."+destFileExt;
	    }            
	    String fName = f.getName();
	    String fPath = f.getParent();
	    destFileURI = destFileURI.replaceAll(" ", "_");
	    // Now we need to check if given file name is valid for file system, and if it isn't we need to convert it to valid form
	    if (!(testIfFileNameIsValid(destFileURI))) {
	        List<String> forbiddenCharsPatterns = new ArrayList<String>();
	        forbiddenCharsPatterns.add("[:]+"); // Mac OS, but it looks that also Windows XP
	        forbiddenCharsPatterns.add("[\\*\"/\\\\\\[\\]\\:\\;\\|\\=\\,]+");  // Windows
	        forbiddenCharsPatterns.add("[^\\w\\d\\.]+");  // last chance... only latin letters and digits
	        for (String pattern:forbiddenCharsPatterns) {
	            String nameToTest = fName;
	            nameToTest = nameToTest.replaceAll(pattern, "_");
	            destFileURI=fPath+"/"+nameToTest;
	            count=1;
	            destFileName = destFileURI.substring(0,destFileURI.lastIndexOf("."));
	            destFileExt = destFileURI.substring(destFileURI.lastIndexOf(".")+1);
	            while ((f=new File(destFileURI)).exists()) {
	                destFileURI=destFileName+"("+(count++)+")"+"."+destFileExt;
	                }
	                if (testIfFileNameIsValid(destFileURI)) break;
	        }
	    }         
	    return destFileURI;
	}
	
	private static boolean testIfFileNameIsValid(String destFileURI) {
	    boolean valid = false;
	    try {
	        File candidate = new File(destFileURI);                
//	        String canonicalPath = candidate.getCanonicalPath();                
	        boolean b = candidate.createNewFile();
	        if (b) {
	            candidate.delete();
	        }
	        valid = true;
	    } catch (IOException ioEx) { }
	    return valid;
	}
	
	public static File URLToFile(URL url) throws IOException, URISyntaxException
	{
		return new File(url.toURI());		
	}

	public static String URLToFilePath(URL url) throws IOException, URISyntaxException
	{
		return URLToFile(url).getCanonicalPath();		
	}
	
	public static <ElementType> Evidence<ElementType>[] createRandomPermutation(Collection<ElementType> collection)
	{
		Random rand = new Random();
		
		@SuppressWarnings("unchecked")
		Evidence<ElementType>[] ret = new Evidence[collection.size()];
		
		int i = 0;
		for (Iterator<ElementType> iterator = collection.iterator(); iterator.hasNext();i++)
		{
			ElementType element = iterator.next();
			ret[i] = new Evidence<ElementType>(element, rand.nextInt());						
		}
				
		Arrays.sort(ret);
		
		return ret;
	}

	
	public static int [] createRandomPermutation(int length)
	{
		Integer [] input = new Integer[length];
		int [] ret = new int[length];
		for (int i = 0; i < input.length; i++) {
			input[i]=i;
		}
		
		Evidence<Integer>[] perm = createRandomPermutation(Arrays.asList(input));
		for (int i = 0; i < input.length; i++) {
			ret[i]=perm[i].element;
		}
		
		return ret;		
	}
	
	public static void main(String [] args)
	{
		System.err.println(Arrays.toString(createRandomPermutation(10)));
	}

}
