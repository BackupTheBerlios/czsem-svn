package czsem.gate;

import java.io.PrintStream;
import java.util.ArrayList;

import gate.Annotation;
import gate.AnnotationSet;

public class SentenceFSWriter
{
	private AnnotationSet annotations;
	private AnnotationSet dependeces;
	
	private PrintStream out = System.out;
	
	public SentenceFSWriter(AnnotationSet sentence_annotations, PrintStream out)
	{
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
		out.print(node_id);
		out.print(',');		
		out.print(kind_attr);		
		out.print(',');		
		out.print(node.getFeatures().get("string"));
		out.print(']');
		
		printCildren(node_id);
	}

	public void printTree()
	{
		printNode(findRoot(), "root");
		
		out.println();
	}
}
