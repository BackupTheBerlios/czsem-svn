package czsem.apps;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.PrintStream;
import java.util.HashSet;
import java.util.Set;

import com.csvreader.CsvReader;

public class CVStoILP_Accidents {

	private PositiveExampleDetector pe_detect;
	
	private Set<String>[] attribute_values_bufeer = null;

	@SuppressWarnings("unchecked")
	protected void initAttributeValuesBufeer(int length)
	{
		attribute_values_bufeer = new HashSet[length];
		
		for (int i=0; i<attribute_values_bufeer.length; i++) {
			attribute_values_bufeer[i] = new HashSet<String>();
		}
	}

	
	CVStoILP_Accidents(PositiveExampleDetector pe_detect)
	{
		this.pe_detect = pe_detect;
	};
	
	CVStoILP_Accidents(PositiveExampleDetector pe_detect, String filename) throws FileNotFoundException
	{
		this.pe_detect = pe_detect;
		ilp_out = new PrintStream(filename);		
	}
	
	private PrintStream ilp_out = System.out;
	
	public void parse_input(String file_name) throws IOException
	{
		CsvReader reader = new CsvReader(file_name, ';');

		reader.readHeaders();
		

		while (reader.readRecord())
		{
			if (attribute_values_bufeer == null)
					initAttributeValuesBufeer(reader.getColumnCount());
					
								
			ilp_out.println("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
			ilp_out.print("id(id_");
			ilp_out.print(reader.get("filename"));
			ilp_out.println(").");
			
			
			for (int i = 0; i < reader.getColumnCount(); i++) {

				String value = reader.get(i); 
//				if (value.compareTo("?") == 0) continue;
				if (value.compareTo("?") == 0) value = "unknown";
				
				attribute_values_bufeer[i].add(value);

				ilp_out.print(reader.getHeader(i));
				ilp_out.print("(id_");
				ilp_out.print(reader.get("filename"));
				ilp_out.print(',');
				ilp_out.print(value);
				ilp_out.println(").");
				
			}
		}
		
		ilp_out.println("\n%%%%%%%%% D A T A %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
		for (int i = 0; i < attribute_values_bufeer.length; i++) {
			for (String value : attribute_values_bufeer[i]) {
				ilp_out.print(reader.getHeader(i));
				ilp_out.print("(");
				ilp_out.print(value);
				ilp_out.println(").");				
			}			
		}

		ilp_out.println("\n%%%%%%%%% M O D E S %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
		//monotinazace
		for (int i = 0; i < attribute_values_bufeer.length; i++) {
			ilp_out.print(reader.getHeader(i));
			ilp_out.print("_atleast(ID,N) :- ");
			ilp_out.print(reader.getHeader(i));
			ilp_out.println("(ID,N),not(integer(N)),!.");

			ilp_out.print(reader.getHeader(i));
			ilp_out.print("_atleast(ID,N) :- ");
			ilp_out.print(reader.getHeader(i));
			ilp_out.print("(ID,N2), integer(N2), ");
			ilp_out.print(reader.getHeader(i));
			ilp_out.println("(N), integer(N), N2>=N.");
		}
		
		//modes
		ilp_out.println();
		for (int i = 0; i < attribute_values_bufeer.length; i++) {
			ilp_out.print(":- mode(1, ");
			ilp_out.print(reader.getHeader(i));
			ilp_out.print("_atleast( +id, #");
			ilp_out.print(reader.getHeader(i));
			ilp_out.println(")).");
		}
		ilp_out.println();
		for (int i = 0; i < attribute_values_bufeer.length; i++) {
			ilp_out.print(":- mode(1, ");
			ilp_out.print(reader.getHeader(i));
			ilp_out.print("( +id, #");
			ilp_out.print(reader.getHeader(i));
			ilp_out.println(")).");
		}

		//determinations
		for (int a=0; a<10; a++)
		{
			ilp_out.println();
			for (int b=0; b<=a; b++)
			{
				ilp_out.print("test_serious_atleast_");			
				ilp_out.print(b);			
				ilp_out.print("(ID) :- serious_atleast_");			
				ilp_out.print(a);			
				ilp_out.println("(ID).");
			}
			
			ilp_out.println();
			ilp_out.print("serious_only_");
			ilp_out.print(a);
			ilp_out.print("(ID) :- serious_atleast_");
			ilp_out.print(a);
			ilp_out.print("(ID)");
			for (int b=a+1; b<10; b++)
			{
				ilp_out.print(", not(serious_atleast_");			
				ilp_out.print(b);			
				ilp_out.print("(ID))");			
			}			
			ilp_out.println('.');

			
			ilp_out.println();
			ilp_out.print(":- mode(1, serious_atleast_");				
			ilp_out.print(a);				
			ilp_out.println("( +id)).");				
			for (int i = 0; i < attribute_values_bufeer.length; i++) {
				if (i == 1) continue; //filename
//				if (i == 3) continue; //type
				if (i == 14) continue; // ranking
				if (i == 1) continue; // randomized_order
				
				ilp_out.print(":- determination(serious_atleast_");
				ilp_out.print(a);
				ilp_out.print("/1, ");
				ilp_out.print(reader.getHeader(i));
				
				if (pe_detect.writeAtleastSuffixInDeterminations())
					ilp_out.println("_atleast/2)."); //monotone
				else
					ilp_out.println("/2).");	//non-monotone
			}
		}

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
	}
	
	public static class MonotonicExampleDetector implements PositiveExampleDetector
	{
		public boolean isPositiveExample(int val, int min, int max) {
			return val >= min;	//monotic 
		}

		public boolean writeAtleastSuffixInDeterminations() {
			return true;
		}		
	}

	public static class NonMonotonicExampleDetector implements PositiveExampleDetector
	{
		public boolean isPositiveExample(int val, int min, int max) {
			return (val >= min) && (val < max);	//non_monotic 
		}

		public boolean writeAtleastSuffixInDeterminations() {
			return false;
		}		
	}
	
	public static class Examples
	{
		String ids[] = new String[50];
		int rankings[] = new int[50];
		int cat_mins[] = {5,15,30,65,81};
		
		public int getCount() {return ids.length;}				
	}
	
	public void printExamples(boolean negative, Examples ex)
	{
		int categories_stat[] = new int[ex.cat_mins.length-1];		
		for (int c=0; c<categories_stat.length; c++) categories_stat[c] = 0;

		for (int a=0; a<ex.getCount(); a++)
			for (int r=0; r< ex.cat_mins.length-1; r++)
			{
				if (negative ^ pe_detect.isPositiveExample(ex.rankings[a], ex.cat_mins[r], ex.cat_mins[r+1]))
				{
					categories_stat[r]++;
					ilp_out.print("serious_atleast_");
					ilp_out.print(r);					
					ilp_out.print('(');					
					ilp_out.print(ex.ids[a]);
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

	public void make_examples(String file_name) throws IOException
	{
		CsvReader reader = new CsvReader(file_name, ';');
		
		reader.readHeaders();
		
		Examples ex = new Examples();

		int i;
		for (i=0; reader.readRecord(); i++)
		{
				ex.ids[i] = "id_" + reader.get("filename");
//				rankings[i] = (int) (Double.parseDouble(reader.get("ranking")) * 10);
				ex.rankings[i] = Integer.parseInt(reader.get("ranking"));
		}
		reader.close();

/***		
		int min = getMinValue(rankings);
		int max = getMaxValue(rankings);
		
		double cat_mins[] = count_cat_mins(min, max, 5);
/***/		
	
			
		ilp_out.println("%%%%%%%%%%%%% P O S I T I V E %%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
		printExamples(false, ex);
		
		ilp_out.println("%%%%%%%%%%%%% N E G A T I V E %%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
		printExamples(true, ex);
	}

	
	public static void main(String[] args) throws IOException
	{
		if (args.length < 1)
		{
			System.err.println("Usage:   CVStoILP_Accidents source_file");						
			return;
		}
		
//		CVStoILP_Accidents csv = new CVStoILP_Accidents("C:\\WorkSpace\\Aleph\\ranking.b");
		CVStoILP_Accidents csv = new CVStoILP_Accidents(new NonMonotonicExampleDetector());
		csv.parse_input(args[0]);
		
//		CVStoILP_Accidents csv2 = new CVStoILP_Accidents("C:\\WorkSpace\\Aleph\\serious.f");
		CVStoILP_Accidents csv2 = new CVStoILP_Accidents(new MonotonicExampleDetector());
		csv2.make_examples(args[0]);
	}


}
