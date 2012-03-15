package cuni.khresmoi;

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
import cuni.khresmoi.bmc.BMCAnalysis;
import czsem.utils.Config;

public class InformationExtractionAnalysis extends BMCAnalysis
{
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
	
	@Override
	protected boolean executeAnalysis(Document doc) throws IOException, ExecutionException {
		try
		{
			analyzer.execute();
			logStatisitcs(doc);
			return true;
		}
		catch (ExecutionException e)
		{
			if (! InvalidOffsetException.class.isInstance(e.getCause())) throw e;
			System.err.println("Could not be analyzed using FlexibleGazetteer!!!");
			try {
				GateUtils.saveBMCDocumentToDirectory(doc, 
						KhresmoiConfig.getConfig().getOutputDirBmcCrash(), "bmcID");
			} catch (URISyntaxException e1) {
				throw new ExecutionException(e1);
			}
		}
		return false;
	}


	public static void main(String[] args) throws IOException, URISyntaxException, GateException
	{
		Locale.setDefault(Locale.ENGLISH);
	
		Config.getConfig().setGateHome();
		Gate.init();
		
		GateUtils.registerCzsemPlugin();
	
		KhresmoiConfig c = KhresmoiConfig.getConfig();
		
		InformationExtractionAnalysis iea = 
			new InformationExtractionAnalysis(
					c.getOutputDirBmcAnalyzedTmp_Morce(),
					c.getOutputDirBmcAnalyzed() );
		iea.doTheAnalysis();		
	}

}
