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

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;

import javax.xml.parsers.ParserConfigurationException;
import javax.xml.xpath.XPathExpressionException;

import org.xml.sax.SAXException;

import com.generationjava.io.xml.SimpleXmlWriter;
import com.generationjava.io.xml.XmlWriter;

import czsem.utils.ProcessExec;


public class TectoMTAnalyser {
	
	public static void prepareTMTFile(Document doc, String filename) throws IOException 
	{		
		Writer fwr = new OutputStreamWriter(new FileOutputStream(filename), "utf-8");
		XmlWriter xmlwriter = new SimpleXmlWriter(fwr);
		xmlwriter.writeXmlVersion("1.0", "utf-8");
		xmlwriter.writeEntity("tmt_document");
		xmlwriter.writeAttribute("xmlns", "http://ufal.mff.cuni.cz/pdt/pml/");
		xmlwriter.writeEntity("head");
		xmlwriter.writeEntity("schema");
		xmlwriter.writeAttribute("href", "tmt_schema.xml");
		xmlwriter.endEntity();//schema
		xmlwriter.endEntity();//head
		xmlwriter.writeEntity("meta");
		xmlwriter.writeEntityWithText("czech_source_text", doc.getContent().toString());
		xmlwriter.endEntity();//meta
		xmlwriter.endEntity();//tmt_document
		xmlwriter.close();
		fwr.close();
	}
	
	public static void produceTMTAnalysis(String filename) throws IOException, InterruptedException
	{
		String[] cmdarray = 
		{
//				/home/dedek/workspace/tectomt/config/init_devel_environ.sh

				"/bin/bash",
				"/home/dedek/workspace/tectomt/tools/general/brunblocks_env",
				"-S", "-o", "--scen",
				"/home/dedek/workspace/tectomt/applications/czeng10/cs_czeng_analysis_dedek.scen",
				"--", filename
		};		


		ProcessExec tmt_proc = new ProcessExec();			
		tmt_proc.exec(cmdarray);
		tmt_proc.startReaderThreads();
		tmt_proc.waitFor();
		
	}
	
	public static void annotateGateDocumentAcordingtoTMTfile(Document doc, String TmTFilename) throws ParserConfigurationException, SAXException, IOException, XPathExpressionException, InvalidOffsetException
	{				
        AnnotationSet as = doc.getAnnotations();
        as.clear();
        
    	SAXTMTAnnotator tmt_tree_annot = new SAXTMTAnnotator();
    	
    	tmt_tree_annot.parseAndInit(TmTFilename);
    	tmt_tree_annot.debug_print(System.out);
    	tmt_tree_annot.annotate(doc);

/***
        DocumentBuilder builder=DocumentBuilderFactory.newInstance().newDocumentBuilder();
        org.w3c.dom.Document tmt_doc = builder.parse(new File(TmTFilename));
        
/***
        XPath xpath = XPathFactory.newInstance().newXPath();

        XPathExpression exp = xpath.compile("//a");

        NodeList list = 
        	(NodeList) exp.evaluate(
        			tmt_doc.getDocumentElement(), XPathConstants.NODESET);
        
        TransformerFactory tf = TransformerFactory.newInstance();
		try {
	        Transformer tr = tf.newTransformer();
	        tr.setOutputProperty(OutputKeys.OMIT_XML_DECLARATION, "yes");
	        tr.setOutputProperty(OutputKeys.INDENT, "yes");
        
        
	        for (int i=0; i<list.getLength(); i++)
	        {
	        	System.out.print("<<<<<<<<<<<<<<<<<"); System.out.println(i);
	            DOMSource ds = new DOMSource(list.item(i));
	            StreamResult sr = new StreamResult(System.out);
	            tr.transform(ds, sr);
	        	System.out.print("\n>>>>>>>>>>>>>>>>>"); System.out.println(i);
	        	
	        }

		} catch (TransformerConfigurationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (TransformerException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
        
/***        
                
        NodeList sentece_segments = 
        	(NodeList) XPathExperssions.sentece_segments.evaluate(
        			tmt_doc.getDocumentElement(), XPathConstants.NODESET);

        SequenceAnnotator sentence_sa = new SequenceAnnotator(doc);

                
    	//sentences
        for (int i=0; i<sentece_segments.getLength(); i++)
        {
        	try 
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
        	catch (StringIndexOutOfBoundsException e) 
        	{
        		System.err.println(e.getMessage());        		
        	}
        	
        }        

/***/	
	}
	

	public static void main(String[] args) throws GateException, ParserConfigurationException, SAXException, IOException, XPathExpressionException, InterruptedException
	{
		Gate.setNetConnected(false);
	    Gate.setLocalWebServer(false);
//	    Gate.setGateHome(new File("C:\\Program Files\\GATE-5.0"));

	    Gate.init();
	    	    
//	    Gate.getCreoleRegister().registerDirectories(new URL("file:/C:/Program%20Files/GATE-5.0/plugins/Stanford/"));
	    				
//		DataStore ds = Factory.openDataStore("gate.persist.SerialDataStore", "file:/C:/Users/dedek/AppData/GATE/data_store/");
		DataStore ds = Factory.openDataStore("gate.persist.SerialDataStore", "file:/home/dedek/workspace/crawlovani/gate_made/store1/");
		ds.open();
		
		for (Object string : ds.getLrIds("gate.corpora.DocumentImpl")) {
			System.err.println(string);
		}
		
		FeatureMap docFeatures = Factory.newFeatureMap();
		
		docFeatures.put(DataStore.LR_ID_FEATURE_NAME, "cesky na unixu____1268127896084___303");
//		docFeatures.put(DataStore.LR_ID_FEATURE_NAME, "cesky1___1258555197823___5374");
//		docFeatures.put(DataStore.LR_ID_FEATURE_NAME, "all50_serious_messages_noids_utf8___1267111757247___7332");
		docFeatures.put(DataStore.DATASTORE_FEATURE_NAME, ds);		
		docFeatures.put(Document.DOCUMENT_MARKUP_AWARE_PARAMETER_NAME, "false");		
		DocumentImpl doc = (DocumentImpl) Factory.createResource("gate.corpora.DocumentImpl", docFeatures);
		
		
		
		prepareTMTFile(doc, "TmT_serializations/pok1.xml");
		produceTMTAnalysis("TmT_serializations/pok1.xml");
		

//		System.out.println(doc.toXml());
		
//		XPathExperssions.init();
		
//		annotateGateDocumentAcordingtoTMTfile(doc, "C:\\workspace\\czsem\\src\\netgraph\\czsem\\TmT_serializations\\sample.tmt");
//		annotateGateDocumentAcordingtoTMTfile(doc, "C:\\workspace\\czsem\\src\\netgraph\\czsem\\TmT_serializations\\all50_serious_messages_noids_utf8.tmt");
		
		
//		ds.sync(doc);		
		ds.close();		
	}


}
