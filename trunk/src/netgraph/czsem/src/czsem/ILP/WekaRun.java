package czsem.ILP;

import java.io.IOException;

public class WekaRun
{

	public static void main(String[] args) throws IOException
	{
		String [] cmdarray = 
		{
				"java",
				"-classpath",
				"C:\\Program Files\\Weka-3-6\\weka.jar;C:\\Program Files\\Weka-3-6\\",
				"weka.gui.GUIChooser",
		};
		
		Runtime.getRuntime().exec(cmdarray);
		//java -classpath "./weka.jar;." weka.gui.GUIChooser
	}

}
