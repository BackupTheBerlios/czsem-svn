package czsem.gate;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.net.URL;

import javax.xml.parsers.ParserConfigurationException;

import org.xml.sax.SAXException;

import com.generationjava.io.xml.SimpleXmlWriter;
import com.generationjava.io.xml.XmlWriter;

import gate.AnnotationSet;
import gate.Document;
import gate.creole.AbstractResource;
import gate.util.InvalidOffsetException;
import gate.util.Out;

public class TectoMTDocumentAnalyser
{
	private Document doc;
	private String dest_filename;
	
	TectoMTDocumentAnalyser(Document doc)
	{
		this.doc = doc;
	}
	
	protected String prepareTMTFileName(URL outputDirectory)
	{
		StringBuilder sb = new StringBuilder();
		sb.append(outputDirectory.getFile());
		sb.append('/');
		sb.append(((AbstractResource) doc).getName());
		sb.append(".fs");
		
		String dest_filename = FSExporter.findAvailableFileName(sb.toString());
		
		return dest_filename;	
	}

	public String prepareTMTFile(URL outputDirectory) throws IOException 
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
		xmlwriter.writeEntityWithText("czech_source_text", doc.getContent().toString());
		xmlwriter.endEntity();//meta
		xmlwriter.endEntity();//tmt_document
		xmlwriter.close();
		fwr.close();
		
		return dest_filename;
	}

	public void annotateGateDocumentAcordingtoTMTfile() throws ParserConfigurationException, SAXException, IOException, InvalidOffsetException
	{
        AnnotationSet as = doc.getAnnotations();
        as.clear();
        
    	SAXTMTAnnotator tmt_tree_annot = new SAXTMTAnnotator();
    	
    	tmt_tree_annot.parseAndInit(dest_filename);
    	tmt_tree_annot.debug_print(System.out);
    	tmt_tree_annot.annotate(doc);
	}

	public String getTMTFilePath() {
		return dest_filename;
	}


}
