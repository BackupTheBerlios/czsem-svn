package cuni.khresmoi.mimir;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.xml.parsers.ParserConfigurationException;

import org.xml.sax.SAXException;

import czsem.Utils;
import cuni.khresmoi.mesh.MeshSaxParser;
import cuni.khresmoi.mimir.MeshIndexer.MeshParsedIndex.MeshIndexRecord;
import cuni.khresmoi.mimir.MeshIndexer.MeshParsedIndex.MeshTreeNum;

public class MeshIndexer
{
	public static class MeshIndex
	{
		private Map<Integer, int[]> children = null; 
		
		public MeshIndex(MeshParsedIndex parsedIndex)
		{
			children = new HashMap<Integer, int[]>(parsedIndex.records.size());
			
			for (MeshIndexRecord record : parsedIndex.records)
			{
				Set<Integer> l = new HashSet<Integer>();
				for (MeshTreeNum tn : record.tree_nums)
				{
					for (MeshTreeNum  ch : tn.children_by_numbers.values())
					{
						l.add(ch.main_record.id);						
					}					
				}
				
				children.put(record.id, Utils.intArrayFromCollection(l));				
			}
		}

		public MeshIndex() throws IOException, URISyntaxException
		{			
			readFromStream(getClass().getResourceAsStream("/mesh_child_index.bin"));			
		}
		
		
		public MeshIndex(String dat_filename) throws IOException
		{
			readFromFile(dat_filename);			
		}

		public int[] getChildren(String meshID)
		{
			return getChildren(MeshIndexRecord.parseMeshID(meshID));
		}

		public int[] getChildren(int meshID)
		{
			return children.get(meshID);
		}

		public int[] getDescendants(String meshID) {
			return getDescendnats(MeshIndexRecord.parseMeshID(meshID));
		}

		public static interface DescendantsCnstraint
		{
			boolean continueSearch(int currentDepth);			
		}
		
		public Collection<Integer> getDescendnatsCollection(String meshID, DescendantsCnstraint c)
		{
			return getDescendnatsCollection(MeshIndexRecord.parseMeshID(meshID), c);
		}

		public Collection<Integer> getDescendnatsCollection(int meshID)
		{
			return getDescendnatsCollection(meshID, new DescendantsCnstraint() {
				
				@Override
				public boolean continueSearch(int currentDepth) {
					return currentDepth > 0;
				}
			});
		}

		public Collection<Integer> getDescendnatsCollection(int meshID, DescendantsCnstraint c)
		{
			// <MeshID, Depth>
			Map<Integer, Integer> looking_for = new HashMap<Integer, Integer>();

			Set<Integer> ret = new HashSet<Integer>();
			
			looking_for.put(meshID, 0);
			
			while (! looking_for.isEmpty())
			{
				Iterator<Integer> i = looking_for.keySet().iterator();
				int ii = i.next();
				int depth = looking_for.get(ii);
				i.remove();
				
				
				if (c.continueSearch(depth)) ret.add(ii);
				
				
				int[] cur_children = getChildren(ii);				
				Utils.copyArrayToDepthMapExceptListed(cur_children, depth+1, looking_for, ret);											
			}
			
			return ret;
		}

		public int[] getDescendnats(int meshID)
		{
			Collection<Integer> ret = getDescendnatsCollection(meshID);

			return Utils.intArrayFromCollection(ret);		
		}
		
		public void saveToFile(String filename) throws IOException
		{
			DataOutputStream out = new DataOutputStream(new BufferedOutputStream(new FileOutputStream(filename)));
			out.writeInt(children.keySet().size());
			
			for (Integer key : children.keySet())
			{
				int[] data = children.get(key);
				out.writeInt(key);
				out.writeInt(data.length);
				for (int i = 0; i < data.length; i++) {
					out.writeInt(data[i]);					
				}
				
			}
			out.close();
		}

		public void readFromStream(InputStream input_stream) throws IOException
		{
			DataInputStream in = new DataInputStream(new BufferedInputStream(input_stream));
			int size = in.readInt();
			children = new HashMap<Integer, int[]>(size);
			for (int j=0; j<size; j++)
			{
				int key = in.readInt();
				int length = in.readInt();

				int[] data = new int[length];
				for (int i = 0; i < data.length; i++) {
					data[i] = in.readInt();					
				}
				
				children.put(key, data);				
			}
			in.close();			
		}

		public void readFromFile(String filename) throws IOException
		{
			readFromStream(new FileInputStream(filename));
		}

		
	}

	public static class MeshParsedIndex
	{
		private final MeshTreeNum tree_num_index = new MeshTreeNum(); 
	
		public static class MeshTreeNum
		{
			
			private MeshIndexRecord main_record = null;
			private int[] id_numbers;
			private Map<Integer, MeshTreeNum> children_by_numbers = null;
			
			public MeshTreeNum(String treeNumber, MeshIndexRecord record)
			{
				assert(record != null);
				main_record = record;
				
				parseTreeNum(treeNumber);							
			}
	
			/**
			 * @param newMeshTreeNum to add
			 * @param current_depth actual depth in meshTreeNum.{@link #children_by_numbers}
			 */
			private void add(MeshTreeNum newMeshTreeNum, int current_depth)
			{
				assert(newMeshTreeNum.children_by_numbers == null);
				int current_index = newMeshTreeNum.id_numbers[current_depth];
				MeshTreeNum cur = children_by_numbers.get(current_index);
				
				if (newMeshTreeNum.id_numbers.length-1 == current_depth)
				{
					if (cur != null)
					{
						assert(cur.main_record == null);						
						assert(cur.children_by_numbers.size() > 0);
						newMeshTreeNum.children_by_numbers = cur.children_by_numbers;
					}
					else
					{
						newMeshTreeNum.children_by_numbers = new HashMap<Integer, MeshIndexer.MeshParsedIndex.MeshTreeNum>();						
					}
					
					children_by_numbers.put(current_index, newMeshTreeNum);
					return;
				}
				
				if (cur == null)
				{
					cur = new MeshTreeNum();
					children_by_numbers.put(current_index, cur);
				}
				
				cur.add(newMeshTreeNum, current_depth+1);
			}
	
			protected MeshTreeNum()
			{
				 children_by_numbers = new HashMap<Integer, MeshIndexer.MeshParsedIndex.MeshTreeNum>();
			}
	
			protected void parseTreeNum(String treeNumber)
			{
				char first_ch = treeNumber.charAt(0);
				String[] numbers = treeNumber.substring(1).split("\\.");
				
				id_numbers = new int[numbers.length+1];
				
				id_numbers[0] = first_ch;
				
				for (int a=1; a<id_numbers.length; a++)
				{
					id_numbers[a] = Integer.parseInt(numbers[a-1]);					
				}												
				
			}
	
			public String debugPrint() {
				StringBuilder sb = new StringBuilder();
				for ( MeshTreeNum tn : children_by_numbers.values())
				{
					sb.append(MeshIndexRecord.renderMeshID(tn.main_record.id));
					sb.append(": ");					
					sb.append(tn.main_record.name);
					sb.append('\n');					
				}
				return sb.toString();
			}
		};
		
		public static class MeshIndexRecord
		{
			private int id = -1;
			private List<MeshTreeNum> tree_nums = new ArrayList<MeshIndexer.MeshParsedIndex.MeshTreeNum>(2);
			
			public String name;
		
			/**
			 * @return mesh integer ID or -1
			 */
			public static int parseMeshID(String meshID)
			{
				if (meshID.length() != 7) return -1;
				if (meshID.charAt(0) != 'D') return -1;;				
				int id = Integer.parseInt(meshID.substring(1));
				assert(id > 0);
				return id;
			}
			
			public static String renderMeshID(int meshId) {
				return String.format("D%06d", meshId);
			}
		
			public void parseID(String meshID) {
				assert(id == -1);
				id = parseMeshID(meshID);
			}
		
			public void addTreenumber(MeshTreeNum treeNumber) {
				assert(! tree_nums.contains(treeNumber));
				tree_nums.add(treeNumber);
			}}

		private Set<MeshIndexRecord> records = new HashSet<MeshIndexer.MeshParsedIndex.MeshIndexRecord>(27000);
		public void addRecord(MeshIndexRecord record) {
			records.add(record);
		}
		
	}

	public MeshParsedIndex parseMesh() throws ParserConfigurationException, SAXException, IOException
	{
		final MeshParsedIndex index = new MeshParsedIndex();
		
		
		MeshSaxParser parser = new MeshSaxParser() {
			private MeshParsedIndex.MeshIndexRecord record = null;
			
			@Override
			public void putTreeNumber(String treeNumber) {
				MeshTreeNum num = new MeshTreeNum(treeNumber, record);
				index.tree_num_index.add(num, 0);
				record.addTreenumber(num);
			}
			
			@Override
			public void putMeshID(String meshID) {
				record.parseID(meshID);				
			}
			
			@Override
			public void putEnTerm(String enTerm) {
				record.name = enTerm;
				
			}
			
			@Override
			public void putCzTerm(String czTerm) {
				// TODO Auto-generated method stub
				
			}
			
			@Override
			public void newRecord() {
				record = new MeshParsedIndex.MeshIndexRecord();
				index.addRecord(record);
			}
		};
		
		
		parser.parse("c:/data/Khresmoi/czmesh/mesh2011.xml");
		
		return index;
		
	}

	public static void main(String[] args) throws ParserConfigurationException, SAXException, IOException, URISyntaxException
	{
		MeshIndex index;

/*
		MeshIndexer indexer = new MeshIndexer();
		MeshParsedIndex parsed_index = indexer.parseMesh();
		
		System.err.println("records = "+ parsed_index.records.size());
		System.err.println("treenums0 = "+ parsed_index.tree_num_index.children_by_numbers.size());
		
		String pr = parsed_index.tree_num_index.children_by_numbers.values().iterator().next().debugPrint();
		System.err.println(pr);
		
		index = new MeshIndex(parsed_index);
		index.saveToFile("src/main/resources/mesh_child_index.bin");
/**/
//		index = new MeshIndex("meshindex.dat");
		index = new MeshIndex();
		
		final String mesh_term = "D002130";
		
		System.err.println("---------------getChildren--------------------");
		int[] chemicals = index.getChildren(mesh_term);
		System.err.println(chemicals.length);
		for (int i = 0; i < chemicals.length; i++)
		{
			System.err.println(MeshIndexRecord.renderMeshID(chemicals[i]));
			
		}
	
		System.err.println("---------------getDescendnats--------------------");
		int[] chemicals_desc = index.getDescendants(mesh_term);
		System.err.println(chemicals_desc.length);
		for (int i = 0; i < chemicals_desc.length; i++)
		{
			System.err.println(MeshIndexRecord.renderMeshID(chemicals_desc[i]));
			
		}
	}
}
