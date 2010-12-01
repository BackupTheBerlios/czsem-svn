package czsem.utils;

import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.CharArrayReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.Reader;
import java.io.Writer;

public class ProcessExec {

	public static class ReaderThread extends Thread {
			
			private Reader is;
			private Writer os;
	
			private char [] buf = new char[10000];
			private BufferedReader buf_read;
	
			private long last_read = Long.MIN_VALUE;
			private long last_nothing_toread = Long.MIN_VALUE;
			
	
			public ReaderThread(Reader is, Writer os) {
				this.is = is;
				this.os = os;			
			}
			
			public ReaderThread(Reader is, OutputStream os) {
				this(is, new PrintWriter(os));
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
			
			protected void writeBuf(char[] buffer, int chars_to_write) throws IOException
			{
				os.write(buffer, 0, chars_to_write);
				os.flush();
			}
			
			@Override
			public void run() {
				try {
/*
					int runcnt = 0;
					int sum = 0;
/**/					
					for (int i=readbuf(); i>=0; i=readbuf())
					{
/*
						sum += i;
						runcnt++;
						int mod = 100;
						if (runcnt % mod == 1)
						{
							System.out.println(sum / mod);
							sum = 0;
						}
/**/						
						writeBuf(buf, i);
//						Thread.sleep(0);
					}
				} 
				catch (IOException e) {}
				catch (InterruptedException e) {}			
			}

		}

	public static class NullReaderThread extends ReaderThread
	{

		public NullReaderThread(Reader is) {
			super(is, (Writer) null);
		}

		@Override
		protected void writeBuf(char[] buffer, int i) throws IOException 
		{}		
	}


	private ReaderThread err_reader_thread;
	protected ReaderThread cin_reader_thread;
	protected Process process;
	protected PrintWriter output_writer;
	protected BufferedReader input_reader;
	protected BufferedReader error_reader;

	public ProcessExec() {
	}

	public void startErrReaderThread()
	{
		startErrReaderThread(System.err);		
	}

	public void startNullErrReaderThread() {
		err_reader_thread = new NullReaderThread(error_reader);
		err_reader_thread.start();		
	}

	public void startErrReaderThread(OutputStream output) {
		err_reader_thread = new ReaderThread(error_reader, output);
		err_reader_thread.start();		
	}

	public void startReaderThreads(OutputStream std_output, OutputStream err_output) {		
		cin_reader_thread = new ReaderThread(input_reader, std_output);
		err_reader_thread = new ReaderThread(error_reader, err_output);
	
		cin_reader_thread.start();
		err_reader_thread.start();
	}
	
	public void startReaderThreads(String log_filename_prefix) throws FileNotFoundException
	{
		
		startReaderThreads(
				new FileOutputStream(log_filename_prefix + "std.log"),
				new FileOutputStream(log_filename_prefix + "err.log"));	
	}


	public void startNullReaderThreads() {		
		cin_reader_thread = new NullReaderThread(input_reader);
		err_reader_thread = new NullReaderThread(error_reader);
	
		cin_reader_thread.start();
		err_reader_thread.start();
	}

	public void startStdoutReaderThreads() {
		startReaderThreads(System.out, System.err);
	}

	protected void initBuffers()
	{
		output_writer = new PrintWriter(new BufferedOutputStream(process.getOutputStream()));
		input_reader = new BufferedReader(new InputStreamReader(process.getInputStream()));
		error_reader = new BufferedReader(new InputStreamReader(process.getErrorStream()));		
	}

	public void exec(String[] cmdarray) throws IOException
	{
		process = Runtime.getRuntime().exec(cmdarray);		
		initBuffers();
	}

	public void exec(String[] exec_args, File working_directory) throws IOException
	{
		process = Runtime.getRuntime().exec(exec_args, null, working_directory);
		initBuffers();
	}

	public void exec(String[] exec_args, String[] envp) throws IOException
	{		
		process = Runtime.getRuntime().exec(exec_args, envp);
		initBuffers();
	}

	public int waitFor() throws InterruptedException {
		return process.waitFor();		
	}
	
	public String readLine() throws IOException
	{
		return input_reader.readLine();
	}

	public void writeString(String text) throws IOException
	{
		output_writer.write(text);
	}
}