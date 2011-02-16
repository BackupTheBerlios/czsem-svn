package czsem.gate.plugins;

import gate.AnnotationSet;
import gate.Document;
import gate.Resource;
import gate.creole.AbstractLanguageAnalyser;
import gate.creole.ExecutionException;
import gate.creole.ResourceInstantiationException;
import gate.creole.metadata.CreoleParameter;
import gate.creole.metadata.CreoleResource;
import gate.creole.metadata.RunTime;
import gate.qa.QualityAssurancePR;
import gate.util.AnnotationDiffer;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Locale;

import org.apache.log4j.Logger;

/**
 * Mostly copied form {@link QualityAssurancePR}, slightly modified. 
 * @author dedek
 *
 */
@CreoleResource(name = "czsem LearningEvaluator", comment = "Measures performance between two AS, similar to QualityAssurancePR")
public class LearningEvaluator extends AbstractLanguageAnalyser
{		
	protected class DocumentDiff
	{
		public DocumentDiff(String documentName) {
			this.documentName = documentName;
		}
		public String documentName;
		public AnnotationDiffer []	diff;	
	}
	
	private static final long serialVersionUID = -3577722098895242238L;

	private String keyASName;
	private String responseASName;
	private List<String> annotationTypes;
	private List<String> featureNames;

	private AnnotationSet keyAS;
	private AnnotationSet responseAS;
	
	private List<DocumentDiff> documentDifs;

	protected AnnotationDiffer calculateDocumentDiff(Document document, String annotTypeName)
	{				
		AnnotationSet keysIter = keyAS.get(annotTypeName);
		AnnotationSet responsesIter = responseAS.get(annotTypeName);
		
		AnnotationDiffer differ = new AnnotationDiffer();
		differ.setSignificantFeaturesSet(new HashSet<String>(featureNames));
		differ.calculateDiff(keysIter, responsesIter); // compare
		
		return differ;		
	}

	protected AnnotationDiffer [] calculateDocumentDiff(Document document)
	{
		
		AnnotationDiffer [] ret = new AnnotationDiffer[annotationTypes.size()];
		
		for (int i = 0; i < ret.length; i++)
		{
			ret[i] = calculateDocumentDiff(document, annotationTypes.get(i));
			
		}
		
		return ret;
	}


	@Override
	public void execute() throws ExecutionException
	{
		keyAS = document.getAnnotations(keyASName);
		responseAS = document.getAnnotations(responseASName);
		
		DocumentDiff diff = new DocumentDiff(document.getName());
		diff.diff = calculateDocumentDiff(document);
		
		documentDifs.add(diff);
		
		if (documentDifs.size() == corpus.size())
		{
			printStatistics();
		}
				
	}

	public static String getStatisticsStr(AnnotationDiffer diff)
	{
		return String.format("match:%3d  miss:%3d  spur:%3d  overlap:%3d  prec: %f  rec: %f  f1: %f  lenientf1: %f",
				diff.getCorrectMatches(),
				diff.getMissing(),
				diff.getSpurious(),
				diff.getPartiallyCorrectMatches(),
				diff.getPrecisionStrict(),
				diff.getRecallStrict(),
				diff.getFMeasureStrict(1),
				diff.getFMeasureLenient(1)
			);
	}
	
	protected void printStatistics()
	{
		ArrayList<AnnotationDiffer> overall = new ArrayList<AnnotationDiffer>
			(annotationTypes.size() * documentDifs.size());
		
		for (DocumentDiff diff : documentDifs)
		{
			overall.addAll(Arrays.asList(diff.diff));			
		}
		
		
		AnnotationDiffer overall_differ = new AnnotationDiffer(overall);
		
		Logger logger = Logger.getLogger(getClass());
		
		logger.info(String.format("%5s overall: %s", responseASName, getStatisticsStr(overall_differ)));
	}

	@Override
	public Resource init() throws ResourceInstantiationException
	{
		documentDifs = new ArrayList<DocumentDiff>();
		Locale.setDefault(Locale.ENGLISH);
		return super.init();
	}

	public String getKeyASName() {
		return keyASName;
	}

	@RunTime
	@CreoleParameter
	public void setKeyASName(String keyASName) {
		this.keyASName = keyASName;
	}

	public String getResponseASName() {
		return responseASName;
	}

	@RunTime
	@CreoleParameter
	public void setResponseASName(String responseASName) {
		this.responseASName = responseASName;
	}

	public List<String> getAnnotationTypes() {
		return annotationTypes;
	}

	@RunTime
	@CreoleParameter
	public void setAnnotationTypes(List<String> annotationTypes) {
		this.annotationTypes = annotationTypes;
	}

	public List<String> getFeatureNames() {
		return featureNames;
	}

	/**
	 * @see {@link AnnotationDiffer#setSignificantFeaturesSet(java.util.Set)}
	 */
	@RunTime
	@CreoleParameter(defaultValue="")
	public void setFeatureNames(List<String> featureNames) {
		this.featureNames = featureNames;
	}
	

}
