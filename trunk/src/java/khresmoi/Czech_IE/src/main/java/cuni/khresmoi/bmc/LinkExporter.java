package cuni.khresmoi.bmc;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.net.URISyntaxException;

import org.marc4j.MarcReader;
import org.marc4j.MarcStreamReader;
import org.marc4j.marc.Record;

import gate.Document;
import gate.Factory;
import gate.Gate;
import gate.creole.ResourceInstantiationException;
import gate.util.GateException;
import cuni.khresmoi.KhresmoiConfig;
import czsem.utils.Config;

public class LinkExporter {
	
	public static void exportLinksMarc(String output_filename) throws IOException
	{
		Writer out = 
			new OutputStreamWriter(
				new BufferedOutputStream(
						new FileOutputStream(output_filename)));
		
		InputStream in = new FileInputStream("c:/data/Khresmoi/BMC/bmc-2011-01.iso");
		MarcReader reader = new MarcStreamReader(in, "UTF-8");
		
		int records = 0;

		while (reader.hasNext())
		{
			Record record = reader.next();
			if (++records % 10000 == 0) System.err.println(records);

			String url = UnimarcBMC.readURLStr(record);
			String bmc_id = UnimarcBMC.readBMCID(record);
			if (url != null) 
			{
				
				writeLink(out, bmc_id, url);
			}
		}
		out.close();
	}
	
	public static void writeLink(Writer out, String bmc_id, String url) throws IOException
	{
		out.write(bmc_id);
		out.write('\t');
		out.write(url);
		out.write("\n");						
	}

	public static void exportLinksGateFilesDir(String input_dir_filename, String output_filename) throws IOException, ResourceInstantiationException
	{
		Writer out = 
			new OutputStreamWriter(
				new BufferedOutputStream(
						new FileOutputStream(output_filename)));
		
		File dir = new File(input_dir_filename);
		File[] files = dir.listFiles();
						
		int records = 0;

		for (File f : files)
		{
			if (++records % 10 == 0) System.err.println(records);

			Document doc = Factory.newDocument(f.toURI().toURL(), "utf8");

			String bmcid = doc.getFeatures().get("bmcID").toString();
			String url = doc.getFeatures().get("gate.SourceURL").toString();
			
			writeLink(out, bmcid, url);
																					
			Factory.deleteResource(doc);
			
		}
		
		out.close();
		
	}

	
	public static void main(String[] args) throws URISyntaxException, IOException, GateException
	{
		//exportLinksMarc("bmc_links_all.txt");
		/**/
		Config.getConfig().setGateHome();
		Gate.init();
		
		exportLinksGateFilesDir(KhresmoiConfig.getConfig().getInputDirLinkExport(), "bmc_links_filered.txt");
				
		/***/
		
	}

}
