package czsem.gendertag;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.util.Arrays;
import java.util.Locale;

import com.csvreader.CsvWriter;

import czsem.gendertag.NamesDB.DbRecord;


public class FeatureMaker {
	
	protected NamesDB namesDB;
	
	public FeatureMaker() throws Exception
	{
		namesDB = new NamesDB();		
	}
	
	public static void main(String[] args) throws Exception {
		Locale.setDefault(Locale.ENGLISH);

		FeatureMaker gt = new FeatureMaker();
		
		System.err.println(Arrays.toString(gt.findAllToStr(" Jan")));

		
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
			out.writeRecord(NamesDB.getHeadersShort());
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

	public double[] createDoubleFetures(String name) throws Exception {
		DbRecord[] feat_data = createFeatureData(name);
		double[] ret = new double[feat_data .length];
		for (int a=0; a<feat_data.length; a++)
		{
			ret[a] = feat_data[a].nameFrquency; 
		}

		return ret;				
	}

	
	public String[] createFetures(String name) throws Exception {
		DbRecord[] feat_data = createFeatureData(name);
		String[] ret = new String[feat_data .length];
		for (int a=0; a<feat_data.length; a++)
		{
			ret[a] = Double.toString(feat_data[a].nameFrquency); 
		}

		return ret;		
	}

	public String[] createFeturesAll(String name) throws IOException {
		DbRecord[] feat_data = createFeatureData(name);
		String[] ret = new String[feat_data .length*2];
		for (int a=0; a<feat_data.length; a++)
		{
			ret[a*2] = feat_data[a].origName; 
			ret[a*2+1] = Double.toString(feat_data[a].nameFrquency); 
		}

		return ret;
	}

	public DbRecord[] createFeatureData(String name) throws IOException {
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
	

	public String[] findAllToStr(String string) throws Exception {
		DbRecord[] data = namesDB.findAll(string);
		String[] ret = new String[data.length*2];
		
		for (int i = 0; i < data.length; i++) {
			if (data[i] == null) continue;
			ret[i*2] = data[i].origName;
			ret[i*2+1] = Double.toString(data[i].nameFrquency);
		}
				
		return ret;
	}
		
}
