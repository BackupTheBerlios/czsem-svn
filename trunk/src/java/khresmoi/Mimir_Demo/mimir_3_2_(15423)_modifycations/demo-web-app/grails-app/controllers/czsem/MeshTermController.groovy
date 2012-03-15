package czsem

import gate.mimir.web.Index;
import gate.mimir.web.LocalIndex;
import grails.converters.JSON

class MeshTermController {
	
	static def defaultIndexID = "bmc_final"
	static def defaultMeshID = "D006262"
	
    def index = {
/*		
		println("---------------------------")
		println("---------------------------")
		println("---------------------------")
		println("---------------------------")
		println(params)
/***/		
		if (params.id != null && params.indexID != null) 
		{
			def index = LocalIndex.findByIndexId(params.indexID)
			def t = MeshTerm.findByMeshID(params.id) 
			[index: index, meshTerm: t]
		}
		else
		{
			redirect(params:[id: defaultMeshID, indexID: defaultIndexID])			
		}		 
	}
	
	
	def autoComplete = {		
		
		def c = MeshTerm.createCriteria()
		
		def meshTerms = c {
			ilike(params.filter, params.query+"%")
			maxResults(30)
			order(params.filter, "asc")
		}
		
		
/*		def meshTerms = MeshTerm.executeQuery(
			"FROM MeshTerm WHERE "+params.filter+" ilike ?",
			[params.query+"%"], [max:30])
		
		 //.findAllByEnTermLike(params.query+"%", [max:50])
*/		
						
		def result = [
			result: meshTerms
		]
		render result as JSON
	}
	
/*
		def ser = {
		def queryString = "{MeshTerm}"
//		println "/"+indexID+"/search/gus"
		redirect(uri: "/"+indexID+"/search/gus?" + "queryString="+queryString)
		redirect(
			mapping: "gusMappingx",
			controller: "gus", 
			action: "gus", 
			params:[indexID: indexID, queryString:"Stephen King"])
	}
/***/			
}
