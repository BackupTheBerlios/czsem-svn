/**
 * 
 */
package czsem.gate;

import gate.*;
import gate.corpora.DocumentImpl;
import gate.creole.AbstractLanguageAnalyser;
import gate.creole.AbstractResource;
import gate.creole.ExecutionException;
import gate.creole.metadata.*;
import gate.util.GateException;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.URL;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;


/**
 * @author dedek
 *
 */
@CreoleResource(name = "czsem FSExporter", comment = "Exports given corpus to Feature Structure Corpus (FS files)")
public class FSExporter extends AbstractLanguageAnalyser implements ProcessingResource, LanguageAnalyser
{
	private static final long serialVersionUID = -6562545464590354499L;
	
	private URL outputDirectory = null;
	private List<String> additionalAttributes = null;
	private boolean detectAdditionalAributes = true;
	private int number_of_tokens_to_scann = 20;

	private String inputASName = null;
	
	protected List<String> detectAdditionalAttributes()
	{
		AnnotationSet as = document.getAnnotations().get(TOKEN_ANNOTATION_TYPE);
		
		Iterator<Annotation> a_iter = as.iterator();
		
		HashSet<String> addAttr = new HashSet<String>();

		for (int t=0; t<number_of_tokens_to_scann; t++)
		{
			if (! a_iter.hasNext()) break;
			
			Annotation a = a_iter.next();
						
			for (Object key : a.getFeatures().keySet())
			{
				addAttr.add(key.toString());				
			}			
		}
		
		addAttr.removeAll(Arrays.asList(FSFileWriter.default_attributes));
		
		return Arrays.asList(addAttr.toArray(new String[0]));
	}
	
	public void execute() throws ExecutionException
	{
		StringBuilder sb = new StringBuilder();
		sb.append(outputDirectory.getFile());
		sb.append('/');
		sb.append(((AbstractResource) document).getName());
		sb.append(".fs");
		
		String dest_filename = findAvailableFileName(sb.toString());
		
		System.out.print("Writing: ");
		System.out.println(dest_filename);
		
		try {
			FSFileWriter fsw = new FSFileWriter(dest_filename);
			List<String> addAttr = 
				detectAdditionalAributes ? detectAdditionalAttributes() : additionalAttributes;
			
			fsw.PrintAll(document.getAnnotations(inputASName), addAttr);
			fsw.close();
		} catch (FileNotFoundException e) {
			throw new ExecutionException(e);
		}
	}
	
	public String getInputASName() {
		return inputASName ;
	}
	@Optional
	@RunTime
	@CreoleParameter
	public void setInputASName(String inputASName) {
		this.inputASName = inputASName;
	}


	@RunTime
	@CreoleParameter(defaultValue="file:/C:/WorkSpace/czSem/UNIX_copy/netgraph_server/corpus/en_pok")
	public void setOutputDirectory(URL outputDirectory) {
		this.outputDirectory = outputDirectory;
	}

	public URL getOutputDirectory() {
		return outputDirectory;
	}

	@RunTime
	@Optional
	@CreoleParameter(comment="Names of annotation attributes/features propagated to the FS output", defaultValue="category;orth")
	public void setAdditionalAttributes(List<String> additionalAttributes) {
		this.additionalAttributes = additionalAttributes;
	}

	public List<String> getAdditionalAttributes() {
		return additionalAttributes;
	}
 
	@RunTime
	@CreoleParameter(comment="Weather to detect additionalAttributes form the document at startup.", defaultValue="true")
	public void setDetectAdditionalAributes(Boolean detectAdditionalAributes) {
		this.detectAdditionalAributes = detectAdditionalAributes;
	}

	public Boolean getDetectAdditionalAributes() {
		return detectAdditionalAributes;
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

	public static void main(String[] args) throws IOException, GateException
	{		
		Gate.setNetConnected(false);
	    Gate.setLocalWebServer(false);
	    Gate.setGateHome(new File("C:\\Program Files\\GATE-5.0"));

	    Gate.init();
	    	    
	    Gate.getCreoleRegister().registerDirectories(new URL("file:/C:/Program%20Files/GATE-5.0/plugins/Stanford/"));
	    				
		DataStore ds = Factory.openDataStore("gate.persist.SerialDataStore", "file:/C:/Users/dedek/AppData/GATE/data_store/");
		ds.open();
		
		
		for (Object string : ds.getLrIds("gate.corpora.DocumentImpl")) {
			System.err.println(string);
		}
	
		FeatureMap docFeatures = Factory.newFeatureMap();
		docFeatures.put(DataStore.LR_ID_FEATURE_NAME, "PAUL KRUGMAN No Bubble Trouble_ ___1266416268589___8709");
		docFeatures.put(DataStore.DATASTORE_FEATURE_NAME, ds);		
		docFeatures.put(Document.DOCUMENT_MARKUP_AWARE_PARAMETER_NAME, "false");		
		DocumentImpl doc = (DocumentImpl) Factory.createResource("gate.corpora.DocumentImpl", docFeatures);

		String [] addit = {"category"};
		
/*		
		AnnotationSet as =  doc.getAnnotations();
		
	//	FSFileWriter fsw = new FSFileWriter("C:\\WorkSpace\\czSem\\UNIX_copy\\netgraph_server\\corpus\\en_pok\\narative.fs");
		FSFileWriter fsw = new FSFileWriter();
		
		
		fsw.PrintAll(as, Arrays.asList(addit));
*/
		
		FSExporter fsex = new FSExporter();
		fsex.setDocument(doc);
		fsex.setOutputDirectory(new URL("file:/C:/workspace/czsem/src/netgraph/czsem/TmT_serializations"));
		fsex.setAdditionalAttributes(Arrays.asList(addit));
		
		fsex.execute();
		
	}

}
