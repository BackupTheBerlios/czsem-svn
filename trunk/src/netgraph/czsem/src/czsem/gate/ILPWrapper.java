package czsem.gate;

import java.util.List;

import org.jdom.Element;

import gate.LanguageAnalyser;
import gate.ProcessingResource;
import gate.creole.ExecutionException;
import gate.creole.ml.AdvancedMLEngine;
import gate.creole.ml.DatasetDefintion;
import gate.creole.ml.Attribute;
import gate.util.GateException;

public class ILPWrapper implements AdvancedMLEngine
{
	protected int idIndex;
	protected int classIndex;
	protected String className;

	@Override
	public boolean supportsBatchMode() {
		return true;
	}
	 

	@Override
	public void addTrainingInstance(List attributes) throws ExecutionException {
		System.err.print(pr.getDocument().getName());
		System.err.print("___");
		System.err.println(attributes.get(idIndex));
	}

	@Override
	public List batchClassifyInstances(List instances)
			throws ExecutionException {
		// TODO Auto-generated method stub
		
		System.out.println("ILPWrapper.batchClassifyInstances()");
		return null;
	}

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
	public void init() throws GateException {
		System.out.println("ILPWrapper.init()");

	}

	protected DatasetDefintion datasetDefinition = null;
	
	@Override
	public void setDatasetDefinition(DatasetDefintion definition) {
		this.datasetDefinition = definition ;
		
		List<Attribute> attrs = datasetDefinition.getAttributes();
		
		for (int i=0; i<attrs.size(); i++)
		{
			if (attrs.get(i).getName().equals("id"))
			{
				idIndex = i;
				break;
			}
		}
		classIndex = datasetDefinition.getClassIndex();
		className = datasetDefinition.getClassAttribute().getName();
	}

	@Override
	public void setOptions(Element options) {
		// TODO Auto-generated method stub

	}
	
	protected LanguageAnalyser pr = null;

	@Override
	public void setOwnerPR(ProcessingResource pr)
	{
		this.pr = (LanguageAnalyser) pr;
	}

}
