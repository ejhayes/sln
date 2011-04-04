<cfset helper = new assets.cfc.helpers() />

<script>
$(function() {
    // for removing a label file
    $(".removeRevision").bind("click", function(){
        if (confirm("Are you sure you want to remove this revision?")){
            $.ajax({
                type:'POST',
                url:'<cfoutput>#buildURL("registration.removeRevision")#</cfoutput>',
                data: {
                    revisionid: $(this).parent().parent().attr('id'),
                },
                success: function(data, textStatus) {
                    // remove the quicklinks
                    if(data.success){
                        $("#" + data.revisionid).remove();
                    } else {
                        alert(data.error);
                    }
                },
                dataType: "json"
            });
        }
    });
});
</script>

<cfif StructKeyExists(rc,"data")>
<cfdump var="#rc.data#" />
</cfif>
<h3>Details</h3>
<form action="<cfoutput>#buildURL('registration.save')#</cfoutput>" method="post">
    <!--- Hold the ID of the current application record --->
    <input name="id" type="hidden" value="<cfoutput>#rc.app.record.getId()#</cfoutput>" />
    
    <!--- Display Primary Application Details --->
    <table class="padded">
        <tr>
            <td><label>Status: </label></td>
            <td>
                <select name="status">
                        <cfoutput query="rc.lookups.statuses"><option value="#CODE#" <cfif rc.app.record.getStatus().getCode() EQ CODE >selected="selected"</cfif> >#DESCRIPTION#</option></cfoutput>
                </select>
            </td>
            
        </tr>
        <tr>
            <td><label>SLN Number: </label></td>
            <td><input name="specialUseNumber" type="text" value="<cfoutput>#rc.app.record.getSpecialUseNumber()#</cfoutput>" /></td>
        </tr>
        <tr>
            <td><label>SLN Type: </label></td>
            <td>
                <select name="registrationType">
                    <cfoutput query="rc.lookups.registrationTypes"><option value="#CODE#" <cfif rc.app.record.getRegistrationType().getCode() EQ CODE >selected="selected"</cfif> >#DESCRIPTION#</option></cfoutput>
                </select>
            </td>
        </tr>
        <tr>
            <td><label>Issue Date (m/d/yyyy): </label></td>
            <td><input class="datepicker" name="issued" type="text" value="<cfoutput>#DateFormat(rc.app.record.getIssued(),'mm/dd/yyyy')#</cfoutput>" /></td>
        </tr>
        <tr>
            <td><label>Expiration Date (m/d/yyyy): </label></td>
            <td><input class="datepicker" name="expired" type="text" value="<cfoutput>#DateFormat(rc.app.record.getExpired(),'mm/dd/yyyy')#</cfoutput>" /></td>
        </tr>
        <!--- 
        NEW APPLICATIONS WITH A TRACKING ID ALREADY ESTABLISHED (SHORTCUT per John Inouye, 9/29/2010 DEV NOTES)
        If this is a new application, we will allow the registration scientist to be able to enter a tracking id here instead.
        When the application is created, then we can go ahead and create the first revision to it.  Assuming this is all successful
        we can dive right into the revision details screen.
        --->
        <cfif rc.app.record.getId() EQ "">
        <tr>
            <td><label>Tracking ID: </label></td>
            <td><input name="correspondenceCode" type="text" />&nbsp;<span style="color:red">(next available is <cfoutput>#rc.app.record.getNextDummyCode()#</cfoutput>)</span></td>
        </tr>
        </cfif>
    </table>
    <br />
    
    <!--- And the comments regarding the application --->
    <table width="100%">
        <tbody>
            <tr>
                <td><h3>Internal Comments</h3></td>
            </tr>
            <tr>
                <td><textarea name="internalComments" style="width:98%;height:150px"><cfoutput>#rc.app.record.getInternalComments()#</cfoutput></textarea></td>
            </tr>
        </tbody>
    </table>
    <br />
    
    <!--- Is the user creating, or updating? --->
    <cfif rc.app.record.getId() EQ "">
        <input type="submit" name="submit" value="Create Application" />
    <cfelse>
        <input type="submit" name="submit" value="Update Application" />
        <input type="button" name="viewReport" value="View Report" href="<cfoutput>#buildURL('search:main.report&applications=' & rc.app.record.getId())#</cfoutput>"/>
    </cfif>
    
    <!--- Close this application --->
    <input type="button" name="cancel" value="Close" href="<cfoutput>#buildURL('')#</cfoutput>"/>
</form>

<!--- For existing applications, show the revision history --->
<cfif rc.app.record.getId() NEQ "">
    <br />
    <br />
    <h3>Revisions</h3>

    <!--- If there are revisions, display information about them --->
    <cfif rc.app.record.hasRevisions() >
        
        <table width="90%"> 
            <thead> 
                <tr> 
                    <th>Revision</th> 
                    <th>Tracking ID</th> 
                    <th>Last Updated</th> 
                    <th>Actions</th> 
                </tr> 
            </thead> 
            <tbody>
                <cfloop array="#rc.app.record.getRevisions()#" index="i">
                <tr id="<cfoutput>#i.getId()#</cfoutput>"> 
                    <td><a class="removeRevision" href="#">[x]</a> <cfoutput>#i.getRevisionNumber()#</cfoutput></td> 
                    <td>
                        <a href="<cfoutput>#helper.linkTo('TrackingSystem',i.getCorrespondence().getCode())#</cfoutput>" target="_blank"><cfoutput>#i.getCorrespondence().getCode()#</cfoutput></a>&nbsp;
                        <cfoutput><cfif i.hasProduct()>#Left(i.getProduct().getDescription(),50)#<cfelse>Product Not Specified</cfif></cfoutput>
                    </td>
                    <td><cfoutput>#helper.relativeDate(i.getUpdated())# by #i.getUpdatedBy()#</cfoutput></td> 
                    <td>
                        <a href="<cfoutput>#buildURL("registration.rev&id=" & i.getId())#</cfoutput>">Details</a> | 
                        <a href="<cfoutput>#buildURL("registration.sites&id=" & i.getId())#</cfoutput>">Sites</a>
                    </td>
                </tr>
                </cfloop>
            </tbody> 
        </table> 
        <br />
    </cfif>
    
    <!--- Let the user initiate a new revision --->
    <form action="<cfoutput>#buildURL('registration.addRevision&application=' & rc.app.record.getId() )#</cfoutput>" method="post" data-confirm="Are you sure you want to add a revision from this tracking id?">
        <label><strong>Create a new revision from Tracking ID</strong> <span style="color:red">(next available is <cfoutput>#rc.app.record.getNextDummyCode()#</cfoutput>)</span>: </label><input name="correspondenceCode" type="text" />
        <input type="submit" name="submit" value="Add Revision" />
        <!--- NO need to add a deep copy action if we have no revisions --->
        <cfif arrayLen(rc.app.record.getRevisions()) GT 0>
            &nbsp;
            <input type="checkbox" name="deepCopy" id="deepCopy" />&nbsp;
            <label for="deepCopy">copy data from most recent revision</label>
        </cfif>
    </form>
</cfif>