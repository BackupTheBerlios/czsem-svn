package czsem.utils;

import java.beans.XMLDecoder;
import java.beans.XMLEncoder;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;


public class Config
{
	private static Config config = null;
	private static final String config_filename = "config.xml";
	
	public static void main(String[] args) throws IOException
	{
		Config ps = new Config();
		ps.setMyWinValues();
//		ps.setInstallDefaults();
		ps.saveToFile(config_filename);
		
/*
		Config ps2 = new Config();
		ps2 = loadFromFile("config1.xml");
*/				
	}

	
	public static void loadConfig() throws IOException
	{
		config = loadFromFile(config_filename);
	}
	
	public static Config getConfig()
	{
		if (config == null)
			try {
				loadConfig();
			} catch (IOException e) {
				e.printStackTrace();
			}
		return config;
	}
	
	public String wekaJarPath;
	public String alephPath;
	public String prologPath;
	public String ilpProjestsPath;
	public String myClassPath;
		
	public void setInstallDefaults()
	{
		setAlephPath("$aleph");
		setIlpProjestsPath("$projects/ILP_serial_projects");
		setPrologPath("$prolog");
		setWekaJarPath("$weka");
		setMyClassPath("$INSTALL_PATH/FuzzyILP.jar");
	}

	public void setMyWinValues()
	{
		setAlephPath("C:\\Program Files\\aleph\\aleph.pl");
		setIlpProjestsPath("C:\\workspace\\czsem\\src\\netgraph\\czsem\\ILP_serial_projects");
		setPrologPath("C:\\Program Files\\Yap\\bin\\yap.exe");
		setWekaJarPath("C:\\Program Files\\Weka-3-6\\weka.jar");
		setMyClassPath("C:\\workspace\\czsem\\src\\netgraph\\czsem\\bin");
	}

	public void saveToFile(String filename) throws IOException
	{
		// Create output stream.
		  FileOutputStream fos = new FileOutputStream(filename);

		  // Create XML encoder.
		  XMLEncoder xenc = new XMLEncoder(fos);

		  // Write object.
		  xenc.writeObject(this);
		  xenc.flush();		  
		  xenc.close();
		  fos.close();
	}

	public static Config loadFromFile(String filename) throws IOException
	{
		  FileInputStream os = new FileInputStream(filename);
		  XMLDecoder decoder = new XMLDecoder(os);
		  Config c = (Config)decoder.readObject();
		  decoder.close();
		  os.close();
		  return c;
	}
	
	public String getWekaJarPath() {
		return wekaJarPath;
	}

	public void setWekaJarPath(String wekaJarPath) {
		this.wekaJarPath = wekaJarPath;
	}

	public String getAlephPath() {
		return alephPath;
	}

	public void setAlephPath(String alephPath) {
		this.alephPath = alephPath;
	}

	public String getPrologPath() {
		return prologPath;
	}

	public void setPrologPath(String prologPath) {
		this.prologPath = prologPath;
	}

	public String getIlpProjestsPath() {
		return ilpProjestsPath;
	}

	public void setIlpProjestsPath(String ilpProjestsPath) {
		this.ilpProjestsPath = ilpProjestsPath;
	}

	public String getMyClassPath() {
		return myClassPath;
	}

	public void setMyClassPath(String myClassPath) {
		this.myClassPath = myClassPath;
	}
}
