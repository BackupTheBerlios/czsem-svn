package czsem.gate.plugins;

import java.io.IOException;
import java.net.URISyntaxException;
import java.util.Arrays;
import java.util.List;

import czsem.gate.plugins.TectoMTOnlineAnalyser.TectMTServerConnection;
import junit.framework.TestCase;

public class TectoMTOnlineAnalyserTest extends TestCase
{
	public static List<String> getTempBlocks() {
		String [] blocks =
		{
				"SEnglishW_to_SEnglishM::Sentence_segmentation",
				"SEnglishW_to_SEnglishM::Tokenization"
		};
		
		return Arrays.asList(blocks);
	}

	
	public void testRunTerminate() throws IOException, InterruptedException, URISyntaxException
	{
		TectoMTOnlineAnalyser ta = new TectoMTOnlineAnalyser();
		
		assertFalse(ta.isServerRunning());
		
		ta.setLoadScenarioFromFile(false);
		ta.setBlocks(getTempBlocks());

		ta.startTMTAnalysisServer();
//		Thread.sleep(2000);
		assertTrue(ta.isServerRunning());
		
		TectMTServerConnection con = new TectMTServerConnection(8080);
		
/*
		con.analyseFile("czsem_GATE_plugins/TmT_serializations/1032.xml_0001A.tmt~");
		con.analyseFile("czsem_GATE_plugins/TmT_serializations/10784.xml_00025.tmt~");
		con.analyseFile("czsem_GATE_plugins/TmT_serializations/9809.xml_00262.tmt");
*/
		con.terminate();
		Thread.sleep(100);
		assertFalse(ta.isServerRunning());

	}

}
