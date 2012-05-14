package czsem.gate.learning;

import java.io.File;
import java.io.IOException;
import java.io.PrintStream;
import java.util.Locale;

import weka.core.Instances;
import weka.core.Range;
import weka.core.converters.CSVLoader;
import weka.experiment.PairedCorrectedTTester;
import weka.experiment.ResultMatrix;
import weka.experiment.ResultMatrixPlainText;
import weka.experiment.Tester;

public class WekaResultTests
{
	Tester m_TTester = new PairedCorrectedTTester();
	private PrintStream out;
	
	int first_test_attr = 7;


	public WekaResultTests(PrintStream out) {
		this.out = out;
		m_TTester.setShowStdDevs(true);
	}

	public static void main(String[] args) throws Exception
	{
		Locale.setDefault(Locale.ENGLISH);
		WekaResultTests t = new WekaResultTests(System.err);
		
//		t.loadInstances("weka_results_acq_ne_root_longer.csv");
//		t.loadInstances("weka_results.csv");
		t.loadInstances("gate-learning/results/weka_results_acq_complete.csv");
		
		t.printBasicStats();
		
		System.err.println();
//		t.performAllTests();
		
		t.testsAttr(6);
		
		System.err.println("done");
	
	}

	public ResultMatrix testsAttr(int c) throws Exception
	{
		int cur_attr_index = c+first_test_attr;
		ResultMatrix ret = new ResultMatrixPlainText();
		m_TTester.setResultMatrix(ret);
		out.println( m_TTester.header(cur_attr_index));
		out.print(m_TTester.multiResultsetFull(0, cur_attr_index));
		
		return ret;
	}

	public void loadInstances(String filename) throws IOException
	{
		CSVLoader cnv = new CSVLoader();
		File f = new File(filename);
		cnv.setSource(f);
		Instances inst = cnv.getDataSet();
		m_TTester.setInstances(inst);
		
		m_TTester.setRunColumn(1);
		m_TTester.setFoldColumn(2);
		
		
		m_TTester.setDatasetKeyColumns(new Range("1"));
		m_TTester.setResultsetKeyColumns(new Range("4, 5, 6"));
			
	}

	public void printBasicStats()
	{
		out.println("ResultSets"); 
		for (int i = 0; i < m_TTester.getNumResultsets(); i++) {
	        out.println( m_TTester.getResultsetName(i));
	    }

		out.println("DataSets num"); 
		out.println( m_TTester.getNumDatasets());
		
	}

	
	public void performAllTests() throws Exception
		{
			
	//		int [] cols = {3,4,5};
	//		m_TTester.setDisplayedResultsets(null);
	//		ResultMatrix m_ResultMatrix = new ResultMatrixPlainText();
			
			
	//	    m_ResultMatrix.setShowStdDev(true);
	//	    m_ResultMatrix.setRemoveFilterName(ExperimenterDefaults.getRemoveFilterClassnames());
	//	    m_ResultMatrix.setShowAverage(true);
				

	
			
			Instances inst = m_TTester.getInstances();
			int num_tests = inst.numAttributes()-first_test_attr;
			
			ResultMatrix results [] = new ResultMatrix[num_tests];
	
			for (int attr=0; attr< num_tests ; attr++)
			{
				results [attr] = testsAttr(attr);
			}
			
			for (int d=0; d<m_TTester.getNumDatasets(); d++)
			{
				printDatasetHeader(inst.attribute(0).value(d));
				for (int c=0; c< num_tests ; c++)
				{
					int cur_attr_index = c+first_test_attr;
					printAttrName(inst.attribute(cur_attr_index).name());
					int col = 0;
					printAttrValue(results[c].getMean(col, d), results[c].getStdDev(col, d));
					col++;
					printAttrValue(results[c].getMean(col, d), results[c].getStdDev(col, d));
					
					printSignificance(results[c].getSignificance(1, d));					
				}
				
			}
			
	//		processResults(results);
	/*		
			out.println( 
					m_TTester.multiResultsetFull(0, compareCol));
	*/		
		}

	protected void printSignificance(int significance)
	{
		switch (significance) {
		case 1: out.print("up"); break;
		case 2: out.print("down");	break;
		}
		
		out.println();
		
	}

	public static String filterAttrName(String name)
	{
		return name.replace('_', ' ');
	}
	
	protected void printDatasetHeader(String dataset)
	{
		out.println("dataset: " + filterAttrName(dataset.substring(1, dataset.length()-1)));
	}
	
	protected void printAttrName(String name) {
		out.format("%40s | ", filterAttrName(name));		
	}

	protected void printAttrValue(double avg, double stdev)
	{
		out.format("%11.3f +/- %8.3f | ", avg, stdev);				
	}

}
