
<%@ page import="czsem.online.Document" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'document.label', default: 'Document')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-document" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-document" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list document">
			
				<g:if test="${documentInstance?.page}">
				<li class="fieldcontain">
					<span id="page-label" class="property-label"><g:message code="document.page.label" default="Page" /></span>
					
						<span class="property-value" aria-labelledby="page-label"><g:link controller="page" action="show" id="${documentInstance?.page?.id}">${documentInstance?.page?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
				<li class="fieldcontain">
					<span id="doc-label" class="property-label"><g:message code="document.doc.label" default="Doc" /></span>
					
						<span class="property-value" aria-labelledby="doc-label">
						<%
							out.print(((gate.Document) documentInstance.doc).getContent().toString())						
						 %>
						</span>
				</li>
				
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${documentInstance?.id}" />
					<g:link class="edit" action="edit" id="${documentInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
