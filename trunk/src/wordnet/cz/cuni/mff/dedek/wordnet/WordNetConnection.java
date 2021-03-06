/**
 * 
 */
package cz.cuni.mff.dedek.wordnet;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.net.Authenticator;
import java.net.PasswordAuthentication;
import java.net.URL;
import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;
import java.security.cert.X509Certificate;
import java.util.Iterator;

import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.X509TrustManager;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.xpath.XPathExpressionException;

import org.json.*;
import org.w3c.dom.Element;

/**
 * @author dedej1am
 *
 */
public class WordNetConnection extends Authenticator
{
	private String user_name; 
	private char[] password;
	private String server_address;
	private String dictionary_code;
	
	
	/**
	 * Standard constructor
	 * @param _user_name
	 * @param _password
	 * @param _server_address full address including port number, example: https://apollo.fi.muni.cz:9001 
	 * @param _dictionary_code exmaple: wncze1
	 * @throws NoSuchAlgorithmException 
	 * @throws KeyManagementException 
	 */
	public WordNetConnection(String _user_name, char[] _password, String _server_address, String _dictionary_code) throws KeyManagementException, NoSuchAlgorithmException
	{
		user_name = _user_name; 
		password = _password;
		server_address = _server_address;
		dictionary_code = _dictionary_code;
		
		setupConnection();
	}
	
	private String getServerAddress()
	{
		return server_address;		
	}
	/**
	 * @return "servername/dictionary_code"
	 */
	private String getDictionaryAddress()
	{
		return server_address + "/" + dictionary_code;		
	}
	
	/**
	 * SSL initialization
	 * @throws NoSuchAlgorithmException
	 * @throws KeyManagementException
	 */
	private void setupConnection() throws NoSuchAlgorithmException, KeyManagementException
	{
        SSLContext sslctx = SSLContext.getInstance("SSL");
        sslctx.init(null, new X509TrustManager[] { new  MyTrustManager() }, null);

        HttpsURLConnection.setDefaultSSLSocketFactory(sslctx.getSocketFactory());
        Authenticator.setDefault(this);		
	}
	
	/**
	 * Tries to get basic dictionary information. Calls the Request: servername/doc?action=init
	 * @throws IOException
	 * @throws JSONException
	 */
	public void init() throws IOException, JSONException
	{
        
        URL url = new URL(getServerAddress() + "/doc?action=init");
        BufferedReader br = new BufferedReader (new InputStreamReader(url.openStream()));
             		
		String line;
		while ((line = br.readLine()) != null)
		{
			System.out.println(line);			

			JSONObject jo = new JSONObject(line);
			System.out.println();
			System.out.println("Dictionries:");
			Iterator key = jo.getJSONObject("slovniky").keys();
			while (key.hasNext())
			{
				System.out.println(
						jo.getJSONObject("slovniky").getJSONObject((String) key.next()).getString("dict"));
            }
		}

		br.close();
	}
	
	public void query(String search_query) throws IOException, JSONException
	{
		String utf8_query = strToUtf8(search_query);
        URL url = new URL(getDictionaryAddress() + "?action=queryList&word=" + utf8_query);
        BufferedReader br = new BufferedReader (new InputStreamReader(url.openStream(), "UTF8"));
             		
		String line;
		while ((line = br.readLine()) != null)
		{
			System.out.println(line);			
			JSONArray ja = new JSONArray(line);
			
			for (int a=0; a<ja.length(); a++)
			{
				System.out.println("value: " + ja.getJSONObject(a).getString("value"));
				System.out.println("label: " + ja.getJSONObject(a).getString("label"));				
			}
		}

		br.close();
		
	}
	
	public void loadSynset(String synsetID) throws IOException, JSONException
	{
        URL url = new URL(getDictionaryAddress() + "?action=runQuery&query=" + synsetID + "&outtype=plain");
        BufferedReader br = new BufferedReader (new InputStreamReader(url.openStream(), "UTF8"));
             		
		String line;
		while ((line = br.readLine()) != null)
		{
			System.out.println(line);

			JSONTokener jt = new JSONTokener(line);
			String xml_str =  jt.nextValue().toString();

			System.out.println("xml:");
			System.out.println(xml_str);
			
			OutputStreamWriter w = new OutputStreamWriter(new FileOutputStream(new File(synsetID + ".xml")), "UTF-8");
			w.write("<?xml version=\"1.0\"?>\n");
			w.write(xml_str);
			w.close();
		}

		br.close();		
	}

	
	public void saveSebtree(String synsetID, String file_name) throws IOException, JSONException, ParserConfigurationException
	{
		SubtreeXMLWriter xml_writer = new SubtreeXMLWriter();
		saveSebtree(synsetID, xml_writer.getRootElement());
		xml_writer.seveToFile(file_name);
	}

	public void saveSebtree(String synsetID, Element dest) throws IOException, JSONException, ParserConfigurationException
	{
        URL url = new URL(getDictionaryAddress() + "?action=subtree&query=" + synsetID);
        BufferedReader br = new BufferedReader (new InputStreamReader(url.openStream(), "UTF8"));
             		
		String line;
		while ((line = br.readLine()) != null)
		{
			System.out.println(line);			
			
			JSONArray ja = new JSONArray(line);
						
			for (int a=0; a<ja.length(); a++)
			{				
				JSONObject jo = ja.getJSONObject(a);
			
				System.out.println("val: " + jo.getString("val"));
				System.out.println("id: " + jo.getString("id"));
				System.out.println("parent: " + jo.getString("parent"));
				
				System.out.println();				
				saveSebtree(jo.getString("id"),
						SubtreeXMLWriter.appendNode(jo.getString("val"), jo.getString("id"), dest));				
			}
		}

		br.close();				
	}
	
	public void loadSebtree(String synsetID) throws IOException, JSONException
	{
        URL url = new URL(getDictionaryAddress() + "?action=subtree&query=" + synsetID);
        BufferedReader br = new BufferedReader (new InputStreamReader(url.openStream(), "UTF8"));
             		
		String line;
		while ((line = br.readLine()) != null)
		{
			System.out.println(line);			
			
			JSONArray ja = new JSONArray(line);
						
			for (int a=0; a<ja.length(); a++)
			{				
				JSONObject jo = ja.getJSONObject(a);
			
				System.out.println("val: " + jo.getString("val"));
				System.out.println("id: " + jo.getString("id"));
				System.out.println("parent: " + jo.getString("parent"));

				System.out.println();				
				loadSebtree(jo.getString("id"));				
			}
		}

		br.close();		
	}
	
	public void findIntersection(String synsetID1, String synsetID2) throws ParserConfigurationException, IOException, JSONException, XPathExpressionException
	{
		SubtreeXMLWriter xml_writer1 = new SubtreeXMLWriter();
		SubtreeXMLWriter xml_writer2 = new SubtreeXMLWriter();

		saveSebtree(synsetID1, xml_writer1.getRootElement());
		saveSebtree(synsetID2, xml_writer2.getRootElement());
		
		xml_writer1.seveToFile(synsetID1+"_subtree.xml");
		xml_writer2.seveToFile(synsetID2+"_subtree.xml");

		SubtreeXMLIntersection.findIntersection(xml_writer1.getRootElement(), xml_writer2.getRootElement());
	}
	
	
	
	
	/**
	 * converts to utf8, example: hasi� -> hasi%E8
	 * @param orig - original string 
	 * @return orig converted to utf8 
	 */
	private static String strToUtf8(String orig)
	{
		try
		{
			byte [] arr = orig.getBytes("UTF-8");

			String ret = "";

			for (int a=0; a<arr.length; a++)
			{
				ret += "%" + Integer.toHexString(arr[a] & 0xFF);
			}

			return ret;

		} 
		catch (UnsupportedEncodingException e)
		{
			return orig;
		}		
	}
	
    /**
     * SSL authentication / authorization
     */
	protected PasswordAuthentication getPasswordAuthentication()
    {
       return new PasswordAuthentication(user_name, password);
    }
}




/**
 * service class for SSL connection
 * @author dedej1am
 *
 */
class MyTrustManager implements X509TrustManager
{
     public void checkClientTrusted(X509Certificate[] chain, String authType)
     {}
     
     public void checkServerTrusted(X509Certificate[] chain, String authType)
     {}
     
     public X509Certificate[] getAcceptedIssuers()
     {
         return null;
     }

}
