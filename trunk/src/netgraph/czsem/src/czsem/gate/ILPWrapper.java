package czsem.gate;

import gate.Document;
import gate.ProcessingResource;
import gate.creole.ExecutionException;
import gate.creole.ml.AdvancedMLEngine;
import gate.creole.ml.Attribute;
import gate.creole.ml.DatasetDefintion;
import gate.creole.ml.MachineLearningPR;
import gate.util.GateException;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.jdom.Element;

import czsem.gate.GateUtils.CorpusDocumentCounter;

public class ILPWrapper implements AdvancedMLEngine
{
	protected int idIndex;
	protected int lastAttrIndex;
	protected int classIndex;
	protected String className;
	protected ILPSerializer ilpSer;
	protected CorpusDocumentCounter docCounter;

	protected DatasetDefintion datasetDefinition = null;
	protected Element options;
	protected MachineLearningPR pr = null;

	@Override
	public boolean supportsBatchMode() {
		return true;
	}
	 

	@SuppressWarnings("unchecked")
	@Override
	public void addTrainingInstance(List attributes) throws ExecutionException {				
		try {
			serializeTrainingInstance(attributes);
		} catch (Throwable e) {
			throw new ExecutionException(e);
		}
	}

	protected boolean isLastInstanceInDocument(List<String> attributes)
	{
		return attributes.get(lastAttrIndex) == null;
	}
	
	private void serializeTrainingInstance(List<String> attributes) throws IOException, InterruptedException
	{
		Document doc = pr.getDocument();
		
		if (docCounter == null) docCounter = new CorpusDocumentCounter(pr.getCorpus());
		if (docCounter.addDocument(doc)) 
			ilpSer.serializeDocument(doc, pr.getInputASName());
				
		ilpSer.serializeTrainingInstance(
				attributes.get(idIndex),
				pr.getDocument().getName(),
				className,
				Boolean.parseBoolean(attributes.get(classIndex)));
		
		if (docCounter.isLastDocument() && isLastInstanceInDocument(attributes))
		{
			ilpSer.flushAndClose();
			ilpSer.train();
		}
	}


	@SuppressWarnings("unchecked")
	@Override
	public List batchClassifyInstances(List instances) throws ExecutionException
	{
		// TODO Auto-generated method stub		
		System.out.println("ILPWrapper.batchClassifyInstances()");
		return null;
	}

	@SuppressWarnings("unchecked")
	@Override
	public Object classifyInstance(List attributes) throws ExecutionException {
		// TODO Auto-generated method stub		
		System.out.println("ILPWrapper.classifyInstance()");
		return null;
	}

	@Override
	public void cleanUp() {
		// TODO Auto-generated method stub

	}

	@Override
	public void init() throws GateException
	{
		String configFileURI = pr.getConfigFileURL().getPath();
		File configFile = new File(configFileURI);
		String name_ext = configFile.getName();
		String name = name_ext.substring(0, name_ext.indexOf('.')); 
		try {
			ilpSer = new ILPSerializer(configFile.getParent(), name);
			ilpSer.setupAndInit(className, datasetDefinition.getInstanceType(), options.getChild("serializer"));
		} catch (Throwable e) {
			throw new GateException(e);
		}
		
		docCounter = null;
	}

	
	@Override
	public void setDatasetDefinition(DatasetDefintion definition) {
		this.datasetDefinition = definition ;
		
		List<Attribute> attrs = getDatasetAttributes();
		
		for (int i=0; i<attrs.size(); i++)
		{
			if (attrs.get(i).getName().equals("id")) idIndex = i;
			if (attrs.get(i).getName().equals("last")) lastAttrIndex = i;
		}
		classIndex = datasetDefinition.getClassIndex();
		className = datasetDefinition.getClassAttribute().getName();		
	}


	@SuppressWarnings("unchecked")
	private List<Attribute> getDatasetAttributes() {
		return datasetDefinition.getAttributes();
	}

	
	@Override
	public void setOptions(Element options) {
		this.options = options;
	}
	

	@Override
	public void setOwnerPR(ProcessingResource pr)
	{
		this.pr = (MachineLearningPR) pr;
	}

}
