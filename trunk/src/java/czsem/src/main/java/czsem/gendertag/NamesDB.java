package czsem.gendertag;

import java.io.File;
import java.io.IOException;
import java.nio.charset.Charset;
import java.text.Normalizer;
import java.text.Normalizer.Form;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;

import com.csvreader.CsvReader;

public class NamesDB {
	public static void main(String[] args) throws Exception {
		NamesDB new_db = new NamesDB();
		
		new_db.printStats();
		
		System.err.println(Arrays.toString(new_db.findAllToStr(" Dědková")));
		System.err.println(Arrays.toString(new_db.findAll(" Dědková")));
		System.err.println(Arrays.toString(new_db.findAllToStr(" Jan")));
		System.err.println(Arrays.toString(new_db.findAll(" Jan")));
		System.err.println(Arrays.toString(new_db.findAllToStr("Jana ")));
		System.err.println(Arrays.toString(new_db.findAll("Jana ")));

	}

	public static String normalizeName(String name)
	{
		String s0 = name.trim().toLowerCase();
		String s1 = Normalizer.normalize(s0, Form.NFD);
		String s2 = s1.replaceAll("[^\\p{ASCII}]", "");
		return s2;
	}

	
	public static class DbRecord
	{
		private String origName;
		public int nameFrquency;

		public DbRecord(String name, String frequncy) {
			nameFrquency = Integer.parseInt(frequncy);
			origName = name; 
		}


		@Override
		public String toString() {
			return String.format("[%d]", nameFrquency);
		}
		
		public void merge(DbRecord rec)
		{
			if (rec == null) return;
			origName = rec.origName+"+"+origName;
			nameFrquency += rec.nameFrquency;
		}
	}
	
	public static interface Irator3d<ObjType>
	{
		public ObjType iterte(ObjType current, String x1, String x2, String x3) throws Exception;		
	}
	
	public static class DbPlane
	{
		protected Map<String, DbRecord> plane;

		public DbPlane(String filename) throws IOException {
			System.err.println(filename);
			
			plane = new HashMap<String, NamesDB.DbRecord>();
			
			File f = new File("C:/Users/dedek/Desktop/jmena/stat/processing/" + filename + ".csv");
			if (f.exists())
			{
				loadFromFile(f.getAbsolutePath());				
				System.err.println(filename+"!!!");
			}
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
			CsvReader reader = new CsvReader(filename, ';', Charset.forName("utf8"));
			
			//reader.readHeaders();
			
			while (reader.readRecord())
			{
				String freq = reader.get(2);
				String name = reader.get(1);
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

	private DbPlane [][][] db; 

	
	public NamesDB() throws Exception
	{
		createDbPlanes();		
	}
		

	private void createDbPlanes() throws Exception {
		createDbPlanes(new Irator3d<NamesDB.DbPlane>() {

			@Override
			public DbPlane iterte(DbPlane current, String x1, String x2, String x3) throws Exception {
				return new DbPlane(String.format("%s_%s_%s", x1, x2, x3));
			}
		});
	}

	protected void iterateDbPlanes(Irator3d<DbPlane> iter) throws Exception
	{
		for (int a=0; a<attr_names[0].length; a++)
		{
			for (int b=0; b<attr_names[1].length; b++)
			{
				for (int c=0; c<attr_names[2].length; c++)
				{
					iter.iterte(db[a][b][c], attr_names[0][a], attr_names[1][b], attr_names[2][c]);
				}
			}
		}
		
	}

	private void createDbPlanes(Irator3d<DbPlane> iter) throws Exception {
		db = new DbPlane[attr_names[0].length][][];
		for (int a=0; a<attr_names[0].length; a++)
		{
			db[a] = new DbPlane[attr_names[1].length][];
			for (int b=0; b<attr_names[1].length; b++)
			{
				db[a][b] = new DbPlane[attr_names[2].length];
				for (int c=0; c<attr_names[2].length; c++)
				{
					db[a][b][c] = iter.iterte(db[a][b][c], attr_names[0][a], attr_names[1][b], attr_names[2][c]);
				}
			}
		}
	}


	public int[] findAll(String string) throws Exception {
		final int[] ret = new int[(attr_names.length+1)*(attr_names[0].length+1)];
		
		final String norm = normalizeName(string);

		Irator3d<DbPlane> iter = new Irator3d<NamesDB.DbPlane>() {
			int cur = 0; 
			
			@Override
			public DbPlane iterte(DbPlane current, String x1, String x2, String x3) throws Exception {
				DbRecord rec = current.plane.get(norm);
				if (rec != null)
					ret[cur] = rec.nameFrquency;
				
				cur++;
				
				return null;
			}
		};
		
		iterateDbPlanes(iter);
		
		return ret;
		
	}

	
	public String[] findAllToStr(String string) throws Exception {
		final String[] ret = new String[(attr_names.length+1)*(attr_names[0].length+1)*2];
		
		final String norm = normalizeName(string);

		Irator3d<DbPlane> iter = new Irator3d<NamesDB.DbPlane>() {
			int cur = 0; 
			
			@Override
			public DbPlane iterte(DbPlane current, String x1, String x2, String x3) throws Exception {
				DbRecord rec = current.plane.get(norm);
				if (rec != null)
				{
					ret[cur] = rec.origName;
					ret[cur+1] = Integer.toString(rec.nameFrquency);
				}
				
				cur+=2;
				
				return null;
			}
		};
		
		iterateDbPlanes(iter);
		
		return ret;
		
	}

	public void printStats() throws Exception {
		iterateDbPlanes(new Irator3d<NamesDB.DbPlane>() {

			@Override
			public DbPlane iterte(DbPlane current, String x1, String x2, String x3) throws Exception {
				current.printStats();
				return null;
			}
		});
		
	}

}
