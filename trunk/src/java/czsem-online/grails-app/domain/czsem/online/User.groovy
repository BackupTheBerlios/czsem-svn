package czsem.online

class User {
	
	String publicNick
	
	static hasMany = [annotations: AnnotationTypeUsage]

    static constraints = {
		publicNick unique: true 
    }
}
