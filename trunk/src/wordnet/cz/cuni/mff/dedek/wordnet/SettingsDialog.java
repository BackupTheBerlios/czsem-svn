/**
 * 
 */
package cz.cuni.mff.dedek.wordnet;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.*;
import java.awt.*;


/**
 * @author dedek
 *
 */
public class SettingsDialog extends JDialog implements ActionListener
{
	private static final long serialVersionUID = 1L;
	private Settings settings;
	private String SettingsFile;
	
	private JTextField txAddress;
	private JTextField txUser;
	private JPasswordField txPassword;
	private JTextField txDictionary;
	
	private JButton setButton;
	private JButton cancelButton;
	
	
	
	public SettingsDialog(String _SettingsFile)
	{		
		setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
		SettingsFile = _SettingsFile;
		
		//loads settings
		try {
			settings = Settings.load(SettingsFile);
		} catch (Exception e1) {
			settings = new Settings();
		}
		
		initGUI();
	}
	
	private void initGUI()
	{
		setTitle("WordNet connection settings");
		
		Container cp = getContentPane();
		cp.setLayout(new GridLayout(0, 2, 10, 10));


		
        //Server address
        JLabel lbAddress = new JLabel("Server address: ");
        lbAddress.setHorizontalAlignment(SwingConstants.RIGHT);
        cp.add(lbAddress);

		txAddress = new JTextField(settings.getServerAddress());
		cp.add(txAddress);

        //User name
        JLabel lbUser = new JLabel("User name: ");
        lbUser.setHorizontalAlignment(SwingConstants.RIGHT);
        cp.add(lbUser);

		txUser = new JTextField(settings.getUserName());
		cp.add(txUser);

        //Password
        JLabel lbPassword = new JLabel("Password: ");
        lbPassword.setHorizontalAlignment(SwingConstants.RIGHT);
        cp.add(lbPassword);

		txPassword = new JPasswordField(settings.getPasswordString());
		cp.add(txPassword);

        //Dictionary code
        JLabel lbDictionary = new JLabel("Dictionary code: ");
        lbDictionary.setHorizontalAlignment(SwingConstants.RIGHT);
        cp.add(lbDictionary);

		txDictionary = new JTextField(settings.getDictionaryCode());
		cp.add(txDictionary);

		//Create and initialize the buttons.
        setButton = new JButton("Set");
        setButton.setActionCommand("Set");
        setButton.addActionListener(this);
        getRootPane().setDefaultButton(setButton);
        cp.add(setButton);

        cancelButton = new JButton("Cancel");
        cancelButton.addActionListener(this);
        cp.add(cancelButton);
                
        pack();

        //center in screen
        Dimension dim = getToolkit().getScreenSize();
        Rectangle abounds = getBounds();
        setLocation((dim.width - abounds.width) / 2,
            (dim.height - abounds.height) / 2);

	}

	@Override
	public void actionPerformed(ActionEvent arg0) {
		if (arg0.getSource() == cancelButton)
		{
			this.dispose();
		}
		
		if (arg0.getSource() == setButton)
		{
			settings.setDictionaryCode(txDictionary.getText());
			settings.setPassword(txPassword.getPassword());
			settings.setServerAddress(txAddress.getText());
			settings.setUserName(txUser.getText());
			
			try
			{
				settings.save(SettingsFile);
			} 
			catch (Exception e)
			{
				JOptionPane.showMessageDialog(this,
					e.getLocalizedMessage() +
					"\nFile name: " + SettingsFile,
					"Failed to save settings",
					JOptionPane.ERROR_MESSAGE);
			}

			this.dispose();
		}
		
		
	}
}
