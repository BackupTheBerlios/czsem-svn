package czsem.ILP;

import java.io.IOException;
import java.io.InputStreamReader;

import czsem.ILP.ILPExec.ReaderThread;
import czsem.utils.Config;

public class WekaRun
{

	public static void main(String[] args) throws IOException, InterruptedException
	{
		Config.loadConfig();
		
		String [] cmdarray =
		{
				"java",
				"-classpath",
				Config.getConfig().getWekaJarPath() + ":" +	Config.getConfig().getMyClassPath(),
				"weka.gui.GUIChooser"
		};		
		//java -classpath "./weka.jar;." weka.gui.GUIChooser
		Process proc = Runtime.getRuntime().exec(cmdarray);
		
		ReaderThread cin_reader_thread = new ReaderThread(new InputStreamReader(proc.getInputStream()), System.out);
		ReaderThread err_reader_thread = new ReaderThread(new InputStreamReader(proc.getErrorStream()), System.err);

		cin_reader_thread.start();
		err_reader_thread.start();

//		BufferedReader is = new BufferedReader(new InputStreamReader(proc.getInputStream())); 
		
		proc.waitFor();
		
//		System.out.println(is.readLine());
	}

}
