package czsem.apps;

import gate.Annotation;
import gate.AnnotationSet;
import gate.Document;
import gate.Factory;
import gate.Gate;
import gate.Utils;
import gate.util.GateException;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.net.URISyntaxException;
import java.util.List;

import com.csvreader.CsvWriter;

import czsem.gendertag.NamesDB;
import czsem.gendertag.NamesDB.DbRecord;
import czsem.utils.Config;

public class GenderTagger {
	
	protected NamesDB namesDB;
	
	public GenderTagger() throws Exception
	{
		namesDB = new NamesDB();		
	}
	
	public static void main(String[] args) throws Exception {
		GenderTagger gt = new GenderTagger();
		gt.createFertureFile("C:/Users/dedek/Desktop/jmena/data/male.txt", System.err);
	}


	public void createFertureFile(String inputFileName, OutputStream outputS) throws Exception
	{
		BufferedReader in = new BufferedReader(new InputStreamReader(new BufferedInputStream(new FileInputStream(inputFileName)), "utf8"));
		OutputStreamWriter prew_out = new OutputStreamWriter(new BufferedOutputStream(outputS), "utf8");
		CsvWriter out = new CsvWriter(prew_out, ',');
				
		for (;;)
		{
			String line = in.readLine();
			if (line == null) break;
			out.write(line);
			out.writeRecord(createFetures(line));
		}
		
		out.close();
		
	}


	public String[] createFetures(String name) throws Exception {
		String[] tocs = name.split(" ");
		
		DbRecord[] temp_res = namesDB.findAll("");
		for (int a=0; a<temp_res.length; a++) temp_res[a] = new DbRecord();
		
		
		for (String toc : tocs)
		{
			DbRecord[] cur = namesDB.findAll(toc);
			for (int a=0; a<temp_res.length; a++)
			{
				temp_res[a].merge(cur[a]);
			}
		}


		String[] ret = new String[temp_res.length*2];
		for (int a=0; a<temp_res.length; a++)
		{
			ret[a*2] = temp_res[a].origName; 
			ret[a*2+1] = Integer.toString(temp_res[a].nameFrquency); 
		}

		return ret;
	}


	public static void linguisticMain(String[] args) throws GateException, URISyntaxException, IOException {
	    Config.getConfig().setGateHome();
	    Gate.init();
	    
	    Document doc = Factory.newDocument(new File("C:/Users/dedek/Desktop/jmena/pasinka.xml").toURI().toURL(), "cp1250");
	    
	    AnnotationSet as = doc.getAnnotations("TectoMT2");
	    AnnotationSet sents = as.get("Sentence");
	    
	    for (Annotation s : sents)
	    {
	    	AnnotationSet tocs = as.getContained(s.getStartNode().getOffset(), s.getEndNode().getOffset()).get("Token");
	    	List<Annotation> sorted = Utils.inDocumentOrder(tocs);

	    	System.err.format("'%s' (", doc.getContent().getContent(s.getStartNode().getOffset(), s.getEndNode().getOffset()).toString());
	    	
	    	int male=0, female=0;

	    	for (Annotation t : sorted)
	    	{
	    		String tag = (String) t.getFeatures().get("tag");
	    		char gen = tag.charAt(2);
		    	System.err.print(gen);
		    	
		    	switch (gen) {
				case 'F': 
				case 'H': 
				case 'Q': female++; break;
				case 'I': 
				case 'Y': 
				case 'Z': 
				case 'M': male++; break;

				}
	    	}
	    	
	    	String res = "?";	    	
	    	if (male > female) res = "male";
	    	if (female > male) res = "female";
	    	
			System.err.format(") %s\n", res);
	    }

	}

}
