package czsem.online

class AnnotationType {
	
	String name
	
	static hasMany = [usage: AnnotationTypeUsage]
	

    static constraints = {
		name unique: true
    }
}
