package czsem.utils;

import java.text.Normalizer;
import java.text.Normalizer.Form;

import cz.cuni.mff.mirovsky.trees.NGTreeHead;
import czsem.net.NetgraphServerComunication.LoadTreeResult;
import czsem.utils.NetgraphQuery.ResultProcessor;

public class ILPQueryProcessor implements ResultProcessor
{
	
	int tree_num = 0;
	int max_trees = 50;
	
	boolean neagtive = false;
	
	public static String ASCIINormalise(String src)
	{
		if (src == null) return "null";
		String norm = Normalizer.normalize(src, Form.NFD); 
		norm = norm.replaceAll("[^\\p{ASCII}]", "");
		return norm;
		
	}

	public static String VarNormalise(String src)
	{
		String norm = ASCIINormalise(src); 
		norm = norm.replaceAll("[-^#*(),.:`';/ \\\\\"\\[\\]]", "_");
		if (! Character.isLetter((norm.charAt(0))))
		{
			try
			{
				Integer.parseInt(norm); 
			}
			catch (NumberFormatException e)
			{
				norm = "x" + norm;
			}
		}
		return norm;
		
	}


	private String getNodeStr(int node_index)
	{
		return "node" +tree_num+ "_" + node_index;
	}

	private void printAttributes(NGTreeHead head, CZSemTree tree, int node_index)	
	{
		for (int attr = 0; attr < head.getSize(); attr++) {
			String val = tree.getFirstNodeAttributeValue(node_index, attr);
			if (val != null)
			{
				System.out.print(VarNormalise(head.getAttributeAt(attr).getName()));
				System.out.print("(" + getNodeStr(node_index) + ", ");
				System.out.print(VarNormalise(val) + ").");

				System.out.println("         const(" + VarNormalise(val) + ").");				
			}			
		}		
	}
	
	public void processSingleTreeResult(LoadTreeResult tree_result) throws Exception
	{
		System.out.println("\n%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
		System.out.println("% " + ASCIINormalise(tree_result.tree.getSentenceString(tree_result.tree_head)));
		
		System.out.println("tree_root("+getNodeStr(0)+").");
		
		if (isNeagtive()) 
			System.out.println(":- valid_root("+getNodeStr(0)+").");
		else
			System.out.println("valid_root("+getNodeStr(0)+").");
			
		
		for (int i = 0; i < tree_result.tree.getCountOfNodes(); i++)			
		{
			System.out.println("%%%%%%%% " + getNodeStr(i) + " %%%%%%%%%%%%%%%%%%%");
			System.out.println("node("+getNodeStr(i)+").");
			
			printAttributes(tree_result.tree_head, tree_result.tree, i);

//			System.out.println("node_attr(node" +tree_num+ "_"+i+","+ ASCIINormalise(tree_result.tree.getFirstNodeAttributeValue(i, 35)) +").");
//			System.out.println("const(" + ASCIINormalise(tree_result.tree.getFirstNodeAttributeValue(i, 35)) +").");
		} 

		
		for (int i=0; i < tree_result.tree.getEdges().length; i++)
		{
			System.out.println("edge(node" +tree_num+ "_" + tree_result.tree.getEdges()[i][0] + ", node"
					+tree_num+ "_" + tree_result.tree.getEdges()[i][1]+").");
		}
		
		tree_num++;
		
		if (tree_num > getMaxTrees()) throw new Exception(); 
	}

	public void startProcessing()
	{}
	
	public void endProcessing()
	{}

	public boolean isNeagtive() {
		return neagtive;
	}

	public void setNeagtive(boolean neagtive) {
		this.neagtive = neagtive;
	}

	public int getMaxTrees() {
		return max_trees;
	}

	public void setMaxTrees(int max_trees) {
		this.max_trees = max_trees;
	}
}
