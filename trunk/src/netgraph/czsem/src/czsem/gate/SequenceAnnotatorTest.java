package czsem.gate;

import junit.framework.Test;
import junit.framework.TestCase;
import junit.framework.TestSuite;

public class SequenceAnnotatorTest extends TestCase
{
	public void testNextToken1()
	{
		SequenceAnnotator sa = new SequenceAnnotator("Hallo this\nstrange  world !", 0);
		sa.nextToken("Hallo");
		assertEquals(sa.lastStart(), 0);
		assertEquals(sa.lastEnd(), 5);
		
		sa.nextToken("this");
		assertEquals(sa.lastStart(), 6);
		assertEquals(sa.lastEnd(), 10);

		sa.nextToken("strange");
		assertEquals(sa.lastStart(), 11);
		assertEquals(sa.lastEnd(), 18);

		sa.nextToken("world");
		assertEquals(sa.lastStart(), 20);
		assertEquals(sa.lastEnd(), 25);

		 
		sa.backup();
		try
		{
			sa.nextToken("?");
		}
		catch (StringIndexOutOfBoundsException e)
		{
			sa.restore();
			sa.nextToken("!");
			assertEquals(sa.lastStart(), 26);
			assertEquals(sa.lastEnd(), 27);
			
			return;
		}
		fail("Expected StringIndexOutOfBoundsException");

	}
	
	public void testNextToken2()
	{
		
		String s = "Hallo this strange  world!";
		SequenceAnnotator sa = new SequenceAnnotator(s , 0);
		sa.nextToken("Hallo this strange world !");
		assertEquals(sa.lastStart(), 0);
		assertEquals(sa.lastEnd(), s.length());		
	}

	public void testNextToken3()
	{
		String s = " Hallo this\nstrange  world!";
		SequenceAnnotator sa = new SequenceAnnotator(s, 0);
		sa.nextToken("Hallo this strange world !");
		assertEquals(sa.lastStart(), 1);
		assertEquals(sa.lastEnd(), s.length());		
	}

	public static Test suite(){
		return new TestSuite(SequenceAnnotatorTest.class);
	}



}
