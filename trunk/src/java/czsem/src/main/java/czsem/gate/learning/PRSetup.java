package czsem.gate.learning;

import java.util.Arrays;
import java.util.List;

import gate.Factory;
import gate.FeatureMap;
import gate.ProcessingResource;
import gate.creole.ResourceInstantiationException;
import gate.creole.SerialAnalyserController;

public abstract class PRSetup
{
	public static class SinglePRSetup extends PRSetup 
	{
		private Class<?> pr_class;
		FeatureMap fm;
		private String name = null;
	
		public SinglePRSetup(Class<?> cl, String name)
		{
			pr_class = cl;
			fm = Factory.newFeatureMap();
			this.name = name;
			
		}

		public SinglePRSetup(Class<?> cl)
		{
			this(cl, null);
		}
				
		public SinglePRSetup putFeature(Object key, Object value)
		{
			fm.put(key, value);
			return this;
		}
		public SinglePRSetup putFeatureList(Object key, String ... strig_list)
		{
			if (strig_list == null)
				fm.put(key, null);
			else
				fm.put(key, Arrays.asList(strig_list));
			return this;
		}
	
		public ProcessingResource createPR() throws ResourceInstantiationException
		{
			return(ProcessingResource) Factory.createResource(pr_class.getCanonicalName(), fm, null, name);			
		}				
	}

	public abstract ProcessingResource createPR() throws ResourceInstantiationException;

	public static SerialAnalyserController buildGatePipeline(List<PRSetup> prs, String name) throws ResourceInstantiationException
	{
		SerialAnalyserController controller = (SerialAnalyserController)	    	   
			Factory.createResource(SerialAnalyserController.class.getCanonicalName());
		
		controller.setName(name);
	
		
		for (int i = 0; i < prs.size(); i++)
		{
			controller.add(prs.get(i).createPR());			
		}
		
		
		return controller;		
	}		
}