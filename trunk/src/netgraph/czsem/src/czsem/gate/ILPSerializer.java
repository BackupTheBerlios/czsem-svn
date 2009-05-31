package czsem.gate;

import java.util.Collection;

import gate.Annotation;
import gate.AnnotationSet;
import gate.LanguageAnalyser;
import gate.ProcessingResource;
import gate.creole.AbstractLanguageAnalyser;
import gate.creole.ExecutionException;
import gate.creole.metadata.CreoleResource;

@CreoleResource(name = "czsem ILPSerializer", comment = "Exports given corpus to ILP background knowledge")
public class ILPSerializer extends AbstractLanguageAnalyser implements
		ProcessingResource, LanguageAnalyser {

	private static final long serialVersionUID = 6469933231715581382L;
	
	protected void serializeAnnotationSet(AnnotationSet annotations)
	{
/*
		for (Annotation sentence : annotations.get("Sentence"))
		{
			AnnotationSet sentence_set = annotations.getContained(
					sentence.getStartNode().getOffset(), sentence.getEndNode().getOffset());
						
			SentenceFSWriter wr = new SentenceFSWriter(sentence_set, out, attributes);
			wr.printTree();
		}		
*/
	}

	
	public void execute() throws ExecutionException
	{		
		serializeAnnotationSet(document.getAnnotations());				
	}


	public static void main(String[] args) {

	}

}
