package czsem.gate;

import gate.AnnotationSet;
import gate.creole.metadata.CreoleParameter;
import gate.creole.metadata.RunTime;


import czsem.utils.TreeIndex;

public abstract class AbstractAnnotationDependencyMarker extends AbstractLanguageAnalyserWithInputAnnotTypes
{
	private static final long serialVersionUID = 1L;
	
	protected AnnotationSet inputTokensAS = null;
	protected AnnotationSet inputDependenciesAS = null;
	protected String tokenAnnotationTypeName;
	protected String dependencyAnnotationTypeName;
	protected TreeIndex treeIndex;

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
		super.initBeforeExecute();
		
		inputTokensAS = inputAS.get(tokenAnnotationTypeName);
		inputDependenciesAS = inputAS.get(dependencyAnnotationTypeName);
		treeIndex = new TreeIndex(inputDependenciesAS);
	}


}
