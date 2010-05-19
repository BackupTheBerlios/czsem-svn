package czsem.utils;

import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.CharArrayReader;
import java.io.File;
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

	public void startReaderThreads() {
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

	public void waitFor() throws InterruptedException {
		process.waitFor();		
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