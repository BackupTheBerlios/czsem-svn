package czsem.khresmoi;

import gate.Document;
import gate.Factory;
import gate.Gate;
import gate.LanguageAnalyser;
import gate.creole.ExecutionException;
import gate.creole.ResourceInstantiationException;
import gate.persist.PersistenceException;
import gate.util.AnnotationDiffer;
import gate.util.GateException;
import gate.util.InvalidOffsetException;
import gate.util.persistence.PersistenceManager;

import java.io.File;
import java.io.IOException;
import java.net.URISyntaxException;
import java.util.Arrays;
import java.util.Locale;

import czsem.gate.GateUtils;
import czsem.khresmoi.MorceBatchAnalysis.DocumentLoadSynchronizer;
import czsem.utils.Config;

public class InformationExtractionAnalysis extends BMCAnalysis
{
	public static String default_outputdir = "C:\\Users\\dedek\\Desktop\\bmc\\analyzed\\";
	public static String default_crashdir = "C:\\Users\\dedek\\Desktop\\bmc\\flex_crash\\";
	private LanguageAnalyser analyzer;

	public InformationExtractionAnalysis(String inputdir, String outputdir) throws PersistenceException, ResourceInstantiationException, IOException, URISyntaxException
	{
		super(inputdir, outputdir);
		analyzer = prepareAnalyser();
	}
	
	public LanguageAnalyser prepareAnalyser() throws PersistenceException, ResourceInstantiationException, IOException, URISyntaxException
	{
		 LanguageAnalyser ret = (LanguageAnalyser)
		 	PersistenceManager.loadObjectFromFile(
				new File(
						Config.getConfig().getCzsemPluginDir()+
//						"/resources/mimir/CzechMeshAnalysis.gapp"));
						"/resources/mimir/CzechMeshAnalysis_IE_only.gapp"));
		
		 ret.setCorpus(Factory.newCorpus("empty"));
		 return ret;
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

	private void analyzeFile(File file) throws ResourceInstantiationException, ExecutionException, IOException
	{
		Document doc = DocumentLoadSynchronizer.loadDocument(file);
		analyzer.setDocument(doc);
		
		try
		{
			analyzer.execute();
			logStatisitcs(doc);
			GateUtils.saveBMCDocumentToDirectory(doc, outputdir, "bmcID");
		}
		catch (ExecutionException e)
		{
			if (! InvalidOffsetException.class.isInstance(e.getCause())) throw e;
			System.err.println("Could not be analyzed using FlexibleGazetteer!!!");
			GateUtils.saveBMCDocumentToDirectory(doc, default_crashdir, "bmcID");
		}
		
		Factory.deleteResource(doc);
	}

	AnnotationDiffer overall_differ = null;

	public static AnnotationDiffer BMCCrossCoverageDiffer(Document doc)
	{
		return GateUtils.calculateSimpleDiffer(doc, "mimir", "plain", "Lookup");
	}
	
	private void logStatisitcs(Document doc)
	{
//		System.err.println("diffing.....");
		AnnotationDiffer differ = BMCCrossCoverageDiffer(doc);
		
		System.err.format("   diff: prec: %f rec: %f\n", 
				differ.getPrecisionStrict(),
				differ.getRecallStrict());
		
		if (overall_differ == null)
		{
			overall_differ = differ;
			return;
		}
		
		AnnotationDiffer [] differs = new AnnotationDiffer[2];
		differs[0] = differ;
		differs[1] = overall_differ;
		overall_differ = new AnnotationDiffer(Arrays.asList(differs));

		System.err.format("overall: prec: %f rec: %f\n", 
				overall_differ.getPrecisionStrict(),
				overall_differ.getRecallStrict());

	}

	public static void main(String[] args) throws IOException, URISyntaxException, GateException
	{
		Locale.setDefault(Locale.ENGLISH);
	
		Config.getConfig().setGateHome();
		Gate.init();
		
	    GateUtils.registerPluginDirectory(new File("czsem_GATE_plugins"));
	
		InformationExtractionAnalysis iea = 
			new InformationExtractionAnalysis(
					MorceBatchAnalysis.default_outputdir,
					default_outputdir );
/*		InformationExtractionAnalysis iea = 
			new InformationExtractionAnalysis(
					"C:\\Users\\dedek\\Desktop\\bmc\\flex_crash\\",
					null);
/**/		
		iea.doTheAnalysis();		
	}

}
