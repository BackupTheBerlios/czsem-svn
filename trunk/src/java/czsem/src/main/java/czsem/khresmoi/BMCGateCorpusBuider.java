package czsem.khresmoi;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URISyntaxException;
import java.net.URL;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

import org.apache.log4j.Logger;
import org.marc4j.MarcReader;
import org.marc4j.MarcStreamReader;
import org.marc4j.marc.Record;

import czsem.gate.GateUtils;
import czsem.utils.Config;

import gate.Corpus;
import gate.Document;
import gate.Factory;
import gate.Gate;
import gate.creole.ResourceInstantiationException;
import gate.util.GateException;

public class BMCGateCorpusBuider
{
	private Corpus corpus;
	private boolean dontBuildCorpus;
	private String outputDirectory;
	public static Logger logger = Logger.getLogger(BMCGateCorpusBuider.class);


	public BMCGateCorpusBuider(String corpus_name, boolean dontBuildCorpus, String outputDirectory) throws ResourceInstantiationException
	{
		this.outputDirectory = outputDirectory;
		this.dontBuildCorpus = dontBuildCorpus;
		if (dontBuildCorpus) return;
		
		corpus = Factory.newCorpus(corpus_name);
	}
	
	static String [] sl = 
	{
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
		if (! dontBuildCorpus) corpus.add(doc);
		logger.info("added: " + doc.getContent().size());
		
		return doc;
	}
	
	public static void main(String[] args) throws URISyntaxException, IOException, GateException
	{
		Config.getConfig().setGateHome();
				
		Gate.init();
		
		BMCGateCorpusBuider b = new BMCGateCorpusBuider("BMC", true, "C:\\Users\\dedek\\Desktop\\bmc\\bmc");
		
		InputStream in = new FileInputStream("c:/data/Khresmoi/BMC/bmc-2011-01.iso");
		MarcReader reader = new MarcStreamReader(in, "UTF-8");

		logger.info("Start");

		int urls = 0;
		int records = 0;
		while (reader.hasNext())
		{
			Record record = reader.next();
			
			String urlStr = UnimarcBMC.getURLStr(record);
			if (urlStr != null)
			{
				if (! b.documentExistsInTragetDirectory(UnimarcBMC.readBMCID(record)))
				{
					logger.info(String.format("record: %d/617155  url: %d/25408", records, urls));
					try 
					{
						Document doc = b.addDoc(new URL(urlStr));
						UnimarcBMC.setDocumentFeatures(doc, record);
						b.saveDocument(doc);
					}
					catch (ResourceInstantiationException e)
					{
						logger.error(UnimarcBMC.readBMCID(record), e);						
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
		if (dontBuildCorpus)
			GateUtils.saveDocumentToDirectory(doc, outputDirectory, "bmcID");		
	}

	public void saveCorpus() throws IOException
	{
		if (! dontBuildCorpus)
			GateUtils.saveCorpusToDirectory(corpus, outputDirectory, "bmcID");
	}

}
