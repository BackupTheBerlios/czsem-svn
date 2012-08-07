import czsem.online.Page
import czsem.online.helpers.CzsemBootStrap;


class BootStrap {

    def init = { servletContext ->
		CzsemBootStrap.bootStrap()
				
		def p = new Page(url:'http://google.com');
		p.createDocument();
		p.save(flush: true)
    }
    def destroy = {
    }
}
