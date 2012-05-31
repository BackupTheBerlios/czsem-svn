package cuni.khresmoi;

import gate.Annotation;
import gate.AnnotationSet;
import gate.Document;
import gate.Factory;
import gate.FeatureMap;
import gate.Gate;
import gate.Utils;
import gate.creole.ExecutionException;
import gate.creole.ResourceInstantiationException;
import gate.util.GateException;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URISyntaxException;
import java.util.List;
import java.util.Locale;

import cuni.khresmoi.MorceBatchAnalysis.DocumentLoadSynchronizer;
import cuni.khresmoi.bmc.BMCAnalysis;
import czsem.utils.Config;

public class PlainTextExport extends BMCAnalysis
{
	public PlainTextExport(String inputdir, String outputdir) {
		super(inputdir, outputdir);
	}

	@Override
	protected void analyzeFile(File file) throws ResourceInstantiationException, ExecutionException, IOException
	{
		Document doc = DocumentLoadSynchronizer.loadDocument(file);
		
		exportSingleDocument(doc);
				
		Factory.deleteResource(doc);
	}
	
	@Override
	protected String getOtputFileName(File orig_file) {
		String orig = orig_file.getName();
		return orig.replaceFirst("\\.xml$", ".bmc");
	}


	
	protected void exportSingleDocument(Document doc) throws UnsupportedEncodingException, FileNotFoundException
	{
		String filename = (String) doc.getFeatures().get("bmcID");
		
		exportSingleDocument(doc, outputdir+"/"+filename+".bmc");				
	}

	protected void exportSingleDocument(Document doc, String file_path) throws UnsupportedEncodingException, FileNotFoundException
	{
		PrintWriter out = new PrintWriter(new OutputStreamWriter(new BufferedOutputStream(new FileOutputStream(file_path)), "utf8"));
				
		AnnotationSet tmt = doc.getAnnotations("TectoMT"); 
		AnnotationSet sents = tmt.get("Sentence");
		AnnotationSet allTocs = tmt.get("Token"); 
		
		List<Annotation> ordered = Utils.inDocumentOrder(sents);
		
		for (Annotation s : ordered)
		{
			AnnotationSet tocs = allTocs.getContained(s.getStartNode().getOffset(), s.getEndNode().getOffset());
			List<Annotation> toc_ordered = Utils.inDocumentOrder(tocs);
			
			for (Annotation t : toc_ordered)
			{
				FeatureMap f = t.getFeatures();
				if (! f.get("form").equals(" "))
				{
					//forma|lemma|znacka forma|lemma|znacka
					out.format("%s|%s|%s ", f.get("form"), f.get("lemma"), f.get("tag"));
				}
			}
			out.println();			
		}

		
		out.close();
		
	}

	public static void main(String[] args) throws URISyntaxException, IOException, GateException {
		Locale.setDefault(Locale.ENGLISH);
		
		Config.getConfig().setGateHome();
		Gate.init();
		
		
		KhresmoiConfig c = KhresmoiConfig.getConfig();
		
		PlainTextExport export = 
			new PlainTextExport(
					c.getOutputDirBmcAnalyzed(),
					c.getOutputDirBmcPlainTextExport());

	    export.doTheAnalysis();		


	}

}
