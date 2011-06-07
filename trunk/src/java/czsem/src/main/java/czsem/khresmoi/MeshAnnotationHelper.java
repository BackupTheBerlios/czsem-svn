package czsem.khresmoi;

import java.io.File;
import java.io.IOException;
import java.lang.reflect.Constructor;
import java.net.URISyntaxException;
import java.net.URL;
import java.util.Map;

import czsem.utils.Config;

import gate.Corpus;
import gate.Document;
import gate.Factory;
import gate.Gate;
import gate.mimir.SemanticAnnotationHelper;
import gate.mimir.index.MimirConnector;
import gate.mimir.util.DelegatingSemanticAnnotationHelper;
import gate.util.GateException;
import gate.util.GateRuntimeException;

public class MeshAnnotationHelper extends DelegatingSemanticAnnotationHelper
{
	protected MeshAnnotationHelper(String annotationType,
			String[] nominalFeatureNames, String[] integerFeatureNames,
			String[] floatFeatureNames, String[] textFeatureNames,
			String[] uriFeatureNames, SemanticAnnotationHelper delegate) {
		super(annotationType, nominalFeatureNames, integerFeatureNames,
				floatFeatureNames, textFeatureNames, uriFeatureNames, delegate);
		// TODO Auto-generated constructor stub
	}
	
	static final String ANNOTATION_TYPE = "MeshTerm"; 
	static final String DELEGATE_HELPER_TYPE_KEY = "delegateHelperType"; 
	
	public MeshAnnotationHelper(Map<String, Object> settings)
	{
		
		super(ANNOTATION_TYPE, null, null, null, null, null, createHelper(
                ((Class<? extends SemanticAnnotationHelper>)settings.get(DELEGATE_HELPER_TYPE_KEY)),
                ANNOTATION_TYPE, 
                null,
                null,
                null,
                null,
                null));		
	}
	
	  static protected SemanticAnnotationHelper createHelper(
	          Class<? extends SemanticAnnotationHelper> helperClass,
	          String annotationType, String[] nominalFeatureNames, 
	          String[] integerFeatureNames, String[] floatFeatureNames, 
	          String[] textFeatureNames, String[] uriFeatureNames) {
	    
	    // locate the constructor
	    Constructor<? extends SemanticAnnotationHelper> constructor = null;
	    try {
	      constructor = helperClass.getConstructor(String.class, String[].class, 
	            String[].class, String[].class, String[].class, String[].class);
	    } catch(NoSuchMethodException e) {
	      throw new GateRuntimeException("Class " + helperClass.getName() + 
	          " does not have the standard 6-argument SemanticAnnotationHelper " +
	          "constructor.", e);
	    }
	    // create the new instance
	    try {
	      return constructor.newInstance(annotationType, nominalFeatureNames,
	              integerFeatureNames, floatFeatureNames, textFeatureNames,
	              uriFeatureNames);
	    } catch(Exception e) {
	      throw new GateRuntimeException("Could not create instance of "
	              + helperClass.getName(), e);
	    }
	  }



	private static final long serialVersionUID = 2387351152255417500L;
	
	public static void main(String[] args) throws IOException, GateException, URISyntaxException
	{
		Config.getConfig().setGateHome();
		Gate.init();
		
		
		
		String indexurl = "http://localhost:8080/mimir-demo/aa77665f-7149-422a-aaac-bdfe57d76749";
		URL index_url = new URL(indexurl);
		
		Corpus corpus = Factory.newCorpus(null);
		corpus.populate(
				new File("C:\\Users\\dedek\\Desktop\\bmc\\BMC1_test").toURI().toURL(),
//				new File("C:\\Users\\dedek\\Desktop\\bmca_devel").toURI().toURL(),
				null, "utf8", false);
		
		System.err.println("populated");
				
		for (Object object : corpus)
		{
			Document doc = (Document) object;
			MimirConnector.defaultConnector().sendToMimir(doc, null, index_url);
			System.err.println(doc.getName());			
		}

		
		

	}


}
