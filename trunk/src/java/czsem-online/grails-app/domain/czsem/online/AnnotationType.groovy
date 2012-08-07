package czsem.online

class AnnotationType {
	
	String name
	
	static hasMany = [usage: AnnotationTypeUsage]
	
	public String toString() {
		return name;
	}

	
    static constraints = {
		name unique: true
    }
}
