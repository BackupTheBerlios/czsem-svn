package czsem.khresmoi;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.Stack;

import javax.xml.parsers.ParserConfigurationException;
import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;

import org.xml.sax.Attributes;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;

import com.generationjava.io.xml.SimpleXmlWriter;
import com.generationjava.io.xml.XmlWriter;

import czsem.utils.MultiSet;

public class SaxMesh extends DefaultHandler
{
	public static void main(String[] args) throws ParserConfigurationException, SAXException, IOException
	{
		System.err.println("start");
		
		SAXParserFactory spf = SAXParserFactory.newInstance();
	    spf.setValidating(false); // No validation required
	    spf.setFeature("http://apache.org/xml/features/nonvalidating/load-external-dtd", false);
	    SAXParser sax_parser = spf.newSAXParser();
	    
//		InputSource input = new InputSource(new FileInputStream("c:/data/Khresmoi/czmesh/mesh2011.xml"));
		InputSource input = new InputSource(new FileInputStream("c:/data/Khresmoi/mesh/desc2011.xml"));
	    
	    sax_parser.parse(input, new SaxMesh());
		System.err.println("end");

	}

	StringBuilder sb = null;
	MultiSet<String> treenumbers = new MultiSet<String>();
	private Stack<String> qNameStack = new Stack<String>();
	int titles = 0;
	
	public static class MeshRecord
	{		
		String descriptorName;

		//TODO: A record can have more than one tree number
		String TreeNumber;
	}
	
	List<MeshRecord> records = new ArrayList<MeshRecord>(10000);

	
	@Override
	public void startElement(String uri, String localName, String qName, Attributes attributes) throws SAXException
	{
		if (qName.equals("DescriptorRecord")) records.add(new MeshRecord());
		
		if (elemTest(qName))
		{
			sb = new StringBuilder();			
		}

		qNameStack.push(qName);		
	}
	
	protected boolean elemTest(String qName)
	{
		if (qName.equals("TreeNumber")) return true;
		
		if (qName.equals("String") && qNameStack.peek().equals("DescriptorName")) return true;
		
		return false;
	}

	@Override
	public void endElement(String uri, String localName, String qName) throws SAXException
	{
		qNameStack.pop();		
		if (elemTest(qName))
		{
			String str = sb.toString();
			
			if (qName.equals("TreeNumber"))
			{
				records.get(records.size()-1).TreeNumber = str;
				treenumbers.add(str);
			}
			
			if (qNameStack.peek().equals("DescriptorName"))
			{
				if (qNameStack.get(qNameStack.size()-2).equals("DescriptorRecord"))
				{
					records.get(records.size()-1).descriptorName = str;
	//				System.err.println(str);
					titles++;
				}
			}

/**
			String[] ids = str.split("\\.");
			
			if (ids.length == 1 && ids[0].startsWith("A"))
			{
				System.err.println(str);
			}
/**/
		}
		
		sb = null;
	}

	@Override
	public void characters(char[] ch, int start, int length) throws SAXException
	{
		if (sb != null)
		{
			sb.append(ch, start, length);
		}
	}

	@Override
	public void ignorableWhitespace(char[] ch, int start, int length)
			throws SAXException {
	}

	@Override
	public void endDocument() throws SAXException
	{
		System.err.println("unique TreeNumbers: " + treenumbers.size());
		System.err.println("DescriptorName-s: " + titles);
		System.err.println("DescriptorRecords: " + records.size());
		
		try {
			writeSimpleXMLTree(records);
		} catch (IOException e) {
			throw new SAXException(e);
		}
	}
	
	public static void writeSimpleXMLTree(List<MeshRecord> records) throws IOException
	{
		@SuppressWarnings("unchecked")
		List<MeshRecord> [] levels = new List[2];
		for (int i = 0; i < levels.length; i++) {
			levels[i] = new ArrayList<MeshRecord>(); 
		}
		
		Set<Character> first_ch = new HashSet<Character>(); 
		
		for (MeshRecord record : records)
		{
			if (record.TreeNumber == null) continue;
			first_ch.add(record.TreeNumber.charAt(0));
			String[] ids = record.TreeNumber.split("\\.");
			if (ids.length == 1) levels[0].add(record);
			if (ids.length == 2) levels[1].add(record);
		}
		
		Writer fwr = new OutputStreamWriter(new FileOutputStream("c:/data/Khresmoi/enmeshdump.xml"), "utf-8");
		XmlWriter xmlwriter = new SimpleXmlWriter(fwr);
		xmlwriter.writeXmlVersion("1.0", "utf-8");
		xmlwriter.writeEntity("mesh");
		
		for (Character character : first_ch)
		{
			xmlwriter.writeEntity("node");
			xmlwriter.writeAttribute("title", character);
			
			for (MeshRecord r : levels[0])
			{
				if (r.TreeNumber.charAt(0) == character)
				{
					xmlwriter.writeEntity("node");
					xmlwriter.writeAttribute("num", r.TreeNumber);
					xmlwriter.writeAttribute("title", r.descriptorName);
						for (MeshRecord r2 : levels[1])
						{
							if (r2.TreeNumber.split("\\.")[0].equals(r.TreeNumber))
							{
								xmlwriter.writeEntity("node");
								xmlwriter.writeAttribute("num", r2.TreeNumber);
								xmlwriter.writeAttribute("title", r2.descriptorName);
								xmlwriter.endEntity();//node
								
							}
						}
					xmlwriter.endEntity();//node
					
				}
			}

			xmlwriter.endEntity();//char
			
		}
		
		xmlwriter.endEntity();//mesh
		xmlwriter.close();
		fwr.close();
		
	}


}
