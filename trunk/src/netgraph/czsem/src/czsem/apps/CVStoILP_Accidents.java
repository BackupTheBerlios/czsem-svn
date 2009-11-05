package czsem.apps;

import java.io.IOException;
import java.io.PrintStream;
import java.util.HashSet;
import java.util.Set;

import com.csvreader.CsvReader;

import czsem.ILP.ILPExec;
import czsem.ILP.Serializer;
import czsem.ILP.Serializer.Relation;
import czsem.utils.ProjectSetup;

public class CVStoILP_Accidents {
	protected ProjectSetup proproject_setup = new ProjectSetup();

//	private PositiveExampleDetector pe_detect;
	
	private Set<String>[] attribute_values_bufeer = null;

	@SuppressWarnings("unchecked")
	protected void initAttributeValuesBufeer(int length)
	{
		attribute_values_bufeer = new HashSet[length];
		
		for (int i=0; i<attribute_values_bufeer.length; i++) {
			attribute_values_bufeer[i] = new HashSet<String>();
		}
	}

/**	
	CVStoILP_Accidents(PositiveExampleDetector pe_detect)
	{
		this.pe_detect = pe_detect;
	};
	
	CVStoILP_Accidents(PositiveExampleDetector pe_detect, String filename) throws FileNotFoundException
	{
		this.pe_detect = pe_detect;
		ilp_out = new PrintStream(filename);		
	}
/**/
	
	private PrintStream ilp_out = System.out;
	
	public void crateBackgroundKnowledge(String input_file_name) throws IOException
	{
		CsvReader reader = new CsvReader(input_file_name, ';');

		reader.readHeaders();
		
		StringBuilder sb = new StringBuilder(proproject_setup.current_project_dir);
		sb.append(proproject_setup.project_name);
		sb.append(".b");
		Serializer ilp_ser = new Serializer(sb.toString());
		
		Relation [] crisp_relations = new Relation[reader.getHeaderCount()];
		Relation [] atl_relations = new Relation[reader.getHeaderCount()];


		
//		ilp_ser.putCommentLn("--- M O D E S   and   D E T E R M I N A T I O N S   and   D E F I N I T I O N S ---");
		ilp_ser.putCommentLn("--- C R I S P     M O D E S ---");
		
		for (int i = 0; i < crisp_relations.length; i++) {
			crisp_relations[i] = ilp_ser.addBinRelation("has_" + reader.getHeader(i), "file_id", reader.getHeader(i));
			ilp_ser.putBinaryMode(crisp_relations[i], "1", '+', '#');
		}

		ilp_ser.putCommentLn("");
		ilp_ser.putCommentLn("--- M O N O T O N I Z E D    M O D E S ---");
		
		for (int i = 0; i < crisp_relations.length; i++)
		{			
			atl_relations[i] = ilp_ser.addBinRelation(
					crisp_relations[i].getName() + "_atleast",
					crisp_relations[i].getArgTypeName(0),
					crisp_relations[i].getArgTypeName(1));
			
			ilp_ser.putBinaryMode(atl_relations[i], "*", '+', '#');
		}
		
		
		ilp_ser.putCommentLn("");
		ilp_ser.putCommentLn("--- M O N O T O N I C I T Y       A X I O M S ---");

		for (int i = 0; i < crisp_relations.length; i++) {

			//monotonicity axioms
			ilp_ser.print(atl_relations[i].getName());
			ilp_ser.print("(ID,N) :- ");
			ilp_ser.print(crisp_relations[i].getName());
			ilp_ser.print("(ID,N), not(integer(N)),!.\n");

			ilp_ser.print(atl_relations[i].getName());
			ilp_ser.print("(ID,N) :- ");
			ilp_ser.print(crisp_relations[i].getName());
			ilp_ser.print("(ID,N2), integer(N2), ");
			ilp_ser.print(atl_relations[i].getArgTypeName(1));
			ilp_ser.print("(N), integer(N), N2>=N.\n\n");						
		}

		
		
		ilp_ser.putCommentLn("");
		ilp_ser.putCommentLn("--- D E T E R M I N A T I O N S ---");
		
		Relation atl_ser = ilp_ser.addBinRelation("serious_atl", "file_id", "ranking_class");
		Relation crisp_ser = ilp_ser.addBinRelation("serious", "file_id", "ranking_class");
		
		ilp_ser.putBinaryMode(atl_ser, "*", '+', '#');
		ilp_ser.putBinaryMode(crisp_ser, "1", '+', '#');
		ilp_ser.print("\n");
		
		
		for (int i = 0; i < atl_relations.length-2; i++)
		{						
			ilp_ser.putDetermination(atl_ser, atl_relations[i]);
		}
		ilp_ser.print("\n");
		for (int i = 0; i < crisp_relations.length-2; i++)
		{						
			ilp_ser.putDetermination(crisp_ser, crisp_relations[i]);
		}

		
		
		ilp_ser.putCommentLn("");
		ilp_ser.putCommentLn("--- T U P L E S ---");

		while (reader.readRecord())
		{
			ilp_ser.putCommentLn("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
			for (int i = 0; i < crisp_relations.length; i++)
			{
				String value = reader.get(i); 
//				if (value.compareTo("?") == 0) continue;
				if (value.compareTo("?") == 0) value = "unknown";
				
				ilp_ser.putBinTuple(crisp_relations[i], "id_" + reader.get("filename"), value);
			}					
		}
		
		
		
		ilp_ser.putCommentLn("");
		ilp_ser.putCommentLn("--- V A L U E S ---");
		
		ilp_ser.outputAllTypes();

		reader.close();		
	}
	
	public static int getMaxValue(int[] numbers){
		  int maxValue = numbers[0];
		  for(int i=1;i < numbers.length;i++){
		    if(numbers[i] > maxValue){
			  maxValue = numbers[i];
			}
		  }
		  return maxValue;
		}
		 
		public static int getMinValue(int[] numbers){
		  int minValue = numbers[0];
		  for(int i=1;i<numbers.length;i++){
		    if(numbers[i] < minValue){
			  minValue = numbers[i];
			}
		  }
		  return minValue;
		}
	
	public static double[] count_cat_mins(int min, int max, int cats)
	{
		int delta = max-min;
		double cat_d = delta / (double) cats;

		double ret[] = new double[cats+1];
		
		for (int r=0; r<=cats; r++)
		{
			ret[r] = min + cat_d*(r);
		}
		
		return ret;
	}
	
	public static interface PositiveExampleDetector
	{
	 	public boolean writeAtleastSuffixInDeterminations();
		public boolean isPositiveExample(int val, int min, int max);
		public String traintestSuffix();
	}
	
	public static abstract class TrainTestExampleDetector implements PositiveExampleDetector
	{
		private String train_test_suffix;
		
		public TrainTestExampleDetector(String train_test_suffix)
		{
			this.train_test_suffix = train_test_suffix;
		}
		public String traintestSuffix() {return train_test_suffix;}
	}
	
	public static class MonotonicExampleDetector extends TrainTestExampleDetector
	{
		public MonotonicExampleDetector(String trainTestSuffix) {
			super(trainTestSuffix);
		}

		public boolean isPositiveExample(int val, int min, int max) {
			return val >= min;	//monotic 
		}

		public boolean writeAtleastSuffixInDeterminations() {
			return true;
		}		
	}

	public static class NonMonotonicExampleDetector extends TrainTestExampleDetector
	{
		public NonMonotonicExampleDetector(String trainTestSuffix) {
			super(trainTestSuffix);
		}

		public boolean isPositiveExample(int val, int min, int max) {
			return (val >= min) && (val < max);	//non_monotic 
		}

		public boolean writeAtleastSuffixInDeterminations() {
			return false;
		}		
	}
	
	public static class Examples
	{
		private String ids[] = null;//new String[50];
		private int rankings[] = null;//new int[50];
		private int cat_mins[] = {5,15,30,65,81};
		private int last_index = 0;
		
		public int getCount() {return ids.length;}
		public void append(String id, int ranking)
		{
			ids[last_index] = id;
			rankings[last_index] = ranking;
			last_index++;
		}
		
		Examples(int count)
		{
			last_index = 0;
			ids = new String[count];
			rankings = new int[count];			
		}
	}
	
	public void printExamples(PositiveExampleDetector pe_detect, boolean negative, Examples ex)
	{
		int categories_stat[] = new int[ex.cat_mins.length-1];		
		for (int c=0; c<categories_stat.length; c++) categories_stat[c] = 0;

		for (int a=0; a<ex.getCount(); a++)
			for (int r=0; r< ex.cat_mins.length-1; r++)
			{
				if (negative ^ pe_detect.isPositiveExample(ex.rankings[a], ex.cat_mins[r], ex.cat_mins[r+1]))
				{
					categories_stat[r]++;
					ilp_out.print("serious");
					if (pe_detect.writeAtleastSuffixInDeterminations()) ilp_out.print("_atl");
					ilp_out.print(pe_detect.traintestSuffix());
					ilp_out.print("(");
					ilp_out.print(ex.ids[a]);
					ilp_out.print(',');					
					ilp_out.print(r);					
					ilp_out.print(").    %");
					ilp_out.println(ex.rankings[a]);					
				}				
			}
		
		ilp_out.println("%%%%%%%%%%%%% S T A T I S T I C S %%%%%%%%%%%%%%%%%%%%%%%%%");
		
		int cum_sum = 0;
		for (int c=categories_stat.length-1; c>=0; c--)
		{				
			ilp_out.print("% cat_");
			ilp_out.print(c);
			ilp_out.print(" (");
			ilp_out.print((ex.cat_mins[c]));
			ilp_out.print('-');
			ilp_out.print((ex.cat_mins[c+1]));
			ilp_out.print("): ");
			ilp_out.print(categories_stat[c]-cum_sum);
			ilp_out.print(" (");
			ilp_out.print(categories_stat[c]);
			ilp_out.println(')');

			cum_sum = categories_stat[c];
		}				
	}

	public void make_examples(String file_name, int start_index, int length) throws IOException
	{
		CsvReader reader = new CsvReader(file_name, ';');
		
		reader.readHeaders();
		
		Examples test = new Examples(length);
		Examples learn = new Examples(50-length); //TODO: fix hard coded

		//cross validation - select learning and testing set
		for (int i=0; reader.readRecord(); i++)
		{
				Examples var_ex = test; 
				if ((i < start_index) || (i >= start_index+length)) var_ex = learn;
				var_ex.append("id_" + reader.get("filename"), Integer.parseInt(reader.get("ranking")));
		}
		reader.close();

			
		//prepare files
		StringBuilder sb = new StringBuilder(proproject_setup.current_project_dir);
		sb.append(proproject_setup.project_name);
		sb.append('_');
		sb.append(start_index);
		sb.append('-');
		sb.append(start_index+length-1);

		//test positive
		ilp_out = new PrintStream(sb.toString()+"_test.f");		
		ilp_out.println("%%%%%%%%%%%%% P O S I T I V E %%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
		ilp_out.println("%%%%%%%%%%%%% C R I S P %%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
		printExamples(new NonMonotonicExampleDetector("_test"), false, test);
		ilp_out.println("%%%%%%%%%%%%% M O N O T O N I Z E D %%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
		printExamples(new MonotonicExampleDetector("_test"), false, test);
		ilp_out.close();
		

		//test negative
		ilp_out = new PrintStream(sb.toString()+"_test.n");		
		ilp_out.println("%%%%%%%%%%%%% N E G A T I V E %%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
		ilp_out.println("%%%%%%%%%%%%% C R I S P %%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
		printExamples(new NonMonotonicExampleDetector("_test"), true, test);
		ilp_out.println("%%%%%%%%%%%%% M O N O T O N I Z E D %%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
		printExamples(new MonotonicExampleDetector("_test"), true, test);
		ilp_out.close();


		
		
		//learn positive
		ilp_out = new PrintStream(sb.toString()+"_learn.f");				 
		ilp_out.println("%%%%%%%%%%%%% P O S I T I V E %%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
		ilp_out.println("%%%%%%%%%%%%% C R I S P %%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
		printExamples(new NonMonotonicExampleDetector(""), false, learn);
		ilp_out.println("%%%%%%%%%%%%% M O N O T O N I Z E D %%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
		printExamples(new MonotonicExampleDetector(""), false, learn);
		ilp_out.close();
		

		//learn negative
		ilp_out = new PrintStream(sb.toString()+"_learn.n");		
		ilp_out.println("%%%%%%%%%%%%% N E G A T I V E %%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
		ilp_out.println("%%%%%%%%%%%%% C R I S P %%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
		printExamples(new NonMonotonicExampleDetector(""), true, learn);
		ilp_out.println("%%%%%%%%%%%%% M O N O T O N I Z E D %%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
		printExamples(new MonotonicExampleDetector(""), true, learn);
		ilp_out.close();
}

	
	public static void main(String[] args) throws IOException, InterruptedException
	{
		if (args.length < 1)
		{
			System.err.println("Usage:   CVStoILP_Accidents source_file");						
			return;
		}
		
//		CVStoILP_Accidents csv = new CVStoILP_Accidents("C:\\WorkSpace\\Aleph\\ranking.b");
//		CVStoILP_Accidents csv = new CVStoILP_Accidents(new NonMonotonicExampleDetector());
		CVStoILP_Accidents csv = new CVStoILP_Accidents();
		
		csv.proproject_setup.dir_for_projects = "C:\\workspace\\czsem\\src\\ILP\\serious_corss\\";
		csv.proproject_setup.project_name = "serious_cross";
		csv.proproject_setup.init_project();
		csv.crateBackgroundKnowledge(args[0]);
		
//		CVStoILP_Accidents csv2 = new CVStoILP_Accidents("C:\\WorkSpace\\Aleph\\serious.f");
//		CVStoILP_Accidents csv2 = new CVStoILP_Accidents(new MonotonicExampleDetector());
//		for (int i=0; i<5; i++)
		for (int i=0; i<1; i++)
		{
			csv.make_examples(args[0],i*10,10);

			ILPExec exec = new ILPExec(csv.proproject_setup);
			StringBuilder sb = new StringBuilder(csv.proproject_setup.project_name);
			sb.append('_');
			sb.append(i*10);
			sb.append('-');
			sb.append(i*10 + 9);
			exec.setLearnigExamples(sb.toString()+"_learn");
			exec.setTestingExamples(sb.toString()+"_test");
			exec.setRulesFileName(sb.toString()+"_rules");
			exec.setResultsFileName(sb.toString()+"_test_results");
			exec.startILPProcess();
			exec.startReaderThreads();
			exec.induceRules();
			
			//crisp data, crisp rules
			exec.addTestRule("serious_test(ID,DEG):-serious(ID,DEG)");
			exec.testRules(false);
			exec.retractTestRule("serious_test(ID,DEG):-serious(ID,DEG)");

			//crisp data, monotonic rules
			exec.addTestRule("serious_test(ID,DEG):-serious_atl(ID,DEG),DEG2 is DEG+1, not(serious_atl(ID,DEG2))");
			exec.testRules(false);
			exec.retractTestRule("serious_test(ID,DEG):-serious_atl(ID,DEG),DEG2 is DEG+1, not(serious_atl(ID,DEG2))");

			//monotonic data, crisp rules
			exec.addTestRule("serious_atl_test(ID,DEG):-serious(ID,DEG2),DEG=<DEG2");
			exec.testRules(false);
			exec.retractTestRule("serious_atl_test(ID,DEG):-serious(ID,DEG2),DEG=<DEG2");

			//monotonic data, monotonic rules
			exec.addTestRule("serious_atl_test(ID,DEG):-serious_atl(ID,DEG)");
			exec.testRules(false);
			exec.close();
		}
		
	}


}
