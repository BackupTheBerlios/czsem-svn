package czsem.utils;

import java.text.Normalizer;
import java.text.Normalizer.Form;

import cz.cuni.mff.mirovsky.trees.NGTreeHead;
import czsem.net.NetgraphServerComunication.LoadTreeResult;
import czsem.utils.NetgraphQuery.ResultProcessor;

public class ILPQueryProcessor implements ResultProcessor
{
	
	int tree_num = 0;
	int max_trees = 50000;
	
	boolean neagtive = false;
	
	public static int[] interest_attr = {6, 20, 23, 35, 40, 42, 43, 44};
	
	public static String ASCIINormalise(String src)
	{
		if (src == null) return "null";
		String norm = Normalizer.normalize(src, Form.NFD); 
		norm = norm.replaceAll("[^\\p{ASCII}]", "");		
		return norm.toLowerCase();
		
	}

	public static String VarNormalise(String src)
	{
		String norm = ASCIINormalise(src); 
		norm = norm.replaceAll("[-^#*(),.:`';/{} \\\\\"\\[\\]]", "_");
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
		for (int attr = 0; attr < interest_attr.length; attr++) {
			String val = tree.getFirstNodeAttributeValue(node_index, interest_attr[attr]);
			if (val != null)
			{
				System.out.print(VarNormalise(head.getAttributeAt(interest_attr[attr]).getName()));
				System.out.print("(" + getNodeStr(node_index) + ", ");
				System.out.print(VarNormalise(val) + ").");

				System.out.println("         const(" + VarNormalise(val) + ").");
				
				if (interest_attr[attr] == 44) //   m/tag
				{
/**					if (val.charAt(10) == 'N')
						System.out.println("negation("+ getNodeStr(node_index) +").");
/**/
					for (int i = 0; i < 15; i++)
					{
						char ch = val.toLowerCase().charAt(i);
						if (ch != '-')
							System.out.print("m_tag"+ i +"("+getNodeStr(node_index)+",'" + ch +"'). const('"+ch+"'). ");			
					}
					System.out.println();

				}
			}			
		}		
	}
	
	public void processSingleTreeResult3(LoadTreeResult tree_result) throws Exception
	{
		//negative
		if (isNeagtive()) System.out.print(":- ");

		System.out.println("injured("+VarNormalise(tree_result.tree.getFirstNodeAttributeValue(0, 23)) +").");

		tree_num++;
		
		if (tree_num > getMaxTrees()) throw new Exception(); 		
	}

	public void processSingleTreeResult(LoadTreeResult tree_result) throws Exception
	{
		System.out.println("\n%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
		System.out.println("% " + ASCIINormalise(tree_result.tree.getSentenceString(tree_result.tree_head)));
		
		System.out.println("tree_root("+getNodeStr(0)+").");
		
		//negative
//		if (isNeagtive()) System.out.print(":- ");
			
//		System.out.println("injured("+getNodeStr(0)+").");
			
		
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
