package czsem.ILP.BackgroundKnowledge;

import java.io.FileNotFoundException;
import java.io.PrintStream;
import java.io.UnsupportedEncodingException;
import java.util.HashSet;
import java.util.Set;

import cz.cuni.mff.mirovsky.trees.NGTreeHead;
import czsem.net.NetgraphServerComunication;
import czsem.net.NetgraphProtocolConnection.SepartorCahrs;
import czsem.net.NetgraphServerComunication.LoadTreeResult;
import czsem.utils.CZSemTree;
import czsem.utils.NetgraphQuery;
import czsem.utils.NetgraphQuery.ResultProcessor;

public class Maker implements ResultProcessor {
	private String last_filename;
	
	private Set<String>[] attribute_values_bufeer;
	public static final int[] PRINT_ATTRIBUTES =	{
//		0, //atree.rf
//		1, //compl.rf
//		2, //coref_gram.rf
//		3, //coref_special
//		4, //coref_text.rf
//		5, //deepord
		6, //functor
//		7, //gram/aspect
//		8, //gram/degcmp
//		9, //gram/deontmod
//		10, //gram/dispmod
//		11, //gram/gender
//		12, //gram/indeftype
//		13, //gram/iterativeness
//		14, //gram/negation
//		15, //gram/number
//		16, //gram/numertype
//		17, //gram/person
//		18, //gram/politeness
//		19, //gram/resultative
		20, //gram/sempos
//		21, //gram/tense
//		22, //gram/verbmod
//		23, //id
//		24, //is_dsp_root
//		25, //is_generated
//		26, //is_member
//		27, //is_name_of_person
//		28, //is_parenthesis
//		29, //is_state
//		30, //nodetype
//		31, //quot/set_id
//		32, //quot/type
//		33, //sentmod
//		34, //subfunctor
		35, //t_lemma
//		36, //tfa
		37, //val_frame.rf
//		38, //sentence
//		39, //a/ref_type
		40, //a/afun
//		41, //a/is_member
		42, //m/form
		43, //m/lemma
		44, //m/tag
//		45, //w/token
//		46, //w/no_space_after
//		47, //a/ord
//		48, //a/parent_id
//		49, //hide				
		};

	
	
	private PrintStream tree_out = System.out;
	private String query = null;
	private String searchPath = null;
	
	public Maker()
	{}
	
	@SuppressWarnings("unchecked")
	protected void initAttributeValuesBufeer()
	{
		attribute_values_bufeer = new HashSet[PRINT_ATTRIBUTES.length];
		
		for (int i=0; i<attribute_values_bufeer.length; i++) {
			attribute_values_bufeer[i] = new HashSet<String>();
		}
	}

	public Maker(String output_file) throws FileNotFoundException, UnsupportedEncodingException
	{
		tree_out = new PrintStream(output_file, "UTF-8");
	}
	
	public void performOutput() throws Exception
	{
		NetgraphServerComunication nc = new NetgraphServerComunication();
		nc.openConnection("localhost", 2000);
		nc.login("dedek", "50eb3b47fbee4df59eaef6368261063b");
		
		if (getSearchPath() != null)
			nc.setSearchPathAndInitializeGlobalHead(getSearchPath());
		else
			nc.setSearchPathAndInitializeGlobalHead(nc.getCurrentDirectory());
		
		NetgraphQuery nq = new NetgraphQuery(query, nc);
		
		if (query != null)
			nq.startTheQuery();
		else
			nq.startQueryAll();
		
		nq.processResult(this);
		
		nc.close();		
	}
		
	/**
	 * From Long path name extract filename without extension.
	 * @param filename
	 * @return
	 */
	public static String stripFilename(String filename)
	{				
		return filename.subSequence(filename.lastIndexOf('/')+1, filename.indexOf('.')).toString();
	}
	
	public static String makeAtomString(String src_token)
	{
//		String norm = ASCIINormalise(src); 
//		String norm = src_token.replaceAll("[-+^#*()!?,.:`';/{} \\\\\"\\[\\]]", "_");
		String norm = src_token.replaceAll("[^\\p{L}\\p{Alnum}]", "_");
		if (! Character.isLetter(norm.charAt(0)) || Character.isUpperCase(norm.charAt(0)))
		{
			try
			{
				Integer.parseInt(norm); 
			}
			catch (NumberFormatException e)
			{
				norm = "q" + norm;
			}
		}
		return norm;
	}
	
	protected void printCaluse(String name, String arg1)
	{
		tree_out.println(
				makeAtomString(name) + "(" +		
				makeAtomString(arg1) + ").");				
	}
	protected void printCaluse(String name, String arg1, String arg2)
	{
		tree_out.println(
				makeAtomString(name) + "(" +		
				makeAtomString(arg1) + "," +				
				makeAtomString(arg2) + ").");				
	}

	protected void printCaluseQuoted(String name, String arg1, String quoted_arg)
	{
		tree_out.println(
				makeAtomString(name) + "(" +		
				makeAtomString(arg1) + ",'" +				
				quoted_arg + "').");				
	}

	protected void printCaluseQuoted(String name, String quoted_arg)
	{
		tree_out.println(
				makeAtomString(name) + "('" +		
				quoted_arg + "').");				
	}

	protected void printAttributesOfNode(LoadTreeResult tree_result, int node_index)
	{
		CZSemTree tree = tree_result.tree;
		NGTreeHead head = tree_result.tree_head;
		
/*		
		for (int aa=0; aa<head.getSize(); aa++)
		{
			System.err.print(aa);				
			System.err.print(", //");				
			System.err.println(head.getAttributeAt(aa).getName());			
		}
*/
		
		for (int attr = 0; attr < PRINT_ATTRIBUTES.length; attr++) {
			String val = tree.getFirstNodeAttributeValue(node_index, PRINT_ATTRIBUTES[attr]);
			if (val != null)
			{
				printCaluseQuoted(
						head.getAttributeAt(PRINT_ATTRIBUTES[attr]).getName(),
						tree.getNodeID(node_index),
						val);
				
				attribute_values_bufeer[attr].add(val);
				
/*
				if (PRINT_ATTRIBUTES[attr] == 44) //   m/tag
				{
//					if (val.charAt(10) == 'N')
//						ilp_task.getTree_out().println("negation("+ getNodeStr(node_index) +").");

					for (int i = 0; i < 15; i++)
					{
						char ch = val.toLowerCase().charAt(i);
						if (ch != '-')
							ilp_task.getTree_out().print("m_tag"+ i +"("+tree.getNodeID(node_index)+",'" + ch +"'). const('"+ch+"'). ");			
					}
					ilp_task.getTree_out().println();
				}
*/
			}			
		}					
	}
	
	@Override
	public void processSingleTreeResult(LoadTreeResult tree_result)
			throws Exception {
		
		tree_out.println("\n%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
		tree_out.println("% " + tree_result.tree.getSentenceString(tree_result.tree_head));
		
		String cur_filename = stripFilename(tree_result.filename); 
		if (cur_filename.compareTo(last_filename) != 0)
		{
			printCaluse("file", cur_filename);
			last_filename = cur_filename;
		}
		printCaluse("tree_root", tree_result.tree.getNodeID(0));		
		printCaluse("root_in_file", tree_result.tree.getNodeID(0), stripFilename(tree_result.filename));

		
		for (int i = 0; i < tree_result.tree.getCountOfNodes(); i++)			
		{
			tree_out.println("%%%%%%%% NODE " + tree_result.tree.getNodeID(i) + " %%%%%%%%%%%%%%%%%%%");
			printCaluse("node", tree_result.tree.getNodeID(i));
			
			printAttributesOfNode(tree_result, i);
		} 

		
		//EDGES
		for (int i=0; i < tree_result.tree.getEdges().length; i++)
		{
			printCaluse("edge", 
					tree_result.tree.getNodeID(tree_result.tree.getEdges()[i][0]),
					tree_result.tree.getNodeID(tree_result.tree.getEdges()[i][1]));
		}
		
		

		
		
	}
	
	public static final String[] train_set = {
		"jihomoravsky55788",
/*		"jihomoravsky48793",
		"jihomoravsky49921",
		"jihomoravsky51460",
		"jihomoravsky54536",
		"jihomoravsky56560",
		"jihomoravsky48752",
		"jihomoravsky53388",
		"jihomoravsky51719",
		"jihomoravsky56762",
		"jihomoravsky55629",
		"jihomoravsky50788",
		"jihomoravsky55918",
		"jihomoravsky56118",
		"jihomoravsky52147",
		"jihomoravsky47443",
		"jihomoravsky55789",
		"jihomoravsky56177",
		"jihomoravsky49737",
		"jihomoravsky56184",
		"jihomoravsky48880",
		"jihomoravsky54637",
		"jihomoravsky51054",
		"jihomoravsky50885",*/
		"jihomoravsky48749"};
	
	public static final String corpus_path = "/cygdrive/c/WorkSpace/czSem/UNIX_copy/netgraph_server/corpus\\hasici\\jihomoravsky/"; 
	public static final String extension = ".t.gz.fs"; 
	public static final char separator = SepartorCahrs.FS; 
	
	public static String makeSearchPath(String[] filenames)
	{
		StringBuilder sb = new StringBuilder();
		
		for (String file : filenames) {
			sb.append(corpus_path);
			sb.append(file);
			sb.append(extension);
			sb.append(separator);
		}
		
		return sb.toString();
	}
	
	public static void main(String[] args) throws Exception {
		Maker m = new Maker("C:\\WorkSpace\\aleph\\trees1.b");
		m.setSearchPath(makeSearchPath(train_set));
		m.performOutput();
	}

	@Override
	public void startProcessing() throws Exception {
		last_filename = "";
		initAttributeValuesBufeer();		
	}
	
	@Override
	public void endProcessing(LoadTreeResult last_result) throws Exception {
		
		for (int a=0; a< attribute_values_bufeer.length; a++) {
			String attr_name = last_result.tree_head.getAttributeAt(PRINT_ATTRIBUTES[a]).getName();
			
			for (String val : attribute_values_bufeer[a]) {
				printCaluseQuoted(attr_name, val);			
			}
		}
	}

	public void setSearchPath(String searchPath) {
		this.searchPath = searchPath;
	}

	public String getSearchPath() {
		return searchPath;
	}
}
