/**
 * 
 */
package cz.cuni.mff.dedek.wordnet;

import javax.swing.JDialog;

/**
 * @author dedek
 *
 */
public class SettingsDialog extends JDialog
{
	private Settings settings;
	
	public SettingsDialog(String SettingsFile)
	{
		//settings = Settings.load(SettingsFile);		
	}

}

/*
//Create and set up the window.
JFrame frame = new JFrame("DialogDemo");
frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

//Create and set up the content pane.
DialogDemo newContentPane = new DialogDemo(frame);
newContentPane.setOpaque(true); //content panes must be opaque
frame.setContentPane(newContentPane);

//Display the window.
frame.pack();
frame.setVisible(true);
*/

