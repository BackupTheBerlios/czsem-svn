package czsem.gate.tectomt;

import org.apache.log4j.Logger;

import gate.Document;

public class SequenceAnnotator
{
	static Logger logger = Logger.getLogger(SequenceAnnotator.class);
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
	
	
	public void nextToken(String token) throws StringIndexOutOfBoundsException
	{
		correction=0;
		int new_index = indexOf(token);
//		int new_index = string_content.indexOf(token, last_index);
		if (new_index == -1) 
			throw new StringIndexOutOfBoundsException(string_content.substring(last_start_index, last_start_index + token.length()));
		
		if (new_index - last_start_index > 5)
		{
			logger.warn(
					String.format(
							"Big space in annotations dedtected! "+
							"last_index: %d, new_index: %d, diff: %d",
							last_start_index, new_index, new_index-last_start_index));
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
						//quotation correction
						if (loc_ch == '"' && (toc_ch == '\'' || toc_ch == '`'))
						{
							if (token_index+1<token.length() && token.charAt(token_index+1)==toc_ch)
								token_index++;
						}
						else
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
					logger.debug("correction: " + correction);
				}
				return local_start_index;
			} catch (Throwable e) {/*contine*/} 			
		}		
	}		

}
