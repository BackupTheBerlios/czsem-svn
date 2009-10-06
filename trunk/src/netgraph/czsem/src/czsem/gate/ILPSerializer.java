
package czsem.gate;

import gate.*;
import gate.corpora.DocumentImpl;
import gate.creole.*;
import gate.creole.metadata.*;
import gate.util.GateException;

import java.io.*;
import java.net.URL;
import java.text.CharacterIterator;
import java.text.SimpleDateFormat;
import java.text.StringCharacterIterator;
import java.util.*;

import czsem.ILP.Serializer;
import czsem.ILP.Serializer.Relation;


@CreoleResource(name = "czsem ILPSerializer", comment = "Exports given corpus to ILP background knowledge")
public class ILPSerializer extends AbstractLanguageAnalyser implements
		ProcessingResource, LanguageAnalyser {

	public static class ReaderThread extends Thread {
		private InputStream is;
		private OutputStream os;
		public ReaderThread(InputStream is, OutputStream os) {
			this.is = is;
			this.os = os;
		}
		
		@Override
		public void run() {
			byte [] buf = new byte[1000];
			try {
				for (int i=is.read(buf); i>=0; i=is.read(buf))
				{
					os.write(buf, 0, i);
				}
			} catch (IOException e) {}				
		}
	}


	private static final long serialVersionUID = 6469933231715581382L;
	
	private List<String> annotationTypesToSerialze = null;
	private List<String> featureNamesToSerialze = null;

	
/*
	protected void serializeDependency(Annotation dep_annot)
	{
		ArrayList<Integer> args = (ArrayList<Integer>) annotation.getFeatures().get("args");
		ser.putBinTuple(edge, args.get(0).toString(), args.get(1).toString());
		
		ser.putBinTuple(dep_kind, args.get(1).toString(), (String) annotation.getFeatures().get("kind"));
		System.out.print(annotation);
	}
*/
	private File working_directory;
	public String ILP_proj_dir = "C:\\workspace\\czsem\\src\\netgraph\\czsem\\ILP_serial_projects\\";
	public String project_name = "serialized_exp";
	private Serializer ser;		
	
	public void init_project() throws FileNotFoundException, UnsupportedEncodingException
	{
        Calendar rightNow = Calendar.getInstance();
        SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd_HHmmss");
        String time_stamp = df.format(rightNow.getTime());
        
        StringBuilder file_strb = new StringBuilder();
        file_strb.append(ILP_proj_dir);
        file_strb.append(time_stamp);
//        file_strb.append("pokkk");
        
        working_directory = new File(file_strb.toString());
        working_directory.mkdir();
    

        file_strb.append('\\');
        file_strb.append(project_name);
        file_strb.append(".b");

		ser = new Serializer(file_strb.toString());		
	}
	
	protected void serializeAnnotationSet(AnnotationSet annotations)
	{		
		
		Relation annot_type = ser.addBinRelation("annot_type", "annotation", "annot_type");
		ser.putBinaryMode(annot_type, "1", '+', '#');
		
		Relation dep_edge = ser.addBinRelation("dependency", "annotation", "annotation");
		ser.putBinaryMode(dep_edge, "*", '+', '-');
		ser.putBinaryMode(dep_edge, "1", '-', '+');
		
		Relation dep_kind = ser.addBinRelation("dep_kind", "annotation", "dep_kind");
		ser.putBinaryMode(dep_edge, "1", '+', '#');
		
		List<String> feat_names = getFeatureNamesToSerialze();
		Relation [] feat_rels = new Relation[feat_names.size()];
		
		for (int i=0; i<feat_rels.length; i++)
		{
			feat_rels[i] = ser.addBinRelation("has_" + feat_names.get(i), "annotation", feat_names.get(i));
			ser.putBinaryMode(feat_rels[i], "1", '+', '#');
		}
		
		ser.putCommentLn("------ TUPLES ------");
		
		for (String ser_type_name : annotationTypesToSerialze) {
			for (Annotation annotation : annotations.get(ser_type_name))
			{
				ser.putBinTuple(annot_type, annotation.getId().toString(), annotation.getType());

				for (int i=0; i<feat_rels.length; i++)
				{
					String feat_val = (String) annotation.getFeatures().get(feat_names.get(i));
					if (feat_val != null)
						ser.putBinTuple(feat_rels[i], annotation.getId().toString(), feat_val);
				}
			}
			
		}
		
/**/	//Dependencies
		for (Annotation annotation : annotations.get("Dependency"))
		{
			ArrayList<Integer> args = (ArrayList<Integer>) annotation.getFeatures().get("args");
			ser.putBinTuple(dep_edge, args.get(0).toString(), args.get(1).toString());				
			ser.putBinTuple(dep_kind, args.get(1).toString(), (String) annotation.getFeatures().get("kind"));
		}
		
		ser.putCommentLn("------ TYPES ------");
/**/
		ser.outputAllTypes();
		
		
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

	protected void execILP() throws IOException, InterruptedException
	{
		String prolog_path = "C:\\Program Files\\Yap\\bin\\yap.exe";
		String aleph_path = "C:\\Program Files\\aleph\\aleph.pl";
		
		String [] exec_args = {prolog_path, "-l", aleph_path };
		
		System.err.println(prolog_path);
		System.err.println(aleph_path);
		
		Process prolog_proc = Runtime.getRuntime().exec(exec_args, null, working_directory);
//				new String [] {"LANG=cs_CZ.UTF-8"} , working_directory);
		
		PrintStream os = new PrintStream(new BufferedOutputStream(prolog_proc.getOutputStream()));
		BufferedInputStream is = new BufferedInputStream(prolog_proc.getInputStream());
		BufferedInputStream ierr = new BufferedInputStream(prolog_proc.getErrorStream());
		
		new ReaderThread(is, System.out).start();
		new ReaderThread(ierr, System.err).start();
		
		os.println("yap_flag(encoding,X).\n");
		os.flush();
/**
		os.println("yap_flag(encoding,utf8).");
		os.flush();
		
		Thread.sleep(3000);
/**/		
/**/		
		os.print("read_all(");
		os.print(project_name);
		os.println(").");
		os.flush();
/**/
		os.println("halt.");
		os.flush();

		System.err.println("halt sent..");
			
		prolog_proc.waitFor();
//		System.err.println(prolog_proc.exitValue());
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
		features.add("category");
		features.add("string");
		features.add("root");
/**/		
		ilp_ser.setAnnotationTypesToSerialze(types);			
		ilp_ser.setFeatureNamesToSerialze(features);			
		
		ilp_ser.init_project();
		
		ilp_ser.serializeAnnotationSet(as);
		
		ilp_ser.execILP();

		
//		System.out.print(Serializer.encodeValue("01"));
	}


	public List<String> getAnnotationTypesToSerialze() {
		return annotationTypesToSerialze;
	}


	@RunTime
	@Optional
	@CreoleParameter(comment="Names of annotation types to be serilaized.", defaultValue="Token")
	public void setAnnotationTypesToSerialze(List<String> annotationTypesToSerialze) {
		System.err.println("ILPSer SetAnnotationTypesTo..");
		this.annotationTypesToSerialze = annotationTypesToSerialze;
	}


	public List<String> getFeatureNamesToSerialze() {
		return featureNamesToSerialze;
	}


	@RunTime
	@Optional
	@CreoleParameter(comment="Names of annotation features to be serilaized.", defaultValue="category;root;string")
	public void setFeatureNamesToSerialze(List<String> featureNamesToSerialze) {
		this.featureNamesToSerialze = featureNamesToSerialze;
	}

}
