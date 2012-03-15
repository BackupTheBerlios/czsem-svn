/*
 *  MimirUrlMappings.groovy
 *
 *  Copyright (c) 2007-2011, The University of Sheffield.
 *
 *  This file is part of GATE Mímir (see http://gate.ac.uk/family/mimir.html), 
 *  and is free software, licenced under the GNU Affero General Public License,
 *  Version 3, November 2007 (also included with this distribution as file 
 *  LICENCE-AGPL3.html).
 *
 *  A commercial licence is also available for organisations whose business
 *  models preclude the adoption of open source and is subject to a licence
 *  fee charged by the University of Sheffield. Please contact the GATE team
 *  (see http://gate.ac.uk/g8/contact) if you require a commercial licence.
 *
 *  $Id$
 */
 
 class MimirUrlMappings {
  static mappings = {
    // static view mappings
    "/"(controller:"meshTerm", action:"index")

//	"/"(controller:"mimirStaticPages", action:"index")
    "/mimirStaticPages/$action?"(controller:"mimirStaticPages")
    
	"500"(controller:"mimirStaticPages", action:"error")
	
    "/meshTerm/$action?"(controller:"meshTerm")
//	"/meshTermQuery"(controller:"meshTerm", action:"index")
	
	//	"/$indexId/bmc_search"(controller:"gusBmc", action:"index")
	
/**/
    // Searching
    //
    // action names that do not start "gus" are mapped to the search
    // controller (the XML search service and the back-end used by
    // RemoteQueryRunner)
    "/$indexId/search/$action?"(controller:"search", parseRequest:true) {
      constraints { action(matches:/^(?!gus).*$/) }
    }

    // action names that start "gus" are mapped to the GUS demo web UI
    "/$indexId/search/$action?/$id?"(controller:"gus") {
      constraints { action(matches:/^gus.*$/) }
    }
    
    name gusMapping: "/$indexId/search/gus" {
        controller = "gus"
        action = "gus"
    }


    // the top-level "index URL" for a given index *must* be mapped to this
    // action (the plugin assumes this and uses it to generate reverse
    // mappings).
    "/$indexId"(controller:"indexManagement", action:"index")

    // Index management actions (adding documents, closing index, etc.)
    "/$indexId/manage/$action?"(controller:"indexManagement")

    // admin-only actions - CRUD controllers plus index administration

	/***/
	
    "/admin"(controller:"mimirStaticPages", action:"admin")
    "/admin/$controller/$action?/$id?"{
      constraints {
        controller(inList:[
          "federatedIndex",
          "localIndex",
          "remoteIndex",
          "indexTemplate"
        ])
      }
    }
    "/admin/actions/$indexId/$action?"(controller:"indexAdmin")

  
    /*****/
  }  
}
