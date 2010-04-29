package czsem.gate;

import java.util.List;

import org.jdom.Element;

import gate.ProcessingResource;
import gate.creole.ExecutionException;
import gate.creole.ml.AdvancedMLEngine;
import gate.creole.ml.DatasetDefintion;
import gate.util.GateException;

public class ILPWrapper implements AdvancedMLEngine {

	@Override
	public boolean supportsBatchMode() {
		return true;
	}

	int a =0;

	@Override
	public void addTrainingInstance(List attributes) throws ExecutionException {
		System.err.println(attributes);
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

	@Override
	public void setDatasetDefinition(DatasetDefintion definition) {
		// TODO Auto-generated method stub

	}

	@Override
	public void setOptions(Element options) {
		// TODO Auto-generated method stub

	}
	
	protected ProcessingResource pr = null;

	@Override
	public void setOwnerPR(ProcessingResource pr)
	{
		this.pr = pr;
	}

}
