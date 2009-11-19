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
import org.w3c.dom.traversal.NodeFilter;
import org.xml.sax.SAXException;


public class TectoMTAnalyser {
	public static class TokenNodeFilter implements NodeFilter
	{
		@Override
		public short acceptNode(Node n) {
			if (n.getNodeName().equals("SCzechT")) return NodeFilter.FILTER_REJECT; 
			return NodeFilter.FILTER_ACCEPT;
		}
		
	}
	
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

	public static void annotateGateDocumentAcordingtoTMTfile(Document doc, String TmTFilename) throws ParserConfigurationException, SAXException, IOException, XPathExpressionException, InvalidOffsetException
	{				
		DocumentBuilder builder=DocumentBuilderFactory.newInstance().newDocumentBuilder();
        org.w3c.dom.Document tmt_doc = builder.parse(new File(TmTFilename));
                
        XPath xpath = XPathFactory.newInstance().newXPath();
        XPathExpression x_sentece_segments = xpath.compile("/tmt_document/bundles[1]/LM"); 
        XPathExpression x_sentece_text = xpath.compile("czech_source_sentence"); 
        XPathExpression x_a_nodes_ord = xpath.compile("trees/SCzechA//LM/ord"); 
        XPathExpression x_a_m_form = xpath.compile("m/form");
        
        
        NodeList sentece_segments = (NodeList) x_sentece_segments.evaluate(tmt_doc.getDocumentElement(), XPathConstants.NODESET);

        SequenceAnnotator sa = new SequenceAnnotator(doc);
        AnnotationSet as = doc.getAnnotations();
        as.clear();               
                
        for (int i=0; i<sentece_segments.getLength(); i++)
        {
        	//sentence
        	Node sentece_segment = sentece_segments.item(i);
        	System.err.println((String) x_sentece_text.evaluate(sentece_segment, XPathConstants.STRING));
            
        	//a nodes array
        	NodeList a_nodes_ord = (NodeList) x_a_nodes_ord.evaluate(sentece_segment, XPathConstants.NODESET);
            Node[] a_nodes_array = new Node[a_nodes_ord.getLength()]; 
            for (int j=0; j<a_nodes_array.length; j++)
            {
            	Node a_node_ord = a_nodes_ord.item(j);
            	int ord = Integer.parseInt(a_node_ord.getTextContent());
            	a_nodes_array[ord-1] = a_node_ord.getParentNode();            	
            }
            
            //a nodes forms
            for (int j=0; j<a_nodes_array.length; j++)
            {
            	String token = (String) x_a_m_form.evaluate(a_nodes_array[j], XPathConstants.STRING);
            	System.out.print(token);            	
            	System.out.print(' ');
            	
            	sa.nextToken(token);
            	
            	as.add(sa.lastStart(), sa.lastEnd(), "sdd", Factory.newFeatureMap());
            	
            }
        	System.out.println();            	
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
