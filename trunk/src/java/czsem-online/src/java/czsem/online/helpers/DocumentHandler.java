package czsem.online.helpers;

import gate.Document;
import gate.Factory;
import gate.Gate;
import gate.Resource;
import gate.TextualDocument;
import gate.corpora.DocumentImpl;
import gate.corpora.DocumentStaxUtils;
import gate.creole.ResourceData;
import gate.creole.ResourceInstantiationException;
import gate.persist.PersistenceException;
import gate.util.GateException;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.OutputStream;
import java.io.Reader;
import java.io.StringReader;
import java.io.StringWriter;
import java.net.MalformedURLException;
import java.net.URL;

import javax.xml.stream.XMLInputFactory;
import javax.xml.stream.XMLOutputFactory;
import javax.xml.stream.XMLStreamException;
import javax.xml.stream.XMLStreamReader;
import javax.xml.stream.XMLStreamWriter;

public class DocumentHandler {

	private static XMLOutputFactory outputFactory = XMLOutputFactory
			.newInstance();
	private static XMLInputFactory inputFactory = XMLInputFactory.newInstance();

	public static void writeGateDocXml(Document doc, XMLStreamWriter xsw)
			throws XMLStreamException {
		((DocumentImpl) doc).setEncoding("utf8");

		xsw.writeStartDocument("utf8", "1.0");
		xsw.writeCharacters("\n");

		DocumentStaxUtils.writeDocument(doc, xsw, "");
		xsw.close();
	}

	public static void writeGateDocXml(Document doc, OutputStream outputStream)
			throws XMLStreamException {
		XMLStreamWriter xsw = outputFactory.createXMLStreamWriter(outputStream,
				"utf8");
		writeGateDocXml(doc, xsw);
	}

	public static String serializeDocToString(Document doc)
			throws XMLStreamException {
		StringWriter writer = new StringWriter();
		XMLStreamWriter xsw = outputFactory.createXMLStreamWriter(writer);
		writeGateDocXml(doc, xsw);

		return writer.toString();
	}

	public static Document deserializeDocFromString(String data)
			throws XMLStreamException, ResourceInstantiationException {
		Reader reader = new StringReader(data);
		XMLStreamReader sxr = inputFactory.createXMLStreamReader(reader);

		return deserializeDocFromXMLStream(sxr);
	}

	public static byte[] serializeDocToArray(Document doc)
			throws PersistenceException, IOException, XMLStreamException {
		ByteArrayOutputStream data = new ByteArrayOutputStream();
		writeGateDocXml(doc, data);
		return data.toByteArray();
	}

	public static Document deserializeDocFromStream(InputStream stream) throws XMLStreamException, ResourceInstantiationException	
	{
		XMLStreamReader sxr = inputFactory.createXMLStreamReader(stream, "utf8");
		return deserializeDocFromXMLStream(sxr);		
	}

	public static Document deserializeDocFromXMLStream(XMLStreamReader sxr)
			throws ResourceInstantiationException, XMLStreamException {
		Document doc = Factory.newDocument("");
		((DocumentImpl) doc).setEncoding("utf8");

		sxr.next();
		DocumentStaxUtils.readGateXmlDocument(sxr, doc);
		return doc;
	}
	
	
	public static void writeDocumentToOutputStream(Document doc, OutputStream stream) throws IOException
	{
		new ObjectOutputStream(stream).writeObject(doc);		
	}
	
	public static Object readDocumentFromInputStream(InputStream stream) throws IOException, ClassNotFoundException, ResourceInstantiationException
	{
        Object doc = new ObjectInputStream(stream).readObject();
        
        ResourceData rd = Gate.getCreoleRegister().get(doc.getClass().getName());
        if(rd != null) {
          rd.addInstantiation((Resource) doc);
        }
        else {
          throw new ResourceInstantiationException("Could not find resource data for class "+doc.getClass().getName());
        }
        
        return doc;


		/*
		System.out.println("start processing");
		for (;;)
		{
			int r = stream.read();
			if (r == -1) break;
			System.out.write(r);
		}
		System.out.println("end processing");
		*/		
	}


	
	
	public static Document deserializeDocFromArray(byte[] data)
			throws IOException, ClassNotFoundException,
			ResourceInstantiationException, XMLStreamException {

		InputStream stream = new ByteArrayInputStream(data);
		return deserializeDocFromStream(stream);
	}

	public static void main(String[] args) throws GateException,
			ClassNotFoundException, IOException, XMLStreamException {
		CzsemBootStrap.bootStrap();

		// Document doc = Factory.newDocument("Hallo world!");
		Document doc = Factory.newDocument(new URL("http://lezec.cz"));
		// Document doc = Factory.newDocument(new
		// URL("https://dedekj.appspot.com/"));

		Document doc2 = deserializeDocFromArray(serializeDocToArray(doc));

		System.err.println(((TextualDocument) doc).getEncoding());
		System.err.println(((TextualDocument) doc2).getEncoding());
		System.err.println(doc2.getFeatures());
		System.err.println(doc2.getContent().toString());

	}

	public static Document documentFromUrl(String url_str) throws MalformedURLException, ResourceInstantiationException {
		URL url = new URL(url_str);
/*
		CharsetDetector detector = new CharsetDetector();
		detector.setText(new BufferedInputStream(url.openStream()));
		CharsetMatch match = detector.detect();
		String encoding = match.getName();
		
		System.err.println(encoding);
		
		return Factory.newDocument(url, encoding);
*/		
		return Factory.newDocument(url);
	}

}
