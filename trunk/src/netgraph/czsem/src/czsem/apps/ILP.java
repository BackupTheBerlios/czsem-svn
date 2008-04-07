package czsem.apps;

import java.io.IOException;

import cz.cuni.mff.mirovsky.account.ServerCommunicationFormatErrorException;
import czsem.net.NetgraphServerComunication;
import czsem.net.NetgraphProtocolConnection.NetgraphProtocolException;
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

	
		NetgraphQuery nq = new NetgraphQuery(query_string, nc);
		
		nq.startTheQuery();


//		nq.processResult();
//		System.err.println(nq.processResult(sp) + " trees");

		nc.close();		
	}

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

}
