package czsem.gate;

import czsem.gate.tectomt.SequenceAnnotator;
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

	public void testNextToken4()
	{
		String s = 	"The BBC's Bethany Bell in Jerusalem says many people face shortages of food, medicine and fuel. Chancellor Alistair Darling says the new longer-term agreement will guarantee earnings growth for 5.5 million workers and will allow\n"+
					"departments to plan more effectively. However, the TUC says the government's pay target of 2% has put it on \"a collision course with six million public servants\". TUC general secretary Brendan Barber said long term pay deals could be agreed but only on certain terms. \"The problem is last year we saw the government impose pay deals of only around 2%. Inflation was running at over 4%, so millions of public service workers saw themselves facing a real cut in their living standards,\" he said. Police in England, Wales and Northern Ireland are in dispute with the government over the staging of the 2.5% pay rise - in Scotland it was paid in full. Thousands of prison staff in England and Wales also walked out in August over the government's decision to give them their pay rise in two stages. Civil servants have also staged industrial action, which could be repeated, while strikes have been threatened in the NHS and local government. Meanwhile, Mr. Brown has urged MPs to limit their own salary rises to below 2% keep them in line with those of public sector workers.";
		SequenceAnnotator sa = new SequenceAnnotator(s, 0);
		sa.nextToken("The BBC's Bethany Bell in Jerusalem says many people face shortages of food, medicine and fuel.");
		assertEquals(sa.lastStart(), 0);
		assertEquals(sa.lastEnd(), 95);		
		sa.nextToken("Chancellor Alistair Darling says the new longer-term agreement will guarantee earnings growth for 5.5 million workers and will allow departments to plan more effectively.");
		assertEquals(sa.lastStart(), 96);
		assertEquals(sa.lastEnd(), 266);		
					//However, the TUC says the government's pay target of 2% has put it on "a collision course with six million public servants".
		sa.nextToken("However, the TUC says the government's pay target of 2% has put it on`` a collision course with six million public servants''.");
		assertEquals(sa.lastStart(), 267);
		assertEquals(sa.lastEnd(), 391);
		sa.nextToken("``The problem is last year we saw the government impose pay deals of only around 2%.");
		assertEquals(sa.lastStart(), 497);
		assertEquals(sa.lastEnd(), 580);
		
	}

	public void testNextToken5()
	{
		String s = 	"However, the TUC says the government's pay target of 2% has put it on \"a collision course with six million public servants\".";
		SequenceAnnotator sa = new SequenceAnnotator(s, 0);
		
		String [] tokens = {
				"However",
				",",
				"the",
				"TUC",
				"says",
				"the",
				"government",
				"'s",
				"pay",
				"target",
				"of",
				"2",
				"%",
				"has",
				"put",
				"it",
				"on``",
				"a",
				"collision",
				"course",
				"with",
				"six",
				"million",
				"public",
				"servants",
				".",
		};
				
		for (int i = 0; i < tokens.length; i++) {
			sa.nextToken(tokens[i]);
		}		
		assertEquals(sa.lastStart(), 123);
		assertEquals(sa.lastEnd(), 124);
	}
	
	public void testNextToken6()
	{
		String s = 	"Honeywell said HIS 's Federal Systems Division is now a";
		SequenceAnnotator sa = new SequenceAnnotator(s, 0);
		sa.nextToken("Honeywell");
		assertEquals(0, sa.lastStart());
		sa.nextToken("said");
		assertEquals(10, sa.lastStart());
		sa.nextToken("HIS`");
		assertEquals(15, sa.lastStart());
		sa.nextToken("s");
		assertEquals(20, sa.lastStart());
		sa.nextToken("Federal");
		assertEquals(22, sa.lastStart());
	}

	public void testNextTokenAngleBrackets()
	{
		String s = 	
 "FIRST WISCONSIN <FWB > TO BUY MINNESOTA BANK"
+"    MILWAUKEE, Wis., March 26 - First Wisconsin Corp said it"
+"plans to acquire Shelard Bancshares Inc for about 25 mln dlrs"
+"in cash, its first acquisition of a Minnesota -based bank ."
+"    First Wisconsin said Shelard is the holding company for two"
+"banks with total assets of 168 mln dlrs."
+"    First Wisconsin , which had assets at yearend of 7.1 billion"
+"dlrs, said the Shelard purchase price is about 12 times the"
+"1986 earnings of the bank."
+"    It said the two Shelard banks have a total of five offices"
+"in the Minneapolis-St. Paul area."
+" Reuter";

		SequenceAnnotator sa = new SequenceAnnotator(s, 0);
		sa.nextToken("FIRST WISCONSIN TO BUY MINNESOTA BANK MILWAUKEE, Wis., March 26- First Wisconsin Corp said it plans to acquire Shelard Bancshares Inc for about 25 mln dlrs in cash, its first acquisition of a Minnesota -based bank.");
		assertEquals(0, sa.lastStart());
		sa.nextToken("First Wisconsin said Shelard is the holding company for two banks with total assets of 168 mln dlrs.");
		assertEquals(228, sa.lastStart());
		sa.nextToken("First Wisconsin, which had assets at yearend of 7.1 billion dlrs, said the Shelard purchase price is about 12 times the 1986 earnings of the bank.");
		assertEquals(331, sa.lastStart());
	}


	public void testNextTokenAngleBrackets2()
	{
		String s = "FIRST WISCONSIN <FWB > TO BUY MINNESOTA BANK";

		SequenceAnnotator sa = new SequenceAnnotator(s, 0);
		sa.nextToken("FIRST");
		assertEquals(0, sa.lastStart());
		sa.nextToken("WISCONSIN");
		assertEquals(6, sa.lastStart());
		assertEquals(15, sa.lastEnd());
		sa.nextToken("TO");
		assertEquals(23, sa.lastStart());
		assertEquals(25, sa.lastEnd());
		sa.nextToken("BUY");
		assertEquals(26, sa.lastStart());		
	}
	
	

	public static Test suite(){
		return new TestSuite(SequenceAnnotatorTest.class);
	}



}
