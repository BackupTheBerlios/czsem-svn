package cuni.khresmoi.mesh;

import gate.Annotation;
import gate.AnnotationSet;
import gate.Document;
import gate.Factory;
import gate.Gate;
import gate.Utils;
import gate.util.GateException;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;

import javax.xml.parsers.ParserConfigurationException;

import org.xml.sax.SAXException;

import cuni.khresmoi.KhresmoiConfig;
import cuni.khresmoi.mesh.MeshRecordDB.MeshRecord;
import czsem.utils.Config;


public class MeshAnnieGazeteer
{
	public static interface Outputter
	{
		void outputRecord(PrintWriter out, MeshRecord rec, int ord_num);
	}
	
	
	

	private String output_file_name;
	private Outputter outputter;
	Collection<MeshRecord> records;

	
	public MeshAnnieGazeteer(String output_file_name, Outputter outputter)
	{
		this.output_file_name = output_file_name;
		this.outputter = outputter; 
	}



	public void writeGazeteerList() throws IOException, URISyntaxException 
	{
		PrintWriter out = 
			new PrintWriter(
				new OutputStreamWriter(
					new BufferedOutputStream(
							new FileOutputStream(output_file_name)),
					"utf8"));
		

		int ord_num = 0;
		for (MeshRecord r : records)
		{
			outputter.outputRecord(out, r, ord_num++);			
		}
		
		out.println();
		out.close();		
	}

	public static List<String> [] loadMeshLemmas() throws GateException, URISyntaxException, IOException
	{
		Config.getConfig().setGateHome();
		Gate.init();
		
		Document doc = Factory.newDocument(new File(
				KhresmoiConfig.getConfig().getMeshCzLammatizationAnalysisOutput())
				.toURI().toURL());
		
		AnnotationSet tmt = doc.getAnnotations("TectoMT");
		AnnotationSet sents = tmt.get("Sentence");
		AnnotationSet tocs = tmt.get("Token");
		
		@SuppressWarnings("unchecked")
		List<String>[] ret = new ArrayList[sents.size()];
		
		List<Annotation> ord_sents = Utils.inDocumentOrder(sents);
		int a = 0;
		for (Iterator<Annotation> iterator = ord_sents.iterator(); iterator.hasNext();) {
			Annotation s = (Annotation) iterator.next();
			
			AnnotationSet conttocs = tocs.getContained(
					s.getStartNode().getOffset(), s.getEndNode().getOffset());
			List<Annotation> ord_tocs = Utils.inDocumentOrder(conttocs);
			List<String> sb = new ArrayList<String>(ord_tocs.size());
			for (Annotation toc : ord_tocs) {
				sb.add((String) toc.getFeatures().get("clean_lemma"));				
			}
			ret[a] = sb;
			
			a++;
			
		}
		return ret;
	}
	
	public static void main(String[] args) throws ParserConfigurationException, SAXException, IOException, URISyntaxException, GateException, ClassNotFoundException
	{
		System.err.println("start");
		final List<String>[] mesh_lemmas = loadMeshLemmas();
		System.err.println("mesh lemmas loaded");
		
/*	    
		MeshAnnieGazeteer g = new MeshAnnieGazeteer(
	    		Config.getConfig().getCzsemPluginDir() + "/resources/gazetteer/meshcz_lemma.txt",
	    		new Outputter(){
					@Override
					public void outputRecord(PrintWriter out, MeshRecord rec) {
						out.format("<Sentence>%s</Sentence>\n", rec.czTerm);						
					}});
/**/

		
		MeshAnnieGazeteer g = new MeshAnnieGazeteer(
	    		Config.getConfig().getCzsemPluginDir() + "/resources/gazetteer/meshcz_lemmas.lst",
	    		new Outputter(){
					@Override
					public void outputRecord(PrintWriter out, MeshRecord rec, int ord_num) {
						out.format("%s:meshID=%s:czTerm=%s:enTerm=%s\n", 
								czsem.Utils.listToStr(mesh_lemmas[ord_num], " "),
								rec.meshID, rec.czTerm, rec.enTerm);						
					}});
	    		
				
		g.loadMeshDB();
		
		g.writeGazeteerList();

	    System.err.print("end, record written: ");
	    System.err.println(g.records.size());

	}



	void loadMeshDB() throws FileNotFoundException, IOException, ClassNotFoundException, URISyntaxException {
		MeshRecordDB db = new MeshRecordDB();
		db.load();
		records = db.getRecords();		
	}
}
