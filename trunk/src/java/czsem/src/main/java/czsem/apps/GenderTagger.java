package czsem.apps;

import gate.Annotation;
import gate.AnnotationSet;
import gate.Document;
import gate.Factory;
import gate.Gate;
import gate.Utils;
import gate.util.GateException;

import java.io.File;
import java.io.IOException;
import java.net.URISyntaxException;
import java.util.List;

import czsem.utils.Config;

public class GenderTagger {

	public static void main(String[] args) throws GateException, URISyntaxException, IOException {
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

}
