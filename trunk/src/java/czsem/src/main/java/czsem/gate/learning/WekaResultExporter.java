package czsem.gate.learning;

import gate.util.AnnotationDiffer;
import gate.util.reporting.exceptions.BenchmarkReportInputFileFormatException;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URISyntaxException;
import java.nio.charset.Charset;
import java.util.Collection;
import java.util.Map;

import org.apache.log4j.Logger;

import com.csvreader.CsvReader;
import com.csvreader.CsvWriter;

import czsem.gate.GateUtils;
import czsem.gate.GateUtils.TimeBenchmarkReporter;
import czsem.gate.plugins.LearningEvaluator;
import czsem.gate.plugins.LearningEvaluator.DiffCondition;
import czsem.gate.plugins.LearningEvaluator.DocumentDiff;
import czsem.utils.ProjectSetup;

public class WekaResultExporter
{
	private static class TimeBenchmarkWekaReporter implements TimeBenchmarkReporter
	{
		Logger logger = Logger.getLogger(TimeBenchmarkWekaReporter.class);

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
					for (int i = 0; i < wekaResultExporter.results.length; i++)
					{
						Result r = wekaResultExporter.results[i];
						if (pr_name.contains(
								MLEngine.renderPRNameTrain(
										r.getResponsesASName())))
						{
							logger.debug(String.format("train: %s %s", pr_name, child));
							r.setTrainTime((String) child);
							continue;
						}

						if (pr_name.contains(
								MLEngine.renderPRNameTest(
										r.getResponsesASName())))
						{
							logger.debug(String.format("test: %s %s", pr_name, child));
							r.setTestTime((String) child);
						}
						
						
					}

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
		"Key_Dataset",
		"Key_Run",
		"Key_Fold",
		"Key_Scheme",
		"Key_Scheme_options",
		"Key_Scheme_version_ID",
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
		public void setTestTime(String time) {
			setField(data.length-1, time);			
		}
		public void setTrainTime(String time) {
			setField(data.length-2, time);						
		}
		public String getResponsesASName() {
			return data[3];
		}	
		public void setRunNumber(int run_number) {
			setField(1, run_number);
		}

		String data[];

		public Result()
		{
			data = new String[header.length];			
		}

		protected void setField(int index, Object value)
		{
			data[index] = value.toString();
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
		
		public Result(LearningEvaluator learningEvaluator, AnnotationDiffer diff, int fold_number, String timestamp)
		{
			this(					
					learningEvaluator.getAnnotationTypes().toString(), //Key_Dataset
					learningEvaluator.actualRunNumber,//Key_Run
					fold_number,//Key_Fold
					learningEvaluator.getResponseASName(),//Key_Scheme
					learningEvaluator.getKeyASName(),//Key_Scheme_options
					"a",//Key_Scheme_version_ID
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
		
		if (rep_contnet.isEmpty()) return;
		
		int num_of_folds = rep_contnet.iterator().next().actualFoldNumber;
		
		results = new Result[rep_contnet.size()*num_of_folds]; 
		int a=0;
		for (LearningEvaluator learningEvaluator : rep_contnet)
		{
			for (int fold=0; fold < num_of_folds; fold++)
			{
				final int fold_number = fold+1;
				
				AnnotationDiffer eval = 
					LearningEvaluator.CentralResultsRepository.repository.

//					getOveralResults(learningEvaluator, new AllDiffsCondition());
					getOveralResults(learningEvaluator, 
/**/
						new DiffCondition() {
							@Override
							public boolean evaluate(DocumentDiff diff) {
								return diff.foldNumber == fold_number;
							}
						});
/**/				
				results[a*num_of_folds+fold] = new Result(learningEvaluator, eval, fold_number, timestamp );
			}
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
		
		int run_number;
		if (append)
		{
			run_number = lastRunNumberFromData(filename)+1;
		}
		else
		{
			run_number = 1;
			wr.writeRecord(header);
		}
		
		for (int i = 0; i < results.length; i++)
		{
			Result res = results[i];
			res.setRunNumber(run_number);
			wr.writeRecord(res.data);
			
		}
		
		wr.close();		
	}

	private int lastRunNumberFromData(String filename) throws IOException
	{
		int ret = 0;
		
		FileInputStream in = new FileInputStream(filename);
		CsvReader rd = new CsvReader(in, ',', Charset.defaultCharset());
		
		rd.readHeaders();
		while (rd.readRecord())
		{
			String cur = rd.get("Key_Run");
			int cur_int = Integer.parseInt(cur);
			ret = Math.max(ret, cur_int);
		}
		
		rd.close();
		
		return ret;
	}


	public static void main(String [] args) throws BenchmarkReportInputFileFormatException, URISyntaxException, IOException
	{
		String[][] data = 
		{
				{"data","2","1","Paum"},
				{"data","2","1","ILP_config_NE_roots"},
				{"data","2","1","ILP_config_NE_roots_subtree"},
				{"data","2","1","ILP_config"},		
				{"data","2","2","Paum"},
				{"data","2","2","ILP_config_NE_roots"},
				{"data","2","2","ILP_config_NE_roots_subtree"},
				{"data","2","2","ILP_config"},		
		};
		
		System.err.println(GateUtils.createGateTimeBenchmarkReport());

		WekaResultExporter ex = new WekaResultExporter(data);
		ex.addInfoFromTimeBechmark();
		
		ex.saveAll("main.csv", true);
		
	}


}
