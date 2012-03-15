package cuni.khresmoi.bmc;

import gate.Annotation;
import gate.AnnotationSet;
import gate.Document;
import gate.Factory;
import gate.FeatureMap;
import gate.Gate;
import gate.util.GateException;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URISyntaxException;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.marc4j.MarcReader;
import org.marc4j.MarcStreamReader;
import org.marc4j.marc.Record;

import cuni.khresmoi.KhresmoiConfig;
import czsem.utils.Config;
import czsem.utils.MultiSet;

public class FileInfo {

	public static void main(String[] args) throws URISyntaxException, IOException, GateException
	{
		Locale.setDefault(Locale.ENGLISH);
		
		Config.getConfig().setGateHome();
		Gate.init();
		
		KhresmoiConfig c = KhresmoiConfig.getConfig();
		
		String inputdir = c.getInputDirFileInfo();
		File dir = new File(inputdir );
		File[] files = dir.listFiles();
		
		
		int files_count = 0;
		
		BMCGateCorpusBuider b = new BMCGateCorpusBuider("BMC", true, inputdir);

		InputStream in = new FileInputStream(c.getBmcIsoFilePath());
		MarcReader reader = new MarcStreamReader(in, "UTF-8");
		
		int foud = 0;
		
		Map<String, List<String>> file_terms = new HashMap<String, List<String>>();  
		Map<String, String> term_names = new HashMap<String, String>();  
		
		int records = 0;
		int urls = 0;
		
		while (reader.hasNext())
		{
			Record record = reader.next();

			records++;
			if (UnimarcBMC.readURLStr(record) != null) urls++;
			
			String bid = UnimarcBMC.readBMCID(record);
			if (b.documentExistsInTragetDirectory(bid))
			{
				foud++;
				System.err.println(bid);
				List<String> ids = UnimarcBMC.readMeshIDs(record);
				UnimarcBMC.updateTermNames(term_names, record);
				file_terms.put(bid, ids);
				
				for (String id : ids)
				{
					System.err.println(id);
				}
			}
			
			if (foud >= 5) break;			
		}
		
		//System.err.format("records: %d   urls: %d\n", records, urls);


		
	
		for (File f : files)
		{
			System.err.println(String.format("--------------------- file: %s ---------------------", f.getName()));
			if (files_count++ < 0) continue;
			Document doc = Factory.newDocument(f.toURI().toURL(), "utf8");

			String bmcid = doc.getFeatures().get("bmcID").toString();
			
			printStat(doc, file_terms.get(bmcid), term_names);
						
												
			Factory.deleteResource(doc);
			
		}


	}

	private static void printStat(Document doc, List<String> bmc_terms, Map<String, String> term_names)
	{
		FeatureMap f = doc.getFeatures();
		
		printF(f, "bmcID");
		System.err.println("bmc online record: http://www.medvik.cz/link/" + f.get("bmcID")); 
		printF(f, "gate.SourceURL");
		printF(f, "MimeType");				

		
		AnnotationSet as = doc.getAnnotations("mimir").get("MeshTerm");
		
		MultiSet<String> ans = new MultiSet<String>();
		for (Annotation a : as)
		{
			FeatureMap af = a.getFeatures();			
			ans.add(String.format("%s - %s", af.get("meshID"), af.get("czTerm")));								
		}

		
		System.err.println("---BMČ terms---");

		for (String s : bmc_terms)
		{
			String key = String.format("%s - %s", s, term_names.get(s));
			System.err.format("found: %2d | %s\n", ans.get(key), key);				
		}

		System.err.println("---discovered terms---"); 
		
		System.err.print(ans.toFormatedString("\n"));
				
	}

	private static void printF(FeatureMap f, String f_name)
	{
		System.err.print(f_name);
		System.err.print(": ");
		System.err.println(f.get(f_name));
		
	}

}
