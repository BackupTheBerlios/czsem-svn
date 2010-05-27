package czsem.gate;

import java.util.ArrayDeque;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Queue;
import java.util.Set;

import gate.Annotation;
import gate.AnnotationSet;
import gate.Factory;
import gate.FeatureMap;
import gate.creole.AbstractLanguageAnalyser;
import gate.creole.ExecutionException;
import gate.creole.metadata.CreoleParameter;
import gate.creole.metadata.CreoleResource;
import gate.creole.metadata.Optional;
import gate.creole.metadata.RunTime;

@CreoleResource(name = "czsem AnnotationDependencyRootMarker", comment = "Finds a nearest common father annotation for all 'tokens' inside a given annotation.")
public class AnnotationDependencyRootMarker extends AbstractLanguageAnalyser
{
	private static final long serialVersionUID = 8357007815773883611L;
	
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
	@Override
	public void execute() throws ExecutionException
	{
		inputAS = document.getAnnotations(inputASName);
		inputTokensAS = inputAS.get(tokenAnnotationTypeName);
		inputDependenciesAS = inputAS.get(dependencyAnnotationTypeName);
		treeIndex = new TreeIndex(inputDependenciesAS);
		outputAS = document.getAnnotations(outputASName);
		AnnotationSet inputAnnotations = inputAS.get(new HashSet<String>(inputAnnotationTypeNames));
		for (Annotation annotation : inputAnnotations)
		{			
			markAnnotationDependencyRoot(annotation);			
		}
	}
	protected void markAnnotationDependencyRoot(Annotation annotation)
	{
		AnnotationSet tokens = inputTokensAS.getContained(
				annotation.getStartNode().getOffset(),
				annotation.getEndNode().getOffset());
		
		if (tokens.isEmpty()) return;
				
		
		Annotation root_token = findRootBFS(new ArrayList<Annotation>(tokens));		
		
		FeatureMap fm = Factory.newFeatureMap();
		fm.put("root_id", root_token.getId());
		fm.put("root_type", root_token.getType());
		
		outputAS.add(
				root_token.getStartNode(),
				root_token.getEndNode(),
				annotation.getType()+"_root",
				features);
		
	}
	
	protected static class TreeIndex
	{
		private Map<Integer, Integer> parentIndex;
		private Map<Integer, Set<Integer>> childIndex;
		
		public Integer getParent(Integer child)
		{
			return parentIndex.get(child);
		}

		public Iterable<Integer> getChildren(Integer parent)
		{
			return childIndex.get(parent);
		}
		
		protected void addDependency(Integer[] dep)
		{
			addDependency(dep[0], dep[1]);
		}

		protected void addDependency(Integer parent, Integer child)
		{
			parentIndex.put(child, parent);
			Set<Integer> children = childIndex.get(parent);
			if (children == null) children = new HashSet<Integer>();
			children.add(child);
			childIndex.put(parent, children);
		}
		
		public TreeIndex (AnnotationSet dependencyAnnotatons)
		{
			parentIndex = new HashMap<Integer, Integer>();
			childIndex = new HashMap<Integer, Set<Integer>>();
			
			for (Annotation dependencyAnnotation : dependencyAnnotatons)
			{
				addDependency(GateUtils.decodeEdge(dependencyAnnotation));				
			}
						
		}
	}
	
	protected static class DependencyBFSnode
	{
		DependencyBFSnode current_root;
		Integer annotationID;
		int tree_level;
		int distance;
				
		DependencyBFSnode up(Integer parentID)
		{
			return new DependencyBFSnode(parentID, tree_level+1, distance+1);			
		}

		DependencyBFSnode down(Integer parentID)
		{
			return new DependencyBFSnode(parentID, tree_level-1, distance+1);			
		}

		public DependencyBFSnode(Integer parentID, int treeLevel, int distance, DependencyBFSnode current_root)
		{
			this(parentID, treeLevel, distance);
			this.current_root = current_root;
		}

		public DependencyBFSnode(Integer parentID, int treeLevel, int distance)
		{
			this.current_root = this;
			this.annotationID = parentID;
			tree_level = treeLevel;
			this.distance = distance;
		}
	}
	
	protected Annotation findRootBFS(Collection<Annotation> tokens_to_find)
	{		
		Annotation token = tokens_to_find.iterator().next();
		tokens_to_find.remove(token);
		DependencyBFSnode confirmed_root = new DependencyBFSnode(token.getId(), 0, 0);
				
		Queue<DependencyBFSnode> queueBFS= new ArrayDeque<DependencyBFSnode>();
		
		queueBFS.add(confirmed_root);
		
		while (! tokens_to_find.isEmpty() && ! isInterrupted() && ! queueBFS.isEmpty())
		{
			DependencyBFSnode currentBFSnode = queueBFS.remove();
			Integer currentID = currentBFSnode.annotationID;
			
			for (Annotation not_found_token : tokens_to_find)
			{
				if (not_found_token.getId().equals(currentID))
				{
					tokens_to_find.remove(not_found_token);
					if (confirmed_root.tree_level < currentBFSnode.tree_level)
					{
						confirmed_root = currentBFSnode.current_root; 						
					}
					break;
				}				
			}
			
			Integer parentID = treeIndex.getParent(currentID);
			if (parentID != null) queueBFS.add(currentBFSnode.up(parentID));
			
			Iterable<Integer> children = treeIndex.getChildren(currentID);
			if (children != null)
			{
				for (Integer childID : children)
				{
					queueBFS.add(currentBFSnode.down(childID));
				}
			}
		}
		
		return inputTokensAS.get(confirmed_root.annotationID);
	}

/*
	public static void main(String[] args) throws Exception
	{
		gate.Main.main(args);		
	}
*/
}
