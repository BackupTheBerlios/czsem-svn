package czsem.online

import czsem.online.helpers.PageCreator
import czsem.online.helpers.DocumentHandler


class Page {
	
	String url	
	String title
	Date date	
	static hasOne = [content: Document]	
	static hasMany = [annotations: AnnotationTypeUsage]
		
    static constraints = {
		url(unique: true, url: true, reuire: true)
		date(reuire: true)
    }
	
	public String toString() {
		String strip1 = url.replaceFirst("^http://", "");
		String ret = strip1; 
		if (strip1.length() > 20)
		{
			int subst = strip1.length() - 20 -3;
			int start_sub = strip1.length()/2 - subst/2;
			int end_sub = start_sub + subst;
			
			ret = strip1.substring(0, start_sub) + "..." + strip1.substring(end_sub, strip1.length());  
			
		}
		return ret;
	}
		
	
	public boolean createDocument()
	{
		try {
	
			gate.Document doc = DocumentHandler.documentFromUrl(url);
			
			date = new Date();
			
			title = DocumentHandler.extractTitle(doc);
	
			content = new Document(doc: doc)
			return true;
			
		} catch (Exception e)
		{
			this.errors.rejectValue("url", String.format("Cannot create document for url '%s', reason: %s", url, e.getLocalizedMessage()))
			return false;
		}
	}	
}
