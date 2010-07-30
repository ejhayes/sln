<!--- 
Friendly Date Parse:
Displays a date in a human readable format as it is relative to the current time:

Within an hour:
x minutes ago

Within the day (<24 hours):
x hours ago

Within 2 weeks (<14 days):
x days ago

Within the year:
mmm/dd

Older:
m/d/yy

--->
<cfcomponent>
<cffunction name="relativeDate" access="public" returntype="string" hint="Returns a string of the date relative to now">
	<cfargument name="dt" type="date" required="yes">
	
	<cfset var time=now() />
	<cfset var mins = datediff('n',dt,time) />
	<cfset var hours = datediff('h',dt,time) />
	<cfset var days = datediff('d',dt,time) />
	
	<cfif mins EQ 1>
		<cfreturn "1 minute ago" />
	<cfelseif mins LT 60>
		<cfreturn mins & " minutes ago" />
	</cfif>
	
	<cfif hours EQ 1>
		<cfreturn "1 hour ago" />
	<cfelseif hours LT 24>
		<cfreturn hours & " hours ago" />
	</cfif>
	
	<cfif days EQ 1>
		<cfreturn "1 day ago" />
	<cfelseif days LT 14>
		<cfreturn days & " days ago" />
	</cfif>
	
	<cfif year(time) EQ year(dt)>
		<cfreturn DateFormat(dt, "mmm d")  />
	<cfelse>
		<cfreturn DateFormat(dt, "m/d/yy") />
	</cfif>

</cffunction>

</cfcomponent>