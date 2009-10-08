package czsem.gate;

import gate.Annotation;
import gate.AnnotationSet;

import java.io.FileNotFoundException;
import java.io.PrintStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;

public class FSFileWriter {
	private PrintStream out = System.out;
	
	private ArrayList<String> attributes = null;
		
	public static final String[] default_attributes =
	{
		"ord",
		"id",
		"dependency",		
//		"category",		
		"string"
	};
	
	public static final int ORD_INDEX = 0;
	public static final int ID_INDEX = 1;
	public static final int DEPENDECY_INDEX = 2;
	public static final int STRNG_INDEX = default_attributes.length-1;

	
	public FSFileWriter() {};

	public FSFileWriter(String filename) throws FileNotFoundException
	{
		out = new PrintStream(filename);
	};
	
	private void printHead()
	{		
		for (String attr : attributes)
		{
			out.print("@P ");			
			out.println(attr);			
		}
		
		out.print("@N ");
		out.println(default_attributes[ORD_INDEX]);
		out.print("@V ");
		out.println(default_attributes[STRNG_INDEX]);


/*			
		out.println("@P ord");
		out.println("@N ord");
		out.println("@P kind");		
		out.println("@P string");
		out.println("@V string");
*/
		out.println();		
	}

	
	public void PrintAll(AnnotationSet annotations, Collection<String> additinnal_attributes)
	{
		attributes = new ArrayList<String>(Arrays.asList(default_attributes));
		attributes.addAll(additinnal_attributes);

		printHead();
		
		for (Annotation sentence : annotations.get("Sentence"))
		{
			AnnotationSet sentence_set = annotations.getContained(
					sentence.getStartNode().getOffset(), sentence.getEndNode().getOffset());
						
			SentenceFSWriter wr = new SentenceFSWriter(sentence_set, out, attributes);
			wr.printTree();
		}		
	}
	
	public void close()
	{
		out.close();
	}
}