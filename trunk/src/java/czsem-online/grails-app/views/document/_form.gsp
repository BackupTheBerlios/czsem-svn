<%@ page import="czsem.online.Document" %>



<div class="fieldcontain ${hasErrors(bean: documentInstance, field: 'page', 'error')} required">

<object type="application/x-java-applet" height="400" width="100%" >
        <param name="code" value="czsem.gate.applet.GateApplet" />
        <param name="archive" value="${resource(dir: 'applet', file: 'gate-applet-1.0-signed.jar')}" />
        <param name="gateDocumentUrl" value="${createLink(action: 'xml', absolute: true, id: documentInstance.id)}"/>
        <param name="defaultAnnotationSet" value=""/>
        Applet failed to run.  No Java plug-in was found.
</object>

<!-- 
	<label for="page">
		<g:message code="document.page.label" default="Page" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="page" name="page.id" from="${czsem.online.Page.list()}" optionKey="id" required="" value="${documentInstance?.page?.id}" class="many-to-one"/>
-->
</div>

