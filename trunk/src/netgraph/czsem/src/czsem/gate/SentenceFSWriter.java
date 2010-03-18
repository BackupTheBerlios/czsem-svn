package czsem.gate;

import java.io.PrintStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Comparator;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.SortedSet;
import java.util.TreeSet;

import gate.Annotation;
import gate.AnnotationSet;

public class SentenceFSWriter
{
	public static class TreeBuilder
	{
		private Map<Integer, List<Integer>> dependencies = new HashMap<Integer, List<Integer>>(); 
		private Map<Integer, Integer> parents = new HashMap<Integer, Integer>(); 		

		protected void addDpendency(int parent_id, int child_id)
		{
			List<Integer> children = dependencies.get(parent_id);
			if (children == null)
			{
				children = new ArrayList<Integer>(6);
				dependencies.put(parent_id, children);
			}
			
			children.add(child_id);
			parents.put(child_id, parent_id);
		}

		protected void addDpendency(Annotation a)
		{
			int[] dep = decodeEdge(a);
			addDpendency(dep[0], dep[1]);
		}; 
		
		protected void addTokenDpendency(Annotation a, String feature_name)
		{
			Integer child = (Integer) a.getFeatures().get(feature_name);
			addDpendency(a.getId(), child);		
		}; 

		protected void fillDependecies(AnnotationSet dependenciesAS)
		{
			for (Annotation dep : dependenciesAS)
			{
				addDpendency(dep);
			}							
		}
		
		protected void fillTokenDependecies(AnnotationSet tokenAS, String feature_name)
		{
			for (Annotation toc : tokenAS)
			{
				addTokenDpendency(toc, feature_name);
			}							
		}
		
		private int findRoot()
		{
			if (parents.entrySet().isEmpty()) return -1;
			
			int ret = -1;
			for (Integer i = parents.entrySet().iterator().next().getValue(); i != null; i = parents.get(i))
			{
				System.err.println(i);
				ret = i;
			}
			
			return ret;
			
		}

		private void printCildren(int father_id)
		{
			char delim = '('; 
			for (int child_id : dependencies.get(father_id))
			{
				out.print(delim);
				delim = ',';
				printNode(child_id);
			}			
			if (delim == ',') out.print(')');
		}

		private void printNode(int node_id)
		{
			Annotation node = tokens.get(node_id);		
			if (node == null) return;
			
			out.print('[');
			for (int a=0; ;)
			{
				switch (a) {
//				case FSFileWriter.DEPENDECY_INDEX:
//					out.print(kind_attr);						
//					break;
				case FSFileWriter.ID_INDEX:
					out.print(node_id);
					break;
				default:
					out.print(node.getFeatures().get(attributes[a]));
					break;
				}
				
				if (++a >= attributes.length) break;
				out.print(',');					
			}
			out.print(']');
					
			printCildren(node_id);
		}

		
		public void printNode(int id, String prefix)
		{
			out.print(prefix);
			out.println(id);
			
			List<Integer> children = dependencies.get(id);
			
			if (children == null) return;
			
			for (Integer child : children)
			{
				printNode(child, prefix+ "   ");				
			}
		}
		
		PrintStream out;
		AnnotationSet tokens;
		String [] attributes;

		public void printTree(PrintStream out, String [] attributes, AnnotationSet tokens)
		{
			this.out = out;
			this.tokens = tokens;
			this.attributes = attributes;
			
			out.print("Dependencies: ");			
			out.println(dependencies.keySet().size());
			
			int root = findRoot();
			printNode(root);

		}

	}
	
	
			
	private AnnotationSet annotations;
	private AnnotationSet dependenciesAS;
	private List<String> attributes;
	
	private PrintStream out = System.out;
	

	public static Set<String> setFromArray(String[] array)
	{		
		return new HashSet<String>(Arrays.asList(array));
	}
	
	protected String[] guessAtttributes()
	{		
		AnnotationSet tokens = annotations.get(setFromArray(FSFileWriter.token_annotation_types));
		
		Set<String> attr_set = new HashSet<String>();  
		
		for (Annotation token : tokens)
		{
			for (Object feature : token.getFeatures().keySet())
			{
				attr_set.add((String) feature);				
			}			
		}
		
		return attr_set.toArray(new String[0]);		
	}
	
	public SentenceFSWriter(AnnotationSet sentence_annotations, PrintStream out, List<String> attributes)
	{
		this.attributes = attributes;
		this.out = out;		
		this.annotations = sentence_annotations;
//		dependenciesAS = annotations.get("Dependency");
		
		String [] attrs = guessAtttributes();
		Arrays.sort(attrs);
		for (int i = 0; i < attrs.length; i++) {
			System.err.println(attrs[i]);
		}
		
		for (int a=0; a<FSFileWriter.dependency_annotation_types.length; a++)
		{
			TreeBuilder tb = new TreeBuilder();
			
			AnnotationSet dependenciesAS = sentence_annotations.get(
					setFromArray(FSFileWriter.dependency_annotation_types[a]));
		
			tb.fillDependecies(dependenciesAS);
			

			if (FSFileWriter.tokendependency_annotation_types[a] != null)
			{
				tb.fillTokenDependecies(sentence_annotations.get(FSFileWriter.token_annotation_types[a]), 
						FSFileWriter.tokendependency_annotation_types[a]);
			}
			
			tb.printTree(System.err, attrs, annotations);
		}
	}
	
	@SuppressWarnings("unchecked")
	public static int[] decodeEdge(Annotation a)
	{
		int [] ret = new int[2];
		ArrayList<Integer> list = (ArrayList<Integer>) a.getFeatures().get("args");
		ret[0] = list.get(0);
		ret[1] = list.get(1);
		return ret;
	}

	
	/**
	 * Adds the feature "ord", which contains the order of given token in a sentence. 
	 */
	private void numberSentenceTokens()
	{		
		Annotation [] tokens = annotations.get("Token").toArray(new Annotation[0]);

					
		Arrays.sort(tokens, new Comparator<Annotation>() {
			public int compare(Annotation a1, Annotation a2) {
				return  a1.getId().compareTo(a2.getId());
		}});
		
		int ord = 0;
		for (Annotation a : tokens)
		{
			a.getFeatures().put("ord", ord++);
		}
	}
	
	private int findRoot()
	{
		if (dependenciesAS.size() <= 0) return -1;			
		
		Annotation a = (Annotation) dependenciesAS.iterator().next();
		
		int ret = decodeEdge(a)[0];
		int new_ret;
		
		for (;;) {		
			new_ret = -1;
			for (Annotation dep : dependenciesAS)
			{
				int [] edge = decodeEdge(dep);
				if (edge[1] == ret)
				{
					new_ret = edge[0];
					break;				
				}
			}
			
			if (new_ret == -1) break;
			
			ret = new_ret;			
		} 
		
		return ret;	
	}
	
	private void printCildren(int father_id)
	{
		char delim = '('; 
		for (Annotation dep : dependenciesAS)
		{
			int [] edge = decodeEdge(dep);
			if (edge[0] == father_id)
			{
				out.print(delim);
				delim = ',';
				printNode(edge[1], (String) dep.getFeatures().get("kind"));
			}
		}			
		if (delim == ',') out.print(')');
	}

	private void printNode(int node_id, String kind_attr)
	{
		Annotation node = annotations.get(node_id);		
		if (node == null) return;
		
		out.print('[');
		for (int a=0; ;)
		{
			switch (a) {
			case FSFileWriter.DEPENDECY_INDEX:
				out.print(kind_attr);						
				break;
			case FSFileWriter.ID_INDEX:
				out.print(node_id);
				break;
			default:
				out.print(node.getFeatures().get(attributes.get(a)));
				break;
			}
			
			if (++a >= attributes.size()) break;
			out.print(',');					
		}
		out.print(']');
				
		printCildren(node_id);
	}

	public void printTree()
	{
		numberSentenceTokens();
		
		printNode(findRoot(), "root");
		
		out.println();
	}
}
