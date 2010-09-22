package czsem.gate.plugins;

import gate.Document;
import gate.Resource;
import gate.creole.ExecutionException;
import gate.creole.ResourceInstantiationException;
import gate.creole.metadata.CreoleParameter;
import gate.creole.metadata.CreoleResource;
import gate.creole.metadata.Optional;
import gate.util.InvalidOffsetException;

import java.io.File;
import java.io.IOException;
import java.net.URISyntaxException;
import java.net.URL;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.xml.parsers.ParserConfigurationException;

import org.apache.log4j.Logger;
import org.xml.sax.SAXException;

import czsem.gate.AbstractLanguageAnalyserWithInputOutputAS;
import czsem.gate.SAXTMTParser;
import czsem.gate.TMTAnnotator;
import czsem.gate.TMTAnnotator.Sentence;
import czsem.gate.TMTDocumentHelper;
import czsem.utils.Config;
import czsem.utils.ProcessExec;

@CreoleResource(name = "czsem TectoMTAnalyser", comment = "Alyses givem corpus by TMT tools")
public class TectoMTBatchAnalyser extends AbstractLanguageAnalyserWithInputOutputAS
{

	private static final long serialVersionUID = -1436830144361327369L;
	static Logger logger = Logger.getLogger(TectoMTBatchAnalyser.class);


	private URL scenarioFilePath = null;
	private URL serializationDirectory = null;
	private List<String> blocks = null;
	private boolean loadScenarioFromFile = true;
	private String language = "english";
		
	private List<TMTDocumentHelper> documents_to_anlayse= new ArrayList<TMTDocumentHelper>();

	protected void executeBatch() throws ParserConfigurationException, SAXException, IOException, InterruptedException, URISyntaxException, InvalidOffsetException
	{
		logger.info("Executing external TMT analysis");
		int ret = executeTMTAnalysis();
		logger.info(
				String.format("External TMT analysis ended, return code: %d (%s!!!)",
						ret, ret == 0 ? "Success" : "Error"));

						
		for (TMTDocumentHelper d : documents_to_anlayse)
		{
			annotateGateDocumentAcordingtoTMTfile(d.getDocument(), d.getTMTFilePath());
		}
		
		logger.debug("All documents annotated");
		documents_to_anlayse.clear();		
	}
	
	@Override
	public void execute() throws ExecutionException
	{
		try {
			
			if (documents_to_anlayse.size() <= corpus.size())
			{
				documents_to_anlayse.add(
						new TMTDocumentHelper(document, getLanguage(), getSerializationDirectory()));
				
				if (documents_to_anlayse.size() == corpus.size())
				{
					executeBatch();
				}
			} 
		} catch (Exception e) {
			throw new ExecutionException(e);
		}
	}

	
	protected int executeTMTAnalysis() throws IOException, InterruptedException, URISyntaxException
	{
		Config cfg = Config.getConfig();
		String tredEnvp [] =
		{
				"PERLLIB="+cfg.getTmtRoot()+"/libs/core" +System.getProperty( "path.separator" )+
				cfg.getTmtRoot()+"/libs/blocks" +System.getProperty( "path.separator" )+
				cfg.getTmtRoot()+"/libs/other",
				"TRED_DIR="+cfg.getTredRoot(),
				"TMT_ROOT="+cfg.getTmtRoot(),
				"JAVA_HOME="+System.getProperty("java.home"),
				"Path="+System.getenv("Path"),
	/*		    'conll_mcd_order2.model'      => '2600m',    # tested on sol1, sol2 (64bit)
			    'conll_mcd_order2_0.01.model' => '540m',     # tested on sol2 (64bit) , cygwin (32bit win), java-1.6.0(64bit)
			    'conll_mcd_order2_0.03.model' => '540m',     # load block tested on cygwin notebook (32bit win), java-1.6.0(64bit)
			    'conll_mcd_order2_0.1.model'  => '540m',     # load block tested on cygwin notebook (32bit win), java-1.6.0(64bit)
				"TMT_PARAM_MCD_EN_MODEL=conll_mcd_order2_0.01.model", */
				"TMT_SHARED="+cfg.getTmtRoot()+"/share",
				"CYGWIN=nodosfilewarning"
		};

		
		String[] cmdarray = 
		{
				"perl",
				cfg.getTredRoot() + "/btred",
				"-q",
				"-c",
				cfg.getTmtRoot() + "/config/.tredrc",
				"-Z",
				cfg.getTmtRoot() + "/pml_schemas/" +System.getProperty( "path.separator" )
					+cfg.getTredRoot()+"/resources/"+System.getProperty( "path.separator" ),
				"-0",
				"-m",
				cfg.getTmtRoot()+ "/tools/general/runblocks.btred",
				"-S", "-o"
		};
		
		List<String> cmd_list = new ArrayList<String>(Arrays.asList(cmdarray));
		
		URL scen = getScenarioFilePath();
		if (loadScenarioFromFile)
		{
			cmd_list.add("--scen");			
			cmd_list.add(new File(scen.toURI()).getCanonicalPath());			
		}
		else
		{
			List<String> blocks = getBlocks();
			cmd_list.addAll(blocks);
		}
		cmd_list.add("--");
		
		for (TMTDocumentHelper da : documents_to_anlayse)
		{
			cmd_list.add(new File(da.getTMTFilePath()).getCanonicalPath());			
		}
		
		logger.debug("-------------START list of commentds to execute------------------------");
		for (String cmd : cmd_list)
		{
			logger.debug(cmd);
		}
		logger.debug("-------------END list of commentds to execute------------------------");

		ProcessExec tmt_proc = new ProcessExec();
		tmt_proc.exec(cmd_list.toArray(new String[0]), tredEnvp);
		tmt_proc.startReaderThreads("TMT_GATE_");
		return tmt_proc.waitFor();		
	}
	
	protected void annotateGateDocumentAcordingtoTMTfile(Document doc, String tmt_filepath) throws ParserConfigurationException, SAXException, IOException, InvalidOffsetException
	{
		SAXTMTParser parser = new SAXTMTParser(language);
		List<Sentence> sentences = parser.parse(tmt_filepath);
		TMTAnnotator tmt_tree_annot = new TMTAnnotator(sentences);
//		tmt_tree_annot.debug_print(System.out);
    	tmt_tree_annot.annotate(doc, outputASName);
//		doc.sync();
	}
	

	@CreoleParameter(comment="Directory where temporary TMT files are stored.", defaultValue="file:TmT_serializations")
	public void setSerializationDirectory(URL serializationDirectory) {
		this.serializationDirectory = serializationDirectory;
	}

	public URL getSerializationDirectory() {
		return serializationDirectory;
	}

	@Optional
	@CreoleParameter(defaultValue="file:/home/dedek/workspace/tectomt/applications/czeng10/cs_czeng_analysis_dedek_testing.scen")
	public void setScenarioFilePath (URL scenarioFilePath ) {
		this.scenarioFilePath  = scenarioFilePath ;
	}

	public URL getScenarioFilePath() {
		return scenarioFilePath;
	}

	
	@Optional
	@CreoleParameter(comment="List of blocks to be used in the analysis", defaultValue="SCzechW_to_SCzechM::Sentence_segmentation;SCzechW_to_SCzechM::Tokenize_joining_numbers")
	public void setBlocks(List<String> blocks) {
		this.blocks = blocks;
	}
	
	public List<String> getBlocks() {
		return blocks;
	}


	@Override
	public void cleanup() {
		documents_to_anlayse = null;
		super.cleanup();
	}


	@Override
	public Resource init() throws ResourceInstantiationException {
		documents_to_anlayse = new ArrayList<TMTDocumentHelper>();
		return super.init();
	}


	public Boolean getLoadScenarioFromFile() {
		return loadScenarioFromFile;
	}


	@CreoleParameter(defaultValue="true")
	public void setLoadScenarioFromFile(Boolean loadScenarioFromFile) {
		this.loadScenarioFromFile = loadScenarioFromFile;
	}


	public String getLanguage() {
		return language;
	}


	@CreoleParameter(defaultValue="english") //czech
	public void setLanguage(String language) {
		this.language = language;
	}

}
