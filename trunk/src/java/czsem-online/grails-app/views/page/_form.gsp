<%@ page import="czsem.online.Page" %>



<div class="fieldcontain ${hasErrors(bean: pageInstance, field: 'url', 'error')} ">
	<label for="url">
		<g:message code="page.url.label" default="Url" />
		
	</label>
	<g:field type="url" name="url" size="50" value="${pageInstance?.url ? pageInstance?.url : 'http://'}" />
</div>

