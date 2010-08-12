<cfset helper = new assets.cfc.helpers() />

<h3>Enter a Special Use Number to edit (or create a <a href="<cfoutput>#buildURL('registration.app')#</cfoutput>">new one</a>)</h3>

<form action="<cfoutput>#buildURL('registration.app')#</cfoutput>" method="post">
    <input name="specialUseNumber" type="text" />
    <input name="edit" type="submit" value="Edit" />
</form>

<br />

<h3>Statistics at a Glance</h3>
<ul>
<li>There are <a href="#"><cfoutput>#rc.data.totalActiveRecords#</cfoutput> active applications</a>.</li>
<li>There are <a href="#">2 active applications with inactive products</a>.</li>
</ul>

<cfif ArrayLen(rc.data.incomplete) GT 0>
<h3>There are <cfoutput>#ArrayLen(rc.data.incomplete)#</cfoutput> Incomplete Applications</h3>
<p>
The following applications do not currently have a special use number associated with them.
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