package czsem.ILP;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URISyntaxException;

import czsem.gate.GateUtils;

import junit.framework.TestCase;

public class ILPExecTest extends TestCase
{
	public void testUtf8() throws IOException, URISyntaxException, InterruptedException
	{
		File file = GateUtils.URLToFile(getClass().getResource("/utf8test.yap"));
		
		ILPExec exec = new ILPExec(file.getParentFile(), "utf8test");
		exec.startILPProcess();
		exec.startNullReaderThreads();
//		exec.startStdoutReaderThreads();
		exec.setUtf8Encoding();
		exec.format("consult('%s').\n", file.getName());
		exec.writeString("open('prolog_uf8_test.txt', write, S), set_output(S), test(X), write(X), close(S).\n\n");
		exec.close();
		
		String out_file = file.getParent() + "/prolog_uf8_test.txt";
		BufferedReader read = 
			new BufferedReader(	new InputStreamReader(
					new FileInputStream(out_file) , "utf-8"));
		String ret = read.readLine();
		
		assertEquals("dědek Janěščřžýáíéúů", ret);
		new File(out_file).delete();		
	}

}
