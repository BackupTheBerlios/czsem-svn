package czsem.online.helpers;

import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.xml.stream.XMLStreamException;

import gate.Annotation;
import gate.Document;
import gate.Factory;
import gate.creole.ResourceInstantiationException;
import gate.persist.PersistenceException;
import gate.util.InvalidOffsetException;


public class PageCreator {
		
	private Document doc;
	private Map<Object, Object> params;
	
	public String extractTitle() throws InvalidOffsetException
	{
		Iterator<Annotation> i = doc.getAnnotations("Original markups").get("title").iterator();
		if (! i.hasNext()) return "";
		Annotation a = i.next();
			
		return doc.getContent().getContent(
				a.getStartNode().getOffset(), 
				a.getEndNode().getOffset()).toString();		
	}
	
	public PageCreator(String url) throws ResourceInstantiationException, InvalidOffsetException, IOException
	{
		doc = DocumentHandler.documentFromUrl(url);
		
		params = new HashMap<Object, Object>();
		
		params.put("url", url);
		params.put("date", new Date());
		params.put("title", extractTitle());
	}

	public Document getDoc() {
		return doc;
	}
	
	public byte[] getDocBytes() throws PersistenceException, IOException, XMLStreamException {
		return DocumentHandler.serializeDocToArray(doc);
	}

	public String getDocXmlString() throws XMLStreamException {
		return DocumentHandler.serializeDocToString(doc);
	}


	public Map<Object, Object> getParams() {
		return params;
	}

	@Override
	protected void finalize() throws Throwable {
		Factory.deleteResource(doc);
	}

	public String getDocContentString() {
		return doc.getContent().toString();
	}


}
