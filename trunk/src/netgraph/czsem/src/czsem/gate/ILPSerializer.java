package czsem.gate;

import gate.*;
import gate.corpora.DocumentImpl;
import gate.creole.*;
import gate.creole.metadata.*;
import gate.util.GateException;

import java.io.File;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

import czsem.ILP.Serializer;
import czsem.ILP.Serializer.Relation;

@CreoleResource(name = "czsem ILPSerializer", comment = "Exports given corpus to ILP background knowledge")
public class ILPSerializer extends AbstractLanguageAnalyser implements
		ProcessingResource, LanguageAnalyser {

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
	protected void serializeAnnotationSet(AnnotationSet annotations)
	{
		Serializer ser = new Serializer();

		Relation annot_type = ser.addBinRelation("annot_type", "annotation", "annot_type");
		
		Relation dep_edge = ser.addBinRelation("dependency", "annotation", "annotation");
		Relation dep_kind = ser.addBinRelation("dep_kind", "annotation", "dep_kind");
		
		List<String> feat_names = getFeatureNamesToSerialze();
		Relation [] feat_rels = new Relation[feat_names.size()];
		
		for (int i=0; i<feat_rels.length; i++)
		{
			feat_rels[i] = ser.addBinRelation("has_" + feat_names.get(i), "annotation", feat_names.get(i));
		}
		
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
		
		//Dependencies
		for (Annotation annotation : annotations.get("Dependency"))
		{
			ArrayList<Integer> args = (ArrayList<Integer>) annotation.getFeatures().get("args");
			ser.putBinTuple(dep_edge, args.get(0).toString(), args.get(1).toString());				
			ser.putBinTuple(dep_kind, args.get(1).toString(), (String) annotation.getFeatures().get("kind"));
		}
		
		ser.outputAllTypes();
		
		
/*
		for (Annotation sentence : annotations.get("Sentence"))
		{
			AnnotationSet sentence_set = annotations.getContained(
					sentence.getStartNode().getOffset(), sentence.getEndNode().getOffset());
						
			SentenceFSWriter wr = new SentenceFSWriter(sentence_set, out, attributes);
			wr.printTree();
		}		
*/
	}

	
	public void execute() throws ExecutionException
	{		
		serializeAnnotationSet(document.getAnnotations());				
	}


	public static void main(String[] args) throws GateException, MalformedURLException
	{
		Gate.setNetConnected(false);
	    Gate.setLocalWebServer(false);
	    Gate.setGateHome(new File("C:\\Program Files\\GATE-5.0"));

	    Gate.init();
	    	    
	    Gate.getCreoleRegister().registerDirectories(new URL("file:/C:/Program%20Files/GATE-5.0/plugins/Stanford/"));
	    				
		DataStore ds = Factory.openDataStore("gate.persist.SerialDataStore", "file:/C:/Program%20Files/GATE-5.0/data_store/");
		ds.open();
		
		for (Object string : ds.getLrIds("gate.corpora.DocumentImpl")) {
			System.err.println(string);
		}

		FeatureMap docFeatures = Factory.newFeatureMap();
		docFeatures.put(DataStore.LR_ID_FEATURE_NAME, "GATE Document_00018___1243768759160___760");
		docFeatures.put(DataStore.DATASTORE_FEATURE_NAME, ds);		
		docFeatures.put(Document.DOCUMENT_MARKUP_AWARE_PARAMETER_NAME, "false");		
		DocumentImpl doc = (DocumentImpl) Factory.createResource("gate.corpora.DocumentImpl", docFeatures);
		
		
		AnnotationSet as =  doc.getAnnotations();
		
		ILPSerializer ilp_ser = new ILPSerializer();
		
		ArrayList<String> types = new ArrayList<String>();
		ArrayList<String> features = new ArrayList<String>();
		types.add("Token");
		features.add("category");
		features.add("string");
		features.add("root");
		ilp_ser.setAnnotationTypesToSerialze(types);			
		ilp_ser.setFeatureNamesToSerialze(features);			
		
		ilp_ser.serializeAnnotationSet(as);
	}


	public List<String> getAnnotationTypesToSerialze() {
		return annotationTypesToSerialze;
	}


	@RunTime
	@Optional
	@CreoleParameter(comment="Names of annotation types to be serilaized.", defaultValue="Token")
	public void setAnnotationTypesToSerialze(List<String> annotationTypesToSerialze) {
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
