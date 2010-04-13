
package czsem.gate;

import gate.*;
import gate.corpora.DocumentImpl;
import gate.creole.*;
import gate.creole.metadata.*;
import gate.util.Err;
import gate.util.GateException;
import gate.util.InvalidOffsetException;
import gate.util.Out;

import java.io.*;
import java.net.URL;
import java.util.*;

import czsem.utils.ProcessExec.ReaderThread;
import czsem.ILP.ILPExec;
import czsem.ILP.Serializer;
import czsem.ILP.Serializer.Relation;
import czsem.utils.Config;
import czsem.utils.ProjectSetup;


@CreoleResource(name = "czsem ILPSerializer", comment = "Exports given corpus to ILP background knowledge")
public class ILPSerializer extends AbstractLanguageAnalyser implements
		ProcessingResource, LanguageAnalyser {

	protected ProjectSetup project_setup = new ProjectSetup();


	private static final long serialVersionUID = 6469933231715581382L;
	
	private List<String> annotationTypesToSerialze = null;
	private List<String> featureNamesToSerialze = null;
	private List<String> dependecyAnnotationTypes = null;

	
/*
	protected void serializeDependency(Annotation dep_annot)
	{
		ArrayList<Integer> args = (ArrayList<Integer>) annotation.getFeatures().get("args");
		ser.putBinTuple(edge, args.get(0).toString(), args.get(1).toString());
		
		ser.putBinTuple(dep_kind, args.get(1).toString(), (String) annotation.getFeatures().get("kind"));
		System.out.print(annotation);
	}
*/
	
	protected void serializeAnnotationSet(AnnotationSet annotations) throws FileNotFoundException, UnsupportedEncodingException
	{
		//logging
		Err.println("Anntoation types:");
		for (String type_name : annotations.getAllTypes()) {
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
		return  sb.toString();
	}

	protected static String renderID(Annotation anntotation, AnnotationSet as)
	{
		return renderID(anntotation.getId(), as);
	}

	protected static int parseID(String id_string)
	{				
		return Integer.parseInt(id_string.split("_", 3)[2]);
	}

	@SuppressWarnings("unchecked")
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
		
		Relation dep_kind = ser_bkg.addBinRelation("dep_kind", "annotation", "dep_kind");
		ser_bkg.putBinaryMode(dep_kind, "1", '+', '#');
		
		List<String> feat_names = getFeatureNamesToSerialze();
		Relation [] feat_rels = new Relation[feat_names.size()];
		
		
		Relation pos_neg = ser_bkg.addRealtion(project_setup.project_name, new String[]{"annotation"});
		ser_bkg.putMode(pos_neg, "1", new char[] {'+'});
		ser_bkg.putDetermination(pos_neg, annot_type);
		ser_bkg.putDetermination(pos_neg, dep_edge);
		ser_bkg.putDetermination(pos_neg, dep_kind);

		
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
		
/**/	//Dependencies
		for (Annotation annotation : annotations.get("Dependency"))
		{
			ArrayList<Integer> args = (ArrayList<Integer>) annotation.getFeatures().get("args");
			
			ser_bkg.putBinTuple(dep_edge, 
					renderID(args.get(0), annotations),
					renderID(args.get(1), annotations));				
			
			ser_bkg.putBinTuple(dep_kind, 
					renderID(args.get(1), annotations),
					(String) annotation.getFeatures().get("kind"));
		}
		
		ser_bkg.putCommentLn("------ TYPES ------");
/**/
		ser_bkg.outputAllTypes();
		
		
/*
		for (Annotation sentence : annotations.get("Sentence"))
		{
			AnnotationSet sentence_set = annotations.getContained(
					sentence.getStartNode().getOffset(), sentence.getEndNode().getOffset());
						
			SentenceFSWriter wr = new SentenceFSWriter(sentence_set, out, attributes);
			wr.printTree();
		}		
/**/
	}

	@Override
	public Resource init() throws ResourceInstantiationException {
		System.err.println("ILPSer Init");
		
		return super.init();
	}
	
	@Override
	public void reInit() throws ResourceInstantiationException {
		System.err.println("ILPSer Reinit");
		
		super.reInit();
	}
	
	@Override
	public void setCorpus(Corpus corpus) {
		System.err.println("ILPSer SetCorpus");

		super.setCorpus(corpus);
	}
	
	@Override
	public void setDocument(Document document) {
		System.err.println("ILPSer SetDocument");
		// TODO Auto-generated method stub
		super.setDocument(document);
	}
	
	public void execute() throws ExecutionException
	{	
		System.err.println("ILPSer Execute");
		/*
		try {
			serializeAnnotationSet(document.getAnnotations());
		} catch (FileNotFoundException e) {
			throw new ExecutionException(e);
		}	
		*/			
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
		
/**
		new ReaderThread(is, System.out).start();
/**/				
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

/**
		new ReaderThread(is, System.out).start();
		new ReaderThread(ierr, System.err).start();
/**/				
		
		
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

/**/
		types.add("Token");
		types.add("PosNeg");
		features.add("category");
		features.add("string");
		features.add("root");
		features.add("isPositve");
		
/**/		
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
	@CreoleParameter(comment="Names of annotation types to be serilaized.", defaultValue="Token;PosNeg")
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

}
