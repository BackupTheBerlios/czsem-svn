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
import gate.TextualDocument;
import gate.creole.ExecutionException;
import gate.creole.ResourceInstantiationException;
import gate.creole.SerialAnalyserController;
import gate.util.GateException;
import gate.util.InvalidOffsetException;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.PrintStream;
import java.net.MalformedURLException;
import java.net.URISyntaxException;
import java.util.Arrays;
import java.util.Iterator;

import javax.xml.parsers.ParserConfigurationException;

import junit.framework.Test;
import junit.framework.TestCase;
import junit.framework.TestSuite;

import org.xml.sax.SAXException;

import czsem.gate.GateUtils;
import czsem.utils.Config;

public class TectoMTBatchAnalyserTest extends TestCase
{
	String [] english_sentences =
	{
		"The BBC's Bethany Bell in Jerusalem says many people face shortages of food, medicine and fuel.",
		"Chancellor Alistair Darling says the new longer-term agreement will guarantee earnings growth for 5.5 million workers and will allow departments to plan more effectively."
	};

	String [] czech_sentences =
	{
		"Požár byl operačnímu středisku HZS ohlášen dnes ve 2.13 hodin, na místo vyjeli profesionální hasiči ze stanice v Židlochovicích a dobrovolní hasiči z Židlochovic, Žabčic a Přísnotic.",
		"Oheň, který zasáhl elektroinstalaci u chladícího boxu, hasiči dostali pod kontrolu ve 2.32 hodin a uhasili tři minuty po třetí hodině.",
		"Příčinou vzniku požáru byla technická závada, škodu vyšetřovatel předběžně vyčíslil na osm tisíc korun."
	};
	
	Corpus corpus_czech_short;
	Corpus corpus_english_short;
	Corpus corpus_english_long;
	Corpus corpus_english_full;
	
	Document czech_short_doc;
	Document english_short_doc;
	Document english_long_doc;
	Document english_full_doc;



	@SuppressWarnings("unchecked")
	public TectoMTBatchAnalyserTest() throws Exception
	{
	    if (! Gate.isInitialised())
	    {
			Config.setGateHome();
			Gate.init();
		    GateUtils.registerPluginDirectory(new File("czsem_GATE_plugins"));
	    }
	    
	    corpus_czech_short = Factory.newCorpus("corpus_czech_short");
	    corpus_english_short = Factory.newCorpus("corpus_english_short");
	    corpus_english_long = Factory.newCorpus("corpus_english_long");
	    corpus_english_full = Factory.newCorpus("corpus_english_full");
	    
	    czech_short_doc = Factory.newDocument(czech_sentences[0]);
	    english_short_doc = Factory.newDocument(english_sentences[0]);
	    english_long_doc = Factory.newDocument(english_sentences[0] + " " + english_sentences[1]);
	    english_full_doc = Factory.newDocument(getClass().getResource("/english_full.txt"));
	    corpus_czech_short.add(czech_short_doc);
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
		
		FeatureMap tfm = as.get("tToken").get((long) 0).iterator().next().getFeatures();
		assertEquals(8, tfm.size());
		assertEquals("BBC", tfm.get("t_lemma"));
		assertEquals("n:poss", tfm.get("formeme"));
		assertEquals("APP", tfm.get("functor"));
		assertEquals(3, tfm.get("lex.rf"));

		
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

	public void testExecuteCzechMorphology() throws ResourceInstantiationException, ExecutionException
	{
		String [] blocks = {
				"SCzechW_to_SCzechM::TextSeg_tokenizer_and_segmenter",
				"SCzechW_to_SCzechM::Tokenize_joining_numbers",
				"SCzechW_to_SCzechM::TagMorce"
				};

		executeTmtOnCorpus("czech", blocks, corpus_czech_short);

		AnnotationSet as = czech_short_doc.getAnnotations();
		
		assertEquals(31, as.size());
		validateAsType(as, "Token", 30, 3);
		
		FeatureMap fm = as.get((long) czech_sentences[0].indexOf("ohlášen")).iterator().next().getFeatures();
		assertEquals("ohlášen",  fm.get("form"));
		assertEquals("ohlásit",  fm.get("lemma"));
		assertEquals("VsYS---XX-AP---", fm.get("tag"));
		assertEquals(fm.get("afun"), null);
		assertEquals(fm.get("ord"), null);		
	}
	
	public void testExecuteCzechFull() throws ResourceInstantiationException, ExecutionException, FileNotFoundException
	{
		String [] blocks = {
				"SCzechW_to_SCzechM::TextSeg_tokenizer_and_segmenter",
				"SCzechW_to_SCzechM::Tokenize_joining_numbers",
				"SCzechW_to_SCzechM::TagMorce",
//				"SCzechM_to_SCzechN::SVM_ne_recognizer",
//				"SCzechM_to_SCzechN::Embed_instances",
//				"SCzechM_to_SCzechN::Geo_ne_recognizer",
//				"SCzechM_to_SCzechN::Embed_instances",
				"SCzechM_to_SCzechA::McD_parser_local TMT_PARAM_MCD_CZ_MODEL=pdt20_train_autTag_golden_latin2_pruned_0.02.model",
				"SCzechM_to_SCzechA::Fix_atree_after_McD",
				"SCzechM_to_SCzechA::Fix_is_member",

				"SCzechA_to_SCzechT::Mark_edges_to_collapse",
				"SxxA_to_SxxT::Build_ttree                    LANGUAGE=Czech",
				"SCzechA_to_SCzechT::Rehang_unary_coord_conj",
				"SxxA_to_SxxT::Fill_is_member                 LANGUAGE=Czech",
				
//				"SCzechA_to_SCzechT::Mark_auxiliary_nodes",
//				"SCzechA_to_SCzechT::Build_ttree",
//				"SCzechA_to_SCzechT::Fill_is_member",
//				"SCzechA_to_SCzechT::Rehang_unary_coord_conj",
				"SCzechA_to_SCzechT::Assign_coap_functors",
//				"SCzechA_to_SCzechT::Fix_is_member",
				"SCzechA_to_SCzechT::Distrib_coord_aux",
				"SCzechA_to_SCzechT::Mark_clause_heads",
				"SCzechA_to_SCzechT::Mark_relclause_heads",
				"SCzechA_to_SCzechT::Mark_relclause_coref",
				"SCzechA_to_SCzechT::Fix_tlemmas",
				"SCzechA_to_SCzechT::Recompute_deepord",
				"SCzechA_to_SCzechT::Assign_nodetype",
				"SCzechA_to_SCzechT::Assign_grammatemes",
				"SCzechA_to_SCzechT::Detect_formeme",
				"SCzechA_to_SCzechT::Add_PersPron",
				"SCzechA_to_SCzechT::Mark_reflpron_coref",
				"SCzechA_to_SCzechT::TBLa2t_phaseFd",
				"XAnylang1X_to_XAnylang2X::Normalize_ordering LAYER=SCzechT"
/**/		};

		executeTmtOnCorpus("czech", blocks, corpus_czech_short);

		AnnotationSet as = czech_short_doc.getAnnotations();
		
		new PrintStream("test_out.xml").print(gate.corpora.DocumentXmlUtils.toXml((TextualDocument) czech_short_doc));
		
		assertEquals(110, as.size());
		validateAsType(as, "Token", 30, 5);
		validateAsType(as, "aDependency", 28, 1);
		validateAsType(as, "tToken", 22, null);
		validateAsType(as, "tDependency", 21, 1);
		validateAsType(as, "auxRfDependency", 8, 1);
		
		FeatureMap fm = as.get("Token").get((long) czech_sentences[0].indexOf("ohlášen")).iterator().next().getFeatures();
		assertEquals("ohlášen",  fm.get("form"));
		assertEquals("ohlásit",  fm.get("lemma"));
		assertEquals("VsYS---XX-AP---", fm.get("tag"));
		assertEquals("Pred", fm.get("afun"));
		assertEquals("6", fm.get("ord"));

		
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

			
	public static Test suite(){
		return new TestSuite(TectoMTBatchAnalyserTest.class);
	}


}
