package czsem.khresmoi;

import java.io.IOException;
import java.net.URISyntaxException;
import java.util.Arrays;
import java.util.List;

import czsem.khresmoi.MeshIndexer.MeshIndex;
import czsem.khresmoi.MeshIndexer.MeshParsedIndex.MeshRecord;
import junit.framework.TestCase;

public class MeshIndexerTest extends TestCase {

	public void testMeshIndex() throws IOException, URISyntaxException
	{
		assertEquals("D002130", MeshRecord.renderMeshID(2130));
		assertEquals(2130, MeshRecord.parseMeshID("D002130"));
		
		boolean asserions_enabled = false;
		
		try {assert(false);}catch (java.lang.AssertionError e) {asserions_enabled = true;}
		
		try {
			assertEquals(2130, MeshRecord.parseMeshID("D02130"));
			if (asserions_enabled) fail(); //should throw AssertionError 
		}
		catch (java.lang.AssertionError e)
		{
			//ok
		}
		
		MeshIndex index = new MeshIndex();
		
		assertNotNull(index);
		
		final String mesh_term = "D002130";
		
		//System.err.println("---------------getChildren--------------------");
		int[] chemicals = index.getChildren(mesh_term);
		
		Integer [] a_children = {2131, 1031};
		Integer [] a_descendants = {2131, 6882, 17886, 1031};
		
		List<Integer> children = Arrays.asList(a_children);		
		List<Integer> descendants = Arrays.asList(a_descendants);
		
		assertEquals(2, chemicals.length);
		for (int i = 0; i < chemicals.length; i++)
		{
			assertTrue(children.contains(chemicals[i]));
		}
	
		//System.err.println("---------------getDescendnats--------------------");
		int[] chemicals_desc = index.getDescendants(mesh_term);
		for (int i = 0; i < chemicals.length; i++)
		{
			assertTrue(descendants.contains(chemicals_desc[i]));
		}			

	}

}
