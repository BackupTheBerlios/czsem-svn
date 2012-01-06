package czsem.khresmoi.bmc;

import gate.Document;
import gate.Factory;
import gate.Gate;
import gate.creole.ExecutionException;
import gate.creole.ResourceInstantiationException;
import gate.creole.gazetteer.DefaultGazetteer;
import gate.util.GateException;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.io.FileUtils;
import org.marc4j.MarcReader;
import org.marc4j.MarcStreamReader;
import org.marc4j.marc.Record;

import czsem.gate.GateUtils;
import czsem.gate.learning.PRSetup;
import czsem.khresmoi.bmc.BMCGateCorpusBuider.BmcRecord;
import czsem.utils.Config;

public class BMCGateCorpusFilter
{
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
		System.err.println("---finih---");

		
	}

	private File include_dir;
	private File exclude_dir;

	public BMCGateCorpusFilter() throws IOException, ClassNotFoundException, ResourceInstantiationException, URISyntaxException
	{
		this(BMCGateCorpusBuider.BMC_DIR);		
	}

	public BMCGateCorpusFilter(String dir_name) throws IOException, ClassNotFoundException, ResourceInstantiationException, URISyntaxException
	{
		bmc_dir = dir_name;


		
		String parent = new File(dir_name).getParentFile().getAbsolutePath();
		
		include_dir = new File(parent + "/filter_include");
		exclude_dir =  new File(parent + "/filter_exclude");
		
		include_dir.delete();
		exclude_dir.delete();
		
		include_dir.mkdirs();
		exclude_dir.mkdirs();
		

		
		
		
		File dir = new File(dir_name);
		String[] file_names = dir.list();
		fname_index = new HashSet<String>(Arrays.asList(file_names));
		
		filter.load("url_filter.dat");
		
		PRSetup.SinglePRSetup setup = new PRSetup.SinglePRSetup(DefaultGazetteer.class);
		setup
			.putFeature(DefaultGazetteer.DEF_GAZ_CASE_SENSITIVE_PARAMETER_NAME, false)
			.putFeature(DefaultGazetteer.DEF_GAZ_FEATURE_SEPARATOR_PARAMETER_NAME, ":")
			.putFeature(DefaultGazetteer.DEF_GAZ_LISTS_URL_PARAMETER_NAME,
					new File(
							Config.getConfig().getCzsemPluginDir() +
							"/resources/gazetteer/mesh.def")
						.toURI().toURL());
						
		gazetteer = (DefaultGazetteer) setup.createPR();				

	}

	Set<String> fname_index;		
	UrlFilter filter = new UrlFilter();
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
		for (String url: filter.getUrls())
		{
			combineRecords(filter.getIds(url));
		}
		System.err.println("---");
		System.err.println(fname_index.size());
		
	}

	protected void combineRecords(Iterable<BmcRecord> records) throws ResourceInstantiationException, ExecutionException, IOException
	{
		ArrayList<File> files = new ArrayList<File>();
		
		for (BmcRecord rec : records)
		{
			if (fname_index.contains(rec.id + ".xml"))
			{
				files.add(new File(bmc_dir + rec.id + ".xml"));
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

}
