package czsem.khresmoi.bmc;

import gate.Document;
import gate.Factory;
import gate.LanguageAnalyser;
import gate.creole.ExecutionException;
import gate.creole.ResourceInstantiationException;

import java.io.File;
import java.io.IOException;

import org.apache.commons.lang.NotImplementedException;

import czsem.Utils.StopRequestDetector;
import czsem.gate.GateUtils;
import czsem.khresmoi.MorceBatchAnalysis.DocumentLoadSynchronizer;

public class BMCAnalysis {

	protected StopRequestDetector stop_request_detector = new StopRequestDetector();
	protected File[] files = null;
	protected String outputdir = null;
	protected LanguageAnalyser analyzer;


	protected static void doGarbageCollection() {
		Runtime rt = Runtime.getRuntime();
		System.err.format(    "free mem before: %9d      used mem: %9d\n", rt.freeMemory(), rt.totalMemory() - rt.freeMemory());				
		for (int m=0; m<5; m++)
		{
			rt.gc();
			System.err.format("free mem after%d: %9d      used mem: %9d\n", m+1, rt.freeMemory(), rt.totalMemory() - rt.freeMemory());				
			
		}			
	}

	public BMCAnalysis(String inputdir, String outputdir)
	{
		this.outputdir = outputdir;
		File dir = new File(inputdir);
		files = dir.listFiles();
		stop_request_detector.startDetector();
	}
	
	public void doTheAnalysis() throws ResourceInstantiationException, ExecutionException, IOException
	{
		int a=0;
		for (File file : files)
		{
			if (stop_request_detector.stop_requested) return;
			if (new File(outputdir+file.getName()).exists())
			{
				System.err.println(++a);
				continue;
			}
			System.err.format("----- File%d %s -----\n", ++a, file);
			analyzeFile(file);
			System.gc();
			System.gc();
			System.gc();
		}
		
	}

	protected void analyzeFile(File file) throws ResourceInstantiationException, ExecutionException, IOException
	{
		Document doc = DocumentLoadSynchronizer.loadDocument(file);
		analyzer.setDocument(doc);
		
		if (executeAnalysis(doc))
			GateUtils.saveBMCDocumentToDirectory(doc, outputdir, "bmcID");
				
		Factory.deleteResource(doc);
	}

	protected boolean executeAnalysis(Document doc) throws IOException, ExecutionException {
		throw new NotImplementedException();
	}


}