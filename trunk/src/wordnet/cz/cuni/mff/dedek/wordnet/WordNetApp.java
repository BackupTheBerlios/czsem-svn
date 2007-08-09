/**
 * 
 */
package cz.cuni.mff.dedek.wordnet;

import java.io.IOException;
import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;

import javax.xml.parsers.ParserConfigurationException;

import org.json.JSONException;


/**
 * @author dedej1am
 *
 */
public class WordNetApp
{
	private static char Key = '*'; 
	private static String UserName = "jdedek"; 
	private static String Password = "NX_BKA";
	private static String ServerAddress = "https://apollo.fi.muni.cz:9001";
	private static String DictionaryCode = "wncz";

	/**
	 * @param args
	 */
	public static void main(String[] args)
	{
		
		try {
			WordNetConnection connection1 = new WordNetConnection(UserName, xorCript(Password, Key), ServerAddress, DictionaryCode);
			
//			connection1.init();
//			connection1.query("hasiè");
//			connection1.loadSynset("ENG20-09444162-n");
//			connection1.loadSebtree("ENG20-09444162-n");
			connection1.saveSebtree("ENG20-09444162-n", "subtree1.xml");
			
			
		} catch (KeyManagementException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ParserConfigurationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
		
		System.out.println("application quit");
				

	}
	
	/**
	 * Utility presdure for simle password encoding
	 * @param msg source string
	 * @param key key used for encoding
	 * @return encoded string
	 */
	private static char [] xorCript(String msg, char key)
	{
		char [] chars = msg.toCharArray();
		
		for (int a=0; a< chars.length; a++)
		{
			chars[a] = (char) (chars[a] ^ key); 

		}
		
		return chars;		
	}

}

