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
	
	public static class Features
	{
		public double[] doubleFeatures;
		public String[] stringFeatures;

		public Features(double[] doubleFeatures, String[] stringFeatures) {
			this.doubleFeatures = doubleFeatures;
			this.stringFeatures = stringFeatures;
		}

		public String[] toStringArray() {
			return Utils.arrayConcat(
					doubleFeturesToString(doubleFeatures), 
					stringFeatures);
		}
	}

	public static class NameDecison
	{
		public String lastName;
		public String firstName;
		
		public NameDecison(String lastName, String firstName) {
			this.lastName = lastName;
			this.firstName = firstName;
		}

		@Override
		public String toString() {
			return lastName+", "+firstName;
		}
	}
	
	public static final String [] string_headers = 
	{
		"name",
		"last_name_gram",
		"last_name_gram2",
		"first_name_gram",
		"first_name_gram2",
		"lang",
		"class",
	};

	private static String[] header = null;
	
	protected NamesDB namesDB;
	
	public FeatureMaker() throws Exception
	{
		if (header == null) header = createHeader();
		namesDB = new NamesDB();		
	}
	
	public static void main(String[] args) throws Exception {
			Locale.setDefault(Locale.ENGLISH);
	
			FeatureMaker fMaker = new FeatureMaker();
			
			
			System.err.println(Arrays.toString(FeatureMaker.getHeader()));
			System.err.println(Arrays.toString(fMaker.createDoubleFeturesWithDescriptions(" Jan")));
			System.err.println(fMaker.getFirstName("Jan Dědek mladší"));
			System.err.println(fMaker.getFirstName("Adam Ondra"));
			System.err.println(Arrays.toString(fMaker.createDoubleFeturesWithDescriptions("Adam Ondra")));
			System.err.println(fMaker.getFirstName("Laďka Něrgešová"));
			System.err.println(Arrays.toString(fMaker.createDoubleFeturesWithDescriptions("Laďka Něrgešová")));
			System.err.println(fMaker.getFirstName("Xena Longenová"));
			System.err.println(Arrays.toString(fMaker.createDoubleFeturesWithDescriptions("vit lada")));
				
			fMaker.preparaDataFile();
		}

	public NameDecison getFirstName(String name) {
		String[] tocs = name.split(" ");
		return getFirstName(tocs);				
	}

	public NameDecison getFirstName(String[] tocs) {
		if (tocs.length == 1) return new NameDecison(tocs[0], tocs[0]);
		
		for (int i = 0; i < tocs.length; i++) {
			if (Utils.removeDiacritics(tocs[i].toLowerCase()).endsWith("ova"))
			{
				NameDecison recur = getFirstName(
						Utils.removeFromArray(tocs, i));
				return new NameDecison(
						tocs[i],
						recur.firstName);			
			}
		}
		
		DbRecord[][] features = new DbRecord[tocs.length][];
		for (int i = 0; i < features.length; i++) {
			features[i] = namesDB.findAll(tocs[i]);			
		}

		double[] sum_first = new double[tocs.length];		
		double[] sum_last = new double[tocs.length];
		
		for (int t = 0; t < tocs.length; t++)
		{
			for (int i = 0; i < NamesDB.firstNameFeatures.length; i++) {
				sum_first[t] += Utils.newIfNull(features[t][NamesDB.firstNameFeatures[i]]).nameFrquency;
			}
	
			for (int i = 0; i < NamesDB.lastNameFeatures.length; i++) {
				sum_last[t] += Utils.newIfNull(features[t][NamesDB.lastNameFeatures[i]]).nameFrquency;
			}
		}
		
		int firstNameMaxIndex = Utils.maxIndex(sum_first);
		int lastNameMaxIndex = Utils.maxIndex(sum_last);
		
		if (firstNameMaxIndex != lastNameMaxIndex) 
			return new NameDecison(
					tocs[lastNameMaxIndex],
					tocs[firstNameMaxIndex]);
		
		if (sum_first[firstNameMaxIndex] > sum_last[lastNameMaxIndex])
		{
			NameDecison recur = getFirstName(
					Utils.removeFromArray(tocs, firstNameMaxIndex));
			return new NameDecison(
					recur.lastName,
					tocs[firstNameMaxIndex]);
		} else {
			NameDecison recur = getFirstName(
					Utils.removeFromArray(tocs, lastNameMaxIndex));
			return new NameDecison(
					tocs[lastNameMaxIndex],
					recur.firstName);			
		}
	}

	public void preparaDataFile() throws Exception
	{
		OutputStream out = new FileOutputStream("C:/Users/dedek/Desktop/jmena/data/weka.csv");
		OutputStreamWriter prew_out = new OutputStreamWriter(new BufferedOutputStream(out), "utf8");
		CsvWriter csv_out = new CsvWriter(prew_out, ',');

		writeFeaturesToStream(null, csv_out , null, null);
		writeFeaturesToStream("C:/Users/dedek/Desktop/jmena/data/male.txt", csv_out , "cz", "male");
		writeFeaturesToStream("C:/Users/dedek/Desktop/jmena/data/female.txt", csv_out , "cz", "female");
		writeFeaturesToStream("C:/Users/dedek/Desktop/jmena/data/sestry.txt", csv_out , "cz", "female");
		writeFeaturesToStream("C:/Users/dedek/Desktop/jmena/data/fotbalisti.txt", csv_out , "cz", "male");
		csv_out.close();		
	}
	
	public static String [] createHeader() throws Exception
	{
		String[] names_header = NamesDB.getHeadersShort();
		
		return Utils.arrayConcat(names_header, string_headers);		
	}

	public static String [] getHeader()
	{
		return header ;
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

	public void writeFeaturesToStream(String inputFileName, CsvWriter out, String lang, String classLabel) throws Exception
	{
		
		if (inputFileName == null)
		{
			out.writeRecord(getHeader());
			return;
		}

		BufferedReader in = new BufferedReader(new InputStreamReader(new BufferedInputStream(new FileInputStream(inputFileName)), "utf8"));
						
		for (;;)
		{
			String line = in.readLine();
			if (line == null) break;
			if (disardInstance(line)) 
				continue;
			out.writeRecord(createFeatures(line, lang, classLabel).toStringArray());
		}
		in.close();
	}
	
	public Features createFeatures(String name, String lang, String classLabel) throws Exception
	{
		return new Features(
				createDoubleFeatures(name),
				createStringFetures(name, lang, classLabel));
	}

	public String[] createStringFetures(String name, String lang, String classLabel) throws IOException {
		String[] ret = new String[string_headers.length];
		int c=0;
		ret[c++] = name;

		NameDecison nd = getFirstName(name);
		ret[c++] = Utils.lastNGram(3, Utils.removeDiacritics(nd.lastName));
		ret[c++] = Utils.lastNGram(2, nd.lastName);
		ret[c++] = Utils.lastNGram(2, Utils.removeDiacritics(nd.firstName));
		ret[c++] = Utils.lastNGram(3, nd.firstName);
		
		ret[c++] = lang;
		ret[c++] = classLabel;

		return ret;
	}

	public DbRecord[] createDoubleFeatureData(String name) throws IOException {
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
	

	public double[] createDoubleFeatures(String name) throws IOException {
		DbRecord[] feat_data = createDoubleFeatureData(name);
		double[] ret = new double[feat_data .length];
		for (int a=0; a<feat_data.length; a++)
		{
			ret[a] = feat_data[a].nameFrquency; 
		}
	
		return ret;				
	}

	public static String[] doubleFeturesToString(double [] feat_data) {
		String[] ret = new String[feat_data.length];
		for (int a=0; a<feat_data.length; a++)
		{
			ret[a] = Double.toString(feat_data[a]); 
		}
	
		return ret;		
	}

	public String[] createDoubleFeturesWithDescriptions(String name) throws IOException {
		DbRecord[] feat_data = createDoubleFeatureData(name);
		String[] ret = new String[feat_data .length*2];
		for (int a=0; a<feat_data.length; a++)
		{
			ret[a*2] = feat_data[a].origName; 
			ret[a*2+1] = Double.toString(feat_data[a].nameFrquency); 
		}
	
		return ret;
	}

}
