package czsem.khresmoi.mesh;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.util.ArrayList;
import java.util.List;

import javax.xml.parsers.ParserConfigurationException;

import org.xml.sax.SAXException;

import czsem.utils.MultiSet;

public class MeshStatistics
{
	static abstract class MeshStatisticsMeshParser extends MeshSaxParser
	{
		public List<String> terms = new ArrayList<String>();
		@Override
		public void newRecord() {}
		@Override
		public void putMeshID(String meshID) {}
		@Override
		public void putTreeNumber(String treeNumber) {}		
		@Override
		public void putCzTerm(String czTerm) {}
		@Override
		public void putEnTerm(String enTerm) {}
	}
	
	public MeshStatistics(boolean parese_english) {	
		if (parese_english) mp = new MeshStatisticsMeshParser() {
			@Override
			public void putEnTerm(String enTerm) {
				terms.add(enTerm);
			}
		};
		else mp = new MeshStatisticsMeshParser() {
			@Override
			public void putCzTerm(String czTerm) {
				terms.add(czTerm);
			}
		};
	}
	
	private MeshStatisticsMeshParser mp;

	public static void main(String [] args) throws ParserConfigurationException, SAXException, IOException, ClassNotFoundException
	{
		MeshStatistics ms = new MeshStatistics(true);
	    ms.parse("c:/data/Khresmoi/mesh/desc2011.xml");
//		ms.parse("c:/data/Khresmoi/czmesh/mesh2011.xml");
//		ms.serializeToFile("mesh_terms.ser");
//		ms.deserializeFromFile("mesh_terms.ser");
		ms.countCharStats();
		ms.countTokenStats();
	}
	
	public void load() throws FileNotFoundException, IOException, ClassNotFoundException
	{
		deserializeFromFile("mesh_terms.ser");		
	}
	
	public void parse(String filename) throws ParserConfigurationException, SAXException, IOException {
		mp.parse(filename);
	}

	public void countCharStats() {
		MultiSet<Character> ch_stats = new MultiSet<Character>();
		
		for (String term : mp.terms)
		{
			for (char ch : term.toCharArray())
			{
				if (Character.isLetter(ch)) ch_stats.add('A'); 
				else if (Character.isDigit(ch)) ch_stats.add('9');				
				else ch_stats.add(ch);				
			}
		}
		
		System.err.println(ch_stats.toFormatedString("\n"));
		
	}

	public void countTokenStats() {
		MultiSet<Integer> toc_num_stats = new MultiSet<Integer>();
		MultiSet<Integer> toc_len_stats = new MultiSet<Integer>();
		MultiSet<String> toc_stats = new MultiSet<String>();
				
		for (String term : mp.terms)
		{
			String[] split = splitTerm(term);
			toc_num_stats.add(split.length);
			for (String token: split)
			{
				toc_len_stats.add(token.length());
				toc_stats.add(token);
				
/*
				if (token.length() == 52)
				{
					System.out.println(term);
					System.out.println(Arrays.asList(split).toString());
				}
/**/				
			}
		}
		
		System.err.println(toc_num_stats.toFormatedString("\n"));
		System.err.println(toc_len_stats.toFormatedString("\n"));
		List<String> top = toc_stats.getTopKeys(100);
		for (String key : top)
		{
			System.err.format("%s : %3d\n", key, toc_stats.get(key));
		}
		
	}

	
	public static final String tokenSplitCharsRegexp = " (),\\-";
	public static final String seprators = "(),-";

	public static boolean isSeparator(String sep)
	{
		if (sep.length() > 1) return false;
		return tokenSplitCharsRegexp.contains(sep);		
	}
	
	public static String[] splitTerm(String term) {
		 return term.split("["+tokenSplitCharsRegexp+"]+");		 
	}

	@SuppressWarnings("unchecked")
	public void deserializeFromFile(String filename) throws FileNotFoundException, IOException, ClassNotFoundException {
		ObjectInputStream in = new ObjectInputStream(new BufferedInputStream(new FileInputStream(filename)));
		mp.terms = (List<String>) in.readObject();
		in.close();
	}

	public void serializeToFile(String filename) throws FileNotFoundException, IOException {
		ObjectOutputStream out = new ObjectOutputStream(new BufferedOutputStream(new FileOutputStream(filename)));
		out.writeObject(mp.terms);
		out.close();		
	}
}
