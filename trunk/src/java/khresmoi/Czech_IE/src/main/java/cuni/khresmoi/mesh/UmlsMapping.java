package cuni.khresmoi.mesh;

import java.io.FileInputStream;
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URI;
import java.net.URISyntaxException;
import java.util.HashMap;
import java.util.Map;

import javax.xml.parsers.ParserConfigurationException;
import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;

import org.xml.sax.Attributes;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;

import cuni.khresmoi.mesh.MeshRecordDB.MeshRecord;
import cuni.khresmoi.mimir.MeshIndexer.MeshParsedIndex.MeshIndexRecord;

public class UmlsMapping {

	public static void main(String[] args) throws SAXException, IOException, ParserConfigurationException, ClassNotFoundException, URISyntaxException {
		System.err.println("start");
		Map<Integer, UmlsEnty> ds = parseUMSFile("c:/data/Khresmoi/mesh_umls_linkedlifedata_middle.xml");
		System.err.println("parsed");
		MeshRecordDB mdb = new MeshRecordDB();
		mdb.load();
		
		int cnt=0;
		
		for (MeshRecord a : mdb.getRecords())
		{
			UmlsEnty umls = ds.get(MeshIndexRecord.parseMeshID(a.meshID));
			if (umls == null)
			{
				System.err.format("%s %s\n", a.meshID, a.enTerm);
				cnt ++;
			}
		}

		System.err.println(cnt); //5044
		
	}

	
	public static class UmlsEnty
	{
		public UmlsEnty(String umls, String mesh) throws URISyntaxException, MalformedURLException {
			this.umls = umls == null ? null : new URI(umls);
			this.mesh = mesh == null ? null : new URI(mesh);
		}
		
		URI umls;
		URI mesh;		
	}
	
	public static class UmlsSaxHandler extends DefaultHandler 
	{
		private StringBuilder sb = new StringBuilder();

		private StringBuilder id, mesh, umls;

		private Map<Integer, UmlsEnty> ds = new HashMap<Integer, UmlsEnty>();
		
		private void addEntry() throws URISyntaxException, MalformedURLException {
			Integer key = MeshIndexRecord.parseMeshID(id.toString());
			UmlsEnty entry = new UmlsEnty(umls.toString(), mesh.toString());
			ds.put(key, entry );
			
//			System.err.format("_%06d\t%s\t%s\n", key, entry.umls.toASCIIString(), entry.mesh.toASCIIString());
		}


		@Override
		public void startElement(String uri, String localName, String qName, Attributes attributes) throws SAXException {
			if (qName.equals("result"))
			{
/**/
				id   = new StringBuilder();
				mesh = new StringBuilder();
				umls = new StringBuilder();
/**/				
			} else if (qName.equals("binding"))
			{
				switch (attributes.getValue("name").charAt(0)) {
				case 'i':					
					sb = id; break;
				case 's':					
					sb = umls; break;
				case 'm':					
					sb = mesh; break;
				} 
			}else if (qName.equals("literal") || qName.equals("uri"))
			{
				sb.setLength(0);
			}
		}
		
		@Override
		public void endElement(String uri, String localName, String qName) throws SAXException {
			if (qName.equals("result"))
			{
//				System.err.println();
				try {
					addEntry();
				} catch (Exception e) {
					throw new RuntimeException(e);
				}
			}
			else if (qName.equals("literal") || qName.equals("uri"))
			{
/*
				System.err.print(sb.toString());
				System.err.print("\t");
/**/				
				sb = new StringBuilder();
			}
		}

		@Override
		public void characters(char[] ch, int start, int length) throws SAXException {
			sb.append(ch, start, length);
		
		}		
	}
	
	public static Map<Integer, UmlsEnty> parseUMSFile(String fileName) throws SAXException, IOException, ParserConfigurationException {
		SAXParserFactory spf = SAXParserFactory.newInstance();
	    spf.setValidating(false); // No validation required
	    spf.setFeature("http://apache.org/xml/features/nonvalidating/load-external-dtd", false);
	    SAXParser sax_parser = spf.newSAXParser();
	    
		InputSource input = new InputSource(new FileInputStream(fileName));
		
		UmlsSaxHandler handler = new UmlsSaxHandler();
		sax_parser.parse(input, handler);
		
		return handler.ds;
		
	}

}
