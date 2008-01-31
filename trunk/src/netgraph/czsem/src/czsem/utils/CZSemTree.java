package czsem.utils;

import cz.cuni.mff.mirovsky.ShowMessagesAble;
import cz.cuni.mff.mirovsky.trees.NGForest;
import cz.cuni.mff.mirovsky.trees.NGTree;
import cz.cuni.mff.mirovsky.trees.NGTreeHead;
import cz.cuni.mff.mirovsky.trees.TAHLine;
import cz.cuni.mff.mirovsky.trees.TNode;

public class CZSemTree {
    /** Array of all tree nodes, ordered by DepthOrder */
	private TNode [] node_array;
	private NGTree tree;	

	public CZSemTree(ShowMessagesAble p_mess) {
		tree = new NGTree(p_mess);
	}

	public CZSemTree() {
		this((ShowMessagesAble) null);
	}

	public CZSemTree(NGTree tree) {
		this.tree = tree;
		initNodeArray();		
	}
	

	/**
	 * Replace the original value of the node attribute by a new one. 
	 * @param node_index - depthOrder index of the node
	 * @param attr_index - attribute index
	 * @param value - new value to set
	 */
	public void setNodeAttributeValue(int node_index, int attr_index, String value)
	{
    	TAHLine val = new TAHLine();
    	val.Value = value;

    	node_array[node_index].getSetOfAttributes(0).AHTable[attr_index] = val;        	        	        			
	}

	public String getFirstNodeAttributeValue(int node_index, int attr_index)
	{
    	return node_array[node_index].getValue(0, attr_index, 0);        	        	        			
	}
	
	/**
	 * @param attr_index - index of attribute to match
	 * @param value - desired value
	 * @return - if success, the return value is deep order index of the first matching node, otherwise -1 .
	 */
	public int findFirstNodeByAttributeValue(int attr_index, String value)
	{
		for (int i=0; i<node_array.length; i++) {
			if (getFirstNodeAttributeValue(i, attr_index).equals(value)) return i;
		}
		
		return -1;
	}

	public static int findFirstNodeByAttributeValueInForest(NGForest forest, int attr_index, String value)
	{
		int ret = 0;
		for (NGTree tree : forest.getTrees()) {
			CZSemTree czsem_tree = new CZSemTree(tree);
			
			int i = czsem_tree.findFirstNodeByAttributeValue(attr_index, value);
			if (i == -1) ret += czsem_tree.tree.getNumberOfNodes();
			else return ret + i;
		}
		
		return -1;
	}
	
	protected void initNodeArray()
	{
		node_array = tree.getNodesArray();
	}
    
	public int readTree (NGTreeHead head, char[] p_source, int start_position, int p_number_of_attributes)
	{
		int ret = tree.readTree(head, p_source, start_position, p_number_of_attributes);
		initNodeArray();
		return ret;
	}

	public String getSentenceString(NGTreeHead head) {
		return tree.getSentenceString(head);
	}

	
}
