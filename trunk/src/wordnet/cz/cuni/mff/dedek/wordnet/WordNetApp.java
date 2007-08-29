/**
 * 
 */
package cz.cuni.mff.dedek.wordnet;

import java.net.ProtocolException;



/**
 * Main class of the application
 * @author dedej1am
 */
public class WordNetApp
{
	private static final String SettingsFile = "settings.dat";
	
	/**
	 * Runs configuration dialog.
	 */
	private static void configureSettings()
	{
		javax.swing.SwingUtilities.invokeLater(new Runnable() {
			public void run()
			{
				SettingsDialog dlg1 = new SettingsDialog(SettingsFile);
				dlg1.setVisible(true);
			}
		});	 
	}
	
	private static void printUse()
	{
		System.out.println("WordNetApp: Application for WordNet query.");
		System.out.println("(c) Jan Dìdek 2007, http://czsem.berlios.de/");
		System.out.println("Parameters:");
		System.out.println("-c              Shows configuration dialog.");
		System.out.println("-info           Prints current account info.");
		System.out.println("-q query_word   Query WordNet for given word");
		System.out.println("-s synset_id    Saves given synset to the file synset_id.xml");
		System.out.println("-t synset_id    Saves subtree of given synset to the file synset_id_subtree.xml");
		System.out.println();		
		System.out.println("-i synset_id1 synset_id2");
		System.out.println("     Saves subtree of both synsets and prints their intersection.");
	}

	/**
	 * @param args
	 */
	public static void main(String[] args)
	{
		//print use
		if (args.length <= 0)
		{
			printUse();
			return;
		}
		
		//command configure
		if (args[0].equals("-c")) 
		{
			configureSettings();
			return;
		}
		
		//settings load
		Settings sett1;
		try {
			sett1 = Settings.load(SettingsFile);
		} catch (Exception e1) {
			sett1 = new Settings();
		}		
		
		try
		{							
			//make connection
			WordNetConnection connection1 = new WordNetConnection(
					sett1.getUserName(),
					sett1.getPassword(),
					sett1.getServerAddress(),
					sett1.getDictionaryCode());

			if (args[0].equals("-info"))
				connection1.init();
			else if ((args[0].equals("-q")) && (args.length >= 2))			
				connection1.query(args[1]);
			else if ((args[0].equals("-s")) && (args.length >= 2))						
				connection1.loadSynset(args[1]); 
			else if ((args[0].equals("-t")) && (args.length >= 2))						
				connection1.saveSebtree(args[1], args[1] + "_subtree.xml");
			else if ((args[0].equals("-i")) && (args.length >= 3))						
				connection1.findIntersection(args[1], args[2]);
			else printUse();

//			connection1.loadSynset("ENG20-09444162-n"); //hasiè
//			connection1.loadSynset("ENG20-03553164-n"); //kamion
//			connection1.loadSynset("ENG20-02820094-n"); //autobus
			
		}
		catch (ProtocolException e)
		{
			e.printStackTrace();			
			System.err.println("---------------------------------------------");
			System.err.println("error: ProtocolException");
			System.err.println(e.getLocalizedMessage());
			System.err.println("SSL authentication / authorization probably failed.");			
		}
		catch (Exception e)
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}	
}

