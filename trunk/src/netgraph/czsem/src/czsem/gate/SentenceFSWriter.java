package czsem.gate;

import java.io.PrintStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Comparator;
import java.util.List;

import gate.Annotation;
import gate.AnnotationSet;

public class SentenceFSWriter
{
	private AnnotationSet annotations;
	private AnnotationSet dependeces;
	private List<String> attributes;
	
	private PrintStream out = System.out;
	
	public SentenceFSWriter(AnnotationSet sentence_annotations, PrintStream out, List<String> attributes)
	{
		this.attributes = attributes;
		this.out = out;		
		this.annotations = sentence_annotations;
		dependeces = annotations.get("Dependency");		
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
		if (dependeces.size() <= 0) return -1;			
		
		Annotation a = (Annotation) dependeces.iterator().next();
		
		int ret = decodeEdge(a)[0];
		int new_ret;
		
		for (;;) {		
			new_ret = -1;
			for (Annotation dep : dependeces)
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
		for (Annotation dep : dependeces)
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
