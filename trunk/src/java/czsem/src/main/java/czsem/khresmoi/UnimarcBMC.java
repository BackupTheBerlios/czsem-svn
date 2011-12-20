package czsem.khresmoi;

import gate.Document;
import gate.FeatureMap;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.marc4j.MarcReader;
import org.marc4j.MarcStreamReader;
import org.marc4j.marc.ControlField;
import org.marc4j.marc.DataField;
import org.marc4j.marc.Record;
import org.marc4j.marc.Subfield;

import czsem.khresmoi.BMCGateCorpusBuider.BmcRecord;

public class UnimarcBMC
{
	public static Logger logger = Logger.getLogger(UnimarcBMC.class);
	

	public static void updateTermNames(Map<String, String> term_names, Record record)
	{
		@SuppressWarnings("unchecked")
		List<DataField> fields = record.getVariableFields("606");
		
		for (int n=0; n<fields.size(); n++)
		{
			DataField dataField = fields.get(n);
			Subfield id = dataField.getSubfield('3');
			Subfield term = dataField.getSubfield('a');
			if (id != null && term != null)
			{
				term_names.put(id.getData(), term.getData());				
			}
		}

		
	}

	
	public static void setDocumentFeatures(Document doc, Record record)
	{
		List<String> meshIDs;
		List<String> meshArticleTypeIDs;
		List<String> meshTreeNodes;
		List<String> meshTerms;
		
		meshIDs = readFields(record, "606", '0', '3');
		meshArticleTypeIDs = readFields(record, "606", ' ', '3');
		meshTreeNodes = readFields(record, "686", null, 'a');
		meshTerms = readFields(record, "606", '0', 'a');
		
		String title = readBMCArticleName(record);
		
		if (title != null) doc.setName(title);
		
		FeatureMap f = doc.getFeatures();
		f.put("bmcID", readBMCID(record));
		f.put("bmcTitle", title);
		f.put("meshIDs", meshIDs);
		f.put("meshArticleTypeIDs", meshArticleTypeIDs);
		f.put("meshTreeNodes", meshTreeNodes);
		f.put("meshTerms", meshTerms);
		
	}
		

	/**
	 * @param record
	 * @param fieldTag
	 * @param indicator1 - use null if doesn't matter, space (' ') if not present
	 * @return
	 */
	static List<String> readFields(Record record, String fieldTag, Character indicator1, char subfieldCode)
	{
		@SuppressWarnings("unchecked")
		List<DataField> fields = record.getVariableFields(fieldTag);
		
		List<String> ret = new ArrayList<String>(fields.size());

		for (int n=0; n<fields.size(); n++)
		{
			DataField dataField = fields.get(n);
			if ((indicator1 != null) && (dataField.getIndicator1() != indicator1)) continue;
			Subfield subf = dataField.getSubfield(subfieldCode);
			if (subf != null)
				ret.add(subf.getData());
		}

		return ret;		
	}
	
	public static List<String> readMeshIDs(Record record)
	{
		return readFields(record, "606", '0', '3');		
	}

	public static String readBMCID(Record record)
	{
		return 	((ControlField) record.getVariableField("001")).getData();
	}

	public static String readBMCLoc(Record record)
	{
		return readFields(record, "102", null, 'a').iterator().next();
	}

	public static String readBMCLang(Record record)
	{		
		List<String> f1 = readFields(record, "101", null, 'a');
		if (f1.isEmpty()) f1 = readFields(record, "101", null, 'd');
		
		return f1.iterator().next();
	}

	public static String readBMCArticleName(Record record)
	{
		DataField name = (DataField) record.getVariableField("200");
		if (name != null)
		{
			Subfield f = name.getSubfield('a');
			if (f!=null)
			{
//				System.err.println(f.getData());
				return f.getData();
			}
		}
		
		logger.error("readBMCArticleName: failed to read article name!");
		return null;
	}

	public static String readURLStr(Record record)
	{
		DataField url = (DataField) record.getVariableField("856");
		if (url != null)
		{
			Subfield f = url.getSubfield('u');
			if (f!=null)
			{
//				System.err.println(f.getData());
				return f.getData();
			}
			else
				logger.warn("failed to obtain URL from: " + url.toString());					
		}
		
		return null;
	}

	public static void main(String[] args) throws FileNotFoundException {

		InputStream in = new FileInputStream("c:/data/Khresmoi/BMC/bmc-2011-01.iso");
		MarcReader reader = new MarcStreamReader(in, "UTF-8");

		System.err.println("Start");
		
		Record record = null;

		int a = 0;
		
		List<String> urls = new ArrayList<String>(100000);
		
		while (reader.hasNext())
		{
			record = reader.next();
			

			a++;

			DataField url = (DataField) record.getVariableField("856");
			if (url != null)
			{
				Subfield f = url.getSubfield('u');
				if (f!=null)
				{
//					System.err.println(f.getData());
					urls.add(f.getData());
				}
				else
					System.err.println(url.toString());					
			}
//			else continue;
/*
			System.err.println("---------------------------------------------------------------");
			System.err.println(record.toString());
			System.err.println("--------------CTRL---------------------------------------------");
/*
			MarcWriter writer = new MarcXmlWriter(System.err, true);
		          writer.write(record);
		      writer.close();
				System.err.println("--------------XML---------------------------------------------");
		   

	/**		
			@SuppressWarnings("unchecked")
			List<DataField> mesh_ids = record.getVariableFields("606");

			for (int n=1; n<mesh_ids.size(); n++)
			{
				DataField dataField = mesh_ids.get(n);
				if (dataField.getIndicator1() != '0') continue;
				System.err.format("%2d %c %s - %s - %s\n", n, dataField.getIndicator1(), 
					dataField.getSubfield('a').getData(),
					dataField.getSubfield('2').getData(),
					dataField.getSubfield('3').getData());				
			}

			@SuppressWarnings("unchecked")
			List<DataField> mesh_trees = record.getVariableFields("686");
			for (int n=1; n<mesh_trees.size(); n++)
			{
				DataField dataField = mesh_trees.get(n);
				System.err.format("%2d %s - %s\n", n,  
					dataField.getSubfield('a').getData(),
					dataField.getSubfield('2').getData());
			}

			

			/**/			
			
			
			if (urls.size()>3) break;

			/**			
			List<ControlField> c = record.getControlFields();
			for (ControlField controlField : c) {
				System.err.println("-------CTRL--------------");
				System.err.println(controlField.getId());
				
			}
			System.err.println("---------------DATA--------------------------------------------");
			List<DataField> d = record.getDataFields();
			for (DataField dataField : d) {
				System.err.println("-------DATA--------------");
				System.err.println(dataField.getIndicator1());
			}
			System.err.println("---------------VAR--------------------------------------------");
			List<VariableField> v = record.getVariableFields();
			for (VariableField variableField : v) {
				System.err.println("-------VAR--------------");
				System.err.println(variableField.toString());;
			}

			//			System.err.println(record.getVariableField("ff"));
			if (a>10) break;
/**/			
			
			if (a % 10000 == 0)
				System.err.println(a);

		}
		
		System.err.println("---last-record--------------------------------------------------------");
		System.err.println(record.toString());
		System.err.println("---last-record--------------------------------------------------------");
		System.err.println("records: " + a);//617155
		System.err.println("urls: " + urls.size());//25408
		System.err.println("end");

	}


	public static BmcRecord readBmcRecord(Record record)
	{
		return new BmcRecord(record);
	}

}
