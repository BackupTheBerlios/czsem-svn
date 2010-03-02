package czsem.gate;

import java.io.IOException;
import java.io.PrintStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Stack;

import javax.xml.parsers.ParserConfigurationException;
import javax.xml.parsers.SAXParserFactory;

import org.xml.sax.Attributes;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;

import gate.Document;

public class SAXTMTAnnotator extends DefaultHandler
{
	public static class Token
	{
		String [] features;
		
		public Token(int fetures_num)
		{
			features = new String[fetures_num] ;
		}
		
		public void print(PrintStream out)
		{
			for (int i = 0; i < features.length; i++) {
				out.println(features[i]);				
			}
		}
	}
	
	public static class Sentence
	{
		String string;
		
		Map<String, Token> a_tokens;
		Map<String, Token> t_tokens;
		
		public Sentence()
		{
			a_tokens = new HashMap<String, Token>(20);
			t_tokens = new HashMap<String, Token>(20);
		}
		
		public void printTokens(Map<String, Token> tokens, PrintStream out)
		{
			for (String key : tokens.keySet())
			{
				out.println("### " + key + " ###");
				tokens.get(key).print(out);
			}
		}

		
	}
	
	private Stack<String> parent_ids = new Stack<String>();
	private String[] actual_fetures;
	private Map<String, Token> actual_tokens;
	private Sentence actual_sentence;
	private Token actual_token;
	
	private char [] last_chars;
	private int last_char_start;
	private int last_char_length;
	
	private final int setence_stack_level = 2;

	
	private List<Sentence> sentences = new ArrayList<Sentence>();
	
	private javax.xml.parsers.SAXParser sax_parser;
	
	private void setTecto()
	{
		actual_fetures = TMTTreeAnnotator.t_token_sax_features;		
		actual_tokens = actual_sentence.t_tokens;		
	}

	private void setAnalytic()
	{
		actual_fetures = TMTTreeAnnotator.a_token_sax_features;		
		actual_tokens = actual_sentence.a_tokens;		
	}

	private static String [] dummy_str = new String[0]; 
	private static Map<String, Token> dummy_toc = new HashMap<String, Token>(); 

	private void setDummy()
	{
		actual_fetures = dummy_str;		
		actual_tokens = dummy_toc;
		dummy_toc.clear();
	}


	private void newSentence()
	{
		Sentence sent = new Sentence();
		sentences.add(sent);
		actual_sentence = sent;
		
	}
	
	private void newToken(String id)
	{
		Token toc = new Token(actual_fetures.length);
		actual_tokens.put(id, toc);
		actual_token = toc;
	}

	@Override
	public void startElement(String uri, String localName, String qName, Attributes attributes) throws SAXException
	{
		if (qName.equals("SCzechT"))
		{
			setTecto();
		}
		if (qName.equals("SCzechA"))
		{
			setAnalytic();
		}
		if (qName.equals("SCzechM"))
		{
			setDummy();
		}

		if (qName.equals("LM"))
		{
			String id = attributes.getValue(0);
			System.out.println("dependes: " + id + " on " + parent_ids.peek());
			parent_ids.push(id);

			if (parent_ids.size() <= setence_stack_level)
			{
				newSentence();
				return;
			}
			
			if (id != null)
			{
				newToken(id);
			}
		}
	}

	private void testFeatures(String qName, String [] feature_list)
	{
		for (int i = 0; i < feature_list.length; i++) {
			if (feature_list[i].equals(qName))
			{
				actual_token.features[i] = stringFromLastCahrs();
				return;
			}
		}
		
	}
	
	private String stringFromLastCahrs()
	{
		return new String(last_chars, last_char_start, last_char_length);
	}

	private void testFeatures(String qName)
	{
		testFeatures(qName, actual_fetures);		
	}

	@Override
	public void endElement(String uri, String localName, String qName) throws SAXException
	{
		if (qName.equals("LM")) parent_ids.pop();		
		if (qName.equals("czech_source_sentence")) 
			actual_sentence.string = stringFromLastCahrs();
		if (parent_ids.size() > setence_stack_level) testFeatures(qName);
	}
	
	@Override
	public void characters(char[] ch, int start, int length) throws SAXException
	{		
		last_chars = ch;
		last_char_start = start;
		last_char_length = length;
	}

	
	public SAXTMTAnnotator() throws ParserConfigurationException, SAXException
	{
		// Create a JAXP "parser factory" for creating SAX parsers
	    javax.xml.parsers.SAXParserFactory spf = SAXParserFactory.newInstance();

	    // Configure the parser factory for the type of parsers we require
	    spf.setValidating(false); // No validation required

	    // Now use the parser factory to create a SAXParser object
	    // Note that SAXParser is a JAXP class, not a SAX class
	    sax_parser = spf.newSAXParser();

	    // Create a SAX input source for the file argument

	    // Give the InputSource an absolute URL for the file, so that
	    // it can resolve relative URLs in a <!DOCTYPE> declaration, e.g.
//	    input.setSystemId("file://" + new File(args[0]).getAbsolutePath());
	}

	public void parseAndInit(Document doc, String tmTFilename) throws SAXException, IOException
	{	
	    org.xml.sax.InputSource input = new InputSource(tmTFilename);

	    parent_ids.push("TToPP");
	    // Finally, tell the parser to parse the input and notify the handler
	    sax_parser.parse(input, this);

	    // Instead of using the SAXParser.parse() method, which is part of the
	    // JAXP API, we could also use the SAX1 API directly. Note the
	    // difference between the JAXP class javax.xml.parsers.SAXParser and
	    // the SAX1 class org.xml.sax.Parser
	    //
	    // org.xml.sax.Parser parser = sp.getParser(); // Get the SAX parser
	    // parser.setDocumentHandler(handler); // Set main handler
	    // parser.setErrorHandler(handler); // Set error handler
	    // parser.parse(input); // Parse!
	    
	    System.out.println("------------------------------------------------------------");
	    System.out.println("Sentences: " + sentences.size());
	    System.out.println("Last Sentence string: " + actual_sentence.string);
	    System.out.println("Last Sentence aTokens: " + actual_sentence.a_tokens.size());
	    System.out.println("Last Sentence num tTokens: " + actual_sentence.t_tokens.size());
	    System.out.println("Last Sentence tTokens: ");
	    actual_sentence.printTokens(actual_sentence.t_tokens, System.out); 
	}

	
}
