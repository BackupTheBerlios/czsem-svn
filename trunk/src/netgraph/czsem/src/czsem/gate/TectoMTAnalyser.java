package czsem.gate;

import gate.Annotation;
import gate.AnnotationSet;
import gate.DataStore;
import gate.Document;
import gate.Factory;
import gate.FeatureMap;
import gate.Gate;
import gate.corpora.DocumentImpl;
import gate.util.GateException;
import gate.util.InvalidOffsetException;

import java.io.File;
import java.io.IOException;
import java.net.URL;
import java.util.ArrayList;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpression;
import javax.xml.xpath.XPathExpressionException;
import javax.xml.xpath.XPathFactory;

import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;


public class TectoMTAnalyser {
	public static class SequenceAnnotator
	{
		private String string_content;
		private int last_index;
		private int last_length=0;
		
		public long lastStart() {return last_index-last_length;}
		public long lastEnd() {return last_index;}
		
		public SequenceAnnotator(Document doc)
		{
			this(doc, 0);
		}

		public SequenceAnnotator(Document doc, int start_index)
		{
			last_index = start_index;
			string_content = doc.getContent().toString();			
		}
		
		public void nextToken(String token)
		{
			int new_index = string_content.indexOf(token, last_index);
			if (new_index == -1) throw new StringIndexOutOfBoundsException(string_content.substring(last_index));
			
			if (new_index - last_index > 5)
			{
				System.err.println("WARNING big space in annotations dedtected!");
				System.err.print("last_index:");
				System.err.print(last_index);
				System.err.print(" new_index:");
				System.err.print(new_index);
				System.err.print(" diff:");
				System.err.println(new_index-last_index);
			}
			
			last_length = token.length();
			last_index = new_index + last_length; 
		}		
	}

	private static XPath xpath = XPathFactory.newInstance().newXPath();
	private static XPathExpression x_children; 
    

	public static void addDependencyAnnotation(AnnotationSet as, Integer id1, Integer id2, FeatureMap fm) throws InvalidOffsetException
	{
		Annotation a1 = as.get(id1);
		Annotation a2 = as.get(id2);
		
		Long ix1 = Math.min(a1.getStartNode().getOffset(), a2.getStartNode().getOffset());
		Long ix2 = Math.max(a1.getEndNode().getOffset(), a2.getEndNode().getOffset());
		
		as.add(ix1, ix2, "aDependency", fm);
	}
	
	public static void addDependencies(AnnotationSet as, Node parent) throws XPathExpressionException, InvalidOffsetException
	{		
		NodeList children = (NodeList) x_children.evaluate(parent, XPathConstants.NODESET);
		
		for (int a=0; a<children.getLength(); a++)
		{
			FeatureMap fm = Factory.newFeatureMap();
			ArrayList<Integer> args = new ArrayList<Integer>(2);
			Integer id1 = (Integer) parent.getUserData("id"); 
			Integer id2 = (Integer) children.item(a).getUserData("id"); 
			
			args.add(id1);
			args.add(id2);
			fm.put("args", args);			
			addDependencyAnnotation(as, id1, id2, fm);

			
			addDependencies(as, children.item(a));
		}
	}
	
	public static void annotateGateDocumentAcordingtoTMTfile(Document doc, String TmTFilename) throws ParserConfigurationException, SAXException, IOException, XPathExpressionException, InvalidOffsetException
	{				
		DocumentBuilder builder=DocumentBuilderFactory.newInstance().newDocumentBuilder();
        org.w3c.dom.Document tmt_doc = builder.parse(new File(TmTFilename));
                
        XPathExpression x_sentece_segments = xpath.compile("/tmt_document/bundles[1]/LM"); 
        XPathExpression x_sentece_text = xpath.compile("czech_source_sentence"); 
        XPathExpression x_a_nodes_ord = xpath.compile("trees/SCzechA//LM/ord"); 
        XPathExpression x_a_m_form = xpath.compile("m/form");
        XPathExpression x_a_root = xpath.compile("trees/SCzechA/children/LM");
        
		x_children = xpath.compile("children/LM");

        
        String[] token_features = 
        {
        		"m/form", "m/lemma", "m/tag", "afun", "ord" 	
        };
        
        XPathExpression[]  x_token_features = new XPathExpression[token_features.length];
        for (int a=0; a<token_features.length;a++) x_token_features[a] = xpath.compile(token_features[a]);
        
        
        NodeList sentece_segments = (NodeList) x_sentece_segments.evaluate(tmt_doc.getDocumentElement(), XPathConstants.NODESET);

        SequenceAnnotator token_sa = new SequenceAnnotator(doc);
        SequenceAnnotator sentence_sa = new SequenceAnnotator(doc);
        AnnotationSet as = doc.getAnnotations();
        as.clear();               
                
        for (int i=0; i<sentece_segments.getLength(); i++)
        {
        	//sentence
        	Node sentece_segment = sentece_segments.item(i);
        	String sentence_string = (String) x_sentece_text.evaluate(sentece_segment, XPathConstants.STRING);
        	sentence_sa.nextToken(sentence_string);
        	as.add(sentence_sa.lastStart(), sentence_sa.lastEnd(), "Sentence", Factory.newFeatureMap());
        	System.err.println(sentence_string);
            
        	//a nodes array
        	NodeList a_nodes_ord = (NodeList) x_a_nodes_ord.evaluate(sentece_segment, XPathConstants.NODESET);
            Node[] a_nodes_array = new Node[a_nodes_ord.getLength()]; 
            for (int j=0; j<a_nodes_array.length; j++)
            {
            	Node a_node_ord = a_nodes_ord.item(j);
            	int ord = Integer.parseInt(a_node_ord.getTextContent());
            	a_nodes_array[ord-1] = a_node_ord.getParentNode();            	
            }
            
            //a nodes attributes
            for (int j=0; j<a_nodes_array.length; j++)
            {
            	String token = (String) x_a_m_form.evaluate(a_nodes_array[j], XPathConstants.STRING);
            	System.out.print(token);            	
            	System.out.print(' ');
            	
            	token_sa.nextToken(token);
            	
            	FeatureMap fm = Factory.newFeatureMap();
            	for (int a=0; a<token_features.length; a++)
            	{
                	fm.put(
                			token_features[a],
                			x_token_features[a].evaluate(a_nodes_array[j], XPathConstants.STRING));            		
            	}
            	Integer id = as.add(token_sa.lastStart(), token_sa.lastEnd(), "Token", fm);
            	a_nodes_array[j].setUserData("id", id, null);
            	
            }
        	System.out.println();
        	
        	//a dependencies
        	addDependencies(as, (Node) x_a_root.evaluate(sentece_segment, XPathConstants.NODE));
        }        
               
		//sentence
		//tokens
		//trees
	}
	
	
	public static void main(String[] args) throws GateException, ParserConfigurationException, SAXException, IOException, XPathExpressionException
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
		docFeatures.put(DataStore.LR_ID_FEATURE_NAME, "cesky1___1258555197823___5374");
		docFeatures.put(DataStore.DATASTORE_FEATURE_NAME, ds);		
		docFeatures.put(Document.DOCUMENT_MARKUP_AWARE_PARAMETER_NAME, "false");		
		DocumentImpl doc = (DocumentImpl) Factory.createResource("gate.corpora.DocumentImpl", docFeatures);
		

		System.out.println(doc.toXml());
		
		annotateGateDocumentAcordingtoTMTfile(doc, "C:\\workspace\\czsem\\src\\netgraph\\czsem\\TmT_serializations\\sample.tmt");
		
		ds.sync(doc);		
		ds.close();		
	}


}
