package czsem.gate;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Stack;

import javax.xml.parsers.ParserConfigurationException;
import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;

import org.xml.sax.Attributes;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;

import czsem.gate.TMTAnnotator.Dependency;
import czsem.gate.TMTAnnotator.Sentence;
import czsem.gate.TMTAnnotator.Token;

public class SAXTMTParser extends DefaultHandler
{
	private String language = "english";
	
	private Stack<String> qname_stack = new Stack<String>();
	private Stack<String> id_all_stack = new Stack<String>();
	private Stack<String> id_valid_stack = new Stack<String>();
	
	private StringBuilder last_characters = null; 


	private String[] actual_fetures = Constants.dummy_feat;
	private Map<String, Token> actual_tokens;
	private Sentence actual_sentence;
	private Token actual_token;
	private List<Dependency> actual_dependencies;
	private List<Dependency> dummy_dep = new ArrayList<Dependency>(50);	
	
	private List<Sentence> sentences = new ArrayList<Sentence>();
	
	private SAXParser sax_parser;
	
	public static class Constants
	{
		private static String [] dummy_feat = new String[0]; 
		private static Map<String, Token> dummy_toc = new HashMap<String, Token>();
		
		public static final String[] t_token_sax_features = 
	    {
	    		"nodetype", "t_lemma", "functor", "deepord", "formeme",
	    		"sempos", "degcmp", "negation", "gender", "number",  
	    		"verbmod", "deontmod", "tense", "aspect", "resultative",
	    		"dispmod", "iterativeness", "lex.rf"
	    };
		
		public final static String[] a_token_sax_features = 
	    {
	    		"form", "lemma", "tag", "afun", "ord" 	
	    };
		
		public static final int DOC_DEPTH_SENTENCES = 4; 
		public static final int DOC_DEPTH_TREES = 5; 
		public static final int DOC_DEPTH_TREE_ROOTS = 6; 
	}
	
	public SAXTMTParser (String language) throws ParserConfigurationException, SAXException
	{
		this.language = language;
		
		SAXParserFactory spf = SAXParserFactory.newInstance();
	    spf.setValidating(false); // No validation required
	    sax_parser = spf.newSAXParser();

	}
	
	public List<Sentence> parse(String tmTFilename) throws SAXException, IOException
	{
		init();
		
		InputSource input = new InputSource(new FileInputStream(tmTFilename));
	    id_valid_stack.push("TToPP");
	    sax_parser.parse(input, this);

		
		return sentences;		
	}
	
	protected void init()
	{
		id_all_stack.clear();
		id_valid_stack.clear();
		qname_stack.clear();
		sentences.clear();
		setDummy();		
	}
	
	
	private void setDummy()
	{
		actual_fetures = Constants.dummy_feat;		
		actual_tokens = Constants.dummy_toc;
		Constants.dummy_toc.clear();
		actual_dependencies = dummy_dep;
		dummy_dep.clear();
	}
	
	private void setTecto()
	{
		actual_fetures = Constants.t_token_sax_features;		
		actual_tokens = actual_sentence.t_tokens;		
		actual_dependencies = actual_sentence.tDependencies;
	}

	private void setAnalytic()
	{
		actual_fetures = Constants.a_token_sax_features;		
		actual_tokens = actual_sentence.a_tokens;
		actual_dependencies = actual_sentence.aDependencies;
	}
	
	private void newSentence()
	{
		Sentence sent = new Sentence();
		sentences.add(sent);
		actual_sentence = sent;
		
	}
	
	private void newToken(String parent_id, String child_id)
	{
		Token toc = new Token(actual_fetures.length, child_id);
		actual_tokens.put(child_id, toc);
		actual_token = toc;
		
		if (qname_stack.size() > Constants.DOC_DEPTH_TREE_ROOTS+1)
		{
			Dependency dep = new Dependency(parent_id, child_id);
			actual_dependencies.add(dep);
		}
	}
	
	@Override
	public void endElement(String uri, String localName, String qName) throws SAXException
	{
		String current_qname = qname_stack.pop();
		assert current_qname.equals(qName);
		String prewious_qname = qname_stack.empty() ? null : qname_stack.peek();
		
		String id = id_all_stack.pop();
		if (id != null) id_valid_stack.pop();

		if (current_qname.equalsIgnoreCase(language+"_source_sentence"))
		{
			actual_sentence.sentence_string = stringFromLastCahrs();
		}		
		if (current_qname.equals("LM") && prewious_qname.equals("aux.rf"))
		{
			Dependency aux_rf = new Dependency(id_valid_stack.peek(), stringFromLastCahrs());
			actual_sentence.auxRfDependencies.add(aux_rf);
		}
		if (qname_stack.size() > Constants.DOC_DEPTH_TREE_ROOTS)
		{
			updateFeatures(current_qname, actual_fetures);
		}
	}
	
	private void updateFeatures(String qName, String [] feature_list)
	{
		int tf = testFeatures(qName, feature_list);
		if (tf != -1) actual_token.features[tf] = stringFromLastCahrs();		
	}



	
	@Override
	public void startElement(String uri, String localName, String qName, Attributes attributes) throws SAXException
	{
		String new_id = attributes.getValue("id");
		String prew_id = id_valid_stack.peek(); 
		
		if (new_id != null) id_valid_stack.push(new_id);
		id_all_stack.push(new_id);
		qname_stack.push(qName);
		
		//System.err.printf("%3d %s\n", qname_stack.size(), qName);
						
		switch (qname_stack.size())
		{		
			case Constants.DOC_DEPTH_SENTENCES:
				if (qName.equalsIgnoreCase(language+"_source_sentence"))
				{
					newSentence();
					break;
				}
				
			case Constants.DOC_DEPTH_TREES:
				if (qName.equalsIgnoreCase('S'+language+'T'))
				{
					setTecto();
					return;
				}
				if (qName.equalsIgnoreCase('S'+language+'A'))
				{
					setAnalytic();
					return;
				}
//				if (qName.equalsIgnoreCase('S'+language+'M'))
//				System.err.println(qName);
				setDummy();
				return;

			default:
				break;
		}
		
		if ((qName.equals("LM") || qName.equals("children")) && (new_id != null))
		{			
			newToken(prew_id, new_id);
		}		

		if (shouldReadContentOfCurrentElement()) last_characters = new StringBuilder();
	}
	
	
	@Override
	public void characters(char[] ch, int start, int length) throws SAXException
	{
		if (shouldReadContentOfCurrentElement())
		{
			last_characters.append(ch, start, length);		
		}
	}

	
	private boolean shouldReadContentOfCurrentElement()
	{
		String current_qname = qname_stack.peek();
		
		return
			current_qname.equalsIgnoreCase(language+"_source_sentence") ||
			(current_qname.equals("LM") && prewious_qname().equals("aux.rf")) || //aux.rf
			(testFeatures(current_qname, actual_fetures) != -1);
		
	}

	private String prewious_qname()
	{
		String current_qname = qname_stack.pop();
		String prewious_qname = qname_stack.peek();
		qname_stack.push(current_qname);
		return prewious_qname;
	}

	private int testFeatures(String qName, String [] feature_list)
	{
		for (int i = 0; i < feature_list.length; i++) {
			if (feature_list[i].equals(qName))
			{
				return i;
			}
		}
		return -1;
	}
	
	private String stringFromLastCahrs()
	{
		String ret = last_characters.toString();
		return  ret;
	}


	



}
