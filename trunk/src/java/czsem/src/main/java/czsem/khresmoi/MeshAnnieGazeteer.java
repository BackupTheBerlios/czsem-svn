package czsem.khresmoi;

import gate.Annotation;
import gate.AnnotationSet;
import gate.Document;
import gate.Factory;
import gate.Gate;
import gate.Utils;
import gate.util.GateException;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Stack;

import javax.xml.parsers.ParserConfigurationException;
import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;

import org.xml.sax.Attributes;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;

import czsem.khresmoi.MeshAnnieGazeteer.MeshRecord;
import czsem.utils.Config;


public class MeshAnnieGazeteer extends DefaultHandler
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
	
	StringBuilder sb = null;
	
	private Stack<String> qNameStack = new Stack<String>();

	private String output_file_name;
	private Outputter outputter;

	
	public MeshAnnieGazeteer(String output_file_name, Outputter outputter)
	{
		this.output_file_name = output_file_name;
		this.outputter = outputter; 
	}

	@Override
	public void startElement(String uri, String localName, String qName, Attributes attributes) throws SAXException
	{
		if (qName.equals("DescriptorRecord")) records.add(new MeshRecord());
		
		if (elemTest(qName))
		{
			sb = new StringBuilder();			
		}

		qNameStack.push(qName);		
	}
	
	protected boolean elemTest(String qName)
	{
		if (qName.equals("DescriptorUI")) return true;
		
		if (qName.equals("String") && qNameStack.peek().equals("DescriptorName")) return true;
		
		return false;
	}

	@Override
	public void endElement(String uri, String localName, String qName) throws SAXException
	{
		qNameStack.pop();		
		if (elemTest(qName))
		{
			String str = sb.toString();
			
			if (qName.equals("DescriptorUI"))
			{
				if (qNameStack.get(qNameStack.size()-1).equals("DescriptorRecord"))
				{
					records.get(records.size()-1).meshID = str;
				}
			}
			
			if (qNameStack.peek().equals("DescriptorName"))
			{
				if (qNameStack.get(qNameStack.size()-2).equals("DescriptorRecord"))
				{
					MeshRecord rec = records.get(records.size()-1);
					String[] names = str.split("[\\[\\]]");
					if (names.length > 1)
					{
						rec.czTerm = names[0];
						rec.enTerm = names[1];
					} 
					else 
					{
						rec.czTerm = "";
						rec.enTerm = str;
					} 
				}
			}
		}
		
		sb = null;
	}

	@Override
	public void characters(char[] ch, int start, int length) throws SAXException
	{
		if (sb != null)
		{
			sb.append(ch, start, length);
		}
	}

	@Override
	public void ignorableWhitespace(char[] ch, int start, int length)
			throws SAXException {
	}

	@Override
	public void endDocument() throws SAXException
	{
		System.err.println("DescriptorRecords: " + records.size());
		
		try {
			writeGazeteerList();
		} catch (Exception e) {
			throw new SAXException(e);
		}
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
		
		SAXParserFactory spf = SAXParserFactory.newInstance();
	    spf.setValidating(false); // No validation required
	    spf.setFeature("http://apache.org/xml/features/nonvalidating/load-external-dtd", false);
	    SAXParser sax_parser = spf.newSAXParser();
	    
		InputSource input = new InputSource(new FileInputStream("c:/data/Khresmoi/czmesh/mesh2011.xml"));
//		InputSource input = new InputSource(new FileInputStream("c:/data/Khresmoi/mesh/desc2011.xml"));
/**/	    
	    sax_parser.parse(input, new MeshAnnieGazeteer(
	    		Config.getConfig().getCzsemPluginDir() + "/resources/gazetteer/meshcz_lemmas.lst",
	    		new Outputter(){
					@Override
					public void outputRecord(PrintWriter out, MeshRecord rec, int ord_num) {
						out.format("%s:meshID=%s:czTerm=%s:enTerm=%s\n", mesh_lemmas[ord_num], rec.meshID, rec.czTerm, rec.enTerm);						
					}}));
/*
	    sax_parser.parse(input, new MeshAnnieGazeteer(
	    		Config.getConfig().getCzsemPluginDir() + "/resources/gazetteer/meshcz_lemma.txt",
	    		new Outputter(){
					@Override
					public void outputRecord(PrintWriter out, MeshRecord rec) {
						out.format("<Sentence>%s</Sentence>\n", rec.czTerm);						
					}}));
/**/

	    
	    System.err.println("end");

	}

}
