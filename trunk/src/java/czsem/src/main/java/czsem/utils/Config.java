package czsem.utils;

import gate.Gate;

import java.beans.XMLDecoder;
import java.beans.XMLEncoder;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;


public class Config
{
	private static Config config = null;
	private static final String config_filename = "czsem_config.xml";
	public static ClassLoader classLoader = null; 
	
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
				System.err.println(new File(".").getAbsolutePath());
				e.printStackTrace();
			}
		return config;
	}
	
	private String wekaJarPath;
	private String alephPath;
	private String prologPath;
	private String ilpSerialProjestsPath;
	private String myClassPath;
	private String tmtRoot;
	private String tredRoot;
	private String gateHome;
	private String tmtSerializationDirectory;

		
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
		setTmtRoot("C:\\workspace\\tectomt");
		setTredRoot("C:\\tred");
		setGateHome("C:\\Program Files\\GATE-5.2.1");
		setTmtSerializationDirectory("C:\\workspace\\czsem\\src\\java\\czsem\\czsem_GATE_plugins\\TmT_serializations");
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
		XMLDecoder decoder = new XMLDecoder(os, null, null, classLoader);
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
		return ilpSerialProjestsPath;
	}

	public void setIlpProjestsPath(String ilpProjestsPath) {
		this.ilpSerialProjestsPath = ilpProjestsPath;
	}

	public String getMyClassPath() {
		return myClassPath;
	}

	public void setMyClassPath(String myClassPath) {
		this.myClassPath = myClassPath;
	}
	
	public String getTmtRoot() {
		return tmtRoot;
	}

	public void setTmtRoot(String tmtRoot) {
		this.tmtRoot = tmtRoot;
	}

	public String getTredRoot() {
		return tredRoot;
	}

	public void setTredRoot(String tredRoot) {
		this.tredRoot = tredRoot;
	}


	public void setGateHome(String gateHome) {
		this.gateHome = gateHome;
	}


	public String getGateHome() {
		return gateHome;
	}

	public static void setGateHome()
	{		
		Gate.setGateHome(new File(getConfig().getGateHome()));
	}


	public void setTmtSerializationDirectory(String tmtSerializationDirectory) {
		this.tmtSerializationDirectory = tmtSerializationDirectory;
	}


	public URL getTmtSerializationDirectoryURL() throws MalformedURLException
	{
		return new File(getTmtSerializationDirectory()).toURI().toURL();
	}

	public String getTmtSerializationDirectory() {
		return tmtSerializationDirectory;
	}

}
