package czsem.ILP;

import java.io.FileNotFoundException;
import java.io.UnsupportedEncodingException;

import czsem.net.NetgraphServerComunication.LoadTreeResult;
import czsem.net.NetgraphServerComunication.LoadTreeResult.SingleMatch;
import czsem.utils.SimpleXMLQueryProcessor.Selector;

public class ExamplesMaker extends DataMaker {

	public ExamplesMaker(String output_file) throws FileNotFoundException, UnsupportedEncodingException {
		super(output_file);
	}

	public ExamplesMaker() {};

	@Override
	public void endProcessing(LoadTreeResult last_result) throws Exception {}

	@Override
	public void processSingleTreeResult(LoadTreeResult tree_result)
			throws Exception {
		
		
		Selector s = new Selector("damage", "t_lemma", nq);
		
		// find corresponding node in the result tree			
		for (SingleMatch tree_match : tree_result.query_match) {
			if (s.matchAQuery(tree_match))
			{
				printCaluse("relevant_node", s.getMatchingValue(tree_result.tree, tree_match));
			}
		}			


	}

	@Override
	public void startProcessing() throws Exception {}

	
	public static void main(String[] args) throws Exception {
//		ExamplesMaker m = new ExamplesMaker("C:\\WorkSpace\\aleph\\trees1.f");
		ExamplesMaker m = new ExamplesMaker();
		m.setSearchPath(makeSearchPath(train_set));
		m.setQueryString("[t_lemma=vyčíslit|stanovit|odhadnout|dosahovat]([t_lemma=tisíc|milión,_transitive=true]([gram/sempos=adj.quant.def,_name=damage],[t_lemma=koruna,_optional=true,functor=MAT]),[_optional=true]([functor=PAT|ACT|RSTR,_optional=false,t_lemma=škoda|Škoda]),[t_lemma=vyšetřovatel,functor=ACT,_optional=true])");
		m.performOutput();
	}
}
