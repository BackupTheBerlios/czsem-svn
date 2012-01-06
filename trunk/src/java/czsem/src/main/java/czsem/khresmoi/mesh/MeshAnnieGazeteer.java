package czsem.khresmoi.mesh;

import gate.Annotation;
import gate.AnnotationSet;
import gate.Document;
import gate.Factory;
import gate.Gate;
import gate.Utils;
import gate.util.GateException;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.xml.parsers.ParserConfigurationException;

import org.xml.sax.SAXException;

import czsem.utils.Config;


public class MeshAnnieGazeteer extends MeshSaxParser
{
	public static interface Outputter
	{

		void outputRecord(PrintWriter out, MeshRecord rec, int ord_num);
	}
	
	public static class MeshRecord
	{		
		String czTerm;
		String enTerm;

		String meshID;
	}
	
	List<MeshRecord> records = new ArrayList<MeshRecord>(10000);
	
	

	private String output_file_name;
	private Outputter outputter;

	
	public MeshAnnieGazeteer(String output_file_name, Outputter outputter)
	{
		this.output_file_name = output_file_name;
		this.outputter = outputter; 
	}



	private void writeGazeteerList() throws IOException, URISyntaxException 
	{
		PrintWriter out = 
			new PrintWriter(
				new OutputStreamWriter(
					new BufferedOutputStream(
							new FileOutputStream(output_file_name)),
					"utf8"));
		
		for(int a=0; a<records.size(); a++)
		{
			MeshRecord rec = records.get(a);
			outputter.outputRecord(out, rec, a);
		}
		out.println();
		out.close();
		
	}

	public static String [] loadMeshLemmas() throws GateException, URISyntaxException, IOException
	{
		Config.getConfig().setGateHome();
		Gate.init();
		
		Document doc = Factory.newDocument(new File("C:\\Users\\dedek\\Desktop\\meshcz_analysed_gate.xml").toURI().toURL());
		
		AnnotationSet tmt = doc.getAnnotations("TectoMT");
		AnnotationSet sents = tmt.get("Sentence");
		AnnotationSet tocs = tmt.get("Token");
		
		String [] ret = new String[sents.size()];
		
		List<Annotation> ord_sents = Utils.inDocumentOrder(sents);
		int a = 0;
		for (Iterator<Annotation> iterator = ord_sents.iterator(); iterator.hasNext();) {
			Annotation s = (Annotation) iterator.next();
			
			AnnotationSet conttocs = tocs.getContained(
					s.getStartNode().getOffset(), s.getEndNode().getOffset());
			List<Annotation> ord_tocs = Utils.inDocumentOrder(conttocs);
			StringBuilder sb = new StringBuilder();
			for (Annotation toc : ord_tocs) {
				sb.append(toc.getFeatures().get("clean_lemma"));				
				sb.append(' ');				
			}
			sb.deleteCharAt(sb.length()-1);
			ret[a] = sb.toString();
			
			a++;
			
		}
		return ret;
	}
	
	public static void main(String[] args) throws ParserConfigurationException, SAXException, IOException, URISyntaxException, GateException
	{
		System.err.println("start");
		final String[] mesh_lemmas = loadMeshLemmas();
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
						out.format("%s:meshID=%s:czTerm=%s:enTerm=%s\n", mesh_lemmas[ord_num], rec.meshID, rec.czTerm, rec.enTerm);						
					}});
	    		
		
	    g.parse("c:/data/Khresmoi/czmesh/mesh2011.xml");
//	    g.parse("c:/data/Khresmoi/mesh/desc2011.xml");
		
		g.writeGazeteerList();

	    System.err.print("end, record written: ");
	    System.err.println(g.records.size());

	}



	@Override
	public void newRecord() {
		records.add(new MeshRecord());		
	}



	@Override
	public void putMeshID(String meshID) {
		records.get(records.size()-1).meshID = meshID;
	}



	@Override
	public void putCzTerm(String czTerm) {
		MeshRecord rec = records.get(records.size()-1);
		rec.czTerm = czTerm;		
	}



	@Override
	public void putEnTerm(String enTerm) {
		MeshRecord rec = records.get(records.size()-1);
		rec.enTerm = enTerm;				
	}



	@Override
	public void putTreeNumber(String treeNumber) {
		// TODO Auto-generated method stub
		
	}

}
