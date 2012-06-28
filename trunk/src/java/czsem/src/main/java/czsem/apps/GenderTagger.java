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
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.net.URISyntaxException;
import java.util.List;
import java.util.Locale;

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
		Locale.setDefault(Locale.ENGLISH);

		GenderTagger gt = new GenderTagger();
		
		OutputStream out = new FileOutputStream("C:/Users/dedek/Desktop/jmena/data/weka.csv");
		OutputStreamWriter prew_out = new OutputStreamWriter(new BufferedOutputStream(out), "utf8");
		CsvWriter csv_out = new CsvWriter(prew_out, ',');

		gt.writeFeaturesToStream(null, csv_out , null);
		gt.writeFeaturesToStream("C:/Users/dedek/Desktop/jmena/data/male.txt", csv_out , "male");
		gt.writeFeaturesToStream("C:/Users/dedek/Desktop/jmena/data/female.txt", csv_out , "female");
		csv_out.close();
	}


	public void writeFeaturesToStream(String inputFileName, CsvWriter out, String className) throws Exception
	{
		
		if (inputFileName == null)
		{
			out.write("class");
			out.write("name");
			out.writeRecord(namesDB.getHeadersShort());
			return;
		}

		BufferedReader in = new BufferedReader(new InputStreamReader(new BufferedInputStream(new FileInputStream(inputFileName)), "utf8"));
						
		for (;;)
		{
			String line = in.readLine();
			if (line == null) break;
			if (disardInstance(line)) 
				continue;
			out.write(className);
			out.write(line);
			out.writeRecord(createFetures(line));
		}
		in.close();
	}

	public static boolean disardInstance(String name) {
		String[] tocs = name.split(" ");
		if (tocs.length <= 1) return true;
		int max = 0;
		for (String toc : tocs)
		{
			max = Math.max(max, toc.length());
		}
		if (max <= 2) return true;
		return false;
	}

	public String[] createFetures(String name) throws Exception {
		DbRecord[] feat_data = createLoadData(name);
		String[] ret = new String[feat_data .length];
		for (int a=0; a<feat_data.length; a++)
		{
			ret[a] = Double.toString(feat_data[a].nameFrquency); 
		}

		return ret;		
	}

	public String[] createFeturesAll(String name) throws Exception {
		DbRecord[] feat_data = createLoadData(name);
		String[] ret = new String[feat_data .length*2];
		for (int a=0; a<feat_data.length; a++)
		{
			ret[a*2] = feat_data[a].origName; 
			ret[a*2+1] = Double.toString(feat_data[a].nameFrquency); 
		}

		return ret;
	}

	public DbRecord[] createLoadData(String name) throws Exception {
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
		return temp_res;
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
