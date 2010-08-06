package czsem.gate;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.net.URISyntaxException;
import java.net.URL;
import java.util.List;

import javax.xml.parsers.ParserConfigurationException;

import org.xml.sax.SAXException;

import com.generationjava.io.xml.SimpleXmlWriter;
import com.generationjava.io.xml.XmlWriter;

import czsem.gate.TMTAnnotator.Sentence;

import gate.Document;
import gate.creole.AbstractResource;
import gate.persist.PersistenceException;
import gate.security.SecurityException;
import gate.util.InvalidOffsetException;
import gate.util.Out;

public class TectoMTDocumentAnalyser
{
	private Document doc;
	private String dest_filename;
	private String language = "english";
	
	TectoMTDocumentAnalyser(Document doc, String language)
	{
		this(doc, language, null);
	}

	TectoMTDocumentAnalyser(Document doc, String language, String dest_filename)
	{
		this.language = language;
		this.doc = doc;
		this.dest_filename = dest_filename; 
	}
	
	protected String prepareTMTFileName(URL outputDirectory) throws IOException, URISyntaxException
	{
		StringBuilder sb = new StringBuilder();
		sb.append(new File(outputDirectory.toURI()).getCanonicalPath());
		sb.append('/');
		sb.append(((AbstractResource) doc).getName());
		sb.append(".tmt");
		
		String dest_filename = GateUtils.findAvailableFileName(sb.toString());
		
		return dest_filename;	
	}

	public String prepareTMTFile(URL outputDirectory, String languageDependentElementLabel) throws IOException, URISyntaxException 
	{
		dest_filename = prepareTMTFileName(outputDirectory);
		Out.prln(dest_filename);				

		Writer fwr = new OutputStreamWriter(new FileOutputStream(dest_filename), "utf-8");
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
		xmlwriter.writeEntityWithText(languageDependentElementLabel, doc.getContent().toString());
		xmlwriter.endEntity();//meta
		xmlwriter.endEntity();//tmt_document
		xmlwriter.close();
		fwr.close();
		
		return dest_filename;
	}

	public void annotateGateDocumentAcordingtoTMTfile() throws ParserConfigurationException, SAXException, IOException, InvalidOffsetException, PersistenceException, SecurityException
	{
		annotateGateDocumentAcordingtoTMTfile(dest_filename);
	}

	public void annotateGateDocumentAcordingtoTMTfile(String dest_filename) throws ParserConfigurationException, SAXException, IOException, InvalidOffsetException, PersistenceException, SecurityException
	{
		SAXTMTParser parser = new SAXTMTParser(language);
		List<Sentence> sentences = parser.parse(dest_filename);
		TMTAnnotator tmt_tree_annot = new TMTAnnotator(sentences);
		tmt_tree_annot.debug_print(System.out);
    	tmt_tree_annot.annotate(doc);
		doc.sync();
/*
		TMTAnnotator tmt_tree_annot = new TMTAnnotator(language);
    	
    	tmt_tree_annot.parseAndInit(dest_filename);
    	tmt_tree_annot.debug_print(System.out);
    	tmt_tree_annot.annotate(doc);
		doc.sync();
*/		
	}

	public String getTMTFilePath() {
		return dest_filename;
	}


}
