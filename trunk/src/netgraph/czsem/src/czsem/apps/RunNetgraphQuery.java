/**
 * Project applications
 */
package czsem.apps;

import java.io.FileOutputStream;

import cz.cuni.mff.mirovsky.account.UserAccount;
import czsem.net.NetgraphServerComunication;
import czsem.net.NetgraphServerComunication.NetgraphConnectionInfo;
import czsem.utils.NetgraphQuery;
import czsem.utils.SimpleXMLQueryProcessor;

/**
 * @author dedek
 *
 */
public class RunNetgraphQuery {
	
	public static void main(String[] args) throws Exception
	{
		NetgraphServerComunication nc = new NetgraphServerComunication();
		NetgraphConnectionInfo ci = nc.openConnection("localhost", 2000);
//		UserAccount ua = nc.login("dedek", NetgraphConnection.encryptPassword("???"));
		UserAccount ua = nc.login("dedek", "50eb3b47fbee4df59eaef6368261063b");
		
		SimpleXMLQueryProcessor sp = new SimpleXMLQueryProcessor(
				new String [] {
						"action_type.t_lemma",
						"a-negation.m/tag",						
						"injury_manner.t_lemma",
						"participant.t_lemma",
						"quantity.t_lemma"},
						new FileOutputStream("query_out.xml"),
						nc);
		
		sp.stratXMLOtput();
		sp.writeNetgraphConnectionInfo(ci);
		sp.writeUserInfo(ua);

		nc.setSearchPathAndInitializeGlobalHead(nc.getCurrentDirectory());
//		String query_string = "[_name=action_type,gram/sempos=v,t_lemma=zranit|usmrtit|zemřít|zahynout|přežít]([m/tag=??????????N*,_name=a-negation,hide=true,_optional=true],[functor=MANN,_name=injury_manner],[functor=ACT|PAT,t_lemma=kdo|člověk|osoba|muž|žena|dítě|řidič|řidička|spolujezdec|spolujezdkyně,_name=participant]([functor=RSTR,gram/sempos=n.quant.*|adj.quant.*,_name=quantity]))"; 
		String query_string = "[_name=action_type,gram/sempos=v,t_lemma=zranit|usmrtit|zemřít|zahynout|přežít]([m/tag=??????????N*,_name=a-negation,hide=true,_optional=true],[functor=MANN,_name=injury_manner,_optional=true],[functor=ACT|PAT,t_lemma=kdo|člověk|osoba|muž|žena|dítě|řidič|řidička|spolujezdec|spolujezdkyně,_name=participant]([functor=RSTR,gram/sempos=n.quant.*|adj.quant.*,_name=quantity,_optional=true]))"; 

		
		NetgraphQuery nq = new NetgraphQuery(query_string, nc);
		sp.writeQueryInfo(nc.getCurrentDirectory(), nq);
		
		nq.startTheQuery();
		
		System.err.println(nq.processResult(sp) + " trees");
		
		sp.writeNetgraphQueryStatistics(nc.getStatistics());
		
		sp.closeXMLOtput();
						
		nc.close();
		
		
		//print artrt list
/*		for (int i = 0; i < nc.getGlobalHead().getSize(); i++) {
			System.out.println(i+": "+nc.getGlobalHead().getAttributeAt(i).getName());			
		}
/**/

	}

}



/*
		NGForest query_forest = new NGForest(null);
		query_forest.setHead(nc.getGlobalHead());
		query_forest.readForest(query_string.toCharArray(), 0, nc.getGlobalHead().getSize());
										
		
		query_forest.setHead(nc.getGlobalHead());
		query_forest.getVybraneAtributy().addElement("id");
		query_forest.getVybraneAtributy().addElement(NGTreeHead.META_ATTR_NODE_NAME);
		query_forest.getVybraneAtributy().addElement("t_lemma");
		query_forest.getVybraneAtributy().addElement(NetgraphServerComunication.META_ATTR_QUERY_MATCH);
		
		forest.setVybraneAtributy(query_forest.getVybraneAtributy());
		
		NetgraphQuery nq = new NetgraphQuery(query_string, nc);

		
		TreeVisualize tv = new TreeVisualize();
		tv.setVisible(true);
		tv.setForest(forest);

		
		

					
		for (int i = 0; i < forest.getHead().getSize(); i++) {
			System.out.println(i+": "+forest.getHead().getAttributeAt(i).getName());			
		}
		
		
		
		PrintStream out = new PrintStream(System.out, true, "UTF-8");

		for (NGTree tree : query_forest.getTrees()) {
			printTree(tree, out);
		}

		for (NGTree tree : forest.getTrees()) {
			out.println(tree.getSentenceString(forest.getHead()));						
		}


Vector<String> v = new Vector<String>();;
Vector<String> v2 = new Vector<String>();;

v.add("ssss");
v.add("bbbb");
v.add("konec");
		
XMLEncoder encoder = new XMLEncoder(out);
encoder.writeObject(new String("Jan Dědek - ččř=éíéžííýáéěšěůú"));
encoder.writeObject(v);
encoder.close();

		System.out.println(ua.getUserName());
		System.out.println(ua.getRootDirectory());
		System.out.println(ua.getMaxNumberOfTrees());						


	
	
	
	static NGTreeHead defatlHead; 
	
	public static void printTree(NGTree tree, PrintStream out)
	{
		printNode(tree.getRoot(), out, 0);
		
	}
	
	public static void printNode(TNode node, PrintStream out, int depth)
	{
		for (int a=0; a<depth; a++ )
			out.print(" ");		
		
		out.println(node.getValue(0, 0, 0));
		
		TNode son = node.first_son;
		while (son != null)
		{
			printNode(son, out, depth+1);
			son = son.brother;			
		}				
	}


/**/		

