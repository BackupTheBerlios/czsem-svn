package czsem.khresmoi;

import java.io.File;

import czsem.Utils.StopRequestDetector;

public class BMCAnalysis {

	protected StopRequestDetector stop_request_detector = new StopRequestDetector();
	protected File[] files = null;
	protected String outputdir = null;


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

}