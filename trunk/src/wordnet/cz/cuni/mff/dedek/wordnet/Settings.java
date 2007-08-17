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

/**
 * @author dedek
 *
 */
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
