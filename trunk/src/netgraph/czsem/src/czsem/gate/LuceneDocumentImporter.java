package czsem.gate;

import gate.LanguageAnalyser;
import gate.creole.AbstractLanguageAnalyser;
import gate.creole.ExecutionException;
import gate.creole.annic.apache.lucene.index.Term;
import gate.creole.annic.apache.lucene.search.TermQuery;
import gate.creole.annic.lucene.LuceneIndexSearcher;
import gate.creole.metadata.CreoleResource;
import gate.util.GateException;
import gate.util.Out;


import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintStream;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.nutch.metadata.Nutch;
import org.apache.nutch.searcher.Hit;
import org.apache.nutch.searcher.HitDetails;
import org.apache.nutch.searcher.Hits;
import org.apache.nutch.searcher.NutchBean;
import org.apache.nutch.searcher.Query;
import org.apache.nutch.searcher.Summary;
import org.apache.nutch.util.NutchConfiguration;

import antlr.CharBuffer;

@CreoleResource(name = "czsem LuceneDocumentImporter", comment = "Imports document form lucene repository")
public class LuceneDocumentImporter extends AbstractLanguageAnalyser implements LanguageAnalyser
{

	private static final long serialVersionUID = 4194519535438220266L;
	
	public void execute() throws ExecutionException
	{
		try {
			System.out.print("Writing: ");

			Out.println("start1");			
			LuceneIndexSearcher searcher = new LuceneIndexSearcher("/home/dedek/workspace/crawlovani/crawl");
			Out.println("start2");			
			Out.println(searcher.search(new TermQuery(new Term("", "most"))));
			Out.println("end");			
		} catch (IOException e) {
			throw new ExecutionException(e);
		} 
		
	}
	
	
	
	public static void main(String[] args) throws IOException 
	{
		Configuration conf = NutchConfiguration.addNutchResources(new Configuration(true));
		
//		conf.set("analysis.common.terms.file", "/home/dedek/workspace/nutch-1.0/conf/common-terms.utf8"); 
//		Configuration conf = new Configuration(true);
//		conf.
		System.out.println(conf);
		NutchBean bean = new NutchBean(conf, new Path("/home/dedek/workspace/crawlovani/crawl/"));
//		NutchBean bean = new NutchBean(conf, new Path("/home/dedek/workspace/nutch-1.0/"));
		
		Query query = Query.parse("sbor", conf);
		
		Hits hits = bean.search(query, 1);
		
		for (int i = 0; i < hits.getLength(); i++)
		{
			Hit hit = hits.getHit(i);
			HitDetails details = bean.getDetails(hit);
			
			
			
			  
			String title = details.getValue("title");
		      String url = details.getValue("url");
		      Summary summary = bean.getSummary(details, query);

    
//		      PrintStream out = new PrintStream(System.out, true, "cp1250");
		      PrintStream out = new PrintStream(System.out, true, "UTF-8");
		      
		      
		      byte buf[] = bean.getContent(details);
		      
		      ByteArrayInputStream is = new ByteArrayInputStream(buf);
		      InputStreamReader isr = new InputStreamReader(is, "cp1250");
		      
		      for (int j = 0; j < buf.length; j++) {
				out.print((char) isr.read());
			}
		      
		      out.println("\n\n");
/*
		      out.print("title: ");
		      out.println(title);
		      out.print("url: ");
		      out.println(url);
		      out.println("\t" + summary.toString());
		      out.println("\n\t" + summary.toHtml(false));
*/		      
			
		}
		
		
		
		System.out.println("Hallo world \n");

		bean.close();	
	}
	
	



}
