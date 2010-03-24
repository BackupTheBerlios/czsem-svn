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

import cz.cuni.mff.mirovsky.trees.Attribute;
import cz.cuni.mff.mirovsky.trees.NGTreeHead;

import gate.Annotation;
import gate.AnnotationSet;

public class SentenceFSWriter
{
	public static class TreeBuilder
	{
		private PrintStream out;
		private AnnotationSet annotations;
		private String [] attributes;

		private Map<Integer, List<Integer>> dependencies = new HashMap<Integer, List<Integer>>(); 
		private Map<Integer, Integer> parents = new HashMap<Integer, Integer>();
		private int root; 		

		public TreeBuilder(AnnotationSet annotations) {
			this.annotations = annotations;
		}

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
		
		public int findRoot()
		{
			if (parents.entrySet().isEmpty()) return -1;
			
			root = -1;
			for (Integer i = parents.entrySet().iterator().next().getValue(); i != null; i = parents.get(i))
			{
				System.err.println(i);
				root = i;
			}
			
			return root;			
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

		
		private void printAttribute(String attr_name, Object attr_value)		
		{
			out.print(attr_name);
			out.print('=');
			
			String str_value = attr_value.toString();
			String functional_chars = "\\=,[]|<>!";
			
			for (int i=0; i<str_value.length(); i++)
			{
				char ch = str_value.charAt(i);
				if (functional_chars.indexOf(ch) != -1) out.print('\\');
				out.print(ch);
			}
		}
		
		private void printNode(int node_id)
		{
			Annotation node = annotations.get(node_id);		
			if (node == null) return;
			
			out.print('[');
			
			assert FSFileWriter.ID_INDEX == 0;
			printAttribute(FSFileWriter.default_attributes[FSFileWriter.ID_INDEX], node_id);
			out.print(',');
			
			for (int a=1; a<attributes.length; a++)
			{
				Object f = node.getFeatures().get(attributes[a]);
				
				if (f != null)
				{
					printAttribute(attributes[a], f);
					if (a+1<attributes.length) out.print(',');										
				}
				
			}
			out.print(']');
					
			printCildren(node_id);
		}

/*		
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
*/		
		public void printTree(PrintStream out, String [] attributes)
		{
			this.out = out;
			this.attributes = attributes;
			
			out.print("Dependencies: ");			
			out.println(dependencies.keySet().size());
						
			printNode(root);

		}
		
		public static class tokenOrderComprator implements Comparator<Annotation>
		{

			@Override
			public int compare(Annotation a1, Annotation a2) {
				return  a1.getStartNode().getOffset().compareTo(
						a2.getStartNode().getOffset());
			}
			
		}
		
		public void updateSentenceTokens()
		{
			List<Annotation> token_id_list = new ArrayList<Annotation>();
			token_id_list.add(annotations.get(root));
			
			for (List<Integer> id_list : dependencies.values()) {
				for (Integer id : id_list) {
					token_id_list.add(annotations.get(id));
				}
			}
			
			Annotation [] token_annots = token_id_list.toArray(new Annotation[0]);
			
			numberSentenceTokens(token_annots);
			hideSentenceTokens(token_annots);									
		}

		private void hideSentenceTokens(Annotation[] token_annots)
		{
			String root_type = annotations.get(root).getType();
			
			for (int i = 0; i < token_annots.length; i++)
			{
				if (! token_annots[i].getType().equals(root_type))
				{
					token_annots[i].getFeatures().put(FSFileWriter.HIDE_FEATURENAME, true);
				}
			}			
		}

		private void numberSentenceTokens(Annotation [] token_annots)
		{
			Arrays.sort(token_annots, new tokenOrderComprator());
			
			for (int i = 0; i < token_annots.length; i++) {
				token_annots[i].getFeatures().put(FSFileWriter.ORD_FEATURENAME, i);				
			}
		}


	}
	
	
			
	private AnnotationSet annotations;
	private String [] attributes = null;
	
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
		
		String[] attrs = attr_set.toArray(new String[0]);
		
		Arrays.sort(attrs);
		for (int i = 0; i < attrs.length; i++) {
			System.err.println(attrs[i]);
		}
		
		return attrs;
	}
	
	public NGTreeHead createTreeHead()
	{
		NGTreeHead th = new NGTreeHead(null);
		
		for (int i = 0; i < attributes.length; i++)
		{
			th.addAttribute(new Attribute(attributes[i]));			
//			ngf.getVybraneAtributy().add(i, Integer.toString(i));
		}
		
		
		th.N = th.W = th.getIndexOfAttribute(FSFileWriter.ORD_FEATURENAME);
		th.H = th.getIndexOfAttribute(FSFileWriter.HIDE_FEATURENAME);

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

		/*
		String[] attrs = guessAtttributes();
		
		initAttributes(attrs);
		*/
	}

	public SentenceFSWriter(AnnotationSet sentence_annotations, PrintStream out, List<String> additional_attributes)
	{
		this(sentence_annotations, out);
		
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
			TreeBuilder tb = new TreeBuilder(annotations);
			
			AnnotationSet dependenciesAS = annotations.get(
					setFromArray(FSFileWriter.dependency_annotation_types[dependency_annotation_type]));
		
			tb.fillDependecies(dependenciesAS);
			

			if (FSFileWriter.tokendependency_annotation_types[dependency_annotation_type] != null)
			{
				tb.fillTokenDependecies(annotations.get(FSFileWriter.token_annotation_types[dependency_annotation_type]), 
						FSFileWriter.tokendependency_annotation_types[dependency_annotation_type]);
			}
			
			tb.findRoot();
			tb.updateSentenceTokens();
			
			if (attributes == null) initAttributes(guessAtttributes());

			
			tb.printTree(out, attributes);
//		}

		
		out.println();
	}
	
	
}
