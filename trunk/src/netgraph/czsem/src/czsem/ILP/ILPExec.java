package czsem.ILP;

import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.CharArrayReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.Reader;
import java.io.Writer;

import czsem.utils.ProjectSetup;

public class ILPExec {

	public static class ReaderThread extends Thread {
		
		private Reader is;
		private Writer os;

		private char [] buf = new char[1000];
		private BufferedReader buf_read;

		private long last_read = Long.MIN_VALUE;
		private long last_nothing_toread = Long.MIN_VALUE;
		

		public ReaderThread(Reader is, Writer os) {
			this.is = is;
			this.os = os;			
		}
		
		public ReaderThread(Reader is, OutputStream os) {
			this.is = is;
			this.os = new PrintWriter(os);
		}

		public String readLine() throws IOException
		{
			return buf_read.readLine();				
		}

		public void waitUntilNothingToRead() throws InterruptedException
		{
			long timeout = 100;
			while (System.currentTimeMillis() - last_read < timeout) Thread.sleep(timeout);
			
			last_nothing_toread = System.currentTimeMillis();
		}

		public void waitForInput() throws InterruptedException
		{			
//			Thread.sleep(500);
			
			synchronized (buf)
			{
				while (last_nothing_toread > last_read)	buf.wait(); 
			}
		}
		
		private int readbuf() throws IOException, InterruptedException
		{
			int ret = is.read(buf); 
			synchronized (buf)
			{
				buf_read = new BufferedReader(new CharArrayReader(buf));
				last_read = System.currentTimeMillis();
				buf.notify();
				return ret;
			}
		}
		
		@Override
		public void run() {
			try {
				for (int i=readbuf(); i>=0; i=readbuf())
				{
					os.write(buf, 0, i);
					os.flush();
				}
			} 
			catch (IOException e) {}
			catch (InterruptedException e) {}			
		}
	}

	protected String prolog_path = "C:\\Program Files\\Yap\\bin\\yap.exe";
	protected String aleph_path = "C:\\Program Files\\aleph\\aleph.pl";
	protected File working_directory;
	protected String project_name;
	protected String learnig_examples;
	protected String testing_examples;
	private String rules_file = "learned_rules";
	private String results_file = "test_results";
	private ReaderThread err_reader_thread;
	private ReaderThread cin_reader_thread;
	
	Process prolog_process;

	PrintWriter output_writer;	
	BufferedReader input_reader;
	BufferedReader error_reader;
	
	public ILPExec(ProjectSetup ps)
	{
		working_directory = ps.working_directory;
		project_name = ps.project_name;
		learnig_examples = project_name;
		testing_examples = project_name + "_test";
		rules_file = renderRulesFileName(ps);
	}
	
	public static String renderRulesFileName(ProjectSetup ps) {
		return  ps.project_name + ".rules";
	}

	public static String renderRulesFilePathName(ProjectSetup ps) {
		return  ps.renderProjectFileName(".rules");
	}


	public void startPrologProcess(String file_name_to_consult) throws IOException
	{
		String [] exec_args = {prolog_path, "-l", file_name_to_consult};
		
		System.err.println(prolog_path);
		System.err.println(file_name_to_consult);
		
		prolog_process = Runtime.getRuntime().exec(exec_args, null, working_directory);
//				new String [] {"LANG=cs_CZ.UTF-8"} , working_directory);
		
		output_writer = new PrintWriter(new BufferedOutputStream(prolog_process.getOutputStream()));
		input_reader = new BufferedReader(new InputStreamReader(prolog_process.getInputStream()));
		error_reader = new BufferedReader(new InputStreamReader(prolog_process.getErrorStream()));		
	}

	public void startILPProcess() throws IOException
	{
		startPrologProcess(aleph_path);
	}
		
	public void startErrReaderThread()
	{
		err_reader_thread = new ReaderThread(error_reader, System.err);
		err_reader_thread.start();		
	}

	
	public void startReaderThreads()
	{
		cin_reader_thread = new ReaderThread(input_reader, System.out);
		err_reader_thread = new ReaderThread(error_reader, System.err);

		cin_reader_thread.start();
		err_reader_thread.start();
	}
	
	public void induceAndWriteRules()
	{		
		output_writer.println("yap_flag(encoding,X).\n");
		output_writer.flush();
/**
		os.println("yap_flag(encoding,utf8).");
		os.flush();
		
		Thread.sleep(3000);
/**/		
/**/		
		output_writer.print("read_all('");
		output_writer.print(project_name);
		output_writer.print("','");
		output_writer.print(learnig_examples);
		output_writer.println("').");
		output_writer.flush();
				
		output_writer.println("induce.");		
		output_writer.flush();
		
		output_writer.print("write_rules('");		
		output_writer.print(getRulesFileName());		
		output_writer.println("').");		
		output_writer.flush();		

	}

	public void retractTestRule(String rule)
	{
		output_writer.print("retract((");		
		output_writer.print(rule);		
		output_writer.println(")).");		
		output_writer.flush();		
		output_writer.println();
		output_writer.flush();				
	}

	public void consultFile(String filename)
	{
		output_writer.print("consult('");		
		output_writer.print(filename);		
		output_writer.println("').");		
		output_writer.flush();		
	}

	
	public void addTestRule(String rule)
	{
		output_writer.print("assert((");		
		output_writer.print(rule);		
		output_writer.println(")).");		
		output_writer.flush();		
		output_writer.println();
		output_writer.flush();		
	}
	
	public void testRules(boolean showCoverage) throws IOException, InterruptedException	
	{
		String true_positives; 
		String false_positives; 
		String total_positives; 
		String total_negatives; 
		
		String show_flag = "noshow";
		if (showCoverage) show_flag = "show";
		
		cin_reader_thread.waitUntilNothingToRead();
		output_writer.print("test('");
		output_writer.print(testing_examples);
		output_writer.print(".f',");
		output_writer.print(show_flag);
		output_writer.println(",Covered,Total),print(Covered),print('\\n'),print(Total),print('\\n').");
		output_writer.flush();		
		cin_reader_thread.waitForInput();
		true_positives = cin_reader_thread.readLine();
		total_positives = cin_reader_thread.readLine();
		output_writer.println();
		output_writer.flush();


		cin_reader_thread.waitUntilNothingToRead();
		output_writer.print("test('");
		output_writer.print(testing_examples);
		output_writer.print(".n',");
		output_writer.print(show_flag);
		output_writer.println(",Covered,Total),print(Covered),print('\\n'),print(Total),print('\\n').");
		output_writer.flush();		
		cin_reader_thread.waitForInput();
		false_positives = cin_reader_thread.readLine();
		total_negatives = cin_reader_thread.readLine();
		output_writer.println();
		output_writer.flush();
		
		PrintWriter test_out = new PrintWriter(new FileOutputStream(working_directory + "/" + getResultsFileName(), true));
		test_out.print(true_positives); 
		test_out.print('\t'); 
		test_out.print(false_positives); 
		test_out.print('\t'); 
		test_out.print(total_positives); 
		test_out.print('\t'); 
		test_out.print(total_negatives); 
		test_out.println();
		test_out.close();
	}

	public void close() throws InterruptedException
	{
		/**/
		output_writer.println("halt.");
		output_writer.flush();

		System.err.println("halt sent..");
			
		prolog_process.waitFor();
//		System.err.println(prolog_proc.exitValue());		
	}

	public String getLearnigExamples() {
		return learnig_examples;
	}


	public void setLearnigExamples(String learnigExamples) {
		learnig_examples = learnigExamples;
	}


	public String getTestingExamples() {
		return testing_examples;
	}


	public void setTestingExamples(String testingExamples) {
		testing_examples = testingExamples;
	}


	public void setRulesFileName(String rules_file) {
		this.rules_file = rules_file;
	}

	
	public String getRulesFileName() {
		return rules_file;
	}


	public void setResultsFileName(String results_file) {
		this.results_file = results_file;
	}


	public String getResultsFileName() {
		return results_file;
	}

	/*
	public static void main(String[] args) throws InterruptedException, IOException
	{
		ReaderThread rd = new ReaderThread(new InputStreamReader(System.in), System.out);
		System.out.println("created");
		rd.start();
		System.out.println("run");
		
		Thread.sleep(4000);
		
		System.out.println("waitng");
		String s = rd.readLine();
		System.out.println("***"+s+"***");
		
		System.out.println("end");				
	}
	*/

}
