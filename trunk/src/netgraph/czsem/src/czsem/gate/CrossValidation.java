package czsem.gate;

import java.io.File;
import java.net.MalformedURLException;
import java.util.Arrays;
import java.util.Random;

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

@CreoleResource(name = "czsem CrossValidation", comment = "Does k-fold cross validation - training / testing on a corpus")
public class CrossValidation extends AbstractProcessingResource
{	
	private static final long serialVersionUID = 3407156606160786711L;
	protected LanguageAnalyser trainingPR;
	protected LanguageAnalyser testingPR;
	protected Corpus corpus;
	protected int numberOfFolds;
	
	/**	two dimensional - corpusFolds[fold][0] small (testing), corpusFolds[fold][1] remaining large (training) */
	protected Corpus [][] corpusFolds;
	protected DocumentEvidence documentEvidence [];
	
	protected static class DocumentEvidence implements Comparable<DocumentEvidence>
	{
		public DocumentEvidence(Document doc, int random) {
			this.doc = doc;
			this.random = random;
		}
		Document doc;
		int random;
		
		@Override
		public int compareTo(DocumentEvidence o)
		{
			return new Integer(random).compareTo(o.random);
		}
	}
			
	@Override
	public Resource init() throws ResourceInstantiationException
	{
		Random rand = new Random();
		documentEvidence = new DocumentEvidence [corpus.size()]; 
		for (int i = 0; i < documentEvidence.length; i++)
		{
			documentEvidence[i] = new DocumentEvidence((Document) corpus.get(i), rand.nextInt());			
		}
		
		Arrays.sort(documentEvidence);
		
		corpusFolds = new Corpus[numberOfFolds][];
		int reamining_documents = corpus.size();
		int reamining_folds = numberOfFolds;
		int from = 0;
		for (int i = 0; i < numberOfFolds; i++)
		{
			int fold_size = reamining_documents/reamining_folds;
			
			System.err.println(fold_size);
			
			int to = from + fold_size;
			corpusFolds[i] = MakeFold(from, to);
			from = to;
			reamining_documents -= fold_size;
			reamining_folds--;			
		}
		
		return super.init();
	}

	
	/** if (i >= test_from && i < test_to) then "test" else "train" **/
	private Corpus[] MakeFold(int test_from, int test_to) throws ResourceInstantiationException
	{
		Corpus[] ret = new Corpus[2];
		ret[0] = Factory.newCorpus(null); 
		ret[1] = Factory.newCorpus(null);
		
		for (int i = 0; i < documentEvidence.length; i++)
		{
			if (i >= test_from && i < test_to)
				ret[0].add(documentEvidence[i].doc);
			else 
				ret[1].add(documentEvidence[i].doc);			
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
	    		Factory.createResource("gate.creole.SerialAnalyserController");	    
			training_controller.add(trainingPR);			    

			SerialAnalyserController testing_controller = (SerialAnalyserController)	    	   
    			Factory.createResource("gate.creole.SerialAnalyserController");	    
			training_controller.add(testingPR);			    

			for (int i = 0; i < numberOfFolds; i++)
			{
				System.err.print("training fold ");
				System.err.println(i);
				trainingPR.reInit();
			    training_controller.setCorpus(corpusFolds[i][1]);			    	    	    
			    training_controller.execute();
			    
				System.err.print("evaluation on fold ");
				System.err.println(i);
			    testingPR.reInit();
			    testing_controller.setCorpus(corpusFolds[i][0]);
			    testing_controller.execute();				
			}
			
			syncAllDocuments();

		} catch (Throwable t)
		{
			throw new ExecutionException(t);
		}
	}
	
	protected void syncAllDocuments() throws PersistenceException, SecurityException
	{
		for (int i = 0; i < documentEvidence.length; i++)
		{
			documentEvidence[i].doc.sync();			
		}
	}

	
	
	
	
	
	
	
	
	
	public static void main(String[] args) throws GateException, MalformedURLException
	{
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
		fm.put("numberOfFolds", 4);		
		fm.put("trainingPR", learning);		
		fm.put("testingPR", testing);		
	    ProcessingResource cross = (ProcessingResource) 
	    	Factory.createResource("czsem.gate.CrossValidation", fm);
	    
	    cross.execute();
	   	    
	}
}
