package czsem.apps;

import java.io.IOException;

import cz.cuni.mff.mirovsky.account.ServerCommunicationFormatErrorException;
import czsem.net.NetgraphServerComunication;
import czsem.net.NetgraphProtocolConnection.NetgraphProtocolException;
import czsem.utils.ILPQueryProcessor;
import czsem.utils.NetgraphQuery;

public class ILP {
	
	private String query_string;
	
	public ILP(String query_string)
	{
		this.query_string = query_string;
	}
	
	public void perform() throws NetgraphProtocolException, IOException, ServerCommunicationFormatErrorException
	{
		NetgraphServerComunication nc = new NetgraphServerComunication();
		nc.openConnection("localhost", 2000);
		nc.login("dedek", "50eb3b47fbee4df59eaef6368261063b");
		
		nc.setSearchPathAndInitializeGlobalHead(nc.getCurrentDirectory());
		

		System.out.println("%%%%%%%%%%%%%%%%%%%%%%%");
		System.out.println("% Declarations");
		System.out.println("%:- set(nodes,500000)?");
		System.out.println("%:- set(h,1000000)?");
		System.out.println("%:- set(r,10000)?");
		System.out.println(":- set(c,2),set(i,2),  set(inflate,800)?");
		System.out.println(":- set(verbose,2)?");
		System.out.println(":- modeh(1,tree_root(+node))?");
		System.out.println(":- modeb(*,edge(-node,+node))?");
		System.out.println(":- modeb(*,edge(+node,-node))?");
		System.out.println(":- modeb(*,edge(+node,+node))?\n");
		
		
		// print artrt list
		System.out.println("% begin of definitions of linguistic attributes");			
		for (int i = 0; i < nc.getGlobalHead().getSize(); i++)
		{
			System.out.println(":- modeb(1,"+ ILPQueryProcessor.VarNormalise(
					nc.getGlobalHead().getAttributeAt(i).getName()) +"(+node,#const))?");			
		}
		System.out.println("% end of definitions of linguistic attributes");			


	
		NetgraphQuery nq = new NetgraphQuery(query_string, nc);
		
		nq.startTheQuery();


		ILPQueryProcessor ilp_qp = new ILPQueryProcessor();

		try {
		
			nq.processResult(ilp_qp);
		
		} catch (Exception e) {
			e.printStackTrace();
		}

		/**/

		nc.close();		
	}

	/**
	 * @param args
	 * @throws ServerCommunicationFormatErrorException 
	 * @throws IOException 
	 * @throws NetgraphProtocolException 
	 */
	public static void main(String[] args) throws NetgraphProtocolException, IOException, ServerCommunicationFormatErrorException {
//		ILP ilp = new ILP("[deepord=0]");
		 
		ILP ilp = new ILP("[_name=action_type,gram/sempos=v,t_lemma=zranit|usmrtit|zemřít|zahynout|přežít]([m/tag=??????????N*,_name=a-negation,hide=true,_optional=true],[functor=MANN,_name=injury_manner,_optional=true],[functor=ACT|PAT,t_lemma=kdo|člověk|osoba|muž|žena|dítě|řidič|řidička|spolujezdec|spolujezdkyně,_name=participant,_transitive=true]([functor=RSTR,gram/sempos=n.quant.*|adj.quant.*,_name=quantity,_optional=true]))");

		
		ilp.perform();
	}

}

/*
0: atree.rf
1: compl.rf
2: coref_gram.rf
3: coref_special
4: coref_text.rf
5: deepord
6: functor
7: gram/aspect
8: gram/degcmp
9: gram/deontmod
10: gram/dispmod
11: gram/gender
12: gram/indeftype
13: gram/iterativeness
14: gram/negation
15: gram/number
16: gram/numertype
17: gram/person
18: gram/politeness
19: gram/resultative
20: gram/sempos
21: gram/tense
22: gram/verbmod
23: id
24: is_dsp_root
25: is_generated
26: is_member
27: is_name_of_person
28: is_parenthesis
29: is_state
30: nodetype
31: quot/set_id
32: quot/type
33: sentmod
34: subfunctor
35: t_lemma
36: tfa
37: val_frame.rf
38: sentence
39: a/ref_type
40: a/afun
41: a/is_member
42: m/form
43: m/lemma
44: m/tag
45: w/token
46: w/no_space_after
47: a/ord
48: a/parent_id
49: hide
50: _transitive
51: _optional
52: _#sons
53: _#hsons
54: _#descendants
55: _#lbrothers
56: _#rbrothers
57: _depth
58: _#occurrences
59: _name
60: _sentence
61: _querymatch
*/
