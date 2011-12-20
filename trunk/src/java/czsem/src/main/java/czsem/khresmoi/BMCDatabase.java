package czsem.khresmoi;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.marc4j.MarcReader;
import org.marc4j.MarcStreamReader;
import org.marc4j.marc.Record;
import org.mindswap.pellet.utils.MultiValueMap;

import czsem.utils.MultiSet;

public class BMCDatabase {
	
	private List<BMCEntry> entries;
	private MultiValueMap<String, BMCEntry> url_index;
	private Map<String, BMCEntry> bmcid_index;
		
	public static class BMCEntry implements Serializable
	{
		private static final long serialVersionUID = -7293606139409615635L;
		private String bmcID;
		private String url;
		private List<String> meshIDs;
		private String title;
		private String lang;
		private String loc;
		
		
		public BMCEntry(Record record)
		{			
			meshIDs = UnimarcBMC.readFields(record, "606", '0', '3');
//			meshArticleTypeIDs = readFields(record, "606", ' ', '3');
//			meshTreeNodes = readFields(record, "686", null, 'a');
//			meshTerms = readFields(record, "606", null, 'a');
			
//			101 0 $acze
//			102   $aCZ
			
			lang = UnimarcBMC.readBMCLang(record);				
			loc = UnimarcBMC.readBMCLoc(record);				
			
			

			
			title = UnimarcBMC.readBMCArticleName(record);
			bmcID = UnimarcBMC.readBMCID(record);
			url = UnimarcBMC.readURLStr(record);						
		}
	}

	public static void main(String[] args) throws IOException, ClassNotFoundException {
		System.err.println("load");
		BMCDatabase db = new BMCDatabase();
		//db.parseMarcIsoFile("c:/data/Khresmoi/BMC/bmc-2011-01.iso");
		db.deserializeFromFile("bmcDB.ser");
		System.err.println("test");
		db.test();
		System.err.println("save");
		db.serializeToFile("bmcDB.ser");
		System.err.println("end");
	}

	public void test() {
		testMultiURLs();
		testLang();
	}

	public void testLang() {
		MultiSet<String> lang_set = new MultiSet<String>();
		MultiSet<String> loc_set = new MultiSet<String>();
		for (BMCEntry e: entries)
		{
			lang_set.add(e.lang);			
			loc_set.add(e.loc);			
		}
		
		System.err.println(lang_set.toFormatedString("\n"));
		System.err.println(loc_set.toFormatedString("\n"));
	}

	public void testMultiURLs() {
		for (String url : url_index.keySet())
		{
			Set<BMCEntry> vals = url_index.get(url);
			if (vals.size() != 1)
			{
				System.err.format("%4d  %s\n", vals.size(), url);
			}
		}	
	}

	public void serializeToFile(String file_name) throws FileNotFoundException, IOException {
		ObjectOutputStream out = new ObjectOutputStream(new BufferedOutputStream(new FileOutputStream(file_name)));
		out.writeObject(entries);
		out.close();		
	}

	@SuppressWarnings("unchecked")
	public void deserializeFromFile(String file_name) throws FileNotFoundException, IOException, ClassNotFoundException {
		ObjectInputStream in = new ObjectInputStream(new BufferedInputStream(new FileInputStream(file_name)));
		entries = (List<BMCEntry>) in.readObject();
		in.close();	
		
		buildIndexes();
	}

	public void parseMarcIsoFile(String file_name) throws FileNotFoundException {
		entries = new ArrayList<BMCDatabase.BMCEntry>();
		
		InputStream in = new FileInputStream(file_name);
		MarcReader reader = new MarcStreamReader(in, "UTF-8");

		int urls = 0;
		int records = 0;
		while (reader.hasNext())
		{
			Record record = reader.next();
						
			String urlStr = UnimarcBMC.readURLStr(record);
			if (urlStr != null)
			{
				urls++;
				addEntry(record);
			}
			
			records++;
			
			if (records % 50000 == 0)
			{
				System.err.format("recs: %d  urls: %d\n", records, urls);
			}
			
			
//			if (urls> 20) break;
		}
		
		buildIndexes();
	}

	protected void addEntry(Record record) {
		BMCEntry e = new BMCEntry(record);
		entries.add(e);		
	}
	
	
	protected void buildIndexes()
	{
		url_index = new MultiValueMap<String, BMCEntry>(entries.size());
		bmcid_index = new HashMap<String, BMCDatabase.BMCEntry>(entries.size());
		for (BMCEntry e : entries)
		{
			url_index.add(e.url, e);
			bmcid_index.put(e.bmcID, e);			
		}
		
	}


}