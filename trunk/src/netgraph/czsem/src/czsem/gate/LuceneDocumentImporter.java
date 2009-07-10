package czsem.gate;

import gate.LanguageAnalyser;
import gate.creole.AbstractLanguageAnalyser;
import gate.creole.ExecutionException;
import gate.creole.annic.apache.lucene.index.Term;
import gate.creole.annic.apache.lucene.search.TermQuery;
import gate.creole.annic.lucene.LuceneIndexSearcher;
import gate.creole.metadata.CreoleResource;
import gate.util.Out;

import java.io.IOException;

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



}
