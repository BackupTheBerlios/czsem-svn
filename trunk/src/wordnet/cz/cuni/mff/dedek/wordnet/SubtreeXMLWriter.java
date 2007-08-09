/**
 * 
 */
package cz.cuni.mff.dedek.wordnet;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.w3c.dom.*;

import com.sun.org.apache.xml.internal.serialize.XMLSerializer;

/**
 * @author dedej1am
 *
 */
public class SubtreeXMLWriter
{
	private Document xml_doc;
	
	/**
	 * Initializes XML DOM 
	 * @throws ParserConfigurationException
	 */
	public SubtreeXMLWriter() throws ParserConfigurationException
	{
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		DocumentBuilder builder = factory.newDocumentBuilder();		
		
		xml_doc = builder.newDocument();
		
		Element root = (Element) xml_doc.createElement("WordNetSubtree");
		
	    xml_doc.appendChild(root);
	}
	
	/**
	 * Saves an internal XML DOM to a file 
	 * @param file_name
	 * @throws IOException
	 */
	public void seveToFile(String file_name) throws IOException
	{				
		XMLSerializer serializer = new XMLSerializer();
		OutputStreamWriter w = new OutputStreamWriter(new FileOutputStream(new File(file_name)), "UTF-8");
		serializer.setOutputCharStream(w);
		serializer.serialize(xml_doc);		
	}
	
	public Element appendNode(String value, String id, Element dest)
	{
		if (dest == null)
		{
			dest = xml_doc.getDocumentElement();
		}
		
		Element node = (Element) xml_doc.createElement("TreeNode");
		
		Attr val_attr = xml_doc.createAttribute("value");
		val_attr.setValue(value);
		node.setAttributeNode(val_attr);

		Attr id_attr = xml_doc.createAttribute("id");
		id_attr.setValue(id);
		node.setAttributeNode(id_attr);
		
		dest.appendChild(node);
		
		return node;	
	}
	

}
