package czsem.online

import czsem.online.helpers.PageCreator
import org.springframework.dao.DataIntegrityViolationException

class PageController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [pageInstanceList: Page.list(params), pageInstanceTotal: Page.count()]
    }

    def create() {
        [pageInstance: new Page(params)]
    }

    def save() {

		def pageInstance
		try {
        	pageInstance = new Page(params.url)
		} catch(Exception e)
		{
			pageInstance = new Page(params)
			pageInstance.errors.rejectValue("url", "default.optimistic.locking.failure",
				[message(code: 'page.url', default: 'Url')] as Object[],
				e.getLocalizedMessage())
			render(view: "edit", model: [pageInstance: pageInstance])
			return
			
		}
        if (!pageInstance.save(flush: true)) {
            render(view: "create", model: [pageInstance: pageInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'page.label', default: 'Page'), pageInstance.id])
        redirect(action: "show", id: pageInstance.id)
    }

    def show() {
        def pageInstance = Page.get(params.id)
        if (!pageInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'page.label', default: 'Page'), params.id])
            redirect(action: "list")
            return
        }

        [pageInstance: pageInstance]
    }

    def edit() {
        def pageInstance = Page.get(params.id)
        if (!pageInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'page.label', default: 'Page'), params.id])
            redirect(action: "list")
            return
        }

        [pageInstance: pageInstance]
    }

    def update() {
        def pageInstance = Page.get(params.id)
        if (!pageInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'page.label', default: 'Page'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (pageInstance.version > version) {
                pageInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'page.label', default: 'Page')] as Object[],
                          "Another user has updated this Page while you were editing")
                render(view: "edit", model: [pageInstance: pageInstance])
                return
            }
        }

        pageInstance.properties = params

        if (!pageInstance.save(flush: true)) {
            render(view: "edit", model: [pageInstance: pageInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'page.label', default: 'Page'), pageInstance.id])
        redirect(action: "show", id: pageInstance.id)
    }

    def delete() {
        def pageInstance = Page.get(params.id)
        if (!pageInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'page.label', default: 'Page'), params.id])
            redirect(action: "list")
            return
        }

        try {
            pageInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'page.label', default: 'Page'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'page.label', default: 'Page'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
