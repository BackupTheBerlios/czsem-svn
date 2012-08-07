package czsem.encoding;

import eu.medsea.mimeutil.MimeUtil;
import eu.medsea.mimeutil.MimeUtil2;
import eu.medsea.mimeutil.detector.MagicMimeMimeDetector;
import gate.Factory;
import gate.FeatureMap;
import gate.Gate;
import gate.creole.ResourceInstantiationException;
import gate.util.GateException;

import java.io.IOException;
import java.net.URL;
import java.util.Collection;

import org.jsoup.Connection;
import org.jsoup.Connection.Method;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;

import com.sun.org.apache.xpath.internal.operations.Gte;

public class HttpTargetContentDetector {
	static {
		MimeUtil.registerMimeDetector(MagicMimeMimeDetector.class.getCanonicalName());
    }
	
	protected Connection con = null;
	
	public HttpTargetContentDetector(String url) throws IOException
	{
		con = Jsoup.connect(url);
		con.execute();		
	}

	public String detectMimeType() {
		return MimeUtil.getMostSpecificMimeType(MimeUtil.getMimeTypes(con.response().bodyAsBytes())).toString();		
	}
	


	public String detectEncoding() {		

		try {
			con.response().parse();
			return con.response().charset();
		} catch (IOException e) {
			return con.response().charset();
		}
	}

	public static gate.Document gateDocFromUrl(String url) throws IOException,	ResourceInstantiationException {
		
		HttpTargetContentDetector detect = new HttpTargetContentDetector(url);
		
		String enc = detect.detectEncoding();
		String mime = detect.detectMimeType();

		FeatureMap parameterValues = Factory.newFeatureMap();

		URL sourceUrl = new URL(url);
		parameterValues.put(gate.Document.DOCUMENT_URL_PARAMETER_NAME,	sourceUrl);
		
		if (mime != null)
			parameterValues.put(gate.Document.DOCUMENT_MIME_TYPE_PARAMETER_NAME,	"application/pdf");
		
		if (enc != null)
			parameterValues.put(gate.Document.DOCUMENT_ENCODING_PARAMETER_NAME,	enc);
		
		return (gate.Document) Factory.createResource("gate.corpora.DocumentImpl", parameterValues);

	}

	public static void main(String[] args) throws IOException, GateException {
	        
		
		
		testUrl("http://google.com");
		// testUrl("http://www.horosvaz.cz/drytooling/");
		// testUrl("http://lezec.cz");

		System.err.println("end");

		Gate.runInSandbox(true);
		Gate.init();

		gate.Document doc3 = gateDocFromUrl("http://aplikace.mvcr.cz/sbirka-zakonu/ViewFile.aspx?type=z&id=24495");
		System.err.println(doc3.getContent().toString());

		/*
		 * gate.Document doc = Factory.newDocument(new
		 * URL("http://google.com"));
		 * System.err.println(doc.getContent().toString());
		 * 
		 * gate.Document doc2 = gateDocFromUrl("http://google.com");
		 * System.err.println(doc2.getContent().toString()); /*
		 */

	}

	public static void testUrl(String url) throws IOException {
		Connection con = Jsoup.connect(url);
		con.method(Method.GET);
		con.execute();
		System.err.println(con.response().charset());
		System.err.println(con.response().contentType());
		con.response().parse();
		System.err.println(con.response().charset());
		System.err.println(con.response().contentType());
		/*
		 * 
		 * Document doc = Jsoup.connect(url).get();
		 * System.err.println(doc.html());
		 */
		System.err.format(
				"------ %s -----------------------------------------------\n",
				url);
	}

}
