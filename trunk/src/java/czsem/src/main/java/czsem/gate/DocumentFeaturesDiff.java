package czsem.gate;

import gate.Annotation;
import gate.AnnotationSet;
import gate.Corpus;
import gate.Document;
import gate.Factory;
import gate.FeatureMap;
import gate.Gate;
import gate.ProcessingResource;
import gate.creole.SerialAnalyserController;
import gate.util.AnnotationDiffer;

import java.io.File;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.apache.log4j.Level;
import org.apache.log4j.Logger;

import czsem.gate.learning.PRSetup;
import czsem.gate.plugins.LearningEvaluator;
import czsem.utils.Config;

public class DocumentFeaturesDiff
{
	public static class AnnotationDifferDocumentFeaturesImpl extends AnnotationDiffer 
	{
		public AnnotationDifferDocumentFeaturesImpl(int correct, int missing, int spurious)
		{
			super();
			
			this.spurious = spurious;
			this.missing = missing;
			this.correctMatches = correct;
		}

		@Override
		public int getKeysCount() {
			return correctMatches + missing;
		}

		@Override
		public int getResponsesCount() {
			return correctMatches + spurious;
		}
	}
	
	public static void main(String [] args) throws Exception
	{
		Logger.getLogger(DocumentFeaturesDiff.class).setLevel(Level.ALL);

		Config cfg = Config.getConfig();
		cfg.setGateHome();
		Gate.init();
		GateUtils.registerPluginDirectory(new File(cfg.getCzsemPluginDir()));
		
		ProcessingResource eval = 
			new PRSetup.SinglePRSetup(LearningEvaluator.class)
				.putFeature("keyASName", ":-)")
//				.putFeature("responseASName", "lemma_flex")
				.putFeature("responseASName", "orig")
				.putFeature("keyAnnotationsAreInDocumentFeatures", true)
				.putFeatureList("annotationTypes", "Lookup")
				.putFeatureList("featureNames", "meshID").createPR();
				
				
		
		SerialAnalyserController controller = (SerialAnalyserController)	    	   
			Factory.createResource(SerialAnalyserController.class.getCanonicalName());
		
		controller.add(eval);
		
		Corpus corpus = Factory.newCorpus(null);
		corpus.populate(
				new File("C:\\Users\\dedek\\Desktop\\bmc50_analysed3").toURI().toURL(),
//				new File("C:\\Users\\dedek\\Desktop\\bmca_devel").toURI().toURL(),
				null, "utf8", false);
		
		System.err.println("populated");
		
		controller.setCorpus(corpus);

		
		controller.execute();

		
	}

	@SuppressWarnings("unchecked")
	public static AnnotationDiffer computeDiff(Document document, List<String> featureNames, AnnotationSet responsesAnnotations)
	{		
		FeatureMap doc_fm = document.getFeatures();
		Logger log = Logger.getLogger(DocumentFeaturesDiff.class);

		
		int correct = 0;
		int missing = 0;
		int spurious = 0;

		for (String feature_name : featureNames)
		{
			int cur_correct = 0;
			
			List<String> f = (List<String>) doc_fm.get(feature_name);
			if (f == null) 
			{
				f = (List<String>) doc_fm.get(feature_name+"s");
			}
			
			Set<String> vals_from_annot =  new HashSet<String>();
			for (Annotation annotation : responsesAnnotations)
			{
				vals_from_annot.add((String) annotation.getFeatures().get(feature_name));				
			}
			
			
			for (String doc_val : f)
			{
				if (vals_from_annot.contains(doc_val))
				{
					cur_correct++;
					log.debug("cerrect id: " + doc_val);
				}
				else missing++;				
			}
			
			spurious += vals_from_annot.size() - cur_correct;
			correct += cur_correct;						
		}

		
		
		return new AnnotationDifferDocumentFeaturesImpl(correct, missing, spurious);
	}

}
