package czsem.gate;

import gate.DataStore;
import gate.Document;
import gate.Gate;
import gate.LanguageAnalyser;
import gate.ProcessingResource;
import gate.Resource;
import gate.creole.AbstractLanguageAnalyser;
import gate.creole.ExecutionException;
import gate.creole.ResourceInstantiationException;
import gate.creole.metadata.CreoleParameter;
import gate.creole.metadata.CreoleResource;
import gate.creole.metadata.Optional;
import gate.util.GateException;
import gate.util.Out;

import java.io.File;
import java.io.IOException;
import java.net.URISyntaxException;
import java.net.URL;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.xml.parsers.ParserConfigurationException;
import javax.xml.xpath.XPathExpressionException;

import org.xml.sax.SAXException;

import czsem.utils.ProcessExec;
import czsem.utils.ProjectSetup;

@CreoleResource(name = "czsem TectoMTAnalyser", comment = "Alyses givem corpus by TMT tools")
public class TectoMTAnalyser extends AbstractLanguageAnalyser implements ProcessingResource, LanguageAnalyser
{

	private static final long serialVersionUID = -1436830144361327369L;

	private URL scenarioFilePath = null;
	private URL serializationDirectory = null;
	private List<String> blocks = null;
	private boolean loadScenarioFromFile = true;
	private String language = "english";
	
	private final String TMT_root = "C:/workspace/tectomt";
	private final String tredRoot = "C:/tred";
	private final String tredEnvp [] =
	{
			"PERLLIB="+TMT_root+"/libs/core" +System.getProperty( "path.separator" )+
			TMT_root+"/libs/blocks" +System.getProperty( "path.separator" )+
			TMT_root+"/libs/other",
			"TRED_DIR="+tredRoot,
			"TMT_ROOT="+TMT_root,
			"JAVA_HOME="+System.getProperty("java.home"),
			"Path="+System.getenv("Path"),
/*		    'conll_mcd_order2.model'      => '2600m',    # tested on sol1, sol2 (64bit)
		    'conll_mcd_order2_0.01.model' => '540m',     # tested on sol2 (64bit) , cygwin (32bit win), java-1.6.0(64bit)
		    'conll_mcd_order2_0.03.model' => '540m',     # load block tested on cygwin notebook (32bit win), java-1.6.0(64bit)
		    'conll_mcd_order2_0.1.model'  => '540m',     # load block tested on cygwin notebook (32bit win), java-1.6.0(64bit)
			"TMT_PARAM_MCD_EN_MODEL=conll_mcd_order2_0.01.model", */
			"TMT_SHARED="+TMT_root+"/share",
			"CYGWIN=nodosfilewarning"


	};
	
	private List<TectoMTDocumentAnalyser> documents_to_anlayse= new ArrayList<TectoMTDocumentAnalyser>();

	@Override
	public void execute() throws ExecutionException
	{
		try {
			Out.prln(documents_to_anlayse.size());
			
			if (documents_to_anlayse.size() <= corpus.size())
			{
				TectoMTDocumentAnalyser da = new TectoMTDocumentAnalyser(document, getLanguage());
				da.prepareTMTFile(getSerializationDirectory(), getLanguage()+"_source_text");
				documents_to_anlayse.add(da);
				
				if (documents_to_anlayse.size() == corpus.size())
				{
					
					Out.pr("Analyse !!!   ");
					Out.prln(ProjectSetup.makeTimeStamp());
					produceTMTAnalysis();
					Out.pr("Analysed !!   ");
					Out.prln(ProjectSetup.makeTimeStamp());
					
					for (TectoMTDocumentAnalyser a : documents_to_anlayse)
					{
						a.annotateGateDocumentAcordingtoTMTfile();
					}
					Out.pr("Annotated !   ");
					Out.prln(ProjectSetup.makeTimeStamp());
					documents_to_anlayse.clear();
				}
			} 
		} catch (Exception e) {
			throw new ExecutionException(e);
		}
	}

	
	public void produceTMTAnalysis() throws IOException, InterruptedException, URISyntaxException
	{
		String[] cmdarray = 
		{
				"perl",
				tredRoot + "/btred",
				"-q",
				"-c",
				TMT_root + "/config/.tredrc",
				"-Z",
				TMT_root + "/pml_schemas/:"+tredRoot+"/resources/:",
				"-0",
				"-m",
				TMT_root+ "/tools/general/runblocks.btred",
				"-S", "-o"
				
				
				
//				/home/dedek/workspace/tectomt/config/init_devel_environ.sh

//				"/bin/bash",
//				"/home/dedek/workspace/tectomt/tools/general/brunblocks_env",
//				tectoMTRoot + "/brunblocks",
//				"-S", "-o"
				
//				, "--scen",
//				"scen",
//				"/home/dedek/workspace/tectomt/applications/czeng10/cs_czeng_analysis_dedek.scen",
//				"--", new File(filename).getAbsolutePath()
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
		
		for (TectoMTDocumentAnalyser da : documents_to_anlayse)
		{
			cmd_list.add(da.getTMTFilePath());			
		}
		
		for (String cmd : cmd_list)
		{
			Out.prln(cmd);
			
		}

		ProcessExec tmt_proc = new ProcessExec();
		tmt_proc.exec(cmd_list.toArray(new String[0]), tredEnvp);
		tmt_proc.startReaderThreads("TMT_GATE_");
		tmt_proc.waitFor();
		
	}
	
	public static void main(String[] args) throws GateException, ParserConfigurationException, SAXException, IOException, XPathExpressionException, InterruptedException
	{		
		gate.Main.main(args);
		
		//testAnnotation();
	}
	
	public static void testAnnotation() throws GateException, ParserConfigurationException, SAXException, IOException
	{
		Gate.init();
	    GateUtils.registerPluginDirectory("Parser_Stanford");
	    DataStore ds = GateUtils.openDataStore("file:/C:/Users/dedek/AppData/GATE/data_store");
	    Document doc = GateUtils.loadDocumentFormDatastore(ds, "sample.txt_00026___1280755921102___8929");
	    	    
		TectoMTDocumentAnalyser da = new TectoMTDocumentAnalyser(doc, "english", "TmT_serializations/sample.txt_00026.tmt");
		da.annotateGateDocumentAcordingtoTMTfile();				
	}

	@CreoleParameter(comment="Directory where temporary TMT files are stored.", defaultValue="file:/tmp/czsem/src/netgraph/czsem/TmT_serializations")
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
		documents_to_anlayse = new ArrayList<TectoMTDocumentAnalyser>();
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
