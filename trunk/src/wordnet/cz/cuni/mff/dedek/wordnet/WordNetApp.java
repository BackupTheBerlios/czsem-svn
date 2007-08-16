/**
 * 
 */
package cz.cuni.mff.dedek.wordnet;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.Serializable;
import java.net.ProtocolException;
import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;

import javax.xml.parsers.ParserConfigurationException;
import javax.xml.xpath.XPathExpressionException;

import org.json.JSONException;


class Settings implements Serializable 
{
	private static final long serialVersionUID = 1L;
	private static final char Key = '*'; 
	
	private String UserName = "jdedek"; 
	private String Password = ""; //please insert right password
	private String ServerAddress = "https://apollo.fi.muni.cz:9001";
	private String DictionaryCode = "wncz";
	
	public String getUserName(){ return UserName;}
	public char [] getPassword() {return xorCript(Password, Key);}
	public String getServerAddress(){ return ServerAddress;}
	public String getDictionaryCode(){ return DictionaryCode;}
	
	public void save(String filename) throws FileNotFoundException, IOException
	{
		ObjectOutputStream os = new ObjectOutputStream(new FileOutputStream(filename));
		os.writeObject(this); // saves settings
		os.close();		
	}

	public static Settings load(String filename) throws FileNotFoundException, IOException, ClassNotFoundException
	{
		ObjectInputStream is = new ObjectInputStream(new FileInputStream(filename));
		return (Settings) is.readObject();
	}
	
	/**
	 * Utility procedure for simple password encoding
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

/**
 * @author dedej1am
 *
 */
public class WordNetApp
{
	private static String SettingsFile = "settings.dat";

	/**
	 * @param args
	 */
	public static void main(String[] args)
	{
		Settings sett1;
		try {
			sett1 = Settings.load(SettingsFile);
		} catch (Exception e1) {
			sett1 = new Settings();
//			sett1.save(SettingsFile);
		}
		
		try {
			
			WordNetConnection connection1 = new WordNetConnection(
					sett1.getUserName(),
					sett1.getPassword(),
					sett1.getServerAddress(),
					sett1.getDictionaryCode());
			
//			connection1.init();
//			connection1.query("autobus");
			connection1.loadSynset("ENG20-09444162-n"); //hasiè
//			connection1.loadSynset("ENG20-03553164-n"); //kamion
//			connection1.loadSynset("ENG20-02820094-n"); //autobus
//			connection1.loadSebtree("ENG20-09444162-n");
//			connection1.saveSebtree("ENG20-09444162-n", "subtree1.xml");

			if (false)
				connection1.findIntersection("ENG20-03553164-n", "ENG20-02820094-n");
			
			
		} catch (ProtocolException e) {
			e.printStackTrace();			
			System.err.println("---------------------------------------------");
			System.err.println("error: ProtocolException");
			System.err.println(e.getLocalizedMessage());
			System.err.println("SSL authentication / authorization probably failed.");			
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
		} catch (XPathExpressionException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ParserConfigurationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
		
		System.out.println("application quit");
				

	}	
}

