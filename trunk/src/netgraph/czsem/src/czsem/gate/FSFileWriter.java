package czsem.gate;

import gate.Annotation;
import gate.AnnotationSet;

import java.io.FileNotFoundException;
import java.io.PrintStream;

public class FSFileWriter {
	private PrintStream out = System.out;
	
	public FSFileWriter() {};

	public FSFileWriter(String filename) throws FileNotFoundException
	{
		out = new PrintStream(filename);
	};
	
	private void printHead()
	{
		out.println("@P ord");
		out.println("@N ord");
		out.println("@P kind");		
		out.println("@P string");
		out.println("@V string");
		out.println();		
	}


	
	public void PrintAll(AnnotationSet annotations)
	{
		printHead();
		
		for (Annotation sentence : annotations.get("Sentence"))
		{
			AnnotationSet sentence_set = annotations.getContained(
					sentence.getStartNode().getOffset(), sentence.getEndNode().getOffset());
			
			SentenceFSWriter wr = new SentenceFSWriter(sentence_set, out);
			wr.printTree();
		}		
	}
}
