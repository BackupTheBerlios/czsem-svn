package czsem.gate.plugins;

import gate.Annotation;
import gate.AnnotationSet;
import gate.Factory;
import gate.FeatureMap;
import gate.creole.ExecutionException;
import gate.creole.metadata.CreoleResource;
import czsem.gate.AbstractLanguageAnalyserWithInputAnnotTypes;
import czsem.gate.GateUtils;

// 
@CreoleResource(name = "czsem CreateMentions", comment = "Creates annotations of a type ‘Mention’ and puts class labels (original annotation types) to the feature ‘class’.")
public class CreateMentions extends AbstractLanguageAnalyserWithInputAnnotTypes 
{
	
	private static final long serialVersionUID = 3795111522583168425L;

	@Override
	public void execute() throws ExecutionException
	{
		initBeforeExecute();
		
		AnnotationSet annotations = null;
		if (inputAnnotationTypeNames == null || inputAnnotationTypeNames.size() == 0)
			annotations = inputAS.get();
		else
			annotations = inputAS.get(GateUtils.setFromList(inputAnnotationTypeNames));
		
		for (Annotation annotation : annotations)
		{
			FeatureMap fm = Factory.newFeatureMap();
			fm.put("class", annotation.getType());
			fm.put("origID", annotation.getId());
			outputAS.add(annotation.getStartNode(), annotation.getEndNode(), "Mention", fm);
			
			
		}
		
		
	}
	
	

}
