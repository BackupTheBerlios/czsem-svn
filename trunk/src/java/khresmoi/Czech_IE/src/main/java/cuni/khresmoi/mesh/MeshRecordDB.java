package cuni.khresmoi.mesh;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.Serializable;
import java.net.URISyntaxException;
import java.util.Collection;
import java.util.SortedMap;
import java.util.TreeMap;

import javax.xml.parsers.ParserConfigurationException;

import org.xml.sax.SAXException;

import cuni.khresmoi.KhresmoiConfig;
import cuni.khresmoi.mimir.MeshIndexer.MeshParsedIndex.MeshIndexRecord;

public class MeshRecordDB {
	public static class MeshRecord implements Serializable
	{		
		private static final long serialVersionUID = 4173377365349246503L;

		String czTerm;
		String enTerm;

		String meshID;

		public boolean hasSeparator() {
			for (char ch : czTerm.toCharArray())
			{
				if (MeshStatistics.isSeparator(Character.toString(ch)))
					return true;				
			}
			return false;
		}

		public String[] tokones() {
			return MeshStatistics.splitTerm(czTerm);
		}

		public String getEnTerm() {
			return enTerm;
		}
	}
	
	private SortedMap<Integer, MeshRecord> records = new TreeMap<Integer, MeshRecordDB.MeshRecord>();

	public Collection<MeshRecord> getRecords() {
		return records.values();
	}
	
	private void addRecord(MeshRecord r)
	{
		if (r == null) return;
		
		records.put(MeshIndexRecord.parseMeshID(r.meshID), r);		
	}
	

	class MeshRecordDBParser extends MeshSaxParser {
		MeshRecord tmp = null;
		@Override
		public void newRecord() {
			addRecord(tmp);
			tmp = new MeshRecord();		
		}

		@Override
		public void putMeshID(String meshID) {
			tmp.meshID = meshID;
		}

		@Override
		public void putCzTerm(String czTerm) {
			tmp.czTerm = czTerm;		
		}

		@Override
		public void putEnTerm(String enTerm) {
			tmp.enTerm = enTerm;				
		}

		@Override
		public void putTreeNumber(String treeNumber) {
			// Implement? 				
		}
	};

	public void parseMesh(String mushxml_filename) throws ParserConfigurationException, SAXException, IOException
	{
		MeshRecordDBParser parser = new MeshRecordDBParser();
		parser.parse(mushxml_filename);
		addRecord(parser.tmp);
	}
	
	public static void main(String[] args) throws ParserConfigurationException, SAXException, IOException, ClassNotFoundException, URISyntaxException
	{
		System.err.println("start");
		MeshRecordDB db = new MeshRecordDB();
		System.err.println("parse");
		KhresmoiConfig c = KhresmoiConfig.getConfig();
		db.parseMesh(c.getMeshXmlFilePath());
		System.err.println("ser");
		db.serializeToFile(c.getSerializedResourcesDir()+"meshDB.ser");
		System.err.println("deser");
		db.deserializeFromFile(c.getSerializedResourcesDir()+"meshDB.ser");

		System.err.println(db.getEntry("D059085").czTerm);
		
		String last = "";
		for (MeshRecord r : db.getRecords())
		{
			//System.err.println(r.meshID);
			if (last.compareTo(r.meshID) > 0)
			{
				System.err.println(r.meshID);
				break;
			}
			
			last = r.meshID;			
		}

		System.err.println("end");
		
	}

	protected void serializeToFile(String file_name) throws IOException {
		ObjectOutputStream out = new ObjectOutputStream(new BufferedOutputStream(new FileOutputStream(file_name)));
		out.writeObject(records);
		out.close();				
	}

	@SuppressWarnings("unchecked")
	private void deserializeFromFile(String file_name) throws FileNotFoundException, IOException, ClassNotFoundException {
		ObjectInputStream in = new ObjectInputStream(new BufferedInputStream(new FileInputStream(file_name)));
		records =   (SortedMap<Integer, MeshRecord>) in.readObject();
		in.close();			
	}

	public void load() throws FileNotFoundException, IOException, ClassNotFoundException, URISyntaxException {
		deserializeFromFile(KhresmoiConfig.getConfig().getSerializedResourcesDir()+"meshDB.ser");		
	}

	public MeshRecord getEntry(String meshIdStr)
	{	
		return records.get(MeshIndexRecord.parseMeshID(meshIdStr));		
	}

	public int meshTermsWithSeparator(Iterable<String> terms) {
		int ret = 0;
		for (String s: terms)
		{
			MeshRecord e = getEntry(s);			
			if (e.hasSeparator()) ret++;
		}
		return ret;
	}



}
