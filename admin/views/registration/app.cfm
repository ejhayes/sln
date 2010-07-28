<h3>Details</h3>
<cfform action="#buildURL('registration.save')#">
    <!--- Hold the ID of the current application record --->
    <cfinput name="id" type="hidden" value="#rc.data.app.getId()#" />
    
    <!--- Display Primary Application Details --->
    <table>
        <tr>
            <td><label>Status: </label></td>
            <td><cfselect name="status" query="rc.data.statuses" value="code" display="description" selected="#rc.data.app.getStatus().getCode()#" /></td>
        </tr>
        <tr>
            <td><label>Special Use Number: </label></td>
            <td><cfinput name="specialUseNumber" type="text" value="#rc.data.app.getSpecialUseNumber()#" /></td>
        </tr>
        <tr>
            <td><label>Special Use Type: </label></td>
            <td><cfselect name="registrationType" query="rc.data.registrationTypes" value="code" display="description" selected="#rc.data.app.getRegistrationType().getCode()#" /></td>
        </tr>
        <tr>
            <td><label>Issue Date: </label></td>
            <td><cfinput class="datepicker" name="issued" type="text" value="#rc.data.app.getIssued()#" /></td>
        </tr>
        <tr>
            <td><label>Expiration Date: </label></td>
            <td><cfinput class="datepicker" name="expired" type="text" value="#rc.data.app.getExpired()#" /></td>
        </tr>
    <table>
    <br />
    
    <!--- And the comments regarding the application --->
    <table width="100%">
        <tbody>
            <tr>
                <td><h3>Internal Comments</h3></td>
                <td><h3>Public Comments</h3></td>
            </tr>
            <tr>
                <td><cftextarea name="internalComments" style="width:98%;height:150px"><cfoutput>#rc.data.app.getInternalComments()#</cfoutput></cftextarea></td>
                <td><cftextarea name="publicComments" style="width:98%;height:150px"><cfoutput>#rc.data.app.getPublicComments()#</cfoutput></cftextarea></td>
            </tr>
        </tbody>
    </table>
    <br />
    
    <!--- Is the user creating, or updating? --->
    <cfif rc.application EQ "">
        <cfinput type="submit" name="submit" value="Create Application" />
        <cfinput type="button" name="viewReport" value="View Report" onclick="javascript:window.location='generateReport.cfm?appId=2'"/>
    <cfelse>
        <cfinput type="submit" name="submit" value="Update Application" />
    </cfif>
    
    <!--- Close this application --->
    <cfinput type="button" name="cancel" value="Close" onclick="javascript:window.location='.'"/>
</cfform>

<!--- For existing applications, show the revision history --->
<cfif rc.application NEQ "">
    <br />
    <br />
    <h3>Revisions</h3>

    <!--- If there are revisions, display information about them --->
    <cfif rc.data.app.hasRevisions() >
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
    </cfif>
    
    <!--- Let the user initiate a new revision --->
    <form action="#buildURL('registration.addRevision')#">
        <label><strong>Create a new revision from Tracking ID</strong>: </label><input name="trackingId" type="text" />
        <input type="submit" name="submit" value="Add Revision" />
    </form>
</cfif>