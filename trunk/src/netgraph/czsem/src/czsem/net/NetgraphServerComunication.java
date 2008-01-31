package czsem.net;

import java.io.IOException;
import java.net.UnknownHostException;
import java.util.ArrayList;
import java.util.StringTokenizer;

import javax.swing.DefaultListModel;

import cz.cuni.mff.mirovsky.account.ServerCommunicationFormatErrorException;
import cz.cuni.mff.mirovsky.account.UserAccount;
import cz.cuni.mff.mirovsky.trees.Attribute;
import cz.cuni.mff.mirovsky.trees.NGTreeHead;
import czsem.utils.CZSemTree;

public class NetgraphServerComunication extends NetgraphProtocolConnection {
	/** Constants used by the {@link #loadNextTree}	method */
	public static final class TreeSubtypeChars
	{
		/** Look for next tree in the same file */  
		public final static char GET_TREE_SUBTYPE_CONTEXT = 'c';
		/** Look for the next query match in current tree */  
        public final static char GET_TREE_SUBTYPE_OCCURENCE = 'o';
		/** Look for next tree satisfying the query */  
        public final static char GET_TREE_SUBTYPE_TREE = 't';
		/** Look for the first tree satisfying the query */          
        public final static char GET_TREE_SUBTYPE_FIRST = 'f';		
	}

	public class NetgraphConnectionInfo
	{
	    public String server_version;
	    public String client_required_version;
	    public String path_actual;
	    public String client_recommended_version;
	    public String corpus_identifier;		
	}

	public class LoadTreeResult
	{
		public String filename;
		public String query_match_str;
		public ArrayList<int []> query_match = new ArrayList<int[]>();
		
		public QueryStatistics query_statistics; 
				
		public NGTreeHead tree_head;
		public CZSemTree tree;
	
	}

	public class QueryStatistics
	{
		public int number_of_actual_occurrence;
		public int number_of_actual_tree;
		public int number_of_found_occurences;
		public int number_of_found_trees;
		public int number_of_searched_trees;
	}

	public final static String CLIENT_VER = "1.91 (12.11.2007)";
    public final static String META_ATTR_QUERY_MATCH = "_querymatch";

	
	
    private NGTreeHead globalHead = null;
	
    public NetgraphConnectionInfo openConnection(String server_name, int port) throws NetgraphProtocolException, IOException
	{    	
    	open(server_name, port);
		
		return initializeConnection();
	}
	
	public NGTreeHead getGlobalHead()
	{
		return globalHead;
	}

	public void setGlobalHead(NGTreeHead head)
	{
		globalHead = head;
		if (globalHead.getAttribute(META_ATTR_QUERY_MATCH) == null)
			globalHead.addAttribute(new Attribute(META_ATTR_QUERY_MATCH));
	}


	protected NetgraphConnectionInfo initializeConnection() throws NetgraphProtocolException, IOException
	{
		putChar('I');
		putString(CLIENT_VER);
		sendMessage();
		
		assertReplyOK();
		
		NetgraphConnectionInfo nci = new NetgraphConnectionInfo();
		
	    nci.server_version = getString(SepartorCahrs.EOL);
		nci.client_required_version = getString(SepartorCahrs.EOL);
		nci.path_actual = getString(SepartorCahrs.EOL);
		nci.client_recommended_version = getString(SepartorCahrs.EOL);
		nci.corpus_identifier = getString(SepartorCahrs.EOL);
	
	/*
	* start += readCoreferences (zprava, start); // nacte ze source koreference
	* jaaa.zalozka_query.setCoreferencePatterns(coreference_patterns);
	* jaaa.zalozka_trees.setCoreferencePatterns(coreference_patterns);
	*/		
		waitForMessageEnd();
		
		return nci;
	}
	
	/**
	 * Connects and logins to the server.
	 * @param user - user name
	 * @param encoded_password - use {@link #encryptPassword} to encrypt the password
	 * @throws UnknownHostException
	 * @throws IOException
	 * @throws NetgraphProtocolException 
	 * @throws ServerCommunicationFormatErrorException 
	 */
	public UserAccount login(String user, String encoded_password) throws UnknownHostException, IOException, NetgraphProtocolException, ServerCommunicationFormatErrorException
	{		
		putChar('L');
		putChar('a');
		
		putStringLn(user);
		putStringLn(encoded_password);
		sendMessage();
		
		assertReplyOK();
		byte [] ret = waitForMessageEnd();
		
		UserAccount ua = new UserAccount(null, null);
		ua.readFromBytes(ret, 0);
				
		return ua;
	}
	
	public void setSearchPathAndInitializeGlobalHead(String search_path) throws NetgraphProtocolException, IOException
	{
		putChar('F');
//		putChar('f');	//first
		putChar('o');	//first part only
		putString(search_path);
		sendMessage();
		assertReplyOK();
		
		String head_str = getString(SepartorCahrs.EOM);

		StringBuilder sb = new StringBuilder(head_str.length() +2);
		sb.append(head_str);
		sb.append((char) SepartorCahrs.NL);
		sb.append((char) SepartorCahrs.EOM);
		
		
		NGTreeHead head = new NGTreeHead(null);
		head.readTreeHead(sb.toString().toCharArray(), 0);
		setGlobalHead(head);
	}
	
	public String getCurrentDirectory () throws IOException, NetgraphProtocolException
	{		
		putChar('A');
		sendMessage();
		
		assertReplyOK();
		return getString(SepartorCahrs.EOM);				
	}
	
	public void queryAll() throws IOException, NetgraphProtocolException
	{
		putChar('Q');
		putChar('a');
		sendMessage();
		
		assertReplyOK();
		waitForMessageEnd();		
	}

	public void query(
			String query_string,
			boolean invert_match,
			boolean first_match_in_a_tree_only,
			boolean above_previous_query,
			boolean match_lemma_variants,
			boolean match_lemma_comments)
	throws IOException, NetgraphProtocolException
	{
		putChar('Q');
		
		if (above_previous_query) putChar('r');
		else putChar('f');

		putChar((char) 7);	// offset of query string
		
		if (match_lemma_variants) putChar('1');
		else putChar('0');
		
		if (match_lemma_comments) putChar('1');
		else putChar('0');
		
		if (invert_match) putChar('1');
		else putChar('0');
		
		if (first_match_in_a_tree_only) putChar('1');
		else putChar('0');
		
		putString(query_string);
		sendMessage();
				
		assertReplyOK();
		waitForMessageEnd();		
	}
	
	/**
	 * 
	 * @param treeSubtype - {@link TreeSubtypeChars}
	 * @return loaded tree or null - if there is no next tree in the result
	 * @throws IOException
	 * @throws NetgraphProtocolException
	 * @see TreeSubtypeChars
	 */	
	public LoadTreeResult loadNextTree(char treeSubtype) throws IOException, NetgraphProtocolException
	{
		for(;;)	// waiting for server ready
		{
			putChar('N');
			putChar(treeSubtype);
			sendMessage();
			
			
			byte msg_result = getByte();
			
			if (msg_result == SepartorCahrs.OK) break;
			
			waitForMessageEnd();
				
			if (msg_result == 'E'	//end of matching trees 
				|| msg_result == 'G') //end of trees in current context/file
			{
				//debug print
				System.err.println((char) msg_result);
				return null;
			}
			
			//debug print
			System.err.print(".");

			try {
				Thread.sleep(200);
			} catch (InterruptedException e) {}
		}
		
		//read the reply
		assertGetChar((char) SepartorCahrs.NL);
		
		
		LoadTreeResult res = new LoadTreeResult();

		//filename
		res.filename = getString(SepartorCahrs.NL);		
		//query match
		res.query_match_str = getString(SepartorCahrs.NL);
		//query_statistics		
		res.query_statistics = readQueryStatistics();

		//read head
		res.tree_head = new NGTreeHead(null);			
		char[] chars = getString(SepartorCahrs.EOM).toCharArray();
		int pos = res.tree_head.readTreeHead(chars, 0);
		
        DefaultListModel model_list_actual_head = getGlobalHead().getModel();

        //read tree
        res.tree = new CZSemTree();        
        res.tree.readTree(getGlobalHead(), chars, pos, 
        		model_list_actual_head.getSize());
                                
        //set query match
        int match_attr_number = getGlobalHead().getIndexOfAttribute(META_ATTR_QUERY_MATCH); 
        StringTokenizer st = new StringTokenizer(res.query_match_str, ":,");
        while (st.hasMoreTokens())
        {
        	String which_node_str = st.nextToken();
			String match_with_str = st.nextToken();
			int which_node = Integer.parseInt(which_node_str);
			int match_with = Integer.parseInt(match_with_str);
			res.query_match.add(new int[] { which_node, match_with });

			res.tree.setNodeAttributeValue(which_node, match_attr_number, match_with_str);
        }

        return res;				
	}
	
	
	protected QueryStatistics readQueryStatistics() throws NetgraphProtocolException, IOException
	{
		QueryStatistics qs = new QueryStatistics();
	    qs.number_of_actual_occurrence = getInt();
		qs.number_of_actual_tree = getInt();
		qs.number_of_found_occurences = getInt();
		qs.number_of_found_trees = getInt();
		qs.number_of_searched_trees = getInt();
		
		return qs;
	}
	
	public QueryStatistics getStatistics() throws NetgraphProtocolException, IOException
	{
		putChar('Y');
		sendMessage();
		assertReplyOK();
		
		QueryStatistics qs = readQueryStatistics();
		
		waitForMessageEnd();
		
		return qs;
	}
		

	
	// TODO: nefunguje na zpravy rozdelne do vice casti.
	public void dir() throws IOException, NetgraphProtocolException
	{
		putChar('C');
		putChar('a');
		putChar('f');	//first
//		putChar('m');	//more				
		sendMessage();
		
		
		assertReplyOK();				
		assertGetChar('o');				
		byte [] reply = waitForMessageEnd();
		
		int line_start = 0;
		int line_end = 0;

		for (;;)
		{
			while (reply[line_end] != SepartorCahrs.FS && reply[line_end] != SepartorCahrs.EOM)
				line_end++;
			
			System.out.println(new String(reply, line_start, line_end-line_start));

			if (reply[line_end] == SepartorCahrs.EOM) break;
			
			line_start = ++line_end; 						
		}
	}
	
	public void changeDir (String adr) throws IOException, NetgraphProtocolException
	{
		putChar('D');
		putString(adr);
		sendMessage();
		
		assertReplyOK();
		waitForMessageEnd();						
	}
	
	
	public void close() throws NetgraphProtocolException, IOException
	{
		putChar('Z');
		sendMessage();
		//connection should be closed by server
		super.close();		
	}		
}
