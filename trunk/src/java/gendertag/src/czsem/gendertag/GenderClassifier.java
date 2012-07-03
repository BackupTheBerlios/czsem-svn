package czsem.gendertag;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;

import czsem.gendertag.FeatureMaker.Features;

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
	
	public String printDistribution(Features features) throws Exception
	{
		Instance instance = featureDataToInstnce(features);
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

	public String classify(Features features) throws Exception {
		return classifyInstance(featureDataToInstnce(features));
	}

	public Instance featureDataToInstnce(Features features) {
		Instance instance = new Instance(dataset.numAttributes());
		instance.setDataset(dataset);
		
		for (int i = 0; i < features.doubleFeatures.length; i++) {
			instance.setValue(i, features.doubleFeatures[i]);
		}

		for (int i = features.doubleFeatures.length;
		i < instance.numAttributes(); i++)
		{
			instance.setValue(i, 
					instance.attribute(i).indexOfValue(
							features.stringFeatures[i - features.doubleFeatures.length]));
		}
		
		return instance;
	}

/*	
	public static void main(String[] args) throws Exception {
		GenderClassifier clas = new GenderClassifier();
		FeatureMaker tag = new FeatureMaker();
		double[] data = tag.createDoubleFeatures("Jan Dedek");
		System.err.println(clas.classify(data));
		System.err.println(clas.classify(tag.createDoubleFeatures("Jana volhejnova")));
	
		System.err.println(clas.printDistribution(tag.createDoubleFeatures("Jana volhejnova")));
	
	}
*/
}
