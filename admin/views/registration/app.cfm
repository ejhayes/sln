<cfif StructKeyExists(rc,"data")>
<cfdump var="#rc.data#" />
</cfif>
<h3>Details</h3>
<cfform action="#buildURL('registration.save')#">
    <!--- Hold the ID of the current application record --->
    <cfinput name="id" type="hidden" value="#rc.app.record.getId()#" />
    
    <!--- Display Primary Application Details --->
    <table>
        <tr>
            <td><label>Status: </label></td>
            <td><cfselect name="status" query="rc.lookups.statuses" value="code" display="description" selected="#rc.app.record.getStatus().getCode()#" /></td>
        </tr>
        <tr>
            <td><label>Special Use Number: </label></td>
            <td><cfinput name="specialUseNumber" type="text" value="#rc.app.record.getSpecialUseNumber()#" /></td>
        </tr>
        <tr>
            <td><label>Special Use Type: </label></td>
            <td><cfselect name="registrationType" query="rc.lookups.registrationTypes" value="code" display="description" selected="#rc.app.record.getRegistrationType().getCode()#" /></td>
        </tr>
        <tr>
            <td><label>Issue Date: </label></td>
            <td><cfinput class="datepicker" name="issued" type="text" value="#DateFormat(rc.app.record.getIssued(),'mm/dd/yyyy')#" /></td>
        </tr>
        <tr>
            <td><label>Expiration Date: </label></td>
            <td><cfinput class="datepicker" name="expired" type="text" value="#DateFormat(rc.app.record.getExpired(),'mm/dd/yyyy')#" /></td>
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
                <td><cftextarea name="internalComments" style="width:98%;height:150px"><cfoutput>#rc.app.record.getInternalComments()#</cfoutput></cftextarea></td>
                <td><cftextarea name="publicComments" style="width:98%;height:150px"><cfoutput>#rc.app.record.getPublicComments()#</cfoutput></cftextarea></td>
            </tr>
        </tbody>
    </table>
    <br />
    
    <!--- Is the user creating, or updating? --->
    <cfif rc.app.record.getId() EQ "">
        <cfinput type="submit" name="submit" value="Create Application" />
    <cfelse>
        <cfinput type="submit" name="submit" value="Update Application" />
        <cfinput type="button" name="viewReport" value="View Report" onclick="javascript:window.location='generateReport.cfm?appId=2'"/>
    </cfif>
    
    <!--- Close this application --->
    <cfinput type="button" name="cancel" value="Close" onclick="javascript:window.location='.'"/>
</cfform>

<!--- For existing applications, show the revision history --->
<cfif rc.app.record.getId() NEQ "">
    <br />
    <br />
    <h3>Revisions</h3>

    <!--- If there are revisions, display information about them --->
    <cfif rc.app.record.hasRevisions() >
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
                <cfloop array="#rc.app.record.getRevisions()#" index="i">
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
    <form action="<cfoutput>#buildURL('registration.addRevision&application=' & rc.app.record.getId() )#</cfoutput>">
        <label><strong>Create a new revision from Tracking ID</strong>: </label><input name="correspondenceCode" type="text" />
        <input type="submit" name="submit" value="Add Revision" />
    </form>
</cfif>