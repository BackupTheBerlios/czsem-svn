package czsem.gate.plugins;

import gate.Annotation;
import gate.AnnotationSet;
import gate.Corpus;
import gate.Document;
import gate.Factory;
import gate.FeatureMap;
import gate.Gate;
import gate.LanguageAnalyser;
import gate.creole.SerialAnalyserController;
import gate.util.GateException;

import java.io.File;
import java.net.MalformedURLException;
import java.util.Arrays;
import java.util.Iterator;

import junit.framework.Test;
import junit.framework.TestCase;
import junit.framework.TestSuite;
import czsem.gate.GateUtils;

public class TectoMTBatchAnalyserTest extends TestCase {

	@Override
	protected void setUp() throws Exception
	{
		Gate.init();
	    GateUtils.registerPluginDirectory(new File("czsem_GATE_plugins"));
	}

	@SuppressWarnings("unchecked")
	public void testExecuteEnglishSentenceSegmentation() throws GateException, MalformedURLException
	{

		String str_doc = "The BBC's Bethany Bell in Jerusalem says many people face shortages of food, medicine and fuel. Chancellor Alistair Darling says the new longer-term agreement will guarantee earnings growth for 5.5 million workers and will allow departments to plan more effectively.";
		
		Document doc = Factory.newDocument(str_doc);
		Corpus corpus = Factory.newCorpus("TectoMTBatchAnalyser_test_corpus");
		corpus.add(doc);
		
		SerialAnalyserController controller = (SerialAnalyserController)	    	   
			Factory.createResource(SerialAnalyserController.class.getCanonicalName());
		
		controller.setCorpus(corpus);
		
		String [] blocks = {"SEnglishW_to_SEnglishM::Sentence_segmentation"};

		
		FeatureMap fm = Factory.newFeatureMap();
		fm.put("loadScenarioFromFile", "false");
		fm.put("language", "english");
		fm.put("blocks", Arrays.asList(blocks));
		LanguageAnalyser tmt_analyzer = (LanguageAnalyser) Factory.createResource(TectoMTBatchAnalyser.class.getCanonicalName(), fm);
		controller.add(tmt_analyzer);
		controller.execute();
		AnnotationSet sents = doc.getAnnotations().get("Sentence");
		assertEquals(sents.size(), 2);
		Iterator<Annotation> siter = sents.iterator();
		Annotation s1 = siter.next();
		assertEquals((long) s1.getStartNode().getOffset(), 0);
		assertEquals((long) s1.getEndNode().getOffset(), 95);
		Annotation s2 = siter.next();
		assertEquals((long) s2.getStartNode().getOffset(), 96);
		assertEquals((long) s2.getEndNode().getOffset(), 266);
	}
	
	public static Test suite(){
		return new TestSuite(TectoMTBatchAnalyserTest.class);
	}


}
