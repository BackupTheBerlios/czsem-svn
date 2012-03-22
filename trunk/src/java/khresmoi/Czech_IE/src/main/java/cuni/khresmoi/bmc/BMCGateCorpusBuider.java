package cuni.khresmoi.bmc;

import static cuni.khresmoi.bmc.UnimarcBMC.readBMCArticleName;
import static cuni.khresmoi.bmc.UnimarcBMC.readBMCID;
import static cuni.khresmoi.bmc.UnimarcBMC.readFields;
import static cuni.khresmoi.bmc.UnimarcBMC.readURLStr;
import gate.Corpus;
import gate.Document;
import gate.Factory;
import gate.Gate;
import gate.creole.ResourceInstantiationException;
import gate.util.GateException;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.Serializable;
import java.net.MalformedURLException;
import java.net.URISyntaxException;
import java.net.URL;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.apache.log4j.Logger;
import org.marc4j.MarcReader;
import org.marc4j.MarcStreamReader;
import org.marc4j.marc.Record;

import cuni.khresmoi.KhresmoiConfig;
import czsem.gate.GateUtils;
import czsem.utils.Config;

public class BMCGateCorpusBuider
{
	private Corpus corpus;
	private boolean dontBuildGateCorpus;
	private String outputDirectory;
	public static Logger logger = Logger.getLogger(BMCGateCorpusBuider.class);


	public BMCGateCorpusBuider(String corpus_name, boolean dontBuildCorpus, String outputDirectory) throws ResourceInstantiationException
	{
		this.outputDirectory = outputDirectory;
		this.dontBuildGateCorpus = dontBuildCorpus;
		if (dontBuildCorpus) return;
		
		corpus = Factory.newCorpus(corpus_name);
	}
	
	static String [] sl = 
	{
		"195.250.138.169", //Connection timed out
		"www.tigis.cz", //FileNotFoundException
		"www.prolekare.cz" //controlled access
	};
	static Set<String> host_stoplist = new HashSet<String>(Arrays.asList(sl)); 
	
	@SuppressWarnings("unchecked")
	public Document addDoc(URL sourceUrl) throws ResourceInstantiationException
	{
		if (host_stoplist.contains(sourceUrl.getHost().toString()))
			throw new ResourceInstantiationException(sourceUrl.getHost().toString() + " host is on stop list");
		
		logger.info("adding: " + sourceUrl.toString());
		Document doc = Factory.newDocument(sourceUrl);
		if (! dontBuildGateCorpus) corpus.add(doc);
		logger.info("added: " + doc.getContent().size());
		
		return doc;
	}
	
	public static class BmcRecord implements Serializable
	{
		private static final long serialVersionUID = -302333240017740807L;

		List<String> meshIDs;
		List<String> meshArticleTypeIDs;
		List<String> meshTreeNodes;
		List<String> meshTerms;

		String title;
		String url;
		String id;

		public BmcRecord(Record record)
		{			
			meshIDs = readFields(record, "606", '0', '3');
			meshArticleTypeIDs = readFields(record, "606", ' ', '3');
			meshTreeNodes = readFields(record, "686", null, 'a');
			meshTerms = readFields(record, "606", null, 'a');
			
			title = readBMCArticleName(record);
			id = readBMCID(record);
			url = readURLStr(record);						
		}
		
	}

	
	public static void main(String[] args) throws URISyntaxException, IOException, GateException
	{
		Config.getConfig().setGateHome();
				
		Gate.init();
		
		KhresmoiConfig c = KhresmoiConfig.getConfig();
		BMCGateCorpusBuider b = new BMCGateCorpusBuider("BMC", true, 
				c.getOutputDirBmcOrig());
		
		InputStream in = new FileInputStream(c.getBmcIsoFilePath());
		MarcReader reader = new MarcStreamReader(in, "UTF-8");

		logger.info("Start building BMC corpus at:");
		logger.info(b.outputDirectory);

		int urls = 0;
		int records = 0;
		while (reader.hasNext())
		{
			Record record = reader.next();
						
			String urlStr = UnimarcBMC.readURLStr(record);
			if (urlStr != null)
			{
				if (! b.documentExistsInTragetDirectory(UnimarcBMC.readBMCID(record)))
				{
					logger.info(String.format("record: %d/617155  url: %d/25408", records, urls));
					try 
					{
//						if (urls > 23000)
						{
							if (!urlStr.equals("http://www.chemicke-listy.cz/docs/full/2003_S.pdf"))
							{
								Document doc = b.addDoc(new URL(urlStr));
								UnimarcBMC.setDocumentFeatures(doc, record);
								b.saveDocument(doc);
							}
						}
					}
					catch (ResourceInstantiationException e)
					{
						logger.error(UnimarcBMC.readBMCID(record), e);						
					}
					catch (MalformedURLException e)
					{
						logger.error(urlStr, e);												
					}
					
				}
				urls++;
			}
			
			records++;
			
			
//			if (urls> 20) break;
		}
		
		logger.info("Save!");
		
		b.saveCorpus();
		
	}

	public boolean documentExistsInTragetDirectory(String bmcID)
	{
		return new File(outputDirectory+"/"+bmcID+".xml").exists();
		
	}
	
	public void saveDocument(Document doc) throws IOException
	{
		if (dontBuildGateCorpus)
		{
			GateUtils.saveBMCDocumentToDirectory(doc, outputDirectory, "bmcID");
			Factory.deleteResource(doc);
		}
	}

	public void saveCorpus() throws IOException
	{
		if (! dontBuildGateCorpus)
			GateUtils.saveBMCCorpusToDirectory(corpus, outputDirectory, "bmcID");
	}	
}
