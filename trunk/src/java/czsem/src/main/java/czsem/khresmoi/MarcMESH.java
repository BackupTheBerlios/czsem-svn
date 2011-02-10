package czsem.khresmoi;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import org.marc4j.MarcReader;
import org.marc4j.MarcStreamReader;
import org.marc4j.marc.DataField;
import org.marc4j.marc.Record;
import org.marc4j.marc.Subfield;

public class MarcMESH {
	public static void main(String[] args) throws FileNotFoundException {

//		InputStream in = new FileInputStream("c:/data/Khresmoi/mesh/marc11.full.sep10.bin");
		InputStream in = new FileInputStream("c:/data/Khresmoi/czmesh/mesh2011-Marc21.iso");
		MarcReader reader = new MarcStreamReader(in, "UTF-8");
//		MarcReader reader = new MarcStreamReader(in);

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

			/*			
			System.err.println("---------------------------------------------------------------");
			System.err.println(record.toString());
			System.err.println("--------------CTRL---------------------------------------------");
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
		System.err.println("records: " + a);
		System.err.println("urls: " + urls.size());
		System.err.println("end");

	}
}
