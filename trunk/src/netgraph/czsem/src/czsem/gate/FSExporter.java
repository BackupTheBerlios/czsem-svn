/**
 * 
 */
package czsem.gate;

import gate.*;
import gate.corpora.DocumentImpl;
import gate.creole.AbstractLanguageAnalyser;
import gate.util.GateException;
import gate.util.Out;

import java.io.File;
import java.io.IOException;
import java.net.URL;
import java.util.ArrayList;


/**
 * @author dedek
 *
 */
public class FSExporter extends AbstractLanguageAnalyser implements ProcessingResource, LanguageAnalyser
{
	private static final long serialVersionUID = -6562545464590354499L;
	
	private Document documnet = null;

	public FSExporter() {
	}
	
	public void execute()
	{
		Out.println(document.getAnnotations().size());		
		System.err.println(document);		
	}

	@SuppressWarnings("unchecked")
	public static int[] decodeEdge(Annotation a)
	{
		int [] ret = new int[2];
		ArrayList<Integer> list = (ArrayList<Integer>) a.getFeatures().get("args");
		ret[0] = list.get(0);
		ret[1] = list.get(1);
		return ret;
	}
	
	public static void printChilderen(AnnotationSet dependeces, int father_id)
	{
		System.out.print('{');
		for (Annotation dep : dependeces)
		{
			int [] edge = decodeEdge(dep);
			if (edge[0] == father_id)
			{
				System.out.print(edge[1]);
				System.out.print(',');
			}
		}		
		System.out.print('}');
	}

	public static int findRoot(AnnotationSet dependeces)
	{
		if (dependeces.size() <= 0) return -1;			
		
		Annotation a = (Annotation) dependeces.iterator().next();
		
		int ret = decodeEdge(a)[0];
		int new_ret;
		
		for (;;) {		
			new_ret = -1;
			for (Annotation dep : dependeces)
			{
				int [] edge = decodeEdge(dep);
				if (edge[1] == ret)
				{
					new_ret = edge[0];
					break;				
				}
			}
			
			if (new_ret == -1) break;
			
			ret = new_ret;			
		} 
		
		return ret;	
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
		
		fsw.PrintAll(as);
		

/*
			for (Annotation token : sentence_set)
			{
				System.out.print(token.getFeatures());
				System.out.println(' ');
			}						
/**				
			AnnotationSet deps = sentence_set.get("Dependency");
			int root = findRoot(deps);
			System.out.print(root);
			printChilderen(deps, root);
//			System.out.print(' ');
//			System.out.print(sentence);
			System.out.println("------");
**/			
		
/**		
		for (Annotation annot : doc.getAnnotations().get("Dependency", Factory.newFeatureMap())) {
			System.out.print(annot.getFeatures());
			System.out.println(annot.getType());			
		}
/**/		
			      

		
//		Factory.createResource("", "", "", "");
		
//		Object o = PersistenceManager.loadObjectFromFile(new File("C:\\WorkSpace\\GATE\\Store"));
//		System.out.println(o);		
	}

	public Document getDocumnet() {
		return documnet;
	}

	public void setDocumnet(Document documnet) {
		this.documnet = documnet;
	}

}
