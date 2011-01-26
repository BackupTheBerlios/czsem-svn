package czsem.gate.plugins;

import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URISyntaxException;
import java.util.Arrays;
import java.util.List;
import java.util.Vector;

import org.apache.log4j.Logger;
import org.apache.xmlrpc.XmlRpcClientLite;
import org.apache.xmlrpc.XmlRpcException;

import czsem.utils.Config;
import czsem.utils.ProcessExec;

public class TectoMTOnlineAnalyser extends TectoMTAbstractAnalyser
{
	private static final long serialVersionUID = 2036059373106358909L;

	static Logger logger = Logger.getLogger(TectoMTOnlineAnalyser.class);
	protected ProcessExec tmtProcess = null;
	
	@Override
	protected String getBrunBlocks() throws URISyntaxException, IOException
	{
		Config cfg = Config.getConfig();
//		return cfg.getTmtRoot()+ "/tools/general/runblocks.btred";
		return cfg.getCzsemPluginDir() + "/Perl/online_runblocks.btred";

	}

	public boolean isServerRunning()
	{
		if (tmtProcess == null) return false;
		
		return tmtProcess.isRunning();
	}
	
	
	protected void startTMTAnalysisServer() throws IOException, InterruptedException, URISyntaxException
	{		
		List<String> cmd_list = buildTredCmdArray();			
		
		tmtProcess = new ProcessExec();
		tmtProcess.exec(cmd_list.toArray(new String[0]), getTredEnvp());
		tmtProcess.startReaderThreads(Config.getConfig().getLogFileDirectoryPath() + "/TMT_GATE_");
	}
	
	
	public static class TectMTServerConnection
	{
		private XmlRpcClientLite client;
		
		public TectMTServerConnection(int port) throws MalformedURLException
		{
			client = new XmlRpcClientLite("localhost", port);			
		}
		
		public void analyseFile(String file_path) throws XmlRpcException, IOException
		{
			Vector<String> params = new Vector<String>(1);
	        params.addElement(file_path);
	        String result = (String) client.execute("tectoMT.analyzeFile", params);
	        assert (result.equals("succes"));			
		}

		public void terminate()
		{
			try {
				client.execute("tectoMT.terminate", new Vector<String>(0));
			} catch (Exception e) {System.err.println("server terminated");}
		}
		
	}
	
	public static List<String> getTempBlocks() {
		String [] blocks =
		{
				"SEnglishW_to_SEnglishM::Sentence_segmentation",
				"SEnglishW_to_SEnglishM::Tokenization"
		};
		
		return Arrays.asList(blocks);
	}


	
	public static void main(String [] rgs) throws IOException, InterruptedException, URISyntaxException, XmlRpcException
	{
		System.err.println("start");
		TectoMTOnlineAnalyser ta = new TectoMTOnlineAnalyser();
		
		ta.setLoadScenarioFromFile(false);
		ta.setBlocks(getTempBlocks());

		ta.startTMTAnalysisServer();
		
		TectMTServerConnection con = new TectMTServerConnection(8080);
		
		con.analyseFile("czsem_GATE_plugins/TmT_serializations/1032.xml_0001A.tmt~");
		con.analyseFile("czsem_GATE_plugins/TmT_serializations/10784.xml_00025.tmt~");
		con.analyseFile("czsem_GATE_plugins/TmT_serializations/9809.xml_00262.tmt");
		con.terminate();

		
/*		ta.startTMTAnalysisServer();
		
		XmlRpcClientLite client = new XmlRpcClientLite("localhost", 8080);
//		client.execute("dedek_online.Name", new Vector<String>(0));
		

		
		Vector<String> params = new Vector<String>(1);
        params.addElement("czsem_GATE_plugins/TmT_serializations/9809.xml_00262.tmt");
        String result = (String) client.execute("tectoMT.analyzeFile", params);
        System.out.println("Result: " + result);

        params = new Vector<String>(1);
        params.addElement("czsem_GATE_plugins/TmT_serializations/10025.xml_00014.tmt");
        result = (String) client.execute("tectoMT.analyzeFile", params);
        System.out.println("Result: " + result);

		
		try {
			client.execute("tectoMT.terminate", new Vector<String>(0));
		} catch (IOException e) {System.err.println("server terminated");}
*/
        System.err.println("end");
		
		
	}

}


/*


sub run2
{
    my $methods;
    $methods = {
      'tectoMT.analyzeFile' => \&analyzeFile,
      'tectoMT.terminate' => \&terminate };
    my $server;
    $server = Frontier::Daemon->new(LocalPort => 8080, methods => $methods)
        or die "Couldn't start HTTP server: $!";
}

 * */
