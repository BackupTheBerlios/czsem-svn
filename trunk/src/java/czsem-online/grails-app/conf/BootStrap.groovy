import czsem.online.Page
import czsem.online.helpers.CzsemBootStrap;


class BootStrap {

    def init = { servletContext ->
		CzsemBootStrap.bootStrap()
		
		new Page('http://google.com').save(flush: true)
    }
    def destroy = {
    }
}
