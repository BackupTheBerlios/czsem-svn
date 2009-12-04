package czsem.gate;

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
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpressionException;

import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;


public class TectoMTAnalyser {
	
	
	public static void annotateGateDocumentAcordingtoTMTfile(Document doc, String TmTFilename) throws ParserConfigurationException, SAXException, IOException, XPathExpressionException, InvalidOffsetException
	{				
        AnnotationSet as = doc.getAnnotations();
        as.clear();               

        DocumentBuilder builder=DocumentBuilderFactory.newInstance().newDocumentBuilder();
        org.w3c.dom.Document tmt_doc = builder.parse(new File(TmTFilename));
                
        NodeList sentece_segments = 
        	(NodeList) XPathExperssions.sentece_segments.evaluate(
        			tmt_doc.getDocumentElement(), XPathConstants.NODESET);

        SequenceAnnotator sentence_sa = new SequenceAnnotator(doc);

                
    	//sentences
        for (int i=0; i<sentece_segments.getLength(); i++)
        {
        	Node sentece_segment = sentece_segments.item(i);
        	String sentence_string = (String) XPathExperssions.sentece_text.evaluate(sentece_segment, XPathConstants.STRING);
        	sentence_sa.nextToken(sentence_string);
        	as.add(sentence_sa.lastStart(), sentence_sa.lastEnd(), "Sentence", Factory.newFeatureMap());
        	System.err.println(sentence_string);
        	
        	TMTTreeAnnotator tmt_tree_annot = new TMTTreeAnnotator(doc, sentece_segment);
        	
        	tmt_tree_annot.initSortedANodesArray();
        	
        	tmt_tree_annot.ATokensSequnceAnnotation((int) sentence_sa.lastStart());
        	
        	tmt_tree_annot.addADependencies(
        			(Node) XPathExperssions.a_root.evaluate(sentece_segment, XPathConstants.NODE));            

        	tmt_tree_annot.addTNodesAndDependencies(
        			(Node) XPathExperssions.t_root.evaluate(sentece_segment, XPathConstants.NODE));            
        }        
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
		
		XPathExperssions.init();
		
		annotateGateDocumentAcordingtoTMTfile(doc, "C:\\workspace\\czsem\\src\\netgraph\\czsem\\TmT_serializations\\sample.tmt");
		
		ds.sync(doc);		
		ds.close();		
	}


}
