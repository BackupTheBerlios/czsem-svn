package czsem.gate;

import gate.Annotation;
import gate.AnnotationSet;
import gate.Document;
import gate.Factory;
import gate.FeatureMap;
import gate.util.InvalidOffsetException;

import java.io.PrintStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.xml.parsers.ParserConfigurationException;

import org.xml.sax.SAXException;

public class TMTAnnotator 
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
				if (features[i] == null) out.println("null");
				else out.println(features[i]);				
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
	
	
	

//	private String tmTFilename;

	private List<Sentence> sentences;





	
	public TMTAnnotator(List<Sentence> sentences) throws ParserConfigurationException, SAXException
	{
		this.sentences = sentences;		
	}

	
	private SequenceAnnotator seq_anot;
	private AnnotationSet as;

	private void annotateSentence(Sentence sentence) throws InvalidOffsetException
	{
		if (sentence.sentence_string == null)
		{
			System.err.println("Warninig: EMPTY sentece!");
			return;
		}
		
		System.out.flush();
		System.err.println(sentence.sentence_string);
		System.err.flush();
		
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
    	annotateDenedecies(sentence.aDependencies, sentence.a_tokens, "aDependency");
    	annotateTTokens(sentence);
    	annotateDenedecies(sentence.tDependencies, sentence.t_tokens, "tDependency");
    	annotateAuxRfDenedecies(sentence);
    	
    	
	}


	private Token[] sortATokens(Map<String, Token> aTokens)
	{
		
		Token[] ret = aTokens.values().toArray(new Token[0]);
		
		Arrays.sort(ret, new Comparator<Token>() {
			@Override
			public int compare(Token o1, Token o2) {
				return ((Integer)o1.getAOrd()).compareTo(o2.getAOrd());
			}
		});
				
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
			
			FeatureMap fm = loadFeatures(t_token, SAXTMTParser.Constants.t_token_sax_features);

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
//		sentence.printTokens(sentence.a_tokens, System.out);
//		System.out.println(sentence.a_tokens.size());
		Token[] tokens = sortATokens(sentence.a_tokens);
		
		for (int i = 0; i < tokens.length; i++)
		{
			System.out.print(tokens[i].getAForm());
			System.out.print(' ');
			
//			try {
				seq_anot.nextToken(tokens[i].getAForm());
				annotateTokenSeq(tokens[i], SAXTMTParser.Constants.a_token_sax_features, "Token");
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

		as.add(ix1, ix2, dependecy_type, GateUtils.createDependencyArgsFeatureMap(id1, id2));
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

	public void annotate(Document doc, String outputASName) throws InvalidOffsetException
	{
		seq_anot = new SequenceAnnotator(doc);
		as = doc.getAnnotations(outputASName);
//		as.clear();
		
		for (Sentence sentence : sentences)
		{
			annotateSentence(sentence);			
		}
	}

	public void debug_print(PrintStream out)
	{
	    out.println("------------------------------------------------------------");
//	    out.println(tmTFilename);	    
	    out.println("Sentences: " + sentences.size());
	    if (sentences.size() <= 0) return;
	    out.println("First Sentence string: " + sentences.get(0).sentence_string);
	    out.println("First Sentence aTokens: " + sentences.get(0).a_tokens.size());
	    out.println("First Sentence num tTokens: " + sentences.get(0).t_tokens.size());
	    int last_s = sentences.size()-1;
	    Sentence last_sentence = sentences.get(last_s);
	    out.println("Last Sentence string: " + last_sentence.sentence_string);
	    out.println("Last Sentence aTokens forms: ");
		Token[] tokens = sortATokens(last_sentence.a_tokens);
		for (int i = 0; i < tokens.length; i++) {
			out.print(tokens[i].getAForm());
			out.print(' ');
		}
		out.println();
/**/
	    out.println("Last Sentence aTokens: " + last_sentence.a_tokens.size());
	    out.println("Last Sentence num tTokens: " + last_sentence.t_tokens.size());
	    out.println("Last Sentence tTokens: ");
	    last_sentence.printTokens(last_sentence.t_tokens, out); 
	    out.println("-- tDependencies --");
	    last_sentence.printDependecies(last_sentence.tDependencies, out); 
	    out.println("-- aux.rf --");
	    last_sentence.printDependecies(last_sentence.auxRfDependencies, out);
/**/	     		
	}

	
}
