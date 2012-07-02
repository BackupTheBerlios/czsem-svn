package czsem.gendertag;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;

import weka.classifiers.Classifier;
import weka.core.Instance;
import weka.core.Instances;
import weka.core.SerializationHelper;

public class GenderClassifier {

	protected Classifier classifier;
	private Instances dataset; 
	
	public GenderClassifier() throws Exception
	{
		this("logitboost_cz.model");
	}

	public GenderClassifier(String modelName) throws Exception
	{
		this(GenderClassifier.class.getResourceAsStream("resources/"+modelName));
	}

	public GenderClassifier(InputStream inputStream) throws Exception
	{
		classifier = (Classifier) SerializationHelper.read(inputStream);
		dataset = createDeataset();
	}
	
	public String printDistribution(double[] data) throws Exception
	{
		Instance instance = featureDataToInstnce(data);
		double[] dist = classifier.distributionForInstance(instance);
		
		StringBuilder ret = new StringBuilder();

		for (int a=0; a<instance.classAttribute().numValues(); a++)
		{
			
			ret.append(String.format("(%s: %f) ", instance.classAttribute().value(a), dist[a]));
		}
		
		return ret.toString();
		
	}

	public String classifyInstance(Instance instance) throws Exception	
	{
		double clsLabel = classifier.classifyInstance(instance);
		return instance.classAttribute().value((int)clsLabel);		
	}
	
	public static Instances createDeataset() throws Exception
	{
		BufferedReader reader = 
			new BufferedReader(
					new InputStreamReader(
							GenderClassifier.class.getResourceAsStream("resources/dataset_header.arff"),"utf8"));
		Instances data = new Instances(reader);
		data.setClassIndex(data.numAttributes()-1);
		return data;
		
	}

	public String classify(double[] data) throws Exception {
		return classifyInstance(featureDataToInstnce(data));
	}

	public Instance featureDataToInstnce(double[] data) {
		Instance instance = new Instance(0, data);
		instance.setDataset(dataset);
		return instance;
	}

	public static void main(String[] args) throws Exception {
		GenderClassifier clas = new GenderClassifier();
		FeatureMaker tag = new FeatureMaker();
		double[] data = tag.createDoubleFetures("Jan Dedek");
		System.err.println(clas.classify(data));
		System.err.println(clas.classify(tag.createDoubleFetures("Jana volhejnova")));
	
		System.err.println(clas.printDistribution(tag.createDoubleFetures("Jana volhejnova")));
	
	}

}
