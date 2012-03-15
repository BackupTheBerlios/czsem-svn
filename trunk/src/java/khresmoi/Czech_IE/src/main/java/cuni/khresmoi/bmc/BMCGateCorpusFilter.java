package cuni.khresmoi.bmc;

import gate.Document;
import gate.Factory;
import gate.Gate;
import gate.creole.ExecutionException;
import gate.creole.ResourceInstantiationException;
import gate.creole.gazetteer.DefaultGazetteer;
import gate.util.GateException;

import java.io.File;
import java.io.IOException;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

import org.apache.commons.io.FileUtils;

import cuni.khresmoi.KhresmoiConfig;
import cuni.khresmoi.bmc.BMCDatabase.BMCEntry;
import czsem.gate.GateUtils;
import czsem.gate.learning.PRSetup;
import czsem.utils.Config;

public class BMCGateCorpusFilter
{
	private File include_dir;
	private File exclude_dir;
	private BMCDatabase bmc_db = new BMCDatabase();

	public BMCGateCorpusFilter() throws IOException, ClassNotFoundException, ResourceInstantiationException, URISyntaxException
	{
		KhresmoiConfig c = KhresmoiConfig.getConfig();
				
		bmc_dir = c.getOutputDirBmcOrig();
		include_dir = new File(c.getOutputDirBmcFilterInlude());
		exclude_dir =  new File(c.getOutputDirBmcFilterExclude());
		
		include_dir.delete();
		exclude_dir.delete();
		
		include_dir.mkdirs();
		exclude_dir.mkdirs();
		

		
		
		
		File dir = new File(bmc_dir);
		String[] file_names = dir.list();
		fname_index = new HashSet<String>(Arrays.asList(file_names));
		
		bmc_db.load();
				
		PRSetup.SinglePRSetup setup = new PRSetup.SinglePRSetup(DefaultGazetteer.class);
		setup
			.putFeature(DefaultGazetteer.DEF_GAZ_CASE_SENSITIVE_PARAMETER_NAME, false)
			.putFeature(DefaultGazetteer.DEF_GAZ_FEATURE_SEPARATOR_PARAMETER_NAME, ":")
			.putFeature(DefaultGazetteer.DEF_GAZ_LISTS_URL_PARAMETER_NAME,
					new File(
							KhresmoiConfig.getConfig().getGazetteerResourcesDir() +
							"mesh.def")
						.toURI().toURL());
						
		gazetteer = (DefaultGazetteer) setup.createPR();				

	}

	Set<String> fname_index;		
	private String bmc_dir;
	private int cnt;
	private DefaultGazetteer gazetteer;

	
	public static void main(String[] args) throws URISyntaxException, IOException, GateException, ClassNotFoundException 
	{
		//createUrlFilter();
		/**/		

		Config.getConfig().setGateHome();
		Gate.init();
	    GateUtils.registerPluginDirectory("ANNIE");

		
		BMCGateCorpusFilter bmc_filter = new BMCGateCorpusFilter();
		
		bmc_filter.filter();
		
				
/**/		
	}

	public void filter() throws ResourceInstantiationException, ExecutionException, IOException
	{
		cnt = 0;
		for (String url: bmc_db.urlIter())
		{
			combineRecords(bmc_db.entriesForUrl(url));
		}
		System.err.println("---");
		System.err.println(fname_index.size());
		
	}

	protected void combineRecords(Iterable<BMCEntry> entries) throws ResourceInstantiationException, ExecutionException, IOException
	{
		ArrayList<File> files = new ArrayList<File>();
		
		for (BMCEntry e : entries)
		{
			if (fname_index.contains(e.getID() + ".xml"))
			{
				files.add(new File(bmc_dir + e.getID() + ".xml"));
			}
		}
		
		long max = 0;
		File maxf = null;
		for (File file : files)
		{
			if (max < file.length())
			{
				max = file.length();
				maxf = file;
			}			
		}
		
		if (maxf == null) return;
		
		Document doc = Factory.newDocument(maxf.toURI().toURL(), "utf8");
		if (testDoc(doc, max, maxf.toString()))
		{
			FileUtils.copyFileToDirectory(maxf, include_dir);
		}
		else
		{
			FileUtils.copyFileToDirectory(maxf, exclude_dir);
		}
		Factory.deleteResource(doc);
		
		if (++cnt % 1000 == 0)
			System.out.println(cnt);
				
	}

	protected boolean testDoc(Document doc, long file_size, String filename) throws ExecutionException
	{
		gazetteer.setDocument(doc);
		gazetteer.execute();
		int size = doc.getAnnotations().get(DefaultGazetteer.LOOKUP_ANNOTATION_TYPE).size();
		
		if (((double) size)/file_size <= 0.0001 && size> 7)		
			System.err.println(String.format("lookups: %d docsize: %d div %f    %s", size, file_size, ((double) size)/file_size, filename));
		
		return  ((double) size)/file_size > 0.0001;
	}

	/*
	public static class UrlFilter
	{
		Map <String,List<BmcRecord>> filter = new HashMap<String, List<BmcRecord>>();
		int longest = 0;

		public Iterable<String> getUrls()
		{
			return filter.keySet();
		}
		
		public void add(String urlStr, BmcRecord id)
		{
			List<BmcRecord> cur = filter.get(urlStr);
			if (cur == null) cur = new ArrayList<BmcRecord>();
						
			cur.add(id);
			
			if (cur.size() > longest) longest = cur.size();  
			
			filter.put(urlStr, cur);
			
		}

		public String debugStr()
		{
			return String.format("urls: %5d longest: %3d", filter.keySet().size(), longest);
		}

		public void save(String file_name) throws IOException
		{
			ObjectOutputStream out = new ObjectOutputStream(
					new BufferedOutputStream(
							new FileOutputStream(file_name)));
			
			out.writeObject(filter);
			out.close();			
		}

		@SuppressWarnings("unchecked")
		public void load(String file_name) throws IOException, ClassNotFoundException
		{
			ObjectInputStream in = new ObjectInputStream(
					new BufferedInputStream(
							new FileInputStream(file_name)));
			
			filter = (Map<String, List<BmcRecord>>) in.readObject();
			
			in.close();
		}

		public Iterable<BmcRecord> getIds(String url)
		{
			return filter.get(url);
		}
		
	}

	public static void createUrlFilter() throws IOException, ClassNotFoundException
	{
		InputStream in = new FileInputStream("c:/data/Khresmoi/BMC/bmc-2011-01.iso");
		MarcReader reader = new MarcStreamReader(in, "UTF-8");
		
		UrlFilter filter = new UrlFilter();
		
		int cnt = 0;
		
		while (reader.hasNext())
		{
			if (++cnt % 10000 == 1)
			{
				
				System.err.println(filter.debugStr());
			}
			
			Record record = reader.next();
						
			String urlStr = UnimarcBMC.readURLStr(record);
			
			if (urlStr != null)
			{
				BmcRecord rec = UnimarcBMC.readBmcRecord(record);
				filter.add(urlStr, rec);
			}

		}
		
		in.close();

		System.err.println("------");
		System.err.println(filter.debugStr());

		System.err.println("---save---");
		
		filter.save("url_filter.dat");
		System.err.println("---load---");
		filter.load("url_filter.dat");
		System.err.println("---finish---");

		
	}
	*/
	
}
