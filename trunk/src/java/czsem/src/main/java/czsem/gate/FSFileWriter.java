package czsem.gate;

import gate.Annotation;
import gate.AnnotationSet;

import java.io.FileNotFoundException;
import java.io.PrintStream;
import java.io.UnsupportedEncodingException;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

import cz.cuni.mff.mirovsky.trees.Attribute;
import cz.cuni.mff.mirovsky.trees.NGTreeHead;
import czsem.Utils;

public class FSFileWriter {
	private PrintStream out = System.out;
	
	private String[] attributes = null;

	/** The order of elements is the same as in {@link #tokendependency_annotation_types} and {@link #token_annotation_types}. **/
	public static final String[][] dependency_annotation_types =
	{
		{"tDependency", "auxRfDependency"},
		{"aDependency"},		
		{"Dependency"},
	};
	
	/** The order of elements is the same as in {@link #dependency_annotation_types}. **/
	public static final String[] tokendependency_annotation_types =
	{
		"lex.rf",
		null, 
		null
	};


	/** The order of elements is the same as in {@link #dependency_annotation_types}. **/
	public static final String[] token_annotation_types =
	{		
		"tToken",
		"Token",
	};
			
//	public static final int ID_INDEX = 0;
	public static final String ID_FEATURENAME = "ann_id";
	public static final String ORD_FEATURENAME = "sentence_order";
	public static final String STRING_FEATURENAME = "string";
	public static final String HIDE_FEATURENAME = "hidden";

//	public static final int DEPENDECY_INDEX = 2;
//	public static final int STRNG_INDEX = default_attributes.length-1;

	
	public FSFileWriter(String filename) throws FileNotFoundException, UnsupportedEncodingException
	{
		out = new PrintStream(filename, "utf8");
	};
	

	private void printHead()
	{		
		for (String attr : attributes)
		{
			out.print("@P ");			
			out.println(attr);			
		}
		
		out.print("@N ");
		out.println(ORD_FEATURENAME);
		out.print("@V ");
		out.println(STRING_FEATURENAME);
		out.print("@H ");
		out.println(HIDE_FEATURENAME);

		out.println();		

/*			
		out.println("@P ord");
		out.println("@N ord");
		out.println("@P kind");		
		out.println("@P string");
		out.println("@V string");
*/
	}
	
	public static String[] guessAtttributes(AnnotationSet as)
	{		
		AnnotationSet tokens = as.get(
				Utils.setFromArray(FSFileWriter.token_annotation_types));
		
		Set<String> attr_set = new HashSet<String>();
		
		attr_set.add(ID_FEATURENAME);
		
		for (Annotation token : tokens)
		{
			for (Object feature : token.getFeatures().keySet())
			{
				attr_set.add((String) feature);				
			}			
		}
		
		String[] attrs = attr_set.toArray(new String[0]);
		
		Arrays.sort(attrs);
//		for (int i = 0; i < attrs.length; i++) {
//			System.err.println(attrs[i]);
//		}
		
		return attrs;
	}
	
	public static NGTreeHead createTreeHead(String [] attributes)
	{
		NGTreeHead th = new NGTreeHead(null);
		
		for (int i = 0; i < attributes.length; i++)
		{
			th.addAttribute(new Attribute(attributes[i]));			
//			ngf.getVybraneAtributy().add(i, Integer.toString(i));
		}
		
		
		th.N = th.W = th.getIndexOfAttribute(FSFileWriter.ORD_FEATURENAME);
		th.H = th.getIndexOfAttribute(FSFileWriter.HIDE_FEATURENAME);

		return th;
	}

	
	public void PrintAll(AnnotationSet annotations)
	{
		attributes = guessAtttributes(annotations);

		printHead();
		
		for (Annotation sentence : annotations.get("Sentence"))
		{
			AnnotationSet sentence_set = annotations.getContained(
					sentence.getStartNode().getOffset(), sentence.getEndNode().getOffset());
						
			SentenceFSWriter wr = new SentenceFSWriter(sentence_set, out, attributes);
			wr.printTree(0);
		}		
	}
	
	public void close()
	{
		out.close();
	}
}
