package czsem.gendertag;

import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.Charset;
import java.text.Normalizer;
import java.text.Normalizer.Form;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;
import java.util.Map.Entry;

import com.csvreader.CsvReader;

public class NamesDB {
	public static void main(String[] args) throws Exception {
		Locale.setDefault(Locale.ENGLISH);
		
		NamesDB new_db = new NamesDB();
		
		new_db.printStats();
		
		System.err.println(Arrays.toString(NamesDB.getHeadersShort()));
		System.err.println(Arrays.toString(new_db.findAll(" Jan")));

	}

	public static String normalizeName(String name)
	{
		String s0 = name.replaceAll("[,.;\\-/\\%*+]", " ").trim().toLowerCase();
		String s1 = Normalizer.normalize(s0, Form.NFD);
		String s2 = s1.replaceAll("[^\\p{ASCII}]", "");
		return s2;
	}

	
	public static class DbRecord
	{
		public String origName;
		public double nameFrquency;

		public DbRecord(String name, String frequncy) {
			nameFrquency = Double.parseDouble(frequncy);
			origName = name; 
		}


		public DbRecord() {
			origName = "";
			nameFrquency = 0;
		}


		@Override
		public String toString() {
			return String.format("[%f]", nameFrquency);
		}
		
		public void merge(DbRecord rec)
		{
			if (rec == null) return;
			if (origName.equals(""))
				origName = rec.origName;
			else
				origName = rec.origName+"+"+origName;
			
			
			nameFrquency += rec.nameFrquency;
		}
	}
	
	public static interface Irator3d<ObjType>
	{
		public ObjType iterte(ObjType current, String x1, String x2, String x3) throws IOException;		
	}
	
	public static class DbPlane
	{
		protected Map<String, DbRecord> plane;

		public DbPlane(String filename) throws IOException {
			//System.err.println(filename);
			
			plane = new HashMap<String, NamesDB.DbRecord>();
			
			InputStream stream = getClass().getResourceAsStream("resources/scaled_" + filename + ".csv");
			if (stream != null) loadFromStream(stream);				

			
//			NamesDB.class.
			
/*
			File f = new File("C:/Users/dedek/Desktop/jmena/stat/processing/scaled_" + filename + ".csv");
			if (f.exists())
			{
				loadFromFile(f.getAbsolutePath());				
				System.err.println(filename+"!!!");
			}
*/			
		}
		
		public void loadFromStream(InputStream inputStream) throws IOException {
			CsvReader reader = new CsvReader(inputStream, ',', Charset.forName("utf8"));
			loadUsingCsvReader(reader);			
		}

		public void loadUsingCsvReader(CsvReader reader) throws IOException {
			reader.readHeaders();
			
			while (reader.readRecord())
			{
				String freq = reader.get(1);
				String name = reader.get(0);
				if (! freq.equals(""))
				{
					DbRecord new_rec = new DbRecord(name, freq);
					DbRecord orig = plane.put(
							normalizeName(name ),
							new_rec);
					
					new_rec.merge(orig);					
				}
			}
			reader.close();			
		}

		public void loadFromFile(String filename) throws IOException {
/*
			InputStreamReader in = new InputStreamReader(new FileInputStream(filename), "cp1250");
			OutputStreamWriter out = new OutputStreamWriter(new FileOutputStream(filename+"2"), "utf8");
			for (;;)
			{
				char buf[] = new char[1024*1024];
				int ret = in.read(buf);
				if (ret == -1) break;
				out.write(buf, 0, ret);
			}
			in.close();
			out.close();
			
/**/			
			CsvReader reader = new CsvReader(filename, ',', Charset.forName("utf8"));
			loadUsingCsvReader(reader);			
		}

		public void printStats() {
			int max = 0;
			System.err.println(plane.size());
			for(Entry<String, DbRecord> e : plane.entrySet())
			{
				if (--max < 0) break;
				System.err.println(e);
			}
		}

	}

	
	public static final String [][] attr_names = 
	{
		{"male", "female"},
		{"first", "last"},
		{"cz"  , "inter"},
	};

	private static final int attr_num = 8;

	private DbPlane [][][] db; 

	
	public NamesDB() throws Exception
	{
		createDbPlanes();		
	}
		

	private void createDbPlanes() throws IOException {
		db = createDbPlanes(new Irator3d<NamesDB.DbPlane>() {

			@Override
			public DbPlane iterte(DbPlane current, String x1, String x2, String x3) throws IOException {
				return new DbPlane(String.format("%s_%s_%s", x1, x2, x3));
			}
		});
	}

	protected void iterateDbPlanes(Irator3d<DbPlane> iter) throws IOException
	{
		iterateDbPlanes(iter, db);		
	}

	protected static void iterateDbPlanes(Irator3d<DbPlane> iter, DbPlane[][][] in_db) throws IOException
	{
		for (int a=0; a<attr_names[0].length; a++)
		{
			for (int b=0; b<attr_names[1].length; b++)
			{
				for (int c=0; c<attr_names[2].length; c++)
				{
					iter.iterte(in_db[a][b][c], attr_names[0][a], attr_names[1][b], attr_names[2][c]);
				}
			}
		}
		
	}

	protected static DbPlane[][][] createDbPlanes(Irator3d<DbPlane> iter) throws IOException {		
		DbPlane[][][] ret_db = new DbPlane[attr_names[0].length][][];
		for (int a=0; a<attr_names[0].length; a++)
		{
			ret_db[a] = new DbPlane[attr_names[1].length][];
			for (int b=0; b<attr_names[1].length; b++)
			{
				ret_db[a][b] = new DbPlane[attr_names[2].length];
				for (int c=0; c<attr_names[2].length; c++)
				{
					ret_db[a][b][c] = iter.iterte(ret_db[a][b][c], attr_names[0][a], attr_names[1][b], attr_names[2][c]);
				}
			}
		}
		return ret_db;
	}


	public DbRecord[] findAll(String string) throws IOException {
		final DbRecord[] ret = new DbRecord[attr_num];
		
		final String norm = normalizeName(string);

		Irator3d<DbPlane> iter = new Irator3d<NamesDB.DbPlane>() {
			int cur = 0; 
			
			@Override
			public DbPlane iterte(DbPlane current, String x1, String x2, String x3) throws IOException {
				
				ret[cur] = current.plane.get(norm);
				
				cur++;
				
				return null;
			}
		};
		
		iterateDbPlanes(iter);
		
		return ret;
		
	}

	

	public void printStats() throws Exception {
		iterateDbPlanes(new Irator3d<NamesDB.DbPlane>() {

			@Override
			public DbPlane iterte(DbPlane current, String x1, String x2, String x3) throws IOException {
				current.printStats();
				return null;
			}
		});
		
	}

	public static String[] getHeadersShort() throws Exception {
		final String[] ret = new String[attr_num];
				
		createDbPlanes(new Irator3d<NamesDB.DbPlane>() {
			int cur = 0; 
			
			@Override
			public DbPlane iterte(DbPlane current, String x1, String x2, String x3) throws IOException {
				ret[cur] = String.format("%s_%s_%s", x1, x2, x3);				
				cur++;				
				return null;
			}
		});		
		return ret;
	}

}
