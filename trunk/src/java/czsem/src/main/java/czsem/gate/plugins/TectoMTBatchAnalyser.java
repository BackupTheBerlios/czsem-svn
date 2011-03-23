package czsem.gate.plugins;

import gate.Corpus;
import gate.Document;
import gate.Factory;
import gate.FeatureMap;
import gate.Gate;
import gate.ProcessingResource;
import gate.Resource;
import gate.creole.ExecutionException;
import gate.creole.ResourceInstantiationException;
import gate.creole.SerialAnalyserController;
import gate.creole.metadata.CreoleResource;
import gate.persist.PersistenceException;
import gate.security.SecurityException;
import gate.util.InvalidOffsetException;

import java.io.File;
import java.io.IOException;
import java.io.PrintStream;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.List;

import javax.xml.parsers.ParserConfigurationException;

import org.apache.log4j.Logger;
import org.xml.sax.SAXException;

import czsem.gate.GateUtils;
import czsem.gate.tectomt.TMTDocumentHelper;
import czsem.utils.Config;
import czsem.utils.ProcessExec;
import czsem.utils.ProjectSetup;

@CreoleResource(name = "czsem TectoMTBatchAnalyser", comment = "Alyses givem corpus by TMT tools")
public class TectoMTBatchAnalyser extends TectoMTAbstractAnalyser
{

	private static final long serialVersionUID = -1436830144361327369L;
	static Logger logger = Logger.getLogger(TectoMTBatchAnalyser.class);


		
	private List<TMTDocumentHelper> documents_to_anlayse= new ArrayList<TMTDocumentHelper>();

	protected void executeBatch() throws ParserConfigurationException, SAXException, IOException, InterruptedException, URISyntaxException, InvalidOffsetException, PersistenceException, SecurityException
	{
		logger.info("Executing external TMT analysis");
		int ret = executeTMTAnalysis();
		logger.info(
				String.format("External TMT analysis ended, return code: %d (%s!!!)",
						ret, ret == 0 ? "Success" : "Error - see TMT_GATE_err.log"));

						
		Corpus corpus = getCorpus();
		for (TMTDocumentHelper dh : documents_to_anlayse)
		{
			Document doc = dh.getDocument();
			annotateGateDocumentAcordingtoTMTfile(doc , dh.getTMTFilePath());
			int doc_index = corpus.indexOf(doc);
			if (! corpus.isDocumentLoaded(doc_index))
			{
				doc.sync();
			}
			dh = null; //saving memory
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
						new TMTDocumentHelper(document, getInputASName(), getLanguage(),
								Config.getConfig().getTmtSerializationDirectoryURL()));
				
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

		String file_list_path = cfg.getTmtSerializationDirectoryPath() +
		"/gate_tmt_filelist_" + ProjectSetup.makeTimeStamp();
		PrintStream file_list_ostream = new PrintStream(file_list_path);
		
		for (TMTDocumentHelper da : documents_to_anlayse)
		{
			file_list_ostream.println(new File(da.getTMTFilePath()).getCanonicalPath());
		}
		file_list_ostream.close();
		
		List<String> cmd_list = buildTredCmdArray(null); 
		cmd_list.add("-l");
		cmd_list.add(file_list_path);
		
		logger.debug("-------------START list of commentds to execute------------------------");
		for (String cmd : cmd_list)
		{
			logger.debug(cmd);
		}
		logger.debug("-------------END list of commentds to execute------------------------");

		ProcessExec tmt_proc = new ProcessExec();
		tmt_proc.exec(cmd_list.toArray(new String[0]), getTredEnvp());
		tmt_proc.startReaderThreads(Config.getConfig().getLogFileDirectoryPath() + "/TMT_GATE_");
		return tmt_proc.waitFor();		
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


	

	@SuppressWarnings("unchecked")
	public static void main(String [] args) throws Exception
	{
		Config cfg = Config.getConfig();
		cfg.setGateHome();
		Gate.init();
		GateUtils.registerPluginDirectory(new File(cfg.getCzsemPluginDir()));
				
		FeatureMap fm = Factory.newFeatureMap();
		fm.put("scenarioFilePath", 
				new File(
						cfg.getCzsemPluginDir() + 
						"/tmt_analysis_scenarios/english_full_blocks.scen")
				.toURI().toURL());
		
		ProcessingResource tmtBA = (ProcessingResource) Factory.createResource(TectoMTBatchAnalyser.class.getCanonicalName(), fm);
		
		SerialAnalyserController controller = (SerialAnalyserController)	    	   
			Factory.createResource(SerialAnalyserController.class.getCanonicalName());
		
		controller.add(tmtBA);
		
		Corpus corpus = Factory.newCorpus(null);
		corpus.add(Factory.newDocument("My name is czsem mininig suite."));
		controller.setCorpus(corpus);
		
		controller.execute();

		
	}

}
