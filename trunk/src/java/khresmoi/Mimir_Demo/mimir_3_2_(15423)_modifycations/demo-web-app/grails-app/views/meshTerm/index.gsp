<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
	<style>
		*{margin:0;padding:0}
		html, body {height:100%;width:100%;overflow:hidden}
		table {height:100%;width:100%;table-layout:static;border-collapse:collapse}
		iframe {height:100%;width:100%}
		
		.header {border-bottom:1px solid #000}
		.content {height:92%}
	</style>
	<link rel="stylesheet" href="${resource(dir:'css',file:'main.css')}" />
	<gui:resources components="autoComplete"/>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
	<meta name="layout" content="meshterm" />

	<title>Mímir BMČ MeSH term query builder</title>
</head>
<body>
	<table>
		<tr>
			<td class="header">
    			<table>
			    	<tr>
				    	<td>MeSH ID:</td>
				    	<td>English Term:</td>
				    	<td>Czech Term:</td>
				    	<td>Description:</td>
			    	</tr>
			    	<tr>
			    		<% def maxResults = 30 %>
				    	<td>
				    		<gui:autoComplete
				    			id="meshIDAutocmplete"
				    			controller="meshTerm"
				    			action="autoComplete"
				    			value="${meshTerm.meshID}"
				    			params="${[filter:'meshID']}"
				    			labelField="meshID"
				    			idField="meshID"
				    			maxResultsDisplayed="${maxResults}"
				    		/>
				    	</td>
				    	<td>
				    		<gui:autoComplete
				    			id="enTermAutocmplete"
				    			controller="meshTerm"
				    			action="autoComplete"
				    			value="${meshTerm.enTerm}"
				    			params="${[filter:'enTerm']}"
				    			labelField="enTerm"
				    			idField="meshID"
				    			maxResultsDisplayed="${maxResults}"    		
				    		/>
				    	</td>
				    	<td>
				    		<gui:autoComplete
				    			id="czTermAutocmplete"
				    			controller="meshTerm"
				    			action="autoComplete"
				    			value="${meshTerm.czTerm}"
				    			params="${[filter:'czTerm']}"
				    			labelField="czTerm"
				    			idField="meshID"
				    			maxResultsDisplayed="${maxResults}"    		
				    		/>
				    	</td>
				    	<td>
				    		<a href="http://www.nlm.nih.gov/cgi/mesh/2011/MB_cgi?term=${meshTerm.enTerm}">${meshTerm.enTerm} <br> (MeSH Browser at nlm.nih.gov)</a>
				    	</td>
			    	</tr>
		    	</table>	    	

				<script>
				    YAHOO.util.Event.onDOMReady(function() {
				        function selectHandler(type , args){
				            var selectedID = args[2][1];
				//            alert(selectedID);
				            window.location = "${createLink(action: 'index')}?indexID=${index.indexId}&id=" + selectedID;
				        }
				        GRAILSUI.meshIDAutocmplete.itemSelectEvent.subscribe(selectHandler);
				        GRAILSUI.enTermAutocmplete.itemSelectEvent.subscribe(selectHandler);
				        GRAILSUI.czTermAutocmplete.itemSelectEvent.subscribe(selectHandler);
				    });
				</script>
			
			</td></tr>
		<tr>
			<td class="content">
			  	<iframe frameborder="0"
			  		width="99%" 
			  		height="90%" 
			  		src='${resource(dir: index.indexId)}/search/gus?queryString={MeshTerm meshID="${meshTerm.meshID}" descendants=0}'
			  	>
			  	</iframe>
			</td>
       </tr>	
	</table>
</body>
</html>