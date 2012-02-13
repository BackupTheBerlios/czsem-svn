package czsem.khresmoi.bmc;

import gate.Annotation;
import gate.AnnotationSet;
import gate.Document;
import gate.Factory;
import gate.FeatureMap;
import gate.Gate;

import gate.util.AnnotationDiffer;
import gate.util.GateException;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.PrintStream;
import java.net.MalformedURLException;
import java.net.URISyntaxException;
import java.net.URL;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;

import org.apache.commons.math.stat.descriptive.moment.Mean;
import org.apache.commons.math.stat.descriptive.moment.StandardDeviation;
import org.apache.commons.math.stat.descriptive.rank.Max;
import org.apache.commons.math.stat.descriptive.rank.Median;
import org.apache.commons.math.stat.descriptive.rank.Min;

import czsem.Utils.StopRequestDetector;
import czsem.gate.DocumentFeaturesDiff;
import czsem.gate.GateUtils;
import czsem.khresmoi.CompoundAnalysis;
import czsem.khresmoi.InformationExtractionAnalysis;
import czsem.khresmoi.bmc.BMCDatabase.BMCEntry;
import czsem.khresmoi.mesh.MeshRecordDB;
import czsem.khresmoi.mesh.MeshRecordDB.MeshRecord;
import czsem.utils.Config;
import czsem.utils.MultiSet;
import czsem.utils.ProjectSetup;

public class BMCStatistics
{
	public class ComulativeStats
	{
		MultiSet<Integer> tocCounts = new MultiSet<Integer>();
		MultiSet<String> permutations = new MultiSet<String>();
		MultiSet<String> uniqueTerms = new MultiSet<String>();
		public void addTocs(Iterable<String> tocs) {
			for (String s: tocs)
			{
				MeshRecord e = mdb.getEntry(s);			
				tocCounts.add(e.tokones().length);
				uniqueTerms.add(e.getEnTerm());
			}			
		}		
		public void addPerms(Iterable<String> perms) {
			permutations.addAll(perms);
		}
		public void print(PrintStream out) {
			out.println("tocounts");
			out.print(tocCounts.toFormatedString("\n"));
			out.println("permutations");						
			out.print(permutations.toFormatedString("\n"));
			out.format("unique terms: %d\n", uniqueTerms.size());
			for (String key : uniqueTerms.getTopKeys(20))
			{
				out.format("%s :%5d\n", key, uniqueTerms.get(key));				
			}
		}
	}
	
	public static class AsStats
	{
		int mesh_terms;
		int unique_mesh_terms;
		int unique_mesh_terms_with_separator = 0;
		
		AnnotationDiffer mesh_terms_diff;
		AnnotationDiffer unique_mesh_terms_diff;
		AnnotationDiffer goldDiff;				
		
//		MultiSet<Integer> unique_mesh_terms_toc_counts = new MultiSet<Integer>();
//		MultiSet<String> mesh_terms_permutations = new MultiSet<String>();

		public AsStats(int mesh_terms, int unique_mesh_terms) {
			this.mesh_terms = mesh_terms;
			this.unique_mesh_terms = unique_mesh_terms;
		}

		public void fillDocStats(DocStatas docStatas, int asOrd)
		{
			docStatas.setAsTokenData(asOrd,
					mesh_terms, unique_mesh_terms, unique_mesh_terms_with_separator);
			docStatas.setAsDiffData(asOrd, 0, mesh_terms_diff);
			docStatas.setAsDiffData(asOrd, 1, unique_mesh_terms_diff);
			docStatas.setAsDiffData(asOrd, 2, goldDiff);
			
		}
	}
	
//	DocStatas [] stats;
	int next_free_entry = 0;
	
	public static final String [] asNames = {"plain", "mimir", "compound_short", "compound_long"};
	public ComulativeStats comulativeGold = new ComulativeStats();
	public ComulativeStats comulativeResp[] = new ComulativeStats[asNames.length];

	String [][] str_data = new String[2][];
	double [][] double_data = new double[10+(1+4)*3+4*3*3][];
//	AsStats [][] as_data = new AsStats[asNames.length][];
	
	String doubleLabels[] = {
		"text_length",
		"tokens",		
		"mesh terms mimir",
		"CrossRec mimir plain",
		"CrossPrec mimir plain",
		"GoldRec mimir",
		"GoldPrec mimir",
		"GoldPlainRec",
		"GoldPlainPrec",
		"mergedBmcEntries",
		
		//1+4x as toc data (gold + as) [9] resp [12] first (5x3)

		//4x as diff data [24] first (4x3x3)(as x {prec rec F} x {plain, unique, gold})

	};  
	
	public static final int gold_as_toc = 10;  
	public static final int first_as_toc = gold_as_toc+3;  
	public static final int first_as_diff = gold_as_toc +15;  
	
	
	BMCDatabase bmc_db = new BMCDatabase();
	MeshRecordDB mdb = new MeshRecordDB();

	
	public BMCStatistics(File[] files) throws FileNotFoundException, IOException, ClassNotFoundException
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
		
		
		for (int i = 0; i < comulativeResp.length; i++)
		{
			comulativeResp[i] = new ComulativeStats();			
		}
		
/*
		for (int i = 0; i < as_data.length; i++)
		{
			as_data[i] = new AsStats[files.length];			
		}
*/
		bmc_db.loadCZ();
		mdb.load();


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

		public void setAsTokenData(int asOrd, int mesh_terms,
				int unique_mesh_terms, int unique_mesh_terms_with_separator) {
			double_data[first_as_toc+asOrd*3  ][index] = mesh_terms; 			
			double_data[first_as_toc+asOrd*3+1][index] = unique_mesh_terms; 			
			double_data[first_as_toc+asOrd*3+2][index] = unique_mesh_terms_with_separator; 						
		}

		public void setAsDiffData(int asOrd, int i, AnnotationDiffer diff) {
			double_data[first_as_diff + asOrd*9 + i*3    ][index] = diff.getRecallStrict(); 			
			double_data[first_as_diff + asOrd*9 + i*3 + 1][index] = diff.getPrecisionStrict(); 			
			double_data[first_as_diff + asOrd*9 + i*3 + 2][index] = diff.getFMeasureStrict(1); 						
		}

		public void fillAsStats(Document doc, Set<String> gold)
		{
			AnnotationSet last_as = doc.getAnnotations("empttty");
			last_as.clear();
			for (int a=0; a<asNames.length; a++)
			{
				AnnotationSet this_as = doc.getAnnotations(asNames[a]);
				AsStats asData = createAsStats(this_as, last_as, gold, comulativeResp[a]);
				asData.fillDocStats(this, a);
				last_as = this_as;
			}			
		}

		
		private void fillGoldStats(Set<String> gold) {
			setAsTokenData(-1, gold.size(), gold.size(), mdb.meshTermsWithSeparator(gold));			
		}

		public void fillDocStats(Document doc) throws MalformedURLException
		{
			FeatureMap f = doc.getFeatures();
			URL url = new URL(f.get("gate.SourceURL").toString());
			setHost(url.getHost());
			setMime_type((String) f.get("MimeType"));
			setText_length(doc.getContent().size());
			setTokens(doc.getAnnotations("TectoMT").get("Token").size());
			setMesh_terms(doc.getAnnotations("mimir").get("MeshTerm").size());
			setCrossCoverage(InformationExtractionAnalysis.BMCCrossCoverageDiffer(doc));
			setGoldCoverage(bmc_db.computeDocumentDiff(doc, "mimir"));
			setGoldPlainCoverage(bmc_db.computeDocumentDiff(doc, "plain"));
			
			setNumberOfMergedBmcEntries(bmc_db.getNumberOfMergedEntries(doc));
			
			System.err.format("CROSS  : prec: %f rec: %f\n", 
					getCrossPrecision(),
					getCrossRecall());

			System.err.format("GOLD   : prec: %f rec: %f\n", 
					getGoldPrecision(),
					getGoldRecall());

		}
		
		public boolean checkEntry()
		{
			if (getHost().length() <= 0) return false;
			if (getMime_type().length() <= 0) return false;
			if (getText_length() <= 0) return false;
			if (getTokens() <= 0) return false;
			if (getMesh_terms() <= 0) return false;
			if (getCrossPrecision() <= 0.2) return false;
//			if (getPrecision() <= 0.5) return false;
			if (getCrossRecall() < 0 || (getCrossRecall() > 1)) return false;
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
		
		private void setNumberOfMergedBmcEntries(int numberOfMergedEntries) {
			double_data[9][index] = numberOfMergedEntries; 
		}


		public int getMesh_terms() {
			return (int) double_data[2][index];
		}

		public void setCrossCoverage(AnnotationDiffer cross_coverage) {
			setCrossPrec(cross_coverage.getPrecisionLenient());
			setCrossRec(cross_coverage.getRecallLenient());
		}

		public void setGoldCoverage(AnnotationDiffer cross_coverage) {
			setGoldPrec(cross_coverage.getPrecisionLenient());
			setGoldRec(cross_coverage.getRecallLenient());
		}
		
		public void setGoldPlainCoverage(AnnotationDiffer cross_coverage) {
			setGoldPlainPrec(cross_coverage.getPrecisionLenient());
			setGoldPlainRec(cross_coverage.getRecallLenient());
		}
				
		private void setCrossRec(double recall) {
			double_data[3][index] = recall; 			
		}

		private void setCrossPrec(double precision) {
			double_data[4][index] = precision; 						
		}

		private void setGoldRec(double recall) {
			double_data[5][index] = recall; 						
		}

		private void setGoldPrec(double precision) {
			double_data[6][index] = precision; 									
		}
		private void setGoldPlainRec(double recall) {
			double_data[7][index] = recall; 						
		}

		private void setGoldPlainPrec(double precision) {
			double_data[8][index] = precision; 									
		}

		public double getCrossPrecision() {
			return double_data[4][index];
		}

		public double getCrossRecall() {
			return double_data[3][index];
		}

		public double getGoldPrecision() {
			return double_data[6][index];
		}

		public double getGoldRecall() {
			return double_data[5][index];
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

	
	
	
	public static Set<String> uniqueMeshIDsFromAnnots(AnnotationSet annots)
	{
		Set<String> ret = new HashSet<String>();
		return getFetureValsFromAnnots(annots, "meshID", ret) ;
	}
	
	public static <CollectionType extends Collection<String>> 
	CollectionType getFetureValsFromAnnots(AnnotationSet annots, String feture_name, CollectionType ret)
	{
		for (Annotation a: annots)
		{
			String id = (String) a.getFeatures().get(feture_name);
			ret.add(id);
		}
		return ret;
	}
	
	List<String> getPermutValsFromAnnots(AnnotationSet annots)
	{
		List<String> ret = new ArrayList<String>(annots.size());
		for (Annotation a: annots)
		{
			String permut = (String) a.getFeatures().get("permut");
			String meshID = (String) a.getFeatures().get("meshID"); 
			int tokens = mdb.getEntry(meshID).tokones().length;
			ret.add("toc"+tokens+" "+permut);
		}
		return ret;
	}

	
	public AsStats createAsStats(AnnotationSet this_as, AnnotationSet last_as, Set<String> goldData, ComulativeStats comulativeStats) {		
		AnnotationSet this_terms = this_as.get("Lookup");
		AnnotationSet last_terms = last_as.get("Lookup");

		Set<String> this_unique = uniqueMeshIDsFromAnnots(this_terms);
		Set<String> last_unique = uniqueMeshIDsFromAnnots(last_terms);
		
		comulativeStats.addTocs(getFetureValsFromAnnots(this_terms, "meshID", 
				new ArrayList<String>(this_terms.size())));
		
//		comulativeStats.addPerms(getFetureValsFromAnnots(this_terms, "permut", 
//				new ArrayList<String>(this_terms.size())));
		comulativeStats.addPerms(getPermutValsFromAnnots(this_terms));
		
				
		AsStats ret = new AsStats(this_terms.size(), this_unique.size());

		ret.goldDiff = DocumentFeaturesDiff.computeDiffWithGoldStandardData(
				goldData, this_unique);

/*
		for (String s: this_unique)
		{
			MeshRecord e = mdb.getEntry(s);			
			if (e.hasSeparator()) ret.unique_mesh_terms_with_separator++;
//			ret.unique_mesh_terms_toc_counts.add(e.tokones().length);			
		}
*/				
		ret.unique_mesh_terms_with_separator = mdb.meshTermsWithSeparator(this_unique); 
		
		ret.mesh_terms_diff = GateUtils.calculateSimpleDiffer(last_terms, this_terms);
		ret.unique_mesh_terms_diff = 
			DocumentFeaturesDiff.computeDiffWithGoldStandardData(last_unique, this_unique);
		
/*
		ret.mesh_terms_permutations.addAll(
				getFetureValsFromAnnots(this_terms, "permut", 
						new ArrayList<String>(this_terms.size())));		
*/	
		return ret;
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
		System.err.print("corss rec  ");
		printNumericStatistics(double_data[3]);
		System.err.print("cross prec ");
		printNumericStatistics(double_data[4]);
		System.err.print("gold  rec  ");
		printNumericStatistics(double_data[5]);
		System.err.print("gold  prec ");
		printNumericStatistics(double_data[6]);
		System.err.print("gold- rec  ");
		printNumericStatistics(double_data[7]);
		System.err.print("gold- prec ");
		printNumericStatistics(double_data[8]);
		System.err.print("merged entr");
		printNumericStatistics(double_data[9]);
		
		System.err.println("-- gold cumulative tocs --");
		comulativeGold.print(System.err);
		for (int a=0; a< asNames.length; a++)
		{
			System.err.format("-- %s cumulative tocs --\n", asNames[a]);
			comulativeResp[a].print(System.err);			
		}

		System.err.format("-- %s as terms --\n", "gold");
		printAsTocStats(-1);
		for (int a=0; a< asNames.length; a++)
		{
			System.err.format("-- %s as terms --\n", asNames[a]);
			printAsTocStats(a);
		}

		for (int a=0; a< asNames.length; a++)
		{
			System.err.format("-- %s as diff --\n", asNames[a]);
			printAsDiffStatsAll(a);
		}

	}

	private void printAsDiffStatsAll(int ord)
	{
		System.err.println("- prew dif -");
		printAsDiffStats(ord*9);
		System.err.println("- prew unique dif -");
		printAsDiffStats(ord*9+3);
		System.err.println("- gold dif -");
		printAsDiffStats(ord*9+6);
		
	}

	private void printAsDiffStats(int ord)
	{		
		System.err.print("recall    ");
		printNumericStatistics(double_data[first_as_diff+ord]);
		System.err.print("precision ");
		printNumericStatistics(double_data[first_as_diff+ord+1]);
		System.err.print("F1        ");
		printNumericStatistics(double_data[first_as_diff+ord+2]);
		
	}

	
	private void printAsTocStats(int ord)
	{		
		System.err.print("terms          ");
		printNumericStatistics(double_data[first_as_toc+ord*3]);
		System.err.print("unique terms   ");
		printNumericStatistics(double_data[first_as_toc+ord*3+1]);
		System.err.print("terms with sep ");
		printNumericStatistics(double_data[first_as_toc+ord*3+2]);		
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
		s.fillDocStats(doc);
		
		Set<String> gold = bmc_db.getGoldData(doc);
		s.fillGoldStats(gold);
		comulativeGold.addTocs(gold);

		s.fillAsStats(doc, gold);
		return s.checkEntry();
	}

	public static void checkMultipleFilesForSingleUrl() throws FileNotFoundException, IOException, ClassNotFoundException
	{
		File dir = new File(InformationExtractionAnalysis.default_outputdir);
		File[] files = dir.listFiles();
		
		Map<String, String> db_hash = new HashMap<String, String>();
		
		BMCDatabase db = new BMCDatabase();
		db.loadCZ();
		
		for (String url : db.urlIter())
		{
			for (BMCEntry entry : db.entriesForUrl(url))
			{
				db_hash.put(
						"C:\\Users\\dedek\\Desktop\\bmc\\analyzed\\" + entry.getID() + ".xml",
						url); 				
			}
		}
		
		MultiSet<String> hits = new MultiSet<String>();
		
		for (File f : files)
		{
			String url = db_hash.get(f.toString());
			hits.add(url);
		}
		
		List<String> top = hits.getTopKeys(50);
		for (String t : top)
		{
			System.err.format("%d x %s \n", hits.get(t), t);
		}
		
	}

	public static void main(String[] args) throws URISyntaxException, IOException, GateException, ClassNotFoundException
	{
		Locale.setDefault(Locale.ENGLISH);
	
		Config.getConfig().setGateHome();
		Gate.init();
						
		StopRequestDetector stop_request_detector = new StopRequestDetector();
		File dir = new File(CompoundAnalysis.default_outputdir);
//		File dir = new File(InformationExtractionAnalysis.default_outputdir);
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
//				break;
			}
			
			Factory.deleteResource(doc);
			
			if (stop_request_detector.stop_requested) break;
		}
		
		bmc_stat.printStatistics();
		System.err.println("end of file processing.");
		
		System.exit(0); //terminates stop_request_detector
	
	}
	

}
