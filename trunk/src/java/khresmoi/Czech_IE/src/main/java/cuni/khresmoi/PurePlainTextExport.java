package cuni.khresmoi;

import gate.Document;
import gate.Gate;
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
import java.util.Locale;

import czsem.utils.Config;

public class PurePlainTextExport extends PlainTextExport {

	public PurePlainTextExport(String inputdir, String outputdir) {
		super(inputdir, outputdir);
	}
	
	@Override
	protected String getOtputFileName(File orig_file) {
		String orig = orig_file.getName();
		return orig.replaceFirst("\\.xml$", ".txt");
	}
	
	
	@Override
	protected void exportSingleDocument(Document doc, String file_path) throws UnsupportedEncodingException, FileNotFoundException
	{
		PrintWriter out = new PrintWriter(new OutputStreamWriter(new BufferedOutputStream(new FileOutputStream(file_path)), "utf8"));
		
		out.write(doc.getContent().toString());
				
		out.close();		
	}
	
	@Override
	protected void exportSingleDocument(Document doc) throws UnsupportedEncodingException, FileNotFoundException
	{
		String filename = (String) doc.getFeatures().get("bmcID");
		
		exportSingleDocument(doc, outputdir+"/"+filename+".txt");				
	}


	
	public static void main(String[] args) throws URISyntaxException, IOException, GateException {
		Locale.setDefault(Locale.ENGLISH);
		
		Config.getConfig().setGateHome();
		Gate.init();
		
		KhresmoiConfig c = KhresmoiConfig.getConfig();
		
		PurePlainTextExport export = 
			new PurePlainTextExport(
					c.getOutputDirBmcAnalyzed(),
					c.getOutputDirBmcPlainTextExport()+"/txt/");

	    export.doTheAnalysis();		


	}


}
