package czsem.gate;

import java.io.IOException;

import javax.xml.parsers.ParserConfigurationException;
import javax.xml.xpath.XPathExpressionException;

import org.xml.sax.SAXException;

import gate.Document;
import gate.util.GateException;

public class SequenceAnnotator
{
	private String string_content;
	private int last_start_index;
	private int last_length=0;
	private int correction=0;

	private int backup_last_index;
	private int backup_last_length=0;
	
	public long lastStart() {return last_start_index-last_length;}
	public long lastEnd() {return last_start_index;}
	
	public void backup()
	{
		backup_last_index = last_start_index;		
		backup_last_length = last_length;		
	}
	
	public void restore()
	{
		last_start_index = backup_last_index ;		
		last_length = backup_last_length;		
	}
	
	public SequenceAnnotator(Document doc)
	{
		this(doc, 0);
	}

	public SequenceAnnotator(Document doc, int start_index)
	{
		this(doc.getContent().toString(), start_index);
	}
	
	public SequenceAnnotator(String stringContent, int start_index) {
		string_content = stringContent;
		last_start_index = start_index;
	}
	
	
	public void nextToken(String token)
	{
		correction=0;
		int new_index = indexOf(token);
//		int new_index = string_content.indexOf(token, last_index);
		if (new_index == -1) 
			throw new StringIndexOutOfBoundsException(string_content.substring(last_start_index, last_start_index + token.length()));
		
		if (new_index - last_start_index > 5)
		{
			System.err.println("WARNING big space in annotations dedtected!");
			System.err.print("last_index:");
			System.err.print(last_start_index);
			System.err.print(" new_index:");
			System.err.print(new_index);
			System.err.print(" diff:");
			System.err.println(new_index-last_start_index);
		}
		
		last_length = token.length() + correction;
		last_start_index = new_index + last_length; 
	}
	private int indexOf(String token) {
//		int new_index = string_content.indexOf(token, last_index);
		int token_index, local_index;

		//moves start
		for (int local_start_index=last_start_index; ; local_start_index++)
		{
			try {
				//checks strings
				for (token_index=0, local_index=local_start_index; token_index<token.length(); local_index++, token_index++)
				{
					if (local_index>=string_content.length()) 
						return -1;
					
					char loc_ch = string_content.charAt(local_index);
					char toc_ch = token.charAt(token_index);
					
					if (loc_ch != toc_ch)
					{
						if (token_index > 0) //otherwise move start
						{
							if (Character.isWhitespace(loc_ch)) token_index--;
							else
							if (Character.isWhitespace(toc_ch)) local_index--;
							else 
							throw new Throwable();
						}
						else throw new Throwable();
					}					
				}
				correction = local_index - local_start_index - token.length();
				if (correction != 0)
				{
					System.out.print("correction: ");
					System.out.println(correction);					
				}
				return local_start_index;
			} catch (Throwable e) {/*contine*/} 			
		}		
	}		

	public static void main(String[] args)
	{
		
		SequenceAnnotator sa = new SequenceAnnotator("Hallo this\nstrange world !", 0);

		sa.backup();
		
		System.err.println("1");
		try {sa.nextToken("xxx");} catch(StringIndexOutOfBoundsException e) {System.err.println(e.getMessage());}
		System.err.println("2");
		sa.restore();
		sa.nextToken("Hallo this");
		System.err.println("3");
		sa.restore();
		
		
	}

}
