package cuni.khresmoi.mimir;

import gate.Corpus;
import gate.Document;
import gate.Factory;
import gate.Gate;
import gate.mimir.Constraint;
import gate.mimir.ConstraintType;
import gate.mimir.SemanticAnnotationHelper;
import gate.mimir.index.Mention;
import gate.mimir.index.MimirConnector;
import gate.mimir.search.QueryEngine;
import gate.mimir.util.DelegatingSemanticAnnotationHelper;
import gate.util.GateException;
import gate.util.GateRuntimeException;

import java.io.File;
import java.io.IOException;
import java.lang.reflect.Constructor;
import java.net.URISyntaxException;
import java.net.URL;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import cuni.khresmoi.mimir.MeshIndexer.MeshIndex;
import cuni.khresmoi.mimir.MeshIndexer.MeshIndex.DescendantsCnstraint;
import cuni.khresmoi.mimir.MeshIndexer.MeshParsedIndex.MeshIndexRecord;
import czsem.utils.Config;

public class MeshAnnotationHelper extends DelegatingSemanticAnnotationHelper
{	
	private static final long serialVersionUID = 2387351152255417500L;
	
	protected static Logger logger = Logger.getLogger(MeshAnnotationHelper.class);


	static final String ANNOTATION_TYPE = "MeshTerm"; 
	static final String DELEGATE_HELPER_TYPE_KEY = "delegateHelperType"; 

	static final String MESH_ID_FEATURE = "meshID"; 
//	static final String CHILDREN_FEATURE = "children"; 
	static final String DESCENDANTS_FEATURE = "descendants"; 

	
	static final String [] TEXT_FATURES = {"czTerm","enTerm",MESH_ID_FEATURE}; 
//	static final String [] FAKE_TEXT_FATURES = {CHILDREN_FEATURE, DESCENDANTS_FEATURE}; 
	
	protected MeshIndex meshIndex = null;
	
	@SuppressWarnings("unchecked")
	public MeshAnnotationHelper(Map<String, Object> settings)
	{
		
		super (
				ANNOTATION_TYPE,
				null,
				new String[] {DESCENDANTS_FEATURE},
				null,
				TEXT_FATURES,
				null,
				createHelper (
	                ((Class<? extends SemanticAnnotationHelper>)settings.get(DELEGATE_HELPER_TYPE_KEY)),
	                ANNOTATION_TYPE, 
	                null,
	                null,
	                null,
	                TEXT_FATURES,
	                null)
		);		
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


	
	@Override
	public void init(QueryEngine queryEngine) {
		logger.info("mesh init");
		try {
			meshIndex = new MeshIndex();
		} catch (Exception e) {
			logger.error("Failed to init MeshIndex", e);
		}
		super.init(queryEngine);
	}
	
	public static class MeshTermGetMentionsConstraints
	{
		protected List<Constraint> meshID_eq_constraints = new ArrayList<Constraint>(); 
		protected List<Constraint> descendants_constraints = new ArrayList<Constraint>();
		protected List<Constraint> delegated_constraints = new ArrayList<Constraint>();
		
		public MeshTermGetMentionsConstraints(List<Constraint> input_constraints)
		{
			filterConstraints(input_constraints);
		}

		protected void filterConstraints(List<Constraint> input_constraints)
		{
			for (Constraint c : input_constraints)
			{
				String fname = c.getFeatureName();
				if (fname.equals(DESCENDANTS_FEATURE))
				{
					descendants_constraints.add(c);
					continue;
				}
				if (fname.equals(MESH_ID_FEATURE) && c.getPredicate() == ConstraintType.EQ)
				{
					meshID_eq_constraints.add(c);
					continue;
				}
				delegated_constraints.add(c);
			}
			
			checkMultiple(descendants_constraints, DESCENDANTS_FEATURE);
			checkMultiple(meshID_eq_constraints, MESH_ID_FEATURE + "=...");			
		}
		
		private void checkMultiple(List<Constraint> constraints, String feture_name)
		{
			if (constraints.size() > 1)
				throw new IllegalArgumentException("Not allowed multiple assertions for <i>"
						+ feture_name + "</i> feature detected!");
		}

		public List<Constraint> getDelegatedConstraints() {
			return delegated_constraints;
		}
		
		public boolean hasMeshIdEqConstraint() {return ! meshID_eq_constraints.isEmpty();}
		public boolean hasMeshDescendantsConstraint() {return ! descendants_constraints.isEmpty();}
		public Constraint getMeshIdEqConstraint() {return meshID_eq_constraints.get(0);}
		public Constraint getMeshDescendantsConstraint() {return descendants_constraints.get(0);}
	}

	@Override
	public List<Mention> getMentions(String annotationType,
			List<Constraint> input_constraints, QueryEngine engine) {
		
		MeshTermGetMentionsConstraints constraints = 
			new MeshTermGetMentionsConstraints(input_constraints);
		
		List<Constraint> deleg_constraints = constraints.getDelegatedConstraints();

		
		if (constraints.hasMeshIdEqConstraint())
		{
			if (constraints.hasMeshDescendantsConstraint())
			{
				deleg_constraints.add(
						createAdditionalDescendantsConstraint(
								constraints.getMeshIdEqConstraint().getValue(),
								constraints.getMeshDescendantsConstraint()));
			}
			else					
			{
				deleg_constraints.add(constraints.getMeshIdEqConstraint());
			}
			
		}
		else
		{
			if (constraints.hasMeshDescendantsConstraint())
			{	          
				throw new IllegalArgumentException("A value of the <i>" +
	        		  MESH_ID_FEATURE + "</i> feture must be provided to make <i>"+DESCENDANTS_FEATURE+"<i> feature work!");
			}
		}
						
		return super.getMentions(annotationType, deleg_constraints, engine);
	}
	
	public static class MeshTermDescendantsConstraint implements DescendantsCnstraint
	{

		private Number value;
		private ConstraintType predicate;

		public MeshTermDescendantsConstraint(Constraint c) {
			predicate = c.getPredicate();
			
			if (predicate == ConstraintType.REGEX)
			{
				throw new IllegalArgumentException("<i>REGEX</i> predicate not alowed for <i>"
						+ DESCENDANTS_FEATURE + "</i> feture!");
			}

			
			try {
				value = (Number) c.getValue();
			} catch (ClassCastException e)
			{
				try {
					value = Float.parseFloat(c.getValue().toString());					
				} catch (NumberFormatException ee)
				{
			          throw new IllegalArgumentException("Only numeric arguments are alowed for <i>" +
			        		  DESCENDANTS_FEATURE + "</i> feture!");									
				}
			}
		}

		@Override
		public boolean continueSearch(int currentDepth)
		{
			int val = value.intValue();
			switch (predicate) {
			case EQ:
				return currentDepth == val; 
			case GE:
				return currentDepth >= val; 
			case GT:
				return currentDepth > val; 
			case LE:
				return currentDepth <= val; 
			case LT:
				return currentDepth < val; 
			case REGEX:				
		          throw new IllegalArgumentException("<i>REGEX</i> predicate not alowed for <i>" +
		        		  DESCENDANTS_FEATURE + "</i> feture!");
			}
			return false;
		}
		
	}

	private Constraint createAdditionalDescendantsConstraint(Object inputMeshID, Constraint c)
	{
		if (inputMeshID == null) 
	          throw new IllegalArgumentException("A value of the <i>" +
	        		  MESH_ID_FEATURE + "</i> feture must be provided to make <i>"+DESCENDANTS_FEATURE+"<i> feature work!");
		
		int meshID;
		if (Number.class.isInstance(inputMeshID))
		{
			meshID = ((Number) inputMeshID).intValue();
		}
		else
		{
			try{			
				meshID = MeshIndexRecord.parseMeshID( inputMeshID.toString());
			} catch(NumberFormatException e)
			{
		          throw new IllegalArgumentException("Unable to parse the string value '"+inputMeshID.toString()+"' of the <i>" +
		        		  MESH_ID_FEATURE + "</i> feture!");				
			}
		}
		
		Collection<Integer> ids =
			meshIndex.getDescendnatsCollection(
					meshID,
					new MeshTermDescendantsConstraint(c));
		
		if (ids.isEmpty())
	          throw new IllegalArgumentException(
	        		  "No MeSH term is covered by the combination of <i>"+
	        		  MESH_ID_FEATURE + "</i> and <i>" +
	        		  DESCENDANTS_FEATURE + "</i> fetures!");				
					
		StringBuilder sb = new StringBuilder();
		for (Iterator<Integer> iterator = ids.iterator(); ;)
		{
			Integer i = iterator.next();
			sb.append(MeshIndexRecord.renderMeshID(i));
			if (! iterator.hasNext()) break;
			sb.append('|');
		}
		String regex = sb.toString();
			
		return new Constraint(ConstraintType.REGEX, MESH_ID_FEATURE, regex);
	}

	public static void main2(String[] args)
	{
		String i ="10";
		Integer j = 11;
		
		Object o = i;
		
		if (Number.class.isInstance(o))
		{
			j = ((Number) o).intValue();
		}
		
		System.err.println(j);
	}

	public static void main(String[] args) throws IOException, GateException, URISyntaxException
	{
		Config.getConfig().setGateHome();
		Gate.init();
		
		
		
		String indexurl = "http://localhost:8080/mimir-demo/378a00b6-1f94-4249-bcd6-d413f91a3a43";
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
