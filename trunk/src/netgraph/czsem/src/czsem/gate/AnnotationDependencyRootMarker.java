package czsem.gate;

import gate.Annotation;
import gate.AnnotationSet;
import gate.Factory;
import gate.FeatureMap;
import gate.creole.ExecutionException;
import gate.creole.metadata.CreoleResource;

import java.util.ArrayDeque;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashSet;
import java.util.Queue;

@CreoleResource(name = "czsem AnnotationDependencyRootMarker", comment = "Finds a nearest common father annotation for all 'tokens' inside a given annotation.")
public class AnnotationDependencyRootMarker extends AnnotationDependencyAbstractMarker
{
	private static final long serialVersionUID = 8357007815773883611L;
	
	
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
	
	@Override
	public void execute() throws ExecutionException
	{
		initBeforeExecute();
		
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
		fm.put("orig_id", annotation.getId());
		fm.put("orig_type", annotation.getType());
		
		outputAS.add(
				root_token.getStartNode(),
				root_token.getEndNode(),
				annotation.getType()+"_root",
				fm);
		
	}


/*
	public static void main(String[] args) throws Exception
	{
		gate.Main.main(args);		
	}
*/
}
