package czsem.gate.learning;

import gate.util.AnnotationDiffer;
import gate.util.reporting.exceptions.BenchmarkReportInputFileFormatException;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.PrintStream;
import java.net.URISyntaxException;
import java.nio.charset.Charset;
import java.nio.charset.CharsetDecoder;
import java.nio.charset.CharsetEncoder;
import java.util.Collection;
import java.util.Map;

import com.csvreader.CsvWriter;

import czsem.gate.GateUtils;
import czsem.gate.GateUtils.TimeBenchmarkReporter;
import czsem.gate.plugins.LearningEvaluator;
import czsem.utils.ProjectSetup;

public class WekaResultExporter
{
	private static class TimeBenchmarkWekaReporter implements TimeBenchmarkReporter
	{

		private WekaResultExporter wekaResultExporter;

		public TimeBenchmarkWekaReporter(WekaResultExporter wekaResultExporter) {
			this.wekaResultExporter = wekaResultExporter;
		}

		@SuppressWarnings("unchecked")
		private void searchMap(Map<String, Object> map)
		{
			
			for (String pr_name : map.keySet()) {
				if (pr_name.startsWith("doc") || pr_name.equals("systotal"))
					continue;

//				out.print(prefix + pr_name);

				Object child = map.get(pr_name);
				Map<String, Object> ch_map = null;
								
				if (child instanceof String)
				{
					if (pr_name.contains("train"))
						System.err.format("%s %s\n", pr_name, child);

//					out.println("\t" + child); //time
					continue;
				}
				else
				{
					ch_map = (Map<String, Object>) child;
//					out.println("\t" + ch_map.get("systotal"));
				}
				
				
				//recursive call
				searchMap(ch_map);

			}
		}

		@Override
		public void report(Map<String, Object> report1Container1) {
			searchMap(report1Container1);			
		}
	}

	
	public static final String[] header =
	{
/*
		learningEvaluator.getAnnotationTypes().toString(), //Key_Dataset
		//Key_Run
		//Key_Fold
		learningEvaluator.getKeyASName(),//Key_Scheme
		//Key_Scheme_options
		//Key_Scheme_version_ID
		//Date_time
		//Number_of_training_instances
		//Number_of_testing_instances
		diff.getCorrectMatches(),
		diff.getMissing(),
		diff.getSpurious(),
		diff.getPartiallyCorrectMatches(),
		diff.getPrecisionStrict(),
		diff.getRecallStrict(),
		diff.getFMeasureStrict(1),
		diff.getFMeasureLenient(1),
		diff.getFMeasureAverage(1)
*/
		
		"Key_Dataset",
//		"Key_Run",
//		"Key_Fold",
		"Key_ResponseAS",
		"Key_KeyAS",
//		"Key_Scheme_options",
//		"Key_Scheme_version_ID",
		"Date_time",
//		"Number_of_training_instances",
//		"Number_of_testing_instances",
		"Number_correct",
		"Number_missing",
		"Number_spurious",
		"Number_overlap",
//		"Percent_correct",
//		"Percent_incorrect",
//		"Percent_unclassified",
		"Strict_precision",
		"Strict_recall",
		"Strict_F1",
		"Lenient_F1",
		"Average_F1",
//		"Area_under_ROC",
//		"Weighted_avg_true_positive_rate",
		"Elapsed_Time_training",
		"Elapsed_Time_testing",
	};

	
	protected static class Result
	{
		String data[];

		public Result()
		{
			data = new String[header.length];			
		}

		public Result(Object ... data)
		{
			this();
			
			for (int i = 0; i < data.length; i++)
			{
				if (i >= this.data.length) break;
				
				this.data[i] = data[i].toString();
			}
			
		}
		
		public Result(LearningEvaluator learningEvaluator, AnnotationDiffer diff, String timestamp)
		{
			this(					
					learningEvaluator.getAnnotationTypes().toString(), //Key_Dataset
					//Key_Run
					//Key_Fold
					learningEvaluator.getResponseASName(),//Key_ResponseAS
					learningEvaluator.getKeyASName(),//Key_KeyAS
					//Key_Scheme_options
					//Key_Scheme_version_ID
					timestamp,//Date_time
					//Number_of_training_instances
					//Number_of_testing_instances
					diff.getCorrectMatches(),
					diff.getMissing(),
					diff.getSpurious(),
					diff.getPartiallyCorrectMatches(),
					diff.getPrecisionStrict(),
					diff.getRecallStrict(),
					diff.getFMeasureStrict(1),
					diff.getFMeasureLenient(1),
					diff.getFMeasureAverage(1)
					//Number_unclassified
					//Percent_correct
					//Percent_incorrect
					//Percent_unclassified
					//Kappa_statistic
					//Mean_absolute_error
					//Root_mean_squared_error
					//Relative_absolute_error
					//Root_relative_squared_error
					//SF_prior_entropy
					//SF_scheme_entropy
					//SF_entropy_gain
					//SF_mean_prior_entropy
					//SF_mean_scheme_entropy
					//SF_mean_entropy_gain
					//KB_information
					//KB_mean_information
					//KB_relative_information
					//True_positive_rate
					//Num_true_positives
					//False_positive_rate
					//Num_false_positives
					//True_negative_rate
					//Num_true_negatives
					//False_negative_rate
					//Num_false_negatives
					//IR_precision
					//IR_recall
					//F_measure
					//Area_under_ROC
					//Weighted_avg_true_positive_rate
					//Weighted_avg_false_positive_rate
					//Weighted_avg_true_negative_rate
					//Weighted_avg_false_negative_rate
					//Weighted_avg_IR_precision
					//Weighted_avg_IR_recall
					//Weighted_avg_F_measure
					//Weighted_avg_area_under_ROC
					//Elapsed_Time_training
					//Elapsed_Time_testing
					//UserCPU_Time_training
					//UserCPU_Time_testing
					//Serialized_Model_Size
					//Serialized_Train_Set_Size
					//Serialized_Test_Set_Size
					//Summary
					//measureNumRules
			);
		}
		
	}
	
	Result [] results = null;
	
	
	public WekaResultExporter(String [][] data)
	{
		results = new Result[data.length];
		
		for (int i = 0; i < data.length; i++) {
			results[i] = new Result((Object[])data[i]);
		}
	}
	
	
	public WekaResultExporter()
	{
		initFromLearningEvaluatorCentralResultsRepository();
	}
	
	private void initFromLearningEvaluatorCentralResultsRepository()
	{
		String timestamp = ProjectSetup.makeTimeStamp();

		Collection<LearningEvaluator> rep_contnet = LearningEvaluator.CentralResultsRepository.repository.getContent();
		
		results = new Result[rep_contnet.size()]; 
		int a=0;
		for (LearningEvaluator learningEvaluator : rep_contnet)
		{
			AnnotationDiffer eval = LearningEvaluator.CentralResultsRepository.repository.getOveralResults(learningEvaluator);
			
			results[a] = new Result(learningEvaluator, eval, timestamp );
			a++;
		}				
	}
	
	public void addInfoFromTimeBechmark() throws BenchmarkReportInputFileFormatException, URISyntaxException, IOException
	{
		GateUtils.doGateTimeBenchmarkReport(new TimeBenchmarkWekaReporter(this));
	}
	
	public void saveAll(String filename, boolean append) throws IOException
	{
		FileOutputStream out = new FileOutputStream(filename, append);
		CsvWriter wr = new CsvWriter(out, ',', Charset.defaultCharset());
		
		if (! append) wr.writeRecord(header);
		
		for (int i = 0; i < results.length; i++)
		{
			wr.writeRecord(results[i].data);
			
		}
		
		wr.close();		
	}

	public static void main(String [] args) throws BenchmarkReportInputFileFormatException, URISyntaxException, IOException
	{
		String[][] data = 
		{
				{"data","Paum"},
				{"data","ILP_config_NE_roots"},
				{"data","ILP_config_NE_roots_subtree"},
				{"data","ILP_config"},		
		};
		
		System.err.println(GateUtils.createGateTimeBenchmarkReport());

		WekaResultExporter ex = new WekaResultExporter(data);
		ex.addInfoFromTimeBechmark();
		
		ex.saveAll("main.csv", false);
		
	}


}
