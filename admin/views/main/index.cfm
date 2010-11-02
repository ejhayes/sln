<cfset helper = new assets.cfc.helpers(this.config) />

<div class="criteria">
    <h3>Enter a Special Use Number to edit (or create a <a href="<cfoutput>#buildURL('registration.app')#</cfoutput>">new one</a>)</h3>
    <form action="<cfoutput>#buildURL('registration.app')#</cfoutput>" method="post">
        <input name="specialUseNumber" type="text" />
        <input name="edit" type="submit" value="Edit" />
    </form>
</div>

<h3>Statistics at a Glance</h3>
<ul>
<cfoutput>
<li>There are 
    <a href="#buildURL('search:main.search&status=A&status=I')#">#rc.data.totalRecords# total #helper.pluralize(rc.data.totalRecords,"application")#</a>, 
    <a href="#buildURL('search:main.search&status=P')#">#rc.data.totalPendingRecords# pending #helper.pluralize(rc.data.totalPendingRecords,"application")#</a>, 
    <a href="#buildURL('search:main.search&status=A')#">#rc.data.totalActiveRecords# active #helper.pluralize(rc.data.totalActiveRecords,"application")#</a>, 
    <a href="#buildURL('search:main.search&status=I')#">#rc.data.totalInactiveRecords# inactive #helper.pluralize(rc.data.totalInactiveRecords,"application")#</a>, and
    <a href="#buildURL('search:main.search&status=D')#">#rc.data.totalDeniedRecords# denied #helper.pluralize(rc.data.totalDeniedRecords,"application")#</a>, .
</li>
</cfoutput>
</ul>

<!--- Recently Updated Applications --->
<cfif ArrayLen(rc.data.recent) GT 0>
<h3>Recent Activity</h3>
<table width="100%">
    <thead> 
        <tr> 
            <th>Updated</th> 
            <th>Application</th> 
            <th>Status</th>
            <th>Issue Date</th> 
            <th>Expiration Date</th> 
            <th>Revisions</th>
        </tr> 
    </thead> 
    <tbody>
        <cfloop array="#rc.data.recent#" index="i">
        <cfoutput>
        <tr> 
            <td>#helper.relativeDate(i.getUpdated())# by #REReplaceNoCase(i.getUpdatedBy(),"DPRNTDOM\\","")#</td> 
            <td><a href="#buildURL(action='registration.app&id=' & i.getId())#">#i.getOfficialName()#</a></td> 
            <td>#i.getStatus().getDescription()#</td> 
            <td>#DateFormat(i.getIssued(),"m/d/yy")#</td> 
            <td>#DateFormat(i.getExpired(),"m/d/yy")#</td> 
            <td>#ArrayLen(i.getRevisions())#</td>
        </tr> 
        </cfoutput>
        </cfloop>
    </tbody> 
</table> 
</cfif>
<br />
<!--- Incomplete Applications --->
<cfif ArrayLen(rc.data.incomplete) GT 0>
<h3>There <cfoutput>#helper.pluralize(ArrayLen(rc.data.incomplete),"is","are")# #ArrayLen(rc.data.incomplete)# Incomplete #helper.pluralize(ArrayLen(rc.data.incomplete),"Application")#</cfoutput></h3>
<p>
The following <cfoutput>#helper.pluralize(ArrayLen(rc.data.incomplete),"application does","applications do")# not currently have a special use number associated with #helper.pluralize(ArrayLen(rc.data.incomplete),"it","them")#</cfoutput>.
</p>
<table width="100%">
    <thead> 
        <tr> 
            <th>Type</th> 
            <th>Issue Date</th> 
            <th>Expiration Date</th> 
            <th>Status</th> 
            <th>Updated</th>
            <th>Revisions</th>
            <th>Actions</th> 
        </tr> 
    </thead> 
    <tbody>
        <cfloop array="#rc.data.incomplete#" index="i">
        <cfoutput>
        <tr> 
            <td>#i.getRegistrationType().getDescription()#</td> 
            <td>#DateFormat(i.getIssued(),"m/d/yy")#</td> 
            <td>#DateFormat(i.getExpired(),"m/d/yy")#</td> 
            <td>#i.getStatus().getDescription()#</td> 
            <td>#helper.relativeDate(i.getUpdated())# by #REReplaceNoCase(i.getUpdatedBy(),"DPRNTDOM\\","")#</td> 
            <td>#ArrayLen(i.getRevisions())#</td>
            <td><a href="<cfoutput>#buildURL(action='registration.app&id=' & i.getId())#</cfoutput>">Open</a></td>
        </tr> 
        </cfoutput>
        </cfloop>
    </tbody> 
</table> 
</cfif>