package czsem.online

class User {
	
	String publicNick
	
	static hasMany = [annotations: AnnotationTypeUsage]
	
	public String toString() {
		return publicNick;
	}

    static constraints = {
		publicNick unique: true 
    }
}
