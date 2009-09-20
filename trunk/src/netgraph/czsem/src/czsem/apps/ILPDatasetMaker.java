package czsem.apps;

import java.io.IOException;
import java.io.PrintStream;

import czsem.utils.ILPStringList;

/**
 * @author dedek
 *
 */
public class ILPDatasetMaker {
	
	public static void makeDatasets(String filename, double train_test_ratio) throws IOException
	{
		ILPStringList ilp_list = new ILPStringList();
		
		ilp_list.readFromFile(filename);
		
		int lines = ilp_list.getLines();
		int train_lines = (int) (lines * train_test_ratio);
		
		System.err.println("file >" + filename + "< no of used lines: "+ lines + " no of train lines: "+ train_lines);
		
		// TRAIN data
		PrintStream f_train = new PrintStream("train_"+filename);								
		for (int i = 0; i < train_lines; i++)
		{
			f_train.println(ilp_list.removeRandomLine());			
		}		

		// TEST data
		PrintStream f_test = new PrintStream("test_"+filename);		
		for (int i = train_lines; i < lines; i++)
		{
			f_test.println(ilp_list.removeRandomLine());			
		}		
	}
	
	public static void main(String[] args) throws IOException
	{
		if (args.length < 2)
		{
			System.err.println("Usage:   ILPDatasetMaker source_file train_test_ratio");			
			System.err.println("Example: ILPDatasetMaker number_nodes_exmpl03.pl 0.1");
			
			return;
		}

		makeDatasets(args[0], Double.parseDouble(args[1]));
		
/*		ILPStringList ilpsl1 = new ILPStringList();
		
		ilpsl1.readFromFile("number_nodes_exmpl01.pl");
		
		System.out.println(ilpsl1.getLines());
		
		for (int i = 0; i < ilpsl1.getLines(); i++)
		{
//			System.out.println(ilpsl1.removeRandomLine());			
		}
*/
	}

}
