package czsem.ILP;

import java.io.IOException;

import czsem.utils.Config;
import czsem.utils.ProcessExec;

public class WekaRun
{

	public static void main(String[] args) throws IOException, InterruptedException
	{
		System.out.println(  );

		
		Config.loadConfig();
		
		String [] cmdarray =
		{
				"java",
				"-classpath",
				Config.getConfig().getWekaJarPath() + 
					System.getProperty( "path.separator" ) +
					Config.getConfig().getMyClassPath(),
				"weka.gui.GUIChooser"
		};		
		//java -classpath "./weka.jar;." weka.gui.GUIChooser
		ProcessExec proc = new ProcessExec();
		proc.exec(cmdarray);
		proc.startReaderThreads();
					
		
//		BufferedReader is = new BufferedReader(new InputStreamReader(proc.getInputStream())); 
		
		proc.waitFor();
		
//		System.out.println(is.readLine());
	}

}
