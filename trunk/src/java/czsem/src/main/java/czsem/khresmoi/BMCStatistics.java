package czsem.khresmoi;

import gate.Document;
import gate.Factory;
import gate.FeatureMap;
import gate.Gate;
import gate.util.AnnotationDiffer;
import gate.util.GateException;

import java.io.File;
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URISyntaxException;
import java.net.URL;
import java.util.List;
import java.util.Locale;

import org.apache.commons.math.stat.descriptive.moment.Mean;
import org.apache.commons.math.stat.descriptive.moment.StandardDeviation;
import org.apache.commons.math.stat.descriptive.rank.Max;
import org.apache.commons.math.stat.descriptive.rank.Median;
import org.apache.commons.math.stat.descriptive.rank.Min;

import czsem.Utils.StopRequestDetector;
import czsem.utils.Config;
import czsem.utils.MultiSet;
import czsem.utils.ProjectSetup;

public class BMCStatistics
{
//	DocStatas [] stats;
	int next_free_entry = 0;
	
	String [][] str_data = new String[2][];
	double [][] double_data = new double[5][];
	
	public BMCStatistics(File[] files)
	{
		next_free_entry = 0;
		
		for (int i = 0; i < double_data.length; i++)
		{
			double_data[i] = new double[files.length];			
		}

		for (int i = 0; i < str_data.length; i++)
		{
			str_data[i] = new String[files.length];			
		}

	}
	
	public class DocStatas
	{
		private int index;

/*
		private String host;
		private String mime_type;
		private long text_length;
		private int tokens;
		private int mesh_terms;
		private AnnotationDiffer cross_coverage;
*/		
		public DocStatas(int index)
		{
			this.index = index;
		}

		public void fillDocStatas(Document doc) throws MalformedURLException
		{
			FeatureMap f = doc.getFeatures();
			URL url = new URL(f.get("gate.SourceURL").toString());
			setHost(url.getHost());
			setMime_type((String) f.get("MimeType"));
			setText_length(doc.getContent().size());
			setTokens(doc.getAnnotations("TectoMT").get("Token").size());
			setMesh_terms(doc.getAnnotations("mimir").get("MeshTerm").size());
			setCross_coverage(InformationExtractionAnalysis.BMCCrossCoverageDiffer(doc));
			
			System.err.format("   diff: prec: %f rec: %f\n", 
					getPrecision(),
					getRecall());
		}
		
		public boolean checkEntry()
		{
			if (getHost().length() <= 0) return false;
			if (getMime_type().length() <= 0) return false;
			if (getText_length() <= 0) return false;
			if (getTokens() <= 0) return false;
			if (getMesh_terms() <= 0) return false;
			if (getPrecision() <= 0.2) return false;
//			if (getPrecision() <= 0.5) return false;
			if (getRecall() < 0 || (getRecall() > 1)) return false;
//			if (getRecall() < 0.01 || (getRecall() > 0.9)) return false;
			
			return true;
		}

		public void setHost(String host) {
			str_data[0][index] = host;
		}

		public String getHost() {
			return str_data[0][index];
		}

		public void setMime_type(String mime_type) {
			str_data[1][index] = mime_type;
		}

		public String getMime_type() {
			return str_data[1][index];
		}

		public void setText_length(long text_length)
		{
			double_data[0][index] = text_length; 
		}

		public long getText_length() {
			return (long) double_data[0][index];
		}

		public void setTokens(int tokens) {
			double_data[1][index] = tokens; 
		}

		public int getTokens() {
			return (int) double_data[1][index];
		}

		public void setMesh_terms(int mesh_terms) {
			double_data[2][index] = mesh_terms; 
		}

		public int getMesh_terms() {
			return (int) double_data[2][index];
		}

		public void setCross_coverage(AnnotationDiffer cross_coverage) {
			setPrec(cross_coverage.getPrecisionLenient());
			setRec(cross_coverage.getRecallLenient());
		}

		private void setRec(double recallStrict) {
			double_data[3][index] = recallStrict; 			
		}

		private void setPrec(double precisionStrict) {
			double_data[4][index] = precisionStrict; 						
		}

		public double getPrecision() {
			return double_data[4][index];
		}

		public double getRecall() {
			return double_data[3][index];
		}
	}

	public static void printNumericStatistics(double[] values, int count)
	{
		Mean m = new Mean();
		double mean = m.evaluate(values, 0, count);
		
		StandardDeviation std = new StandardDeviation();		
		
		Min min = new Min();
		
		Max max = new Max();
		
		Median median = new Median();
		
		System.err.format("| mean: %11.4f | stdev: %11.4f | min: %11.4f | max: %11.4f | median: %11.4f\n",
			mean,
			std.evaluate(values, mean, 0, count),
			min.evaluate(values, 0, count),
			max.evaluate(values, 0, count),
			median.evaluate(values, 0, count)				
		);

	}

	public void printStatistics()
	{
		System.err.format("files: %d\n", next_free_entry);
		

		System.err.println("Top hosts:");
		printStringStatistics(str_data[0], 25, next_free_entry);

		System.err.println("Top mime types:");
		printStringStatistics(str_data[1], 10, next_free_entry);
		
		System.err.print("length     ");
		printNumericStatistics(double_data[0]);
		System.err.print("tokens     ");
		printNumericStatistics(double_data[1]);
		System.err.print("MeSH terms ");
		printNumericStatistics(double_data[2]);
		System.err.print("precisison ");
		printNumericStatistics(double_data[3]);
		System.err.print("recall     ");
		printNumericStatistics(double_data[4]);
	}

	public static void printStringStatistics(String[] str_strings, int top_count, int count)
	{
		MultiSet<String> s = new MultiSet<String>();
		s.addAll(str_strings, count);
		List<String> top = s.getTopKeys(top_count);
		for (int i=0; i<top.size(); i++)
		{
			System.err.format("%s : %d\n", top.get(i), s.get(top.get(i)));
		}
	}

	private void printNumericStatistics(double[] ds)
	{
		printNumericStatistics(ds, next_free_entry);		
	}

	public boolean add(Document doc) throws MalformedURLException
	{
		DocStatas s = new DocStatas(next_free_entry++);
		s.fillDocStatas(doc);
		return s.checkEntry();
	}

	public static void main(String[] args) throws URISyntaxException, IOException, GateException
	{
		Locale.setDefault(Locale.ENGLISH);
	
		Config.getConfig().setGateHome();
		Gate.init();
						
		StopRequestDetector stop_request_detector = new StopRequestDetector();
		File dir = new File(InformationExtractionAnalysis.default_outputdir);
		File[] files = dir.listFiles();
		
		stop_request_detector.startDetector();
		
		int files_count = 0;
		
		BMCStatistics bmc_stat = new BMCStatistics(files); 
	
		for (File f : files)
		{			
			System.err.println(String.format("%s file:%05d %s", ProjectSetup.makeTimeStamp(), files_count, f.getName()));
			if (files_count++ < 0) continue;
			Document doc = Factory.newDocument(f.toURI().toURL(), "utf8");
						
			if (! bmc_stat.add(doc))
			{
				System.err.println("Error!");
				break;
			}
			
			Factory.deleteResource(doc);
			
			if (stop_request_detector.stop_requested) break;
		}
		
		bmc_stat.printStatistics();
		System.err.println("end of file processing.");
		
		System.exit(0); //terminates stop_request_detector
	
	}
	

}
