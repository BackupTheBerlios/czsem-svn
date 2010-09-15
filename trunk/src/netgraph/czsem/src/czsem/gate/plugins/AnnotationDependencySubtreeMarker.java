package czsem.gate.plugins;

import java.util.HashSet;

import czsem.gate.AnnotationDependencyAbstractMarker;

import gate.Annotation;
import gate.AnnotationSet;
import gate.Factory;
import gate.FeatureMap;
import gate.creole.ExecutionException;
import gate.creole.metadata.CreoleResource;
import gate.util.InvalidOffsetException;

@CreoleResource(name = "czsem AnnotationDependencySubtreeMarker", comment = "Marks the whole subtree for the union of all 'tokens' inside a given annotation.")
public class AnnotationDependencySubtreeMarker extends AnnotationDependencyAbstractMarker
{
	private static final long serialVersionUID = 671833725416131750L;

	@Override
	public void execute() throws ExecutionException
	{
		initBeforeExecute();
		
		AnnotationSet inputAnnotations = inputAS.get(new HashSet<String>(inputAnnotationTypeNames));
		for (Annotation annotation : inputAnnotations)
		{			
			try {
				markAnnotationDependencySubtree(annotation);
			} catch (InvalidOffsetException e) {
				throw new ExecutionException(e);
			}			
		}
	}

	protected static class SubtreeMarkInfo
	{
		FeatureMap fm;
		long start_offset;
		long end_offset;		
		
		
		public SubtreeMarkInfo(FeatureMap fm, long startOffset, long endOffset) {
			this.fm = fm;
			start_offset = startOffset;
			end_offset = endOffset;
		}


		public SubtreeMarkInfo()
		{
			this(Factory.newFeatureMap(), Long.MAX_VALUE, Long.MIN_VALUE);
		}
		
		public SubtreeMarkInfo(Annotation annotation)
		{
			this(
					Factory.newFeatureMap(),
					annotation.getStartNode().getOffset(),
					annotation.getEndNode().getOffset());
			
			fm.put("root_id", annotation.getId());
			fm.put("root_type", annotation.getType());
		}


		public void mergeWith(SubtreeMarkInfo info)
		{
			fm.putAll(info.fm);
			start_offset = Math.min(start_offset, info.start_offset);
			end_offset = Math.max(end_offset, info.end_offset);
		}
	}
	
	protected void markAnnotationDependencySubtree(Annotation annotation) throws InvalidOffsetException
	{
		AnnotationSet tokens = inputTokensAS.getContained(
				annotation.getStartNode().getOffset(),
				annotation.getEndNode().getOffset());
		
		if (tokens.isEmpty()) return;
		
		SubtreeMarkInfo info = new SubtreeMarkInfo();
		for (Annotation token : tokens)
		{
			info.mergeWith(markAnnotationDependencySubtreeForSingleToken(token.getId()));			
		}
		
		info.fm.put("orig_id", annotation.getId());
		info.fm.put("orig_type", annotation.getType());
		
		String orig_type_name = annotation.getType();
		
		String new_type_name = orig_type_name.endsWith("_root")	?
								orig_type_name.substring(0, orig_type_name.length() - 5)
								: orig_type_name + "_subtree";
		
		
		outputAS.add(
				info.start_offset,
				info.end_offset,
				new_type_name,
				info.fm);

		
	}

	protected SubtreeMarkInfo markAnnotationDependencySubtreeForSingleToken(Integer tokenID)
	{
		SubtreeMarkInfo this_token_info = new SubtreeMarkInfo(inputTokensAS.get(tokenID));
		
		Iterable<Integer> children = treeIndex.getChildren(tokenID);		
		if (children == null) return this_token_info;
		
		for (Integer childID : children)
		{
			this_token_info.mergeWith(
					markAnnotationDependencySubtreeForSingleToken(childID));
					//recursive call
		}
		
		return this_token_info;		
	}

}
