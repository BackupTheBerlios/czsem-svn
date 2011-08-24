package czsem.khresmoi;

import gate.Corpus;
import gate.Document;
import gate.Factory;
import gate.Gate;
import gate.creole.ResourceInstantiationException;
import gate.creole.SerialAnalyserController;
import gate.util.GateException;

import java.io.File;
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URISyntaxException;

import czsem.gate.GateUtils;
import czsem.gate.learning.PRSetup.SinglePRSetup;
import czsem.gate.plugins.TectoMTBatchAnalyser;
import czsem.utils.Config;

public class MorceBatchAnalysis extends BMCAnalysis
{
	static String default_inputdir = "C:\\Users\\dedek\\Desktop\\bmc\\filter_include\\";
	static String default_outputdir = "C:\\Users\\dedek\\Desktop\\bmc\\morce_analyzed\\";
	
	static final int threads = 1; //multi-thread execution does not work with TectoMT (Morce)!! 
	int files_in_single_btach = 80;
	
	int firs_file_index_to_process = 0;

	
	
	public static class DocumentLoadSynchronizer
	{
		synchronized static Document loadDocument(File fl) throws ResourceInstantiationException, MalformedURLException
		{
			return Factory.newDocument(fl.toURI().toURL(), "utf8");			
		}		
	}
	
	class BatchAnalysisThread extends Thread
	{
		public BatchAnalysisThread(int firs_file_index_to_process, int files_count_to_process)
		{
			super();
			this.firs_file_index_to_process = firs_file_index_to_process;
			this.files_count_to_process = files_count_to_process;
		}

		int firs_file_index_to_process = 0;
		int files_count_to_process = 0;

		@SuppressWarnings("unchecked")
		protected Corpus prepareBatchCorpus() throws ResourceInstantiationException, MalformedURLException
		{
			Corpus corpus = Factory.newCorpus("corpus_"+getName());
			
			for (int f=0; f<files_count_to_process; f++)
			{
				File fl = files[firs_file_index_to_process + f];
				
				if (new File(outputdir+fl.getName()).exists())
				{
					System.err.println(firs_file_index_to_process + f);
					continue;
				}

				System.err.format(
						"%s file%d: %s\n",
						getName(),
						firs_file_index_to_process + f,
						fl.toString());

				//Document doc = Factory.newDocument(fl.toURI().toURL(), "utf8");
				Document doc = DocumentLoadSynchronizer.loadDocument(fl);
				corpus.add(doc);
			}
			
			return corpus;			
		}
		
		@Override
		public void run()
		{
			Corpus corpus = null;
			TectoMTBatchAnalyser tmt_ba = null;
			SerialAnalyserController controller = null;
			try {				
				corpus = prepareBatchCorpus();

				if (corpus.size() != 0)
				{					
				
					controller = (SerialAnalyserController)	    	   
						Factory.createResource(SerialAnalyserController.class.getCanonicalName());

					tmt_ba = prepareBatchAnlyzer(); 													
	
					
					controller.add(tmt_ba);
					controller.setCorpus(corpus);					
					controller.execute();
					
					//save documents
					GateUtils.saveBMCCorpusToDirectory(corpus, outputdir, "bmcID");

					Factory.deleteResource(tmt_ba); tmt_ba = null;
					Factory.deleteResource(controller); controller = null;
					
					GateUtils.deleteAndCelarCorpusDocuments(corpus);
															
					
					doGarbageCollection();
				}

				Factory.deleteResource(corpus); corpus = null;
								
				runNextBtach();
			}
			catch (Exception e)
			{
				e.printStackTrace();
			}
		}

		private TectoMTBatchAnalyser prepareBatchAnlyzer() throws ResourceInstantiationException
		{
			return (TectoMTBatchAnalyser)
				new SinglePRSetup(
					TectoMTBatchAnalyser.class, "tmt_analyser_"+getName())
						.putFeature("language", "czech")
						.putFeature("outputASName", "TectoMT")
						.putFeature("loadScenarioFromFile", false)
						.putFeatureList("blocks", 
								"SCzechW_to_SCzechM::TextSeg_tokenizer_and_segmenter"
			//					,"SCzechW_to_SCzechM::Tokenize_joining_numbers"
								,"SCzechW_to_SCzechM::TagMorce"
								)
						.createPR();
		}		
	}
	
	public synchronized boolean runNextBtach()
	{
		if (stop_request_detector.stop_requested) return false;
		int remaining = files.length - firs_file_index_to_process;
		if (remaining <= 0) return false;
		
		int next_batch_files_count = Math.min(remaining, files_in_single_btach);
		
		BatchAnalysisThread t = new BatchAnalysisThread(
				firs_file_index_to_process, next_batch_files_count);
		
		firs_file_index_to_process += next_batch_files_count;
		
		t.start();
		return true;
	}
	
	public MorceBatchAnalysis(String inputdir, String outputdir)
	{
		super(inputdir, outputdir);
	}
	

	public static void main(String[] args) throws URISyntaxException, IOException, GateException
	{
		Config.getConfig().setGateHome();
		Gate.init();
		
	    GateUtils.registerPluginDirectory(new File("czsem_GATE_plugins"));


		MorceBatchAnalysis mba = new MorceBatchAnalysis(default_inputdir, default_outputdir); 
		
		
		for (int thread=0; thread<threads; thread++)
		{
			mba.runNextBtach();			
		}
		
//		start_terminate_request_detector();
		

	}

}
