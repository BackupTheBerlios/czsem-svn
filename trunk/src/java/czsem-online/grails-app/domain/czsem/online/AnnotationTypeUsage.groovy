package czsem.online

class AnnotationTypeUsage {
	int timesUsed
	
	static belongsTo = [page:Page, annotType:AnnotationType, user:User]
	
    static constraints = {
		annotType unique: true
		user unique: true
    }
}
