/**
 * 
 */
package cz.cuni.mff.dedek.wordnet;

import java.net.*;
import java.io.*;
import java.security.*;
import java.security.cert.*;
import javax.net.ssl.*;


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
        
		
		try
		{
            SSLContext sslctx = SSLContext.getInstance("SSL");
            sslctx.init(null, new X509TrustManager[] { new  MyTrustManager() }, null);

            HttpsURLConnection.setDefaultSSLSocketFactory(sslctx.getSocketFactory());
            // HttpsURLConnection.setDefaultHostnameVerifier(new  MyHostnameVerifier());
            Authenticator.setDefault(new MyAuthenticator());
            
            URL url = new URL("https://apollo.fi.muni.cz:9001/doc?action=init");
            HttpsURLConnection con = (HttpsURLConnection)  url.openConnection();
            if (con.getResponseCode() == HttpsURLConnection.HTTP_OK)
            {
    			BufferedReader br = new BufferedReader (new InputStreamReader(con.getInputStream()));
    			
    			String line;
    			while ((line = br.readLine()) != null)
    			{
    				System.out.println(line);			
    			}

    			br.close();

/*    			
               InputStream is = con.getInputStream();
               OutputStream os = new FileOutputStream("C:\\z.z");
               byte[] b = new byte[1000];
               int n;
               while ((n = is.read(b)) >= 0) {
                  os.write(b, 0, n);
               }
               os.close();
               is.close();
*/
            }
            con.disconnect();

         } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
         } catch (KeyManagementException e) {
            e.printStackTrace();
         } catch (MalformedURLException e) {
            e.printStackTrace();
         } catch (FileNotFoundException e) {
            e.printStackTrace();
         } catch (IOException e) {
            e.printStackTrace();
         }

/*		
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
*/
		
		
		System.out.println("Cus :-)");
				

	}
}

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

//class MyHostnameVerifier implements HostnameVerifier {
//   public boolean verify(String urlHostName, SSLSession session) {
//      return true;
//   }
//}

class MyAuthenticator extends Authenticator
{
	private static char Key = '*'; 
	private static String UserName = "jdedek"; 
	private static String Password = "nevim"; 
	
	public static char [] xorCript(String msg, char key)
	{
		char [] chars = msg.toCharArray();
		
		for (int a=0; a< chars.length; a++)
		{
			chars[a] = (char) (chars[a] ^ key); 

		}

		
		System.err.print("pass: ");
		for (int a=0; a< chars.length; a++)
		{
			System.err.print(chars[a]);
		}
		System.err.println();
		
		return chars;		
	}
	
    protected PasswordAuthentication getPasswordAuthentication()
    {
       return new PasswordAuthentication(UserName, xorCript(Password, Key));
    }
}
