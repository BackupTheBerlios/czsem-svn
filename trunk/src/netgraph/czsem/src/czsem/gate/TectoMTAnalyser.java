package czsem.gate;

import gate.AnnotationSet;
import gate.DataStore;
import gate.Document;
import gate.Factory;
import gate.FeatureMap;
import gate.Gate;
import gate.corpora.DocumentImpl;
import gate.util.GateException;

import java.io.File;
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpressionException;
import javax.xml.xpath.XPathFactory;

import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.w3c.dom.traversal.DocumentTraversal;
import org.w3c.dom.traversal.NodeFilter;
import org.w3c.dom.traversal.NodeIterator;
import org.w3c.dom.traversal.TreeWalker;
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

	public static void annotateGateDocumentAcordingtoTMTfile(Document doc, String TmTFilename) throws ParserConfigurationException, SAXException, IOException, XPathExpressionException
	{
		DocumentBuilder builder=DocumentBuilderFactory.newInstance().newDocumentBuilder();
        org.w3c.dom.Document tmt_doc = builder.parse(new File(TmTFilename));
        
        XPath xpath = XPathFactory.newInstance().newXPath();
        
        NodeList list = (NodeList) xpath.evaluate("/tmt_document/bundles[1]/LM[1]/trees[1]/SCzechA[1]//LM", tmt_doc.getDocumentElement(), XPathConstants.NODESET);
        
        for (int i=0; i<list.getLength(); i++)
        {
        	Element e = (Element) list.item(i);
        	System.err.println(e.getAttribute("id"));
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
