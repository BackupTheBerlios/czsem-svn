/**
 * 
 */
package cz.cuni.mff.dedek.wordnet;

import java.net.*;
import java.io.*;

/**
 * @author dedej1am
 *
 */
public class FirstApp
{

	/**
	 * @param args
	 */
	public static void main(String[] args)
	{
		// TODO Auto-generated method stub
		
		try
		{
			URL url = new URL("https://apollo.fi.muni.cz:9001/doc?action=init");
			BufferedReader br = new BufferedReader (new InputStreamReader(url.openStream()));
			
			String line;
			while ((line = br.readLine()) != null)
			{
				System.out.println(line);			
			}

			br.close();

		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());			
		}

		
		
		System.out.println("Cus :-)");
				

	}

}
