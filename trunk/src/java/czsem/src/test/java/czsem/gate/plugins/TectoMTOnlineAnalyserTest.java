package czsem.gate.plugins;

import gate.AnnotationSet;
import gate.Corpus;
import gate.Document;
import gate.Factory;
import gate.FeatureMap;
import gate.Gate;
import gate.ProcessingResource;
import gate.Resource;
import gate.creole.ExecutionException;
import gate.creole.ResourceInstantiationException;
import gate.creole.SerialAnalyserController;
import gate.util.GateException;

import java.io.File;
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URISyntaxException;
import java.util.Arrays;
import java.util.List;

import junit.framework.TestCase;

import org.apache.log4j.Level;
import org.apache.log4j.Logger;

import czsem.gate.GateUtils;
import czsem.utils.Config;

public class TectoMTOnlineAnalyserTest extends TestCase
{
	public static List<String> getTempBlocks() {
		String [] blocks =
		{
				"SEnglishW_to_SEnglishM::Sentence_segmentation",
				"SEnglishW_to_SEnglishM::Tokenization"
		};
		
		return Arrays.asList(blocks);
	}
	
	@SuppressWarnings("unchecked")
	protected Corpus corpusFromSentences(String [] sentences) throws ResourceInstantiationException
	{
		Corpus corpus = Factory.newCorpus(null);

		
	    for (int i = 0; i < sentences.length; i++)
	    {
			Document document = Factory.newDocument(sentences[i]);
		    corpus.add(document);
		}

	    
		return corpus;
	}

	
	
	public TectoMTOnlineAnalyserTest() throws URISyntaxException, IOException, GateException
	{
	    if (! Gate.isInitialised())
	    {
			Config.getConfig().setGateHome();
			Gate.init();
		    GateUtils.registerPluginDirectory(new File("czsem_GATE_plugins"));
	    }
	}
	
	
	protected void executeTmtOnCorpus(String language, String [] blocks, Corpus corpus) throws ResourceInstantiationException, ExecutionException
	{
		FeatureMap fm = Factory.newFeatureMap();
		fm.put("loadScenarioFromFile", "false");
		fm.put("language", language);
		fm.put("blocks", Arrays.asList(blocks));
		Resource tmt_analyzer = Factory.createResource(TectoMTOnlineAnalyser.class.getCanonicalName(), fm);

		
		SerialAnalyserController controller = (SerialAnalyserController)	    	   
			Factory.createResource(SerialAnalyserController.class.getCanonicalName());
	
		controller.setCorpus(corpus);
		controller.add((ProcessingResource) tmt_analyzer);
		controller.execute();
		
		Factory.deleteResource(controller);
	}

	

	
	public void testRunTerminate() throws Exception
	{
		Logger.getLogger(TectoMTOnlineAnalyser.class).setLevel(Level.ALL);
		TectoMTOnlineAnalyser ta = new TectoMTOnlineAnalyser();
		
		assertFalse(ta.isServerRunning());
		
//		ta.setLoadScenarioFromFile(false);
		ta.setScenarioFilePath(new File("czsem_GATE_plugins/tmt_analysis_scenarios/czech_full_blocks.scen").toURI().toURL());
		ta.setBlocks(getTempBlocks());

		ta.startTMTAnalysisServer();
//		Thread.sleep(2000);
		assertTrue(ta.isServerRunning());
		
//		TectMTServerConnection con = new TectMTServerConnection(8080);
		
/*
		con.analyseFile("czsem_GATE_plugins/TmT_serializations/1032.xml_0001A.tmt~");
		con.analyseFile("czsem_GATE_plugins/TmT_serializations/10784.xml_00025.tmt~");
		con.analyseFile("czsem_GATE_plugins/TmT_serializations/9809.xml_00262.tmt");
*/
		ta.cleanup();
		Thread.sleep(1000);
		assertFalse(ta.isServerRunning());

	}
	
	public void testExecuteCzechSentenceSegmentation() throws GateException, MalformedURLException
	{		
		
		String [] blocks = 
		{
			"SCzechW_to_SCzechM::TextSeg_tokenizer_and_segmenter",
			"SCzechW_to_SCzechM::Tokenize_joining_numbers"};


		
		
		Corpus corpus = corpusFromSentences(TectoMTBatchAnalyserTest.czech_sentences);
		executeTmtOnCorpus("czech", blocks, corpus);		
		
		for (int i = 0; i < corpus.size(); i++)
		{
			Document doc = (Document) corpus.get(i);
			
			AnnotationSet as = doc.getAnnotations();
			AnnotationSet sents = as.get("Sentence");
			assertTrue(doc.getName(), sents.size() >= 1);
			AnnotationSet toc = as.get("Token");
			assertTrue(doc.getName(), toc.size() >= TectoMTBatchAnalyserTest.czech_sentences[i].length() / 7);
			
		}
		/*
		AnnotationSet sents = document.getAnnotations().get("Sentence");
		assertEquals(sents.size(), 2);
		Iterator<Annotation> siter = sents.iterator();
		Annotation s1 = siter.next();
		assertEquals((long) s1.getStartNode().getOffset(), 0);
		assertEquals((long) s1.getEndNode().getOffset(), 95);
		Annotation s2 = siter.next();
		assertEquals((long) s2.getStartNode().getOffset(), 96);
		assertEquals((long) s2.getEndNode().getOffset(), 266);
		*/
	}


}
