package czsem.gate;

import gate.DataStore;
import gate.Document;
import gate.Factory;
import gate.FeatureMap;
import gate.Gate;
import gate.LanguageAnalyser;
import gate.ProcessingResource;
import gate.corpora.DocumentImpl;
import gate.creole.AbstractLanguageAnalyser;
import gate.creole.ExecutionException;
import gate.creole.metadata.CreoleParameter;
import gate.creole.metadata.CreoleResource;
import gate.creole.metadata.Optional;
import gate.creole.metadata.RunTime;
import gate.util.GateException;
import gate.util.Out;

import java.io.IOException;
import java.net.URL;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.xml.parsers.ParserConfigurationException;
import javax.xml.xpath.XPathExpressionException;

import org.xml.sax.SAXException;

import czsem.utils.ProcessExec;

@CreoleResource(name = "czsem TectoMTAnalyser", comment = "Alyses givem corpus by TMT tools")
public class TectoMTAnalyser extends AbstractLanguageAnalyser implements ProcessingResource, LanguageAnalyser
{

	private static final long serialVersionUID = -1436830144361327369L;

	private URL scenarioFilePath = null;
	private URL serializationDirectory = null;
	private List<String> blocks = null;
	
	private List<TectoMTDocumentAnalyser> documents_to_anlayse= new ArrayList<TectoMTDocumentAnalyser>();

	@Override
	public void execute() throws ExecutionException
	{
		try {
			Out.prln(documents_to_anlayse.size());
			
			if (documents_to_anlayse.size() <= corpus.size())
			{
				TectoMTDocumentAnalyser da = new TectoMTDocumentAnalyser(document);
				da.prepareTMTFile(getSerializationDirectory());
				documents_to_anlayse.add(da);
				
				if (documents_to_anlayse.size() == corpus.size())
				{
					Out.prln("Analyse !");
					produceTMTAnalysis();
					Out.prln("Analysed !");
					for (TectoMTDocumentAnalyser a : documents_to_anlayse)
					{
						a.annotateGateDocumentAcordingtoTMTfile();
					}
					Out.prln("Annotated !");
					documents_to_anlayse.clear();
				}
			} 
		} catch (Exception e) {
			throw new ExecutionException(e);
		}
	}

	
	public void produceTMTAnalysis() throws IOException, InterruptedException
	{
		String[] cmdarray = 
		{
//				/home/dedek/workspace/tectomt/config/init_devel_environ.sh

				"/bin/bash",
				"/home/dedek/workspace/tectomt/tools/general/brunblocks_env",
				"-S", "-o"
				
//				, "--scen",
//				"/home/dedek/workspace/tectomt/applications/czeng10/cs_czeng_analysis_dedek_testing.scen",
//				"/home/dedek/workspace/tectomt/applications/czeng10/cs_czeng_analysis_dedek.scen",
//				"--", new File(filename).getAbsolutePath()
		};
		
		List<String> cmd_list = new ArrayList<String>(Arrays.asList(cmdarray));
		
		URL scen = getScenarioFilePath();
		if (scen != null)
		{
			cmd_list.add("--scen");			
			cmd_list.add(scen.getFile());			
		}
		else
		{
			List<String> blocks = getBlocks();
			cmd_list.addAll(blocks);
		}
		cmd_list.add("--");
		
		for (TectoMTDocumentAnalyser da : documents_to_anlayse)
		{
			cmd_list.add(da.getTMTFilePath());			
		}


		ProcessExec tmt_proc = new ProcessExec();			
		tmt_proc.exec(cmdarray);
		tmt_proc.startReaderThreads();
		tmt_proc.waitFor();
		
	}
	
	/*
	public static void annotateGateDocumentAcordingtoTMTfile(Document doc, String TmTFilename) throws ParserConfigurationException, SAXException, IOException, XPathExpressionException, InvalidOffsetException
	{				
        DocumentBuilder builder=DocumentBuilderFactory.newInstance().newDocumentBuilder();
        org.w3c.dom.Document tmt_doc = builder.parse(new File(TmTFilename));
        
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
	}
	*/	

	

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
		
		
		TectoMTDocumentAnalyser da = new TectoMTDocumentAnalyser(doc);
		
		da.prepareTMTFile(new URL("file:/tmp/czsem/src/netgraph/czsem/TmT_serializations"));
//		da.produceTMTAnalysis();
		da.annotateGateDocumentAcordingtoTMTfile();
		

//		System.out.println(doc.toXml());
		
//		XPathExperssions.init();
		
//		annotateGateDocumentAcordingtoTMTfile(doc, "C:\\workspace\\czsem\\src\\netgraph\\czsem\\TmT_serializations\\sample.tmt");
//		annotateGateDocumentAcordingtoTMTfile(doc, "C:\\workspace\\czsem\\src\\netgraph\\czsem\\TmT_serializations\\all50_serious_messages_noids_utf8.tmt");
		
		
		ds.sync(doc);		
		ds.close();		
	}

	@RunTime
	@CreoleParameter(comment="Directory where temporary TMT files are stored.", defaultValue="file:/tmp/czsem/src/netgraph/czsem/TmT_serializations")
	public void setSerializationDirectory(URL serializationDirectory) {
		this.serializationDirectory = serializationDirectory;
	}

	public URL getSerializationDirectory() {
		return serializationDirectory;
	}

	@RunTime
	@CreoleParameter(defaultValue="file:/home/dedek/workspace/tectomt/applications/czeng10/cs_czeng_analysis_dedek_testing.scen", disjunction="scenario")
	public void setScenarioFilePath (URL scenarioFilePath ) {
		this.scenarioFilePath  = scenarioFilePath ;
	}

	public URL getScenarioFilePath() {
		return scenarioFilePath;
	}

	
	@RunTime
	@Optional
	@CreoleParameter(comment="List of blocks to be used in the analysis", defaultValue="SCzechW_to_SCzechM::Sentence_segmentation;SCzechW_to_SCzechM::Tokenize_joining_numbers", disjunction="scenario")
	public void setBlocks(List<String> blocks) {
		this.blocks = blocks;
	}
	
	public List<String> getBlocks() {
		return blocks;
	}


}
