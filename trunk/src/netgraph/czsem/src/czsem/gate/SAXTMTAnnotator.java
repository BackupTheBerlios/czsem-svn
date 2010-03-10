package czsem.gate;

import gate.Annotation;
import gate.AnnotationSet;
import gate.Document;
import gate.Factory;
import gate.FeatureMap;
import gate.util.InvalidOffsetException;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Stack;

import javax.xml.parsers.ParserConfigurationException;
import javax.xml.parsers.SAXParserFactory;

import org.xml.sax.Attributes;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;

public class SAXTMTAnnotator extends DefaultHandler
{
	public static class Dependency
	{
		String [] ids;
		public Dependency(String parent_id, String child_id)
		{
			ids = new String[2];
			ids[0] = parent_id; //parent
			ids[1] = child_id; //child
		}
		public void print(PrintStream out)
		{
			out.print("Depends: ");
			out.print(ids[1]);
			out.print(" on ");
			out.println(ids[0]);
		}
	}

	public static class Token
	{
		Integer gate_annotation_id;
		String [] features;
		String id;
		
		public Token(int fetures_num, String id)
		{
			this(fetures_num);
			this.id = id;
		}

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

		public String getTLexRf()
		{
			return features[17]; 
		}

		public int getAOrd()
		{
			return Integer.parseInt(features[4]); 
		}

		public String getAForm()
		{
			return features[0]; 
		}

	}
	
	public static class Sentence
	{
		Integer gate_annotation_id;
		String sentence_string;
		
		Map<String, Token> a_tokens;
		Map<String, Token> t_tokens;
		List<Dependency> aDependencies;
		List<Dependency> tDependencies;
		List<Dependency> auxRfDependencies;
		
		public Sentence()
		{
			a_tokens = new HashMap<String, Token>(30);
			t_tokens = new HashMap<String, Token>(30);
			
			aDependencies = new ArrayList<Dependency>(30); 
			tDependencies = new ArrayList<Dependency>(30); 
			auxRfDependencies = new ArrayList<Dependency>(30); 
		}
		
		public void printDependecies(List<Dependency> dep, PrintStream out)
		{
			for (Dependency dependency : dep) {
				dependency.print(out);
			}			
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
	private String[] actual_fetures = dummy_feat;
	private Map<String, Token> actual_tokens;
	private Sentence actual_sentence;
	private Token actual_token;
	private List<Dependency> actual_dependencies;
	
	private StringBuilder last_characters = null; 
	private Stack<String> last_element_qname = new Stack<String>();
	
	private final int setence_stack_level = 2;

	
	private List<Sentence> sentences = new ArrayList<Sentence>();
	
	private javax.xml.parsers.SAXParser sax_parser;
	
	private void setTecto()
	{
		actual_fetures = TMTTreeAnnotator.t_token_sax_features;		
		actual_tokens = actual_sentence.t_tokens;		
		actual_dependencies = actual_sentence.tDependencies;
	}

	private void setAnalytic()
	{
		actual_fetures = TMTTreeAnnotator.a_token_sax_features;		
		actual_tokens = actual_sentence.a_tokens;
		actual_dependencies = actual_sentence.aDependencies;
	}

	private static String [] dummy_feat = new String[0]; 
	private static Map<String, Token> dummy_toc = new HashMap<String, Token>();
	private List<Dependency> dummy_dep = new ArrayList<Dependency>(50);
	private String tmTFilename;


	private void setDummy()
	{
		actual_fetures = dummy_feat;		
		actual_tokens = dummy_toc;
		dummy_toc.clear();
		actual_dependencies = dummy_dep;
		dummy_dep.clear();
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
		
		if (parent_ids.size() > setence_stack_level+1)
		{
			Dependency dep = new Dependency(parent_id, child_id);
			actual_dependencies.add(dep);
		}
	}

	@Override
	public void startElement(String uri, String localName, String qName, Attributes attributes) throws SAXException
	{
		last_element_qname.push(qName);

		if (qName.equals("SCzechT"))
		{
			setTecto();
			return;
		}
		if (qName.equals("SCzechA"))
		{
			setAnalytic();
			return;
		}
		if (qName.equals("SCzechM"))
		{
			setDummy();
			return;
		}
		
		if (qName.equals("LM"))
		{
			String prew_id = parent_ids.peek(); 
			String new_id = attributes.getValue(0);
			parent_ids.push(new_id);

			if (parent_ids.size() <= setence_stack_level)
			{
				newSentence();
				return;
			}
			
			if (new_id != null)
			{
				newToken(prew_id, new_id);
			}
		}		

		if (elementoToRead(qName)) last_characters = new StringBuilder();
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

	private void updateFeatures(String qName, String [] feature_list)
	{
		int tf = testFeatures(qName, feature_list);
		if (tf != -1) actual_token.features[tf] = stringFromLastCahrs();		
	}
	
	private String stringFromLastCahrs()
	{
		String ret = last_characters.toString();
		return  ret;
	}

	private void updateFeatures(String qName)
	{
		updateFeatures(qName, actual_fetures);		
	}

	@Override
	public void endElement(String uri, String localName, String qName) throws SAXException
	{
		String last_qn = last_element_qname.pop();
		assert last_qn.equals(qName);
		
		if (qName.equals("LM"))
		{
			parent_ids.pop();
			if (last_element_qname.peek().equals("aux.rf")) //aux.rf
			{
				Dependency aux_rf = new Dependency(parent_ids.peek(), stringFromLastCahrs());
				actual_sentence.auxRfDependencies.add(aux_rf);
			}
		}
		if (qName.equals("czech_source_sentence"))
		{
			actual_sentence.sentence_string = stringFromLastCahrs();
		}
		if (parent_ids.size() > setence_stack_level)
		{
			updateFeatures(qName);
		}
	}
	
	private boolean elementoToRead(String element_qname)
	{
		String peek = last_element_qname.pop();
		
		boolean ret = 
			element_qname.equals("czech_source_sentence") ||
			(element_qname.equals("LM") && last_element_qname.peek().equals("aux.rf")) || //aux.rf
			(testFeatures(element_qname, actual_fetures) != -1);
		
		last_element_qname.push(peek);
		return ret;
	}
	
	@Override
	public void characters(char[] ch, int start, int length) throws SAXException
	{
		if (elementoToRead(last_element_qname.peek()))
		{
			last_characters.append(ch, start, length);		
		}
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

	public void parseAndInit(String tmTFilename) throws SAXException, IOException
	{	
	    this.tmTFilename = tmTFilename;
		org.xml.sax.InputSource input = new InputSource(new FileInputStream(tmTFilename));

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
	    
	}
	
	private SequenceAnnotator seq_anot;
	private AnnotationSet as;

	private void annotateSentence(Sentence sentence) throws InvalidOffsetException
	{
		System.err.println(sentence.sentence_string);
		
    	seq_anot.backup();
    	try {
	    	seq_anot.nextToken(sentence.sentence_string);
	    	//"Sentence" annotation
	    	Integer gid = as.add(seq_anot.lastStart(), seq_anot.lastEnd(), "Sentence", Factory.newFeatureMap());
	    	sentence.gate_annotation_id = gid;
    	} catch (IndexOutOfBoundsException e) {
    		e.printStackTrace();
		}
    	
    	if (sentence.a_tokens.size() <= 0) return;
    	
    	seq_anot.restore();
    	
    	annotateATokens(sentence);
    	annotateDenedecies(sentence.aDependencies, sentence.a_tokens, "aDependecy");
    	annotateTTokens(sentence);
    	annotateDenedecies(sentence.tDependencies, sentence.t_tokens, "tDependecy");
    	annotateAuxRfDenedecies(sentence);
    	
    	
	}


	private Token[] sortATokens(Map<String, Token> aTokens)
	{
		Token[] ret = new Token[aTokens.values().size()];
		
		for (Token token : aTokens.values()) {
			ret[token.getAOrd()-1] = token;
		}
		
		return ret;
	}


	public static FeatureMap loadFeatures(Token token, String [] feature_names)
	{
    	FeatureMap fm = Factory.newFeatureMap();
    	for (int a=0; a<feature_names.length; a++)
    	{
        	String value = token.features[a];
        	
    		if (value != null)	fm.put(feature_names[a], value);            		
    	}
    	return fm;
	}

	private void annotateTokenSeq(Token token, String [] features, String label) throws InvalidOffsetException
	{
		annotateToken(seq_anot.lastStart(), seq_anot.lastEnd(), token, features, label);
	}

	private void annotateToken(long start_off, long end_off, Token token, String label, FeatureMap fm) throws InvalidOffsetException
	{
    	Integer gate_id = 
    		as.add(	start_off, 
    				end_off, 
    				label, 
    				fm);
		
    	token.gate_annotation_id = gate_id;				
	}

	private void annotateToken(long start_off, long end_off, Token token, String [] features, String label) throws InvalidOffsetException
	{
		annotateToken(start_off, end_off, token, label, 
				loadFeatures(token, features));
	}
	
	private void annotateTTokens(Sentence sentence) throws InvalidOffsetException
	{
		for (Token t_token : sentence.t_tokens.values())
		{
			Token a_toknen = sentence.a_tokens.get(t_token.getTLexRf());			 
			
			FeatureMap fm = loadFeatures(t_token, TMTTreeAnnotator.t_token_sax_features);

			Annotation a;
			if (a_toknen == null)
					a = as.get(sentence.gate_annotation_id);
			else
			{
					a = as.get(a_toknen.gate_annotation_id);
					
					String old_id = (String) fm.put("lex.rf", a_toknen.gate_annotation_id);
					assert old_id.equals(t_token.getTLexRf());
			}

			
			if (a == null)
			{
				a = as.get(sentence.a_tokens.values().iterator().next().gate_annotation_id);
			}
			
			Long start_off = a.getStartNode().getOffset();
			Long end_off = a.getEndNode().getOffset();								
					
			

			
			annotateToken(
					start_off, end_off, 
					t_token, 					
					"tToken",
					fm);						
		}		
	}
	
	private void annotateATokens(Sentence sentence) throws InvalidOffsetException
	{
		Token[] tokens = sortATokens(sentence.a_tokens);
		
		for (int i = 0; i < tokens.length; i++)
		{
			System.out.print(tokens[i].getAForm());
			System.out.print(' ');
			
//			try {
				seq_anot.nextToken(tokens[i].getAForm());
				annotateTokenSeq(tokens[i], TMTTreeAnnotator.a_token_sax_features, "Token");
//			} catch (IndexOutOfBoundsException e) {
//				e.printStackTrace();
//			}
			
		}
		System.out.println();		
	}
	
	public void addDependencyAnnotation(Integer id1, Integer id2, String dependecy_type) throws InvalidOffsetException
	{
		Annotation a1 = as.get(id1);
		Annotation a2 = as.get(id2);
		
		Long ix1 = Math.min(a1.getStartNode().getOffset(), a2.getStartNode().getOffset());
		Long ix2 = Math.max(a1.getEndNode().getOffset(), a2.getEndNode().getOffset());

		FeatureMap fm = Factory.newFeatureMap();
		ArrayList<Integer> args = new ArrayList<Integer>(2);

		args.add(id1);
		args.add(id2);
		fm.put("args", args);			

		as.add(ix1, ix2, dependecy_type, fm);
	}

	private void annotateAuxRfDenedecies(Sentence sentence) throws InvalidOffsetException
	{
		for (Dependency dependency : sentence.auxRfDependencies) {
			addDependencyAnnotation(
					sentence.t_tokens.get(dependency.ids[0]).gate_annotation_id,
					sentence.a_tokens.get(dependency.ids[1]).gate_annotation_id,
					"auxRfDependency");
		}
		
	}
	
	private void annotateDenedecies(List<Dependency> depencies, Map<String, Token> tokens, String dependecy_type) throws InvalidOffsetException
	{
		for (Dependency dependency : depencies) {
			addDependencyAnnotation(
					tokens.get(dependency.ids[0]).gate_annotation_id,
					tokens.get(dependency.ids[1]).gate_annotation_id,
					dependecy_type);
		}
		
	}

	public void annotate(Document doc) throws InvalidOffsetException
	{
		seq_anot = new SequenceAnnotator(doc);
		as = doc.getAnnotations();
		
		for (Sentence sentence : sentences)
		{
			annotateSentence(sentence);			
		}
	}

	public void debug_print(PrintStream out)
	{
	    out.println("------------------------------------------------------------");
	    out.println(tmTFilename);	    
	    out.println("Sentences: " + sentences.size());
	    if (sentences.size() <= 0) return;
	    out.println("Last Sentence string: " + actual_sentence.sentence_string);
	    out.println("Last Sentence aTokens: " + actual_sentence.a_tokens.size());
	    out.println("Last Sentence num tTokens: " + actual_sentence.t_tokens.size());
	    out.println("Last Sentence tTokens: ");
	    actual_sentence.printTokens(actual_sentence.t_tokens, out); 
	    out.println("-- tDependencies --");
	    actual_sentence.printDependecies(actual_sentence.tDependencies, out); 
	    out.println("-- aux.rf --");
	    actual_sentence.printDependecies(actual_sentence.auxRfDependencies, out); 		
	}

	
}
