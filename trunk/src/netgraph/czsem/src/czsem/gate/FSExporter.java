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
import java.util.Arrays;
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

	public FSExporter() {
	}
	
	
	public void execute() throws ExecutionException
	{
		StringBuilder sb = new StringBuilder();
		sb.append(outputDirectory.getFile());
		sb.append('/');
		sb.append(((AbstractResource) document).getName());
		sb.append(".fs");
		
		System.out.print("Writing: ");
		System.out.println(sb.toString());
		
		try {
			FSFileWriter fsw = new FSFileWriter(sb.toString());
			fsw.PrintAll(document.getAnnotations(), additionalAttributes);
			fsw.close();
		} catch (FileNotFoundException e) {
			throw new ExecutionException(e);
		}
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

	
	public static void main(String[] args) throws IOException, GateException
	{		
		Gate.setNetConnected(false);
	    Gate.setLocalWebServer(false);
	    Gate.setGateHome(new File("C:\\Program Files\\GATE-5.0-beta1"));

	    Gate.init();
	    	    
	    Gate.getCreoleRegister().registerDirectories(new URL("file:/C:/Program%20Files/GATE-5.0-beta1/plugins/Stanford/"));
	    				
		DataStore ds = Factory.openDataStore("gate.persist.SerialDataStore", "file:/C:/WorkSpace/GATE/Store/");
		ds.open();
		
		for (Object string : ds.getLrIds("gate.corpora.DocumentImpl")) {
			System.err.println(string);
		}

		FeatureMap docFeatures = Factory.newFeatureMap();
		docFeatures.put(DataStore.LR_ID_FEATURE_NAME, "zzz___1235139244109___5296");
		docFeatures.put(DataStore.DATASTORE_FEATURE_NAME, ds);		
		docFeatures.put(Document.DOCUMENT_MARKUP_AWARE_PARAMETER_NAME, "false");		
		DocumentImpl doc = (DocumentImpl) Factory.createResource("gate.corpora.DocumentImpl", docFeatures);
		
		
		AnnotationSet as =  doc.getAnnotations();
		
//		FSFileWriter fsw = new FSFileWriter("C:\\WorkSpace\\czSem\\UNIX_copy\\netgraph_server\\corpus\\en_pok\\narative.fs");
		FSFileWriter fsw = new FSFileWriter();
		
		String [] addit = {"category"};
		
		fsw.PrintAll(as, Arrays.asList(addit));
	}
}
