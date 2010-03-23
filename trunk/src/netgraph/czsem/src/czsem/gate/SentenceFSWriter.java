package czsem.gate;

import java.io.PrintStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import cz.cuni.mff.mirovsky.trees.Attribute;
import cz.cuni.mff.mirovsky.trees.NGTreeHead;

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
			List<Integer> childern = dependencies.get(father_id);
			if (childern == null) return;

			char delim = '('; 
			for (int child_id : childern)
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
	private String [] attributes;
	
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
	
	public NGTreeHead createTreeHead()
	{
		NGTreeHead th = new NGTreeHead(null);
		
		for (int i = 0; i < attributes.length; i++)
		{
			th.addAttribute(new Attribute(attributes[i]));			
//			ngf.getVybraneAtributy().add(i, Integer.toString(i));
		}
		
		th.N = th.W = 0;  

		return th;
	}
	
	public static String [] arrayConcatenate(String [] first, String [] second)
	{
		String [] ret = new String[first.length + second.length];
		System.arraycopy(first, 0, ret, 0, first.length);
		System.arraycopy(second, 0, ret, first.length, second.length);
		return ret;		
	}

	private void initAttributes(String [] additional_attributes)
	{
		attributes = arrayConcatenate(FSFileWriter.default_attributes, additional_attributes);			
	}
	
	public SentenceFSWriter(AnnotationSet sentence_annotations, PrintStream out)
	{
		this.out = out;		
		this.annotations = sentence_annotations;

		String[] attrs = guessAtttributes();
		Arrays.sort(attrs);
		for (int i = 0; i < attrs.length; i++) {
			System.err.println(attrs[i]);
		}		
		
		initAttributes(attrs);
	}

	public SentenceFSWriter(AnnotationSet sentence_annotations, PrintStream out, List<String> additional_attributes)
	{
		this.out = out;		
		this.annotations = sentence_annotations;
		
		initAttributes(additional_attributes.toArray(new String[0]));
		
//		dependenciesAS = annotations.get("Dependency");
		

/*		
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
*/		
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
	 * @param dependency_annotation_type 
	 * @see FSFileWriter#dependency_annotation_types
	 */
	public void printTree(int dependency_annotation_type)
	{
//		for (int dependency_annotation_type=0; dependency_annotation_type<FSFileWriter.dependency_annotation_types.length; dependency_annotation_type++)
//		{
			TreeBuilder tb = new TreeBuilder();
			
			AnnotationSet dependenciesAS = annotations.get(
					setFromArray(FSFileWriter.dependency_annotation_types[dependency_annotation_type]));
		
			tb.fillDependecies(dependenciesAS);
			

			if (FSFileWriter.tokendependency_annotation_types[dependency_annotation_type] != null)
			{
				tb.fillTokenDependecies(annotations.get(FSFileWriter.token_annotation_types[dependency_annotation_type]), 
						FSFileWriter.tokendependency_annotation_types[dependency_annotation_type]);
			}
			
			tb.printTree(out, attributes, annotations);
//		}

		
		out.println();
	}
}
