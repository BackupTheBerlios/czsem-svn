package czsem.gate.plugins;

import java.io.File;
import java.net.MalformedURLException;

import czsem.gate.GateUtils;
import gate.Corpus;
import gate.Document;
import gate.Factory;
import gate.FeatureMap;
import gate.Gate;
import gate.LanguageAnalyser;
import gate.creole.SerialAnalyserController;
import gate.util.GateException;
import junit.framework.Test;
import junit.framework.TestCase;
import junit.framework.TestSuite;

public class TectoMTBatchAnalyserTest extends TestCase {

	@SuppressWarnings("unchecked")
	public void testExecute() throws GateException, MalformedURLException
	{

		String str_doc = "The BBC's Bethany Bell in Jerusalem says many people face shortages of food, medicine and fuel. Chancellor Alistair Darling says the new longer-term agreement will guarantee earnings growth for 5.5 million workers and will allow departments to plan more effectively.";
		
		Gate.init();
	    GateUtils.registerPluginDirectory(new File("czsem_GATE_plugins"));

		Document doc = Factory.newDocument(str_doc);
		Corpus corpus = Factory.newCorpus("TectoMTBatchAnalyser_test_corpus");
		corpus.add(doc);
		
		SerialAnalyserController controller = (SerialAnalyserController)	    	   
			Factory.createResource(SerialAnalyserController.class.getCanonicalName());
		
		controller.setCorpus(corpus);

		
		FeatureMap fm = Factory.newFeatureMap();
		LanguageAnalyser tmt_analyzer = (LanguageAnalyser) Factory.createResource(TectoMTBatchAnalyser.class.getCanonicalName(), fm);
		controller.add(tmt_analyzer);
		controller.execute();
	}
	
	public static Test suite(){
		return new TestSuite(TectoMTBatchAnalyserTest.class);
	}


}
