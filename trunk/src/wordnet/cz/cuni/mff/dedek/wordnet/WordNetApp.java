/**
 * 
 */
package cz.cuni.mff.dedek.wordnet;

import java.io.IOException;
import java.net.ProtocolException;
import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;

import javax.swing.JFrame;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.xpath.XPathExpressionException;

import org.json.JSONException;



/**
 * @author dedej1am
 *
 */
public class WordNetApp
{
	private static final String SettingsFile = "settings.dat";
	
	private static void configureSettings(Settings s)
	{
		javax.swing.SwingUtilities.invokeLater(new Runnable() {
			public void run()
			{
				SettingsDialog dlg1 = new SettingsDialog(SettingsFile);
				dlg1.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
				dlg1.setVisible(true);
			}
		});	 
	}

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
		
		configureSettings(sett1);
		
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

