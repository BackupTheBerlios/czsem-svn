package czsem.gate;

import java.util.List;

import gate.Annotation;
import gate.AnnotationSet;
import gate.Factory;
import gate.FeatureMap;
import gate.Node;
import gate.creole.AbstractLanguageAnalyser;
import gate.creole.ExecutionException;
import gate.creole.metadata.CreoleParameter;
import gate.creole.metadata.CreoleResource;
import gate.creole.metadata.Optional;
import gate.creole.metadata.RunTime;

@CreoleResource(name = "czsem SubsequentAnnotationMerge", comment = "Merges annotations that follow in a row to one single annotation.")
public class SubsequentAnnotationMerge extends AbstractLanguageAnalyser 
{
	private static final long serialVersionUID = -3136012330465966425L;
	
	protected String inputASName = null;
	protected String outputASName = null;
	protected String annotationTypeName;
	protected int maxDistanceBetweenAnnotations;
	protected boolean deleteOriginalAnnotations;
	
	public String getInputASName() {
		return inputASName;
	}

	@Optional
	@RunTime
	@CreoleParameter
	public void setInputASName(String inputASName) {
		this.inputASName = inputASName;
	}
	public String getOutputASName() {
		return outputASName;
	}
	@Optional
	@RunTime
	@CreoleParameter(defaultValue="Merged")
	public void setOutputASName(String outputASName) {
		this.outputASName = outputASName;
	}
	public String getAnnotationTypeName() {
		return annotationTypeName;
	}
	@RunTime
	@CreoleParameter(defaultValue="damage")
	public void setAnnotationTypeName(String annotationTypeName) {
		this.annotationTypeName = annotationTypeName;
	}
	public Integer getMaxDistanceBetweenAnnotations() {
		return maxDistanceBetweenAnnotations;
	}
	@RunTime
	@CreoleParameter(defaultValue="1")
	public void setMaxDistanceBetweenAnnotations(Integer maxDistanceBetweenAnnotations) {
		this.maxDistanceBetweenAnnotations = maxDistanceBetweenAnnotations;
	}

	public Boolean getDeleteOriginalAnnotations() {
		return deleteOriginalAnnotations;
	}

	@RunTime
	@CreoleParameter(defaultValue="false")
	public void setDeleteOriginalAnnotations(Boolean deleteOriginalAnnotations) {
		this.deleteOriginalAnnotations = deleteOriginalAnnotations;
	}

	@Override
	public void execute() throws ExecutionException
	{
		AnnotationSet inputAS = document.getAnnotations(inputASName);
		AnnotationSet outputAS = document.getAnnotations(outputASName);
		AnnotationSet annotations = inputAS.get(annotationTypeName);		  
		List<Annotation> orderedAnnotations = gate.Utils.inDocumentOrder(annotations);
		
		for (int i = 0; i < orderedAnnotations.size(); i++)
		{
			FeatureMap fm = Factory.newFeatureMap();
			Annotation atart_annot = orderedAnnotations.get(i);
			fm.putAll(atart_annot.getFeatures());
			
			Node start_node = atart_annot.getStartNode();
			Node current_end_node = atart_annot.getEndNode();
			
			for (int j = i+1; j < orderedAnnotations.size(); j++, i++)
			{
				Annotation next_annot = orderedAnnotations.get(j);
				if (next_annot.getStartNode().getOffset() - current_end_node.getOffset() > maxDistanceBetweenAnnotations)
				{
					break;
				}
				current_end_node = next_annot.getEndNode();
				fm.putAll(next_annot.getFeatures());
			}
			
			outputAS.add(start_node, current_end_node, annotationTypeName, fm);
		}
		
		if (deleteOriginalAnnotations)
		{
			inputAS.removeAll(annotations);
		}
	}


}
