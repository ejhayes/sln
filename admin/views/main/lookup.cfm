<cfset request.layout="no" /><cfcontent reset="yes" type="text/plain" /><cfif rc.data NEQ ""><cfoutput query="rc.data">#CODE#=#DESCRIPTION#
</cfoutput></cfif><!--- Displays the page in a format that can be used by the multiselect box --->