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
                    <tr>
                        <th>Site</th>
                        <th>Qualifier</th>
                        <th>Pre-Harvest Interval</th>
                        <th>Re-Entry Interval</th>
                    </tr>
                </thead>
                <tbody>
                <cfloop array="#rc.rev.record.getSites()#" index="i">
                    <cfif ListFind(rc.revisionSites,i.getId()) GT 0 >
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
            <td>
                <select name="Qualifier">
                    <cfoutput query="rc.lookups.qualifiers"><option value="#CODE#">#DESCRIPTION#</option></cfoutput>
                </select>
            </td>
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

<cfif (ArrayLen(rc.rev.record.getSites()) NEQ ListLen(rc.revisionSites)) AND rc.rev.record.hasSites() >
    <h3>Associated Sites <img src="assets/img/site.png" height="15"></h3>
    
    <form action="<cfoutput>#buildURL('registration.saveSites')#</cfoutput>" method="post">
        <!--- Hold the ID of the current application revision record --->
        <input name="id" type="hidden" value="<cfoutput>#rc.rev.record.getId()#</cfoutput>" />

        <table width="100%" class="tablesorter" data-sort="[[1,0]]" >
            <thead>
                <tr>
                    <th class="{sorter: false}"><input type="checkbox" class="checkAll" data-target="revisionSites" /></th>
                    <th>Site</th>
                    <th>Qualifier</th>
                    <th>Pre-Harvest Interval</th>
                    <th>Re-Entry Interval</th>
                </tr>
            </thead>
            <tbody>
                <cfloop array="#rc.rev.record.getSites()#" index="i">
                    <cfif ListFind(rc.revisionSites,i.getId()) EQ 0 >
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
</cfif>
<br /><br /><hr>
<cfoutput><input type="button" value="Back to Revision Details" onclick="javascript:window.location='#buildURL('registration.rev&id=' & rc.rev.record.getId())#'" /></cfoutput>
<cfoutput><input type="button" value="Close Revision" onclick="javascript:window.location='#buildURL('registration.app&id=' & rc.rev.record.getApplication().getId())#'" /></cfoutput>
<cfoutput><input type="button" value="Start a new application" onclick="javascript:window.location='#buildURL('registration.app')#'" /></cfoutput>
