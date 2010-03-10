package czsem.gate;

import gate.Document;

public class SequenceAnnotator
{
	private String string_content;
	private int last_index;
	private int last_length=0;
	private int correction=0;

	private int backup_last_index;
	private int backup_last_length=0;
	
	public long lastStart() {return last_index-last_length;}
	public long lastEnd() {return last_index;}
	
	public void backup()
	{
		backup_last_index = last_index;		
		backup_last_length = last_length;		
	}
	
	public void restore()
	{
		last_index = backup_last_index ;		
		last_length = backup_last_length;		
	}
	
	public SequenceAnnotator(Document doc)
	{
		this(doc, 0);
	}

	public SequenceAnnotator(Document doc, int start_index)
	{
		last_index = start_index;
		string_content = doc.getContent().toString();		
	}
	
	public void nextToken(String token)
	{
		correction=0;
		int new_index = indexOf(token);
//		int new_index = string_content.indexOf(token, last_index);
		if (new_index == -1) 
			throw new StringIndexOutOfBoundsException(string_content.substring(last_index, last_index + token.length()));
		
		if (new_index - last_index > 5)
		{
			System.err.println("WARNING big space in annotations dedtected!");
			System.err.print("last_index:");
			System.err.print(last_index);
			System.err.print(" new_index:");
			System.err.print(new_index);
			System.err.print(" diff:");
			System.err.println(new_index-last_index);
		}
		
		last_length = token.length() + correction;
		last_index = new_index + last_length; 
	}
	private int indexOf(String token) {
//		int new_index = string_content.indexOf(token, last_index);
		int token_index, local_mv;
		for (int local_index=last_index; ; local_index++)
		{
			try {
				for (token_index=0, local_mv=local_index; token_index<token.length(); local_mv++, token_index++)
				{
					if (local_mv>=string_content.length()) 
						return -1;
					
					char loc_ch = string_content.charAt(local_mv);
					char toc_ch = token.charAt(token_index);
					
					if (loc_ch != toc_ch)
					{
						if (token_index > 0)
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
				correction = local_mv - local_index - token.length();
				System.out.print("correction: ");
				System.out.println(correction);
				return local_index;
			} catch (Throwable e) {/*contine*/} 			
		}		
	}		
}
