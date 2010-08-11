<cfset helper = new assets.cfc.helpers() />

<form id="saveForm" action="<cfoutput>#buildURL('registration.saveSites')#</cfoutput>" method="post">
    <!--- Hold the ID of the current application revision record --->
    <input name="id" type="hidden" value="<cfoutput>#rc.rev.record.getId()#</cfoutput>" />
    <input name="revisionSites" type="hidden" value="<cfoutput>#rc.revisionSites#</cfoutput>" />
        
    <div class="notice">
    <cfswitch expression="#rc.mode#">
        <cfcase value="edit">
            <h3>Editing Application Details for these sites</h3>
            <table width="100%">
                <thead>
                    <th>Site</th>
                    <th>Qualifier</th>
                    <th>Pre-Harvest Interval</th>
                    <th>Re-Entry Interval</th>
                </thead>
                <tbody>
                <cfloop array="#rc.rev.record.getSites()#" index="i">
                    <cfif ListContains(rc.revisionSites,i.getId())>
                        <tr>
                            <cfoutput>
                                <td>#i.getSite().getDescription()#</td>
                                <td>#i.getQualifier().getDescription()#</td>
                                <td>#i.getPreHarvestInterval()# #i.getPreHarvestIntervalMeasurement().getDescription()#</td>
                                <td>#i.getReEntryInterval()# #i.getReEntryIntervalMeasurement().getDescription()#</td>
                            </cfoutput>
                        </tr>
                    </cfif>
                </cfloop>
                </tbody>
            </table>
        </cfcase>
        <cfdefaultcase>
            <h3>Add New Sites</h3>
            <select id="sites" name="sites" multiple="yes" class="multiselect" data-src="Sites"></select>
        </cfdefaultcase>
    </cfswitch>
    <br />

    <h3>Usage Details <img src="assets/img/usage.png" height="15"></h3>
    <table>
        <tr>
            <td><label>Qualifier: </label></td>
            <td><input style="width:200px;" id="Qualifier" class="autocomplete" data-src="Qualifiers" data-minLength="3" data-value="" value=""></td>
        </tr>
        <tr>
            <td><label>Pre-Harvest Interval: </label></td>
            <td>
                <input type="text" style="width:30px;" name="preHarvestInterval" />
                
                <select name="preHarvestIntervalMeasurement">
                    <cfoutput query="rc.lookups.preHarvestMeasurements"><option value="#CODE#">#DESCRIPTION#</option></cfoutput>
                </select>
                
            </td>
        </tr>
        <tr>
            <td><label>Re-Entry Interval: </label></td>
            <td>
                <input type="text" style="width:30px;" name="reEntryInterval" />
                
                <select name="reEntryIntervalMeasurement">
                    <cfoutput query="rc.lookups.reEntryMeasurements"><option value="#CODE#">#DESCRIPTION#</option></cfoutput>
                </select>
            </td>
        </tr>
    </table>

    <!--- The save area --->
    <cfoutput>
        <input type="submit" name="save" value="#iif(rc.mode EQ 'add',de('Add'),de('Update'))#" />
        <input type="button" name="cancel" value="Cancel" onclick="javascript:window.location='#buildURL('registration.sites&id=' & rc.id)#'"/>
    </cfoutput>
    </div>
</form>

<br />

<h3>Associated Sites <img src="assets/img/site.png" height="15"></h3>
<form action="<cfoutput>#buildURL('registration.saveSites')#</cfoutput>" method="post">
<!--- Hold the ID of the current application revision record --->
<input name="id" type="hidden" value="<cfoutput>#rc.rev.record.getId()#</cfoutput>" />

<table width="100%">
    <thead>
        <th><input id="CheckAllRevisionSites" type="checkbox" class="checkAll" data-target="revisionSites" /></th>
        <th>Site</th>
        <th>Qualifier</th>
        <th>Pre-Harvest Interval</th>
        <th>Re-Entry Interval</th>
    </thead>
    <tbody>
    <cfloop array="#rc.rev.record.getSites()#" index="i">
        <cfif !ListContains(rc.revisionSites,i.getId())>
            <tr>
                <cfoutput>
                    <td><input type="checkbox" name="revisionSites" value="#i.getId()#" /></td>
                    <td>#i.getSite().getDescription()#</td>
                    <td>#i.getQualifier().getDescription()#</td>
                    <td>#i.getPreHarvestInterval()# #i.getPreHarvestIntervalMeasurement().getDescription()#</td>
                    <td>#i.getReEntryInterval()# #i.getReEntryIntervalMeasurement().getDescription()#</td>
                </cfoutput>
            </tr>
        </cfif>
    </cfloop>
    </tbody>
</table>

<input type="submit" name="save" value="Edit" />
<input type="submit" name="save" value="Delete" />
</form>

<br /><br /><hr>
<cfoutput><input type="button" value="Back to Revision Details" onclick="javascript:window.location='#buildURL('registration.rev&id=' & rc.rev.record.getId())#'" /></cfoutput>
<cfoutput><input type="button" value="Close Revision" onclick="javascript:window.location='#buildURL('registration.app&id=' & rc.rev.record.getApplication().getId())#'" /></cfoutput>
