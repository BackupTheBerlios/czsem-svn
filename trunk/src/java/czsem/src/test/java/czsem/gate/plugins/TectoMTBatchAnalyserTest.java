package czsem.gate.plugins;

import gate.Annotation;
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
import gate.util.InvalidOffsetException;

import java.io.File;
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URISyntaxException;
import java.util.Arrays;
import java.util.Iterator;

import javax.xml.parsers.ParserConfigurationException;

import org.xml.sax.SAXException;

import junit.framework.Test;
import junit.framework.TestCase;
import junit.framework.TestSuite;
import czsem.gate.GateUtils;

public class TectoMTBatchAnalyserTest extends TestCase
{
	String [] english_sentences =
	{
		"The BBC's Bethany Bell in Jerusalem says many people face shortages of food, medicine and fuel.",
		"Chancellor Alistair Darling says the new longer-term agreement will guarantee earnings growth for 5.5 million workers and will allow departments to plan more effectively."
	};
	
	Corpus corpus_english_short;
	Corpus corpus_english_long;
	Corpus corpus_english_full;
	
	Document english_short_doc;
	Document english_long_doc;
	Document english_full_doc;



	@SuppressWarnings("unchecked")
	@Override
	protected void setUp() throws Exception
	{
		Gate.init();
	    GateUtils.registerPluginDirectory(new File("czsem_GATE_plugins"));
	    
	    corpus_english_short = Factory.newCorpus("corpus_english_short");
	    corpus_english_long = Factory.newCorpus("corpus_english_long");
	    corpus_english_full = Factory.newCorpus("corpus_english_full");
	    
	    english_short_doc = Factory.newDocument(english_sentences[0]);
	    english_long_doc = Factory.newDocument(english_sentences[0] + " " + english_sentences[1]);
	    english_full_doc = Factory.newDocument(getClass().getResource("/english_full.txt"));
	    corpus_english_short.add(english_short_doc);
	    corpus_english_long.add(english_long_doc);
	    corpus_english_full.add(english_full_doc);
	   
	}
	
	protected void executeTmtOnCorpus(String language, String [] blocks, Corpus corpus) throws ResourceInstantiationException, ExecutionException
	{
		FeatureMap fm = Factory.newFeatureMap();
		fm.put("loadScenarioFromFile", "false");
		fm.put("language", language);
		fm.put("blocks", Arrays.asList(blocks));
		Resource tmt_analyzer = Factory.createResource(TectoMTBatchAnalyser.class.getCanonicalName(), fm);

		
		SerialAnalyserController controller = (SerialAnalyserController)	    	   
			Factory.createResource(SerialAnalyserController.class.getCanonicalName());
	
		controller.setCorpus(corpus);
		controller.add((ProcessingResource) tmt_analyzer);
		controller.execute();		
	}

	public void testAnnotateGateDocumentAcordingtoTMTfileFull() throws InvalidOffsetException, ParserConfigurationException, SAXException, IOException, URISyntaxException
	{
		english_full_doc.getAnnotations().clear();
		AnnotationSet as = english_full_doc.getAnnotations();
		assertEquals(as.size(), 0);
		assertEquals(1302, (long) english_full_doc.getContent().size());

		TectoMTBatchAnalyser tmt_ba = new TectoMTBatchAnalyser();
		tmt_ba.setLanguage("english");
		tmt_ba.annotateGateDocumentAcordingtoTMTfile(
				english_full_doc,
				GateUtils.URLToFilePath(getClass().getResource("/english_full.tmt")));
		assertEquals(as.size(), 913);
		
				
		validateAsType(as, "Sentence", 10, 0);
		validateAsType(as, "Token", 251, 5);
		validateAsType(as, "NamedEntity", 16, 2);
		validateAsType(as, "aDependency", 231, 1);
		validateAsType(as, "tDependency", 159, 1);
		validateAsType(as, "auxRfDependency", 77, 1);
		validateAsType(as, "tToken", 169, (Integer) null);
		
	}
	
	public void testAnnotateGateDocumentAcordingtoTMTfileMorpho() throws URISyntaxException, InvalidOffsetException, ParserConfigurationException, SAXException, IOException
	{
		english_short_doc.getAnnotations().clear();
		AnnotationSet as = english_short_doc.getAnnotations();
		assertEquals(as.size(), 0);
		
		TectoMTBatchAnalyser tmt_ba = new TectoMTBatchAnalyser();
		tmt_ba.setLanguage("english");
		tmt_ba.annotateGateDocumentAcordingtoTMTfile(
				english_short_doc,
				GateUtils.URLToFilePath(getClass().getResource("/english_morphology.tmt")));
		
		
		assertEquals(20, as.size());
		validateAsType(as, "Token", 19, 3);		
	}
	
	protected void validateAsType(AnnotationSet as, String an_type, int num_annots, Integer num_features)
	{
		AnnotationSet at = as.get(an_type);
		assertEquals(num_annots, at.size());
		for (Annotation a : at) {
			FeatureMap fm = a.getFeatures();
			if (num_features != null) assertEquals(num_features, (Integer) fm.size());
			for (Object key : fm.keySet()) {
				Object value = fm.get(key);
				assertNotNull(value);
				assertFalse(value.equals("null"));
				assertFalse(value.equals("<null>"));
			}
		}

	}

	public void testExecuteEnglishMorphology() throws ResourceInstantiationException, ExecutionException
	{
		String [] blocks = {
				"SEnglishW_to_SEnglishM::Sentence_segmentation",
				"SEnglishW_to_SEnglishM::Penn_style_tokenization",
				"SEnglishW_to_SEnglishM::TagMorce",
				"SEnglishW_to_SEnglishM::Fix_mtags",
				"SEnglishW_to_SEnglishM::Lemmatize_mtree"
				};
		
		
		executeTmtOnCorpus("english", blocks, corpus_english_short);
		
		AnnotationSet as = english_short_doc.getAnnotations();
		
		assertEquals(20, as.size());
		
		validateAsType(as, "Token", 19, 3);
		FeatureMap fm = as.get((long) english_sentences[0].indexOf("says")).iterator().next().getFeatures();
		assertEquals(fm.get("form"), "says");
		assertEquals(fm.get("lemma"), "say");
		assertEquals(fm.get("tag"), "VBZ");
		assertEquals(fm.get("afun"), null);
		assertEquals(fm.get("ord"), null);

	}

		
	public void testExecuteEnglishSentenceSegmentation() throws GateException, MalformedURLException
	{		
		
		String [] blocks = {"SEnglishW_to_SEnglishM::Sentence_segmentation"};

		
		
		executeTmtOnCorpus("english", blocks, corpus_english_long);		
		
		AnnotationSet sents = english_long_doc.getAnnotations().get("Sentence");
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
