
package czsem.gate;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import org.jdom.Element;

import czsem.ILP.LinguisticSerializer;
import gate.Annotation;
import gate.AnnotationSet;
import gate.Document;
import gate.FeatureMap;
import gate.creole.AbstractLanguageAnalyser;
import gate.creole.metadata.CreoleResource;


@CreoleResource(name = "czsem ILPSerializer", comment = "Exports given corpus to ILP background knowledge")
public class ILPSerializer extends AbstractLanguageAnalyser
{
	private static final long serialVersionUID = 6469933231715581382L;
	
	protected LinguisticSerializer lingSer;
	
	protected String docName;
	protected AnnotationSet as;
	
	protected String [] tokens =
	{
//		"Token",
//		"tToken"
	};

	protected String [][] token_features = 
	{
//			{"form", "lemma", "tag", "afun", "ord"},
//			{"nodetype", "t_lemma", "functor", "deepord", "formeme", "sempos", "gender", "negation", "number",
//			"degcmp", "verbmod", "deontmod", "tense", "aspect", "resultative",	"dispmod", "iterativeness"}
	};
	
	protected String [] tree_dependecies =
	{
//		"Dependency",
//		"aDependency",
//		"tDependency",
//		"auxRfDependency"
	};

	protected String [][] tree_dependecy_args =
	{
//			{"Token", "Token"},			
//			{"Token", "Token"},			
//			{"tToken", "tToken"},			
//			{"tToken", "Token"},			
	};

	protected String [] one2one_dependecies =
	{
//		"lex.rf"	
	};

	protected String [][] one2one_dependecy_args =
	{
//			{"tToken", "Token"}
	};

	public ILPSerializer(String projectDir, String projectName) throws FileNotFoundException, UnsupportedEncodingException
	{
		lingSer = new LinguisticSerializer(projectDir, projectName);		
	}
	
	protected void createFeatureTypes()
	{
		int cumulative_features = 0;
		for (int t=0; t<tokens.length; t++)
		{
			for (int f=0; f<token_features[t].length; f++)
			{
				lingSer.createFeatureType(cumulative_features++, tokens[t], token_features[t][f]);
			}
		}				
	}
	protected void createTreeDependencyTypes()
	{
		for (int d=0; d<tree_dependecies.length; d++)
		{
			lingSer.createTreeDependencyType(
					d,
					tree_dependecies[d],
					tree_dependecy_args[d][0],
					tree_dependecy_args[d][1]);
		}
		
	}
	protected void createOne2oneTreeDependencyTypes()
	{
		for (int d=0; d<one2one_dependecies.length; d++)
		{
			lingSer.createOneToOneDependencyType(
					d,
					one2one_dependecies[d],
					one2one_dependecy_args[d][0],
					one2one_dependecy_args[d][1]);
		}		
	}
	
	protected void serializeToneks()
	{
		int token_features_offset = 0;
		for (int t=0; t<tokens.length; t++)
		{
			AnnotationSet tocs = as.get(tokens[t]);			
			for (Annotation token : tocs)
			{
				FeatureMap feats = token.getFeatures();
				for (int f=0; f<token_features[t].length; f++)
				{
					Object feat_val = feats.get(token_features[t][f]);
					
					if (feat_val != null)
					{
						lingSer.putFeature(
								token_features_offset + f,
								renderID(token.getId()),
								feat_val.toString());
						
					}					
				}
			}
			
			token_features_offset+= token_features[t].length;			
		}					
	}

	@SuppressWarnings("unchecked")
	protected void serializeTreeDependency(int dependencyIndex, Annotation dep_annot)
	{
		ArrayList<Integer> args = (ArrayList<Integer>) dep_annot.getFeatures().get("args");

		lingSer.putTreeDependency(
				dependencyIndex,
				renderID(args.get(0)),
				renderID(args.get(1)));
	}
	
	protected void serializeOne2OneDependency(int dependencyIndex, Annotation parent)
	{
		Object child = parent.getFeatures().get(one2one_dependecies[dependencyIndex]);
		
		if (child != null)
		{
			lingSer.putOneToOneDependency(
					dependencyIndex, 
					renderID(parent.getId()),
					renderID((Integer) child));					
		}		
	}


	protected void serializeTreeDependencies()
	{
		for (int d=0; d<tree_dependecies.length; d++)
		{
			AnnotationSet deps = as.get(tree_dependecies[d]);
			for (Annotation dep : deps)
			{
				serializeTreeDependency(d, dep);				
			}			
		}		
	}
	
	protected void serializeOne2OneDependencies()
	{
		for (int d=0; d<one2one_dependecies.length; d++)
		{
			AnnotationSet parents = as.get(one2one_dependecy_args[d][0]);
			for (Annotation parent : parents)
			{
				serializeOne2OneDependency(d, parent);
			}			
		}				
	}


	public void serializeDocument(Document document, String asName)
	{
		docName = document.getName();
		as = document.getAnnotations(asName);
		
		serializeToneks();
		serializeTreeDependencies();
		serializeOne2OneDependencies();				
	}

/*
	
	protected ProjectSetup project_setup = new ProjectSetup();


	
	private List<String> annotationTypesToSerialze = null;
	private List<String> featureNamesToSerialze = null;
	private List<String> dependecyAnnotationTypes = null;

	

	protected void serializeDependency(Annotation dep_annot)
	{
		ArrayList<Integer> args = (ArrayList<Integer>) annotation.getFeatures().get("args");
		ser.putBinTuple(edge, args.get(0).toString(), args.get(1).toString());
		
		ser.putBinTuple(dep_kind, args.get(1).toString(), (String) annotation.getFeatures().get("kind"));
		System.out.print(annotation);
	}

	
	protected void serializeAnnotationSet(AnnotationSet annotations) throws FileNotFoundException, UnsupportedEncodingException
	{
		//logging
		Err.println("Anntoation types:");
		for (String type_name : annotations.getAllTypes()) {
			Err.println(type_name);
		}
		Err.println("Dependecy anntoation types:");
		for (String type_name : dependecyAnnotationTypes) {
			Err.println(type_name);
		}
		//logging
		
		
		serializeBackgroundKnowlege(annotations);
		serializeExamples(annotations, true);
		serializeExamples(annotations, false);
	}
		
		
	protected static AnnotationSet filterExmaples(AnnotationSet annotations, boolean isPositive)
	{
		FeatureMap fmap = Factory.newFeatureMap();
		fmap.put("isPositive", Boolean.toString(isPositive));
				
		return annotations.get("PosNeg", fmap);
	}
	
	protected void serializeExamples(AnnotationSet annotations, boolean isPositive) throws FileNotFoundException, UnsupportedEncodingException
	{
        StringBuilder file_strb = new StringBuilder(project_setup.current_project_dir);
        file_strb.append(project_setup.project_name);
        if (isPositive)
        	file_strb.append(".f");
        else
        	file_strb.append(".n");

        Serializer ser_pos = new Serializer(file_strb.toString());		

        AnnotationSet tokens = annotations.get("Token");
        
        for (Annotation annotation : filterExmaples(annotations, isPositive))
		{
        	Err.print(annotation);        	
        	for (Annotation token : tokens.getContained(annotation.getStartNode().getOffset(), annotation.getEndNode().getOffset()))
        	{
            	Err.print("     ");
            	Err.print(token);
            	ser_pos.putTuple(project_setup.project_name,
            			new String[]{renderID(token, annotations)});        		
        	}
		}
	}
	
	protected static String renderID(Integer id, AnnotationSet as)
	{		
		StringBuilder sb = new StringBuilder();
		sb.append("id_");
		sb.append(as.getDocument().getName());
		sb.append('_');
		sb.append(id);
		
		assert parseID(sb.toString()) == id;
		
		return  sb.toString();
	}

	protected static String renderID(Annotation anntotation, AnnotationSet as)
	{
		return renderID(anntotation.getId(), as);
	}

	protected static int parseID(String id_string)
	{				
		String[] split = id_string.split("_");
		return Integer.parseInt(split[split.length-1]);
	}

	protected void serializeBackgroundKnowlege(AnnotationSet annotations) throws FileNotFoundException, UnsupportedEncodingException
	{		
		StringBuilder file_strb = new StringBuilder(project_setup.current_project_dir);
        file_strb.append(project_setup.project_name);
        file_strb.append(".b");

        Serializer ser_bkg = new Serializer(file_strb.toString());		

		
		Relation annot_type = ser_bkg.addBinRelation("annot_type", "annotation", "annot_type");
		ser_bkg.putBinaryMode(annot_type, "1", '+', '#');
		
		Relation dep_edge = ser_bkg.addBinRelation("dependency", "annotation", "annotation");
		ser_bkg.putBinaryMode(dep_edge, "*", '+', '-');
		ser_bkg.putBinaryMode(dep_edge, "1", '-', '+');
				
		List<String> feat_names = getFeatureNamesToSerialze();
		Relation [] feat_rels = new Relation[feat_names.size()];
		
		
		Relation pos_neg = ser_bkg.addRealtion(project_setup.project_name, new String[]{"annotation"});
		ser_bkg.putMode(pos_neg, "1", new char[] {'+'});
		ser_bkg.putDetermination(pos_neg, annot_type);
		ser_bkg.putDetermination(pos_neg, dep_edge);

		
		for (int i=0; i<feat_rels.length; i++)
		{
			feat_rels[i] = ser_bkg.addBinRelation("has_" + feat_names.get(i), "annotation", feat_names.get(i));
			ser_bkg.putBinaryMode(feat_rels[i], "1", '+', '#');

			ser_bkg.putDetermination(pos_neg, feat_rels[i]);
		}

		ser_bkg.putCommentLn("------ TUPLES ------");
		
		for (String ser_type_name : annotationTypesToSerialze) {
			for (Annotation annotation : annotations.get(ser_type_name))
			{
				ser_bkg.putBinTuple(annot_type, renderID(annotation, annotations), annotation.getType());

				for (int i=0; i<feat_rels.length; i++)
				{
					String feat_val = (String) annotation.getFeatures().get(feat_names.get(i));
					if (feat_val != null)
						ser_bkg.putBinTuple(feat_rels[i], renderID(annotation, annotations), feat_val);
				}
			}
			
		}
		
	//Dependencies
		for (String depeency_type: dependecyAnnotationTypes)
		{
			for (Annotation annotation : annotations.get(depeency_type))
			{
				int[] args = GateUtils.decodeEdge(annotation);
				
				ser_bkg.putBinTuple(dep_edge, 
						renderID(args[0], annotations),
						renderID(args[1], annotations));								
			}
		}
		
		ser_bkg.putCommentLn("------ TYPES ------");

		ser_bkg.outputAllTypes();
		
		

		for (Annotation sentence : annotations.get("Sentence"))
		{
			AnnotationSet sentence_set = annotations.getContained(
					sentence.getStartNode().getOffset(), sentence.getEndNode().getOffset());
						
			SentenceFSWriter wr = new SentenceFSWriter(sentence_set, out, attributes);
			wr.printTree();
		}		
/*
	}
		
	public void execute() throws ExecutionException
	{	
		System.err.println("ILPSer Execute");
		
		try {
			serializeAnnotationSet(document.getAnnotations());
		} catch (FileNotFoundException e) {
			throw new ExecutionException(e);
		}	
					
	}

	protected String prolog_path = "C:\\Program Files\\Yap\\bin\\yap.exe";
	protected String aleph_path = "C:\\Program Files\\aleph\\aleph.pl";

	protected void execILP() throws IOException, InterruptedException
	{
		ILPExec exec = new ILPExec(project_setup);
		
		exec.startILPProcess();
		exec.startReaderThreads();
		exec.induceAndWriteRules();
		exec.close();
	}
	
	protected void applyRules(AnnotationSet as) throws IOException, InterruptedException, InvalidOffsetException
	{				
		//now we are NOT using Aleph
		
		System.err.println(prolog_path);		
		Process prolog_proc = Runtime.getRuntime().exec(prolog_path, null, project_setup.working_directory);
//				new String [] {"LANG=cs_CZ.UTF-8"} , working_directory);
		
		PrintStream os = new PrintStream(new BufferedOutputStream(prolog_proc.getOutputStream()));
//		BufferedInputStream is = new BufferedInputStream(prolog_proc.getInputStream());
		BufferedReader ierr = new BufferedReader(new InputStreamReader(prolog_proc.getErrorStream()));
		
		BufferedReader is_reader = new BufferedReader(new InputStreamReader(prolog_proc.getInputStream()));
		
*//**
		new ReaderThread(is, System.out).start();
/**//*				
		new ReaderThread(ierr, System.err).start();

		os.println("yap_flag(encoding,X).\n");
		os.flush();
		
		os.print("consult('");
		os.print(project_setup.project_name);
		os.println(".b').");
		os.flush();

		os.println("consult(learned_rules).");
		os.flush();

		os.print("bagof(X,");
		os.print(project_setup.project_name);
		os.println("(X),L),print(L),print('\\n').");
		os.println();
		os.flush();
		
		String ids = is_reader.readLine();
		FeatureMap fm = Factory.newFeatureMap();
		for (String s :	ids.substring(1, ids.length()-1) .split(","))
		{
			Out.println(s);
			Annotation a = as.get(parseID(s));
			as.add(a.getStartNode().getOffset(), a.getEndNode().getOffset(), "FOUND", fm);
		}
				
		os.println("halt.");
		os.flush();

		System.err.println("halt sent..");

*//**
		new ReaderThread(is, System.out).start();
		new ReaderThread(ierr, System.err).start();
/
 * @param asName **//*				
		
		
		prolog_proc.waitFor();

		Out.println(as.getDocument().getName());
		Out.println(as.getDocument().getSourceUrl());
		Out.println(as.getDocument().getFeatures());
	}
	
	
	public static void main(String[] args) throws GateException, IOException, InterruptedException
	{	
	
		Gate.setNetConnected(false);
	    Gate.setLocalWebServer(false);
	    Gate.setGateHome(new File("C:\\Program Files\\GATE-5.0"));

	    Gate.init();
	    	    
	    Gate.getCreoleRegister().registerDirectories(new URL("file:/C:/Program%20Files/GATE-5.0/plugins/Stanford/"));
	    				
		DataStore ds = Factory.openDataStore("gate.persist.SerialDataStore", "file:/C:/Users/dedek/AppData/GATE/data_store/");
		ds.open();
		
		for (Object string : ds.getLrIds("gate.corpora.DocumentImpl")) {
			System.err.println(string);
		}

		FeatureMap docFeatures = Factory.newFeatureMap();
		docFeatures.put(DataStore.LR_ID_FEATURE_NAME, "document1___1250534929820___1521");
		docFeatures.put(DataStore.DATASTORE_FEATURE_NAME, ds);		
		docFeatures.put(Document.DOCUMENT_MARKUP_AWARE_PARAMETER_NAME, "false");		
		DocumentImpl doc = (DocumentImpl) Factory.createResource("gate.corpora.DocumentImpl", docFeatures);
		
		
		AnnotationSet as =  doc.getAnnotations();
		

		
		ILPSerializer ilp_ser = new ILPSerializer();
		
		ArrayList<String> types = new ArrayList<String>();
		ArrayList<String> features = new ArrayList<String>();


		types.add("Token");
		types.add("PosNeg");
		features.add("category");
		features.add("string");
		features.add("root");
		features.add("isPositve");
		
		
		ilp_ser.setAnnotationTypesToSerialze(types);			
		ilp_ser.setFeatureNamesToSerialze(features);			
		

		ilp_ser.project_setup.dir_for_projects = Config.getConfig().getIlpProjestsPath()+'/';
		ilp_ser.project_setup.project_name = "serialized_exp";
		ilp_ser.project_setup.init_project();
		
//		as.removeAll(as.get("FOUND"));
		ilp_ser.serializeAnnotationSet(as);
		
		ilp_ser.execILP();
		
		ilp_ser.applyRules(as);
		
		ds.sync(doc);
				
		ds.close();
				

		
//		System.out.print(Serializer.encodeValue("01"));
	}


	public List<String> getAnnotationTypesToSerialze() {
		return annotationTypesToSerialze;
	}


	@RunTime
	@Optional
	@CreoleParameter(comment="Names of annotation types to be serilaized.", defaultValue="Token;tToken;PosNeg")
	public void setAnnotationTypesToSerialze(List<String> annotationTypesToSerialze) {
		System.err.println("ILPSer SetAnnotationTypesTo..");
		this.annotationTypesToSerialze = annotationTypesToSerialze;
	}


	public List<String> getFeatureNamesToSerialze() {
		return featureNamesToSerialze;
	}


	@RunTime
	@Optional
	@CreoleParameter(comment="Names of annotation features to be serilaized.", defaultValue="category;root;string;isPositve")
	public void setFeatureNamesToSerialze(List<String> featureNamesToSerialze) {
		this.featureNamesToSerialze = featureNamesToSerialze;
	}


	public List<String> getDependecyAnnotationTypes() {
		return dependecyAnnotationTypes;
	}


	@RunTime
	@Optional
	@CreoleParameter(comment="Names of dependency annotation types to be serilaized.", defaultValue="Dependency;aDependency;tDependency")
	public void setDependecyAnnotationTypes(List<String> dependecyAnnotationTypes) {
		this.dependecyAnnotationTypes = dependecyAnnotationTypes;
	}

*/

	protected String renderID(String id)
	{
		return renderID(new Integer(id));
	}

	protected String renderID(Integer id)
	{
		return renderID(id, docName);
	}

	protected static String renderID(Integer id, String docName)
	{		
		StringBuilder sb = new StringBuilder();
		sb.append("id_");
		sb.append(docName);
		sb.append('_');
		sb.append(id);
		
		assert parseID(sb.toString()) == id;
		
		return  sb.toString();
	}

	protected static String renderID(Annotation anntotation, AnnotationSet as)
	{
		return renderID(anntotation.getId(), as.getDocument().getName());
	}

	protected static int parseID(String id_string)
	{				
		String[] split = id_string.split("_");
		return Integer.parseInt(split[split.length-1]);
	}

	
	public void train() throws IOException, InterruptedException
	{
		lingSer.train();
	}

	public void serializeTrainingInstance(String instanceGateId, String docName, String instanceTypeName, boolean isPositive)
	{
		if (instanceGateId == null) 
			throw new NullPointerException(
					String.format(
							"Instance ID is null. docName: '%s', instanceTypeName: '%s'",
							docName, instanceTypeName));
		
		String instance_id = renderID(instanceGateId);
		
		if (isPositive)
			lingSer.putPositiveExample(instance_id, instanceTypeName);
		else
				lingSer.putNegativeExample(instance_id, instanceTypeName);
	}

	public void flushAndClose()
	{
		lingSer.flushAndClose();		
	}

	public void initSerializer(Element serializerOtionsElem)
	{
		parseOptions(serializerOtionsElem);
		
		createFeatureTypes();
		createTreeDependencyTypes();
		createOne2oneTreeDependencyTypes();
		
	}
	
	public void initLearning(String className, String classTypeName, String learning_settings)
	{		
		lingSer.putLearningSettings(learning_settings);
		lingSer.putModes();
		lingSer.putDeterminations(className, classTypeName);				
	}

	@SuppressWarnings("unchecked")
	protected void parseOptions(Element serializerOtionsElem)
	{
		List<Element> tokens = serializerOtionsElem.getChild("tokens").getChildren("token");
		this.tokens = new String[tokens.size()];
		this.token_features = new String[tokens.size()][];
		for (int t=0; t<tokens.size(); t++)
		{
			Element token = tokens.get(t);
			this.tokens[t] = token.getAttributeValue("typename");
			List<Element> token_features = token.getChild("features").getChildren("feature");
			this.token_features[t] = new String[token_features.size()];
			for (int f = 0; f < token_features.size(); f++)
			{
				this.token_features[t][f] = token_features.get(f).getValue();				
			}
		}
		
		List<Element> tree_dependecies = serializerOtionsElem.getChild("tree_dependecies").getChildren("dependecy");
		this.tree_dependecies = new String[tree_dependecies.size()];
		this.tree_dependecy_args = new String[tree_dependecies.size()][];
		for (int tree_dep = 0; tree_dep < tree_dependecies.size(); tree_dep++)
		{
			this.tree_dependecies[tree_dep] = tree_dependecies.get(tree_dep).getAttributeValue("typename");
			this.tree_dependecy_args[tree_dep] = new String[2];
			this.tree_dependecy_args[tree_dep][0] = tree_dependecies.get(tree_dep).getAttributeValue("parent_typename");
			this.tree_dependecy_args[tree_dep][1] = tree_dependecies.get(tree_dep).getAttributeValue("child_typename");			
		}
		
		List<Element> one2one_dependecies = serializerOtionsElem.getChild("one2one_dependecies").getChildren("dependecy");		
		this.one2one_dependecies = new String[one2one_dependecies.size()];
		this.one2one_dependecy_args = new String[one2one_dependecies.size()][];
		for (int one_dep = 0; one_dep < one2one_dependecies.size(); one_dep++)
		{
			this.one2one_dependecies[one_dep] = one2one_dependecies.get(one_dep).getAttributeValue("typename");
			this.one2one_dependecy_args[one_dep] = new String[2];
			this.one2one_dependecy_args[one_dep][0] = one2one_dependecies.get(one_dep).getAttributeValue("parent_typename");
			this.one2one_dependecy_args[one_dep][1] = one2one_dependecies.get(one_dep).getAttributeValue("child_typename");			
		}		
	}

	public void setBackgroundSerializerFileName(String fileName) throws FileNotFoundException, UnsupportedEncodingException
	{
		lingSer.setBackgroundSerializerFileName(fileName);		
	}

	public String[] classifyInstances(String[] instancesGateIds, String targetRelationName) throws IOException, InterruptedException
	{
		for (int i = 0; i < instancesGateIds.length; i++) {
			instancesGateIds[i] = renderID(instancesGateIds[i]);
		}
		
		return lingSer.classifyInstances(instancesGateIds, docName, targetRelationName);
	}

	public void closeBackgroundSerializer() {
		lingSer.closeBackgroundSerializer();
	}
}
