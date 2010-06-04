package czsem.gate;

import gate.AnnotationSet;
import gate.creole.AbstractLanguageAnalyser;
import gate.creole.metadata.CreoleParameter;
import gate.creole.metadata.Optional;
import gate.creole.metadata.RunTime;

import java.util.List;

import czsem.utils.TreeIndex;

public abstract class AnnotationDependencyAbstractMarker extends AbstractLanguageAnalyser
{
	private static final long serialVersionUID = 1L;
	
	protected String inputASName = null;
	protected AnnotationSet inputAS = null;
	protected AnnotationSet inputTokensAS = null;
	protected AnnotationSet inputDependenciesAS = null;
	protected String outputASName = null;
	protected AnnotationSet outputAS = null;
	protected List<String> inputAnnotationTypeNames;
	protected String tokenAnnotationTypeName;
	protected String dependencyAnnotationTypeName;
	protected TreeIndex treeIndex;

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
	@CreoleParameter
	public void setOutputASName(String outputASName) {
		this.outputASName = outputASName;
	}
	public List<String> getInputAnnotationTypeNames() {
		return inputAnnotationTypeNames;
	}
	@RunTime
	@CreoleParameter(defaultValue="damage")
	public void setInputAnnotationTypeNames(List<String> inputAnnotationTypeNames) {
		this.inputAnnotationTypeNames = inputAnnotationTypeNames;
	}
	public String getTokenAnnotationTypeName() {
		return tokenAnnotationTypeName;
	}
	@RunTime
	@CreoleParameter(defaultValue="Token")
	public void setTokenAnnotationTypeName(String tokenAnnotationTypeName) {
		this.tokenAnnotationTypeName = tokenAnnotationTypeName;
	}
	public String getDependencyAnnotationTypeName() {
		return dependencyAnnotationTypeName;
	}
	@RunTime
	@CreoleParameter(defaultValue="aDependency")
	public void setDependencyAnnotationTypeName(String dependencyAnnotationTypeName) {
		this.dependencyAnnotationTypeName = dependencyAnnotationTypeName;
	}
		
	protected void initBeforeExecute()
	{
		inputAS = document.getAnnotations(inputASName);
		inputTokensAS = inputAS.get(tokenAnnotationTypeName);
		inputDependenciesAS = inputAS.get(dependencyAnnotationTypeName);
		treeIndex = new TreeIndex(inputDependenciesAS);
		outputAS = document.getAnnotations(outputASName);	
	}


}
