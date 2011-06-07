package czsem.gate.plugins;

import gate.Corpus;
import gate.DataStore;
import gate.Document;
import gate.Factory;
import gate.FeatureMap;
import gate.Gate;
import gate.LanguageAnalyser;
import gate.ProcessingResource;
import gate.Resource;
import gate.creole.AbstractProcessingResource;
import gate.creole.ExecutionException;
import gate.creole.ResourceInstantiationException;
import gate.creole.SerialAnalyserController;
import gate.creole.metadata.CreoleParameter;
import gate.creole.metadata.CreoleResource;
import gate.creole.metadata.RunTime;
import gate.persist.PersistenceException;
import gate.security.SecurityException;
import gate.util.GateException;

import java.io.File;
import java.net.MalformedURLException;
import java.util.Collections;
import java.util.List;

import org.apache.log4j.BasicConfigurator;
import org.apache.log4j.Logger;

import czsem.Utils;
import czsem.gate.GateUtils;
import czsem.gate.ILPWrapper;

@CreoleResource(name = "czsem CrossValidation", comment = "Does k-fold cross validation - training / testing on a corpus")
public class CrossValidation extends AbstractProcessingResource
{	
	private static final long serialVersionUID = 3407156606160786711L;
	static Logger logger = Logger.getLogger(CrossValidation.class);

	protected LanguageAnalyser trainingPR;
	protected LanguageAnalyser testingPR;
	protected Corpus corpus;
	protected int numberOfFolds;
	
	/**	two dimensional - corpusFolds[fold][0] small (testing), corpusFolds[fold][1] remaining large (training) */
	protected Corpus [][] corpusFolds;
	protected Utils.Evidence<Document> documentEvidence [];
	public List<LearningEvaluator> evaluation_register = null;
	
	
	@SuppressWarnings("unchecked")
	@Override
	public Resource init() throws ResourceInstantiationException
	{
		documentEvidence = Utils.createRandomPermutation(corpus);
		
		corpusFolds = new Corpus[numberOfFolds][];
		int reamining_documents = corpus.size();
		int reamining_folds = numberOfFolds;
		int from = 0;
		for (int i = 0; i < numberOfFolds; i++)
		{
			int fold_size = reamining_documents/reamining_folds;
			int to = from + fold_size;
			logger.info(String.format("creating FOLD %3d: size: %4d from: %4d to: %4d", i, fold_size, from, to));
			corpusFolds[i] = MakeFold(i, from, to);
			from = to;
			reamining_documents -= fold_size;
			reamining_folds--;			
		}
		
		return super.init();
	}

	
	/** if (i >= test_from && i < test_to) then "test" else "train" **/
	@SuppressWarnings("unchecked")
	protected Corpus[] MakeFold(int fold_num, int test_from, int test_to) throws ResourceInstantiationException
	{
		Corpus[] ret = new Corpus[2];
		ret[0] = Factory.newCorpus("Corpus for testing fold " + fold_num); 
		ret[1] = Factory.newCorpus("Corpus for training fold " + fold_num);
		
		for (int i = 0; i < documentEvidence.length; i++)
		{
			if (i >= test_from && i < test_to)
			{
				ret[0].add(documentEvidence[i].element);
				logger.debug(String.format("TEST doc %3d name: '%s'", i, documentEvidence[i].element.getName()));
			}
			else
			{
				ret[1].add(documentEvidence[i].element);
				logger.debug(String.format("TRAIN doc %3d name: '%s'", i, documentEvidence[i].element.getName()));
			}
		}
				 
		return ret;
	}


	public LanguageAnalyser getTrainingPR() {
		return trainingPR;
	}

	@RunTime
	@CreoleParameter(comment="PR used for training - typically Machine Learning PR in training mode")
	public void setTrainingPR(LanguageAnalyser trainingPR) {
		this.trainingPR = trainingPR;
	}
	public LanguageAnalyser getTestingPR() {
		return testingPR;
	}
	@RunTime
	@CreoleParameter(comment="PR used for testing/evaluation - typically Machine Learning PR in testing/evaluation mode")
	public void setTestingPR(LanguageAnalyser testingPR) {
		this.testingPR = testingPR;
	}

	public Integer getNumberOfFolds() {
		return numberOfFolds;
	}
	@CreoleParameter(comment="Number of folds in cross validation", defaultValue="5")
	public void setNumberOfFolds(Integer numberOfFolds) {
		this.numberOfFolds = numberOfFolds;
	}

	public Corpus getCorpus() {
		return corpus;
	}

	@CreoleParameter(comment="Corpus used for cross validation")
	public void setCorpus(Corpus corpus) {
		this.corpus = corpus;
	}

	 
	
	@Override
	public void execute() throws ExecutionException
	{
		try {

			SerialAnalyserController training_controller = (SerialAnalyserController)	    	   
	    		Factory.createResource(SerialAnalyserController.class.getCanonicalName());	    
			training_controller.add(trainingPR);			    

			SerialAnalyserController testing_controller = (SerialAnalyserController)	    	   
    			Factory.createResource(SerialAnalyserController.class.getCanonicalName());	    
			testing_controller.add(testingPR);
			
			for (int i = 0; i < numberOfFolds; i++)
			{
				updateEvaluatorsFold(i);
				
				//training
				logger.info(String.format("training fold %3d", i));
				GateUtils.safeDeepReInitPR_or_Controller(training_controller);
			    training_controller.setCorpus(corpusFolds[i][1]);			    	    	    
			    training_controller.execute();
			    if (isInterrupted()) return;
			    
			    //TODO: reimplement
			    ILPWrapper.executeAllTraingInRegister();
			    if (isInterrupted()) return;
			    
				//testing
				logger.info(String.format("testing fold %3d", i));
				GateUtils.safeDeepReInitPR_or_Controller(testing_controller);
			    testing_controller.setCorpus(corpusFolds[i][0]);
			    testing_controller.execute();				
			    if (isInterrupted()) return;			    
			}
			
			syncAllDocuments();
			//don't do recursive close 
			training_controller.setPRs(Collections.emptyList());
			testing_controller.setPRs(Collections.emptyList());
			Factory.deleteResource(training_controller);
			Factory.deleteResource(testing_controller);

		} catch (Throwable t)
		{
			throw new ExecutionException(t);
		}
	}
	
	private void updateEvaluatorsFold(int fold_index)
	{
		if (evaluation_register == null) return;
		
		for (LearningEvaluator eval : evaluation_register)
		{
			eval.actualFoldNumber = fold_index+1;			
		}
		
	}


	protected void syncAllDocuments() throws PersistenceException, SecurityException
	{
		for (int i = 0; i < documentEvidence.length; i++)
		{
			documentEvidence[i].element.sync();			
		}
	}

	
	@Override
	public void cleanup()
	{
		corpusFolds = null;
		documentEvidence = null;
		super.cleanup();
	}


	
	
	
	
	
	
	
	
	public static void main(String[] args) throws GateException, MalformedURLException
	{
		BasicConfigurator.configure();

		Gate.init();
	    Gate.getCreoleRegister().registerDirectories(new File("GATE_plugins").toURI().toURL());
	    Gate.getCreoleRegister().registerDirectories( 
    		    new File(Gate.getPluginsHome(), "Machine_Learning").toURI().toURL());

		
	    DataStore ds = GateUtils.openDataStore("file:/C:/Users/dedek/AppData/GATE/indexed_store/store/");
	    
	    Corpus corpus = GateUtils.loadCorpusFormDatastore(ds, "50msg_index___1268665232288___6956");
	    
	    FeatureMap fm;
	    
		fm = Factory.newFeatureMap();
		fm.put("configFileURL", new File("gate-learning/sampleConfigILP.xml").toURI().toURL());
		fm.put("inputASName", "TectoMT");
		fm.put("training", true);		
	    ProcessingResource learning = (ProcessingResource) 
	    	Factory.createResource("gate.creole.ml.MachineLearningPR", fm);

		fm = Factory.newFeatureMap();
		fm.put("configFileURL", new File("gate-learning/sampleConfigILP.xml").toURI().toURL());
		fm.put("inputASName", "TectoMT");
		fm.put("training", false);		
	    ProcessingResource testing = (ProcessingResource) 
	    	Factory.createResource("gate.creole.ml.MachineLearningPR", fm);

		fm = Factory.newFeatureMap();
		fm.put("corpus", corpus);
		fm.put("numberOfFolds", 3);		
		fm.put("trainingPR", learning);		
		fm.put("testingPR", testing);		
	    ProcessingResource cross = (ProcessingResource) 
	    	Factory.createResource("czsem.gate.CrossValidation", fm);
	    
	    cross.execute();
	   	    
	}
}
