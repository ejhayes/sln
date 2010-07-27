<h3>Details</h3>
<cfform action="#buildURL('registration.save')#">
    <table>
    <tr><td><label>Status: </label></td></td><td><cfselect name="statusType" query="rc.data.statuses" value="code" display="description" selected="#rc.data.app.getStatus().getCode()#" /></td></tr>
    <tr><td><label>Special Use Number: </label></td></td><td><cfinput name="specialUseNumber" type="text" value="#rc.data.app.getSpecialUseNumber()#" /></td></tr>
    <tr><td><label>Special Use Type: </label></td></td><td><cfselect name="statusType" query="rc.data.registrationTypes" value="code" display="description" selected="#rc.data.app.getRegistrationType().getCode()#" /></td></tr>
    <tr><td><label>Issue Date: </label></td></td><td><cfinput class="datepicker" name="issueDate" type="text" value="#rc.data.app.getIssued()#" /></td></tr>
    <tr><td><label>Expiration Date: </label></td></td><td><cfinput class="datepicker" name="expirationDate" type="text" value="#rc.data.app.getExpired()#" /></td></tr>
    <table>
    <br />
    <table width="100%">
        <tbody>
            <tr>
                <td><h3>Internal Comments</h3></td>
                <td><h3>Public Comments</h3></td>
            </tr>
            <tr>
                <td><textarea style="width:98%;height:150px"><cfoutput>#rc.data.app.getInternalComments()#</cfoutput></textarea></td>
                <td><textarea style="width:98%;height:150px"><cfoutput>#rc.data.app.getPublicComments()#</cfoutput></textarea></td>
            </tr>
        </tbody>
    </table>
    
    <br />
    <cfif rc.application EQ "NEW">
        <cfinput type="submit" name="create" value="Create Application" />
    <cfelse>
        <cfinput type="submit" name="update" value="Update Application" />
    </cfif>
    <cfinput type="button" name="viewReport" value="View Report" onclick="javascript:window.location='generateReport.cfm?appId=2'"/>
    <cfinput type="button" name="cancel" value="Close" onclick="javascript:window.location='.'"/>
</cfform>
<br /><br />
<cfif rc.application NEQ "NEW">
<cfif rc.data.app.hasRevisions() >
<h3>Revisions</h3>
<p>
<table width="70%"> 
    <thead> 
        <tr> 
            <th>Revision Number</th> 
            <th>Tracking ID</th> 
            <th>Last Updated</th> 
            <th>Actions</th> 
        </tr> 
    </thead> 
    <tbody>
        <cfloop array="#rc.data.app.getRevisions()#" index="i">
        <tr> 
            <td>2</td> 
            <td><a href="http://registration/track/reports/trackid_action.cfm?RequestTimeout=500&track_id=<cfoutput>#i.getCorrespondence().getCode()#</cfoutput>" target="_blank"><cfoutput>#i.getCorrespondence().getCode()#</cfoutput></a></td> 
            <td><cfoutput>#DateFormat(i.getUpdated(),"m/d/yyyy")# by #i.getUpdatedBy()#</cfoutput></td> 
            <td><a href="<cfoutput>#buildURL("registration.rev&revision=" & i.getId())#</cfoutput>">Edit</a></td>
        </tr>
        </cfloop>
    </tbody> 
</table> 
</p><br />
<cfform action="editRevision.cfm?revisionId=2">
    <label><strong>Create a new revision from Tracking ID</strong>: </label><cfinput name="trackingId" type="text" />
    <cfinput type="submit" name="addRevision" value="Add Revision" />
</cfform>
</cfif>
</cfif>