package czsem.khresmoi;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.Stack;

import javax.xml.parsers.ParserConfigurationException;
import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;

import org.xml.sax.Attributes;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;

public abstract class MeshSaxParser extends DefaultHandler
{
	private Stack<String> qNameStack = new Stack<String>();	
	StringBuilder sb = null;
	
	public abstract void newRecord();
	public abstract void putMeshID(String meshID);
	public abstract void putCzTerm(String czTerm);
	public abstract void putEnTerm(String enTerm);
	public abstract void putTreeNumber(String treeNumber);
	
	public void parse(String meshFileName) throws ParserConfigurationException, SAXException, IOException
	{
		SAXParserFactory spf = SAXParserFactory.newInstance();
	    spf.setValidating(false); // No validation required
	    spf.setFeature("http://apache.org/xml/features/nonvalidating/load-external-dtd", false);
	    SAXParser sax_parser = spf.newSAXParser();
	    
		InputSource input = new InputSource(new FileInputStream(meshFileName));
		
		sax_parser.parse(input, this);	
	}

	
	@Override
	public void startElement(String uri, String localName, String qName, Attributes attributes) throws SAXException
	{
		if (qName.equals("DescriptorRecord")) newRecord();
		
		if (elemTest(qName))
		{
			sb = new StringBuilder();			
		}

		qNameStack.push(qName);		
	}
	
	protected boolean elemTest(String qName)
	{
		if (qName.equals("DescriptorUI")) return true;

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
			
			if (qName.equals("DescriptorUI"))
			{
				if (qNameStack.get(qNameStack.size()-1).equals("DescriptorRecord"))
				{
					putMeshID(str);
				}
			}

			if (qName.equals("TreeNumber"))
			{
					putTreeNumber(str);
			}

			
			if (qNameStack.peek().equals("DescriptorName"))
			{
				if (qNameStack.get(qNameStack.size()-2).equals("DescriptorRecord"))
				{
					String[] names = str.split("[\\[\\]]");
					if (names.length > 1)
					{
						putCzTerm(names[0]);
						putEnTerm(names[1]);
					} 
					else 
					{
						putEnTerm(str);
					} 
				}
			}
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


}
