package czsem.online

import czsem.online.helpers.PageCreator


class Page {
	
	String url	
	String title
	Date date	
	static hasOne = [content: Document]	
	static hasMany = [annotations: AnnotationTypeUsage]
		
    static constraints = {
		url(unique: true, url: true)
    }
	
	public Page () {}
	

	/**
	 * Creates new Page and Document objects.
	 * @return created Page instance
	 */
	public Page (PageCreator pc)
	{
		this(pc.getParams());
		
		content = new Document(doc: pc.getDoc())
	}
	
	public Page (String url)
	{
		this (new PageCreator(url))
	}
}
