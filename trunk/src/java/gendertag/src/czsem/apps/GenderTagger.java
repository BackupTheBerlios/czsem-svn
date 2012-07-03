package czsem.apps;

import java.util.Arrays;

import czsem.gendertag.FeatureMaker;
import czsem.gendertag.GenderClassifier;

public class GenderTagger {

	protected GenderClassifier classifier;
	protected FeatureMaker featureMaker;
	
	protected static GenderTagger singleton = null;
	
	public static synchronized GenderTagger getSingleton() throws Exception
	{
		if (singleton == null)
		{
			singleton = new GenderTagger();
		}
		return singleton;		
	}
	
	public GenderTagger() throws Exception
	{
		classifier = new GenderClassifier();
		featureMaker = new FeatureMaker();		
	}

	

	public static void main(String[] args) throws Exception {
		GenderTagger t = new GenderTagger();
		System.err.println(t.classify("Jan Dedek", "cz"));
		System.err.println(t.classify("Jana Dedekova", "cz"));
		System.err.println(t.classify("Chantal Poullain", "cz"));
		System.err.println(t.printDetails("Chantal Poullain", "cz"));
		System.err.println(t.printDetails("Štěpánek Jára", "cz"));
		System.err.println(t.printDetails("Spilmannová Dana", "cz"));

	}



	public String printDetails(String name, String lang) throws Exception {
		StringBuilder sb = new StringBuilder();
		sb.append(Arrays.toString(featureMaker.createDoubleFeturesWithDescriptions(name)));
		sb.append(classifier.printDistribution(featureMaker.createFeatures(name, lang, "")));
		return sb.toString();
	}



	public String classify(String name, String lang) throws Exception
	{
		return classifier.classify(featureMaker.createFeatures(name, lang, ""));
	}
	
	/*
	public static void linguisticMain(String[] args) throws GateException, URISyntaxException, IOException {
	    Config.getConfig().setGateHome();
	    Gate.init();
	    
	    Document doc = Factory.newDocument(new File("C:/Users/dedek/Desktop/jmena/pasinka.xml").toURI().toURL(), "cp1250");
	    
	    AnnotationSet as = doc.getAnnotations("TectoMT2");
	    AnnotationSet sents = as.get("Sentence");
	    
	    for (Annotation s : sents)
	    {
	    	AnnotationSet tocs = as.getContained(s.getStartNode().getOffset(), s.getEndNode().getOffset()).get("Token");
	    	List<Annotation> sorted = Utils.inDocumentOrder(tocs);

	    	System.err.format("'%s' (", doc.getContent().getContent(s.getStartNode().getOffset(), s.getEndNode().getOffset()).toString());
	    	
	    	int male=0, female=0;

	    	for (Annotation t : sorted)
	    	{
	    		String tag = (String) t.getFeatures().get("tag");
	    		char gen = tag.charAt(2);
		    	System.err.print(gen);
		    	
		    	switch (gen) {
				case 'F': 
				case 'H': 
				case 'Q': female++; break;
				case 'I': 
				case 'Y': 
				case 'Z': 
				case 'M': male++; break;

				}
	    	}
	    	
	    	String res = "?";	    	
	    	if (male > female) res = "male";
	    	if (female > male) res = "female";
	    	
			System.err.format(") %s\n", res);
	    }

	}
*/


}
