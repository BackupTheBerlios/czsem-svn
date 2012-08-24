package czsem.online

class AnnotationType {
	
	String name
	
	static hasMany = [usage: AnnotationTypeUsage]
	
	public String toString() {
		return name;
	}
	
	public String getSchemaXml() {
		return String.format("<schema xmlns=\"http://www.w3.org/2000/10/XMLSchema\"><element name=\"%s\" /></schema>", name); 
	}
	

	
    static constraints = {
		name unique: true
    }
}
