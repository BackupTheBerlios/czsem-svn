package czsem.online

class Document {
	
	gate.Document doc;
	
	static belongsTo = [page:Page]
	
	static mapping = {
		doc column: "doc", sqlType: "binary", length: 50 * 1024 * 1024 // 50MBs
	}

    static constraints = {		
		doc require: true
		
		page unique: true
    }
}
