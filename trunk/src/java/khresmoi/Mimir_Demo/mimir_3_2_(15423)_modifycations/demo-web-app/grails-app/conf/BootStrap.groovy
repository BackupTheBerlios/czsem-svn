import org.codehaus.groovy.grails.commons.ApplicationHolder;
import czsem.MeshTerm;

/*
 *  BootStrap.groovy
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
class BootStrap {
	
	static def defaultMeshTermCount = 26142
	

    def init = { servletContext ->
		
		println "MeshTrems bootstrap - mesh term count: " + MeshTerm.count()
		
		if (MeshTerm.count() != defaultMeshTermCount)
		{
			MeshTerm.executeUpdate("delete MeshTerm")
			
			
			def filePath = "resources/meshcz.lst"
			
			def stream = ApplicationHolder.application.parentContext
				.getResource("classpath:$filePath").inputStream
						
			def reader = new BufferedReader(stream.newReader("UTF-8"))
			def i = 0
			for(def line : reader) {
				i++
				if(i> 20) {
			//        break
				}
				
				def parts = line.split("[:=]")
				def czTerm = parts[0]
				def enTerm = parts[4]
				def meshID = parts[2]
				
				def term = new MeshTerm(czTerm: czTerm, enTerm: enTerm, meshID: meshID)
				if (i % 500 == 0) println "MeSH import progress: " + i + "/"+defaultMeshTermCount +" "+ term.czTerm +" "+ term.enTerm +" "+ term.meshID
				term.save()
			}
			
		}
    }
    def destroy = {
    }
}
