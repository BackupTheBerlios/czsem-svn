package czsem.gate.tectomt;

import gate.Document;
import gate.creole.AbstractResource;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.net.URISyntaxException;
import java.net.URL;

import com.generationjava.io.xml.SimpleXmlWriter;
import com.generationjava.io.xml.XmlWriter;

import czsem.gate.GateUtils;

public class TMTDocumentHelper
{
	private Document gate_doc;
	private String tmt_filepath;
	
	public TMTDocumentHelper(Document doc, String language, URL serilizationDirectory) throws IOException, URISyntaxException
	{
		this.gate_doc = doc;
		
		createTMTFile(serilizationDirectory, language);
	}
	
	protected String findTMTFileName(URL outputDirectory) throws IOException, URISyntaxException
	{
		StringBuilder sb = new StringBuilder();
		sb.append(GateUtils.URLToFilePath(outputDirectory));
		sb.append('/');
		sb.append(((AbstractResource) gate_doc).getName());
		sb.append(".tmt");
		
		String dest_filename = GateUtils.findAvailableFileName(sb.toString());
		
		return dest_filename;	
	}

	public String createTMTFile(URL outputDirectory, String language) throws IOException, URISyntaxException 
	{
		tmt_filepath = findTMTFileName(outputDirectory);

		Writer fwr = new OutputStreamWriter(new FileOutputStream(tmt_filepath), "utf-8");
		XmlWriter xmlwriter = new SimpleXmlWriter(fwr);
		xmlwriter.writeXmlVersion("1.0", "utf-8");
		xmlwriter.writeEntity("tmt_document");
		xmlwriter.writeAttribute("xmlns", "http://ufal.mff.cuni.cz/pdt/pml/");
		xmlwriter.writeEntity("head");
		xmlwriter.writeEntity("schema");
		xmlwriter.writeAttribute("href", "tmt_schema.xml");
		xmlwriter.endEntity();//schema
		xmlwriter.endEntity();//head
		xmlwriter.writeEntity("meta");
		xmlwriter.writeEntityWithText(language+"_source_text", gate_doc.getContent().toString());
		xmlwriter.endEntity();//meta
		xmlwriter.endEntity();//tmt_document
		xmlwriter.close();
		fwr.close();
		
		return tmt_filepath;
	}

	public String getTMTFilePath() {
		return tmt_filepath;
	}

	public Document getDocument() {
		return gate_doc;
	}

}
