package czsem.gate.plugins;

import java.util.HashSet;
import java.util.Iterator;

import gate.Annotation;
import gate.AnnotationSet;
import gate.Factory;
import gate.FeatureMap;
import gate.creole.ExecutionException;
import gate.creole.metadata.CreoleParameter;
import gate.creole.metadata.CreoleResource;
import gate.creole.metadata.RunTime;
import czsem.gate.AbstractLanguageAnalyserWithInputAnnotTypes;
import czsem.gate.GateUtils;

// 
@CreoleResource(name = "czsem CreateMentions", comment = "Creates annotations of a type �Mention� and puts class labels (original annotation types) to the feature �class�.")
public class CreateMentionsPR extends AbstractLanguageAnalyserWithInputAnnotTypes 
{
	
	private static final long serialVersionUID = 3795111522583168425L;
	
	private String mentionAnntotationTypeName = "Mention";
	private boolean inverseFunction = false;

	@Override
	public void execute() throws ExecutionException
	{
		initBeforeExecute();
		
		if (inverseFunction)
			inverseWork();
		else
			regularWork();
					
	}
	
	public void inverseWork()
	{
		AnnotationSet annotations = null;
		if (inputAnnotationTypeNames == null || inputAnnotationTypeNames.size() == 0)
		{
			annotations = inputAS.get(getMentionAnntotationTypeName());
		}
		else
		{
			HashSet<String> cls_set = new HashSet<String>();
			cls_set.add("class");
			annotations = inputAS.get(getMentionAnntotationTypeName(), cls_set);
			
			Iterator<Annotation> iter = annotations.iterator();
			
			while(iter.hasNext())
			{
				Annotation annotation = iter.next();
				String cls = (String) annotation.getFeatures().get("class");
				
				if (! inputAnnotationTypeNames.contains(cls))
				{
					iter.remove();					
				}								
			}
		}
		
		for (Annotation annotation : annotations)
		{
			FeatureMap fm = Factory.newFeatureMap();
			fm.putAll(annotation.getFeatures());
			String cls = (String) fm.get("class");
			fm.put("class", annotation.getType());
			fm.put("origID", annotation.getId());
			outputAS.add(annotation.getStartNode(), annotation.getEndNode(), cls, fm);
			
			
		}					

		
	}

	public void regularWork()
	{
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
			outputAS.add(annotation.getStartNode(), annotation.getEndNode(), getMentionAnntotationTypeName(), fm);
			
			
		}					
	}

	@RunTime
	@CreoleParameter(defaultValue="Mention")	
	public void setMentionAnntotationTypeName(String mentionAnntotationTypeName) {
		this.mentionAnntotationTypeName = mentionAnntotationTypeName;
	}

	public String getMentionAnntotationTypeName() {
		return mentionAnntotationTypeName;
	}

	@RunTime
	@CreoleParameter(comment="Inverse work of the PR - form Mentions create original annotations.", defaultValue="false")
	public void setInverseFunction(Boolean inverseFunction) {
		this.inverseFunction = inverseFunction;
	}

	public Boolean getInverseFunction() {
		return inverseFunction;
	}
	
	

}
