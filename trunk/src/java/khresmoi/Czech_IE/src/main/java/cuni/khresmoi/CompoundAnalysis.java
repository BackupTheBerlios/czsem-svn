package cuni.khresmoi;

import java.io.File;
import java.io.IOException;
import java.net.URISyntaxException;
import java.util.Locale;

import gate.Document;
import gate.Factory;
import gate.Gate;
import gate.LanguageAnalyser;
import gate.ProcessingResource;
import gate.creole.ConditionalSerialAnalyserController;
import gate.creole.ExecutionException;
import gate.creole.ResourceInstantiationException;
import gate.creole.SerialController;
import gate.creole.annotdelete.AnnotationDeletePR;
import gate.persist.PersistenceException;
import gate.util.GateException;
import gate.util.persistence.PersistenceManager;
import czsem.gate.GateUtils;
import czsem.gate.learning.PRSetup.SinglePRSetup;
import cuni.khresmoi.bmc.BMCAnalysis;
import cuni.khresmoi.bmc.BMCStatistics;
import czsem.utils.Config;

public class CompoundAnalysis extends BMCAnalysis
{
	public CompoundAnalysis(String inputdir, String outputdir) throws PersistenceException, ResourceInstantiationException, IOException, URISyntaxException {
		super(inputdir, outputdir);
		analyzer = prepareAnalyser();
	}

	public static void appendCelanupPRs(SerialController c) throws ResourceInstantiationException
	{
		ProcessingResource pr = new SinglePRSetup(AnnotationDeletePR.class)
			.putFeature("keepOriginalMarkupsAS", new Boolean(false))
			.putFeatureList("setsToKeep", BMCStatistics.asNames).createPR();
		
		c.add(pr);
		
	}
	
	private LanguageAnalyser prepareAnalyser() throws PersistenceException, ResourceInstantiationException, IOException, URISyntaxException {
		 ConditionalSerialAnalyserController ret = (ConditionalSerialAnalyserController)
		 	PersistenceManager.loadObjectFromFile(
				new File(KhresmoiConfig.getConfig().getGateAppCmpoundAnalysis()));
		
		 ret.setCorpus(Factory.newCorpus("empty"));
		 
		 appendCelanupPRs(ret);
		 
		 return ret;
	}
	
	protected boolean executeAnalysis(Document doc) throws IOException, ExecutionException {
		analyzer.execute();
		return true;
	}

	
	public static void main(String[] args) throws IOException, URISyntaxException, GateException
	{
		Locale.setDefault(Locale.ENGLISH);
	
		Config.getConfig().setGateHome();
		Gate.init();
		
	    GateUtils.registerCzsemPlugin();
	
	    CompoundAnalysis iea = 
			new CompoundAnalysis(
					KhresmoiConfig.getConfig().getOutputDirBmcAnalyzed(),
					KhresmoiConfig.getConfig().getOutputDirBmcAnalyzedCompound() );

	    iea.doTheAnalysis();		
	}


}
