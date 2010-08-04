<cfset helper = new assets.cfc.helpers() />

<h3>Revision Details</h3>
<cfoutput>Tracking ID <a href="#helper.linkTo('TrackingSystem',rc.rev.record.getCorrespondence().getCode())#" target="_blank">#rc.rev.record.getCorrespondence().getCode()#</a> #rc.rev.record.getCorrespondence().getFirmName()#</cfoutput>

<form action="#buildURL('registration.saveRev')#">
    <!--- Hold the ID of the current application revision record --->
    <input name="id" type="hidden" value="<cfoutput>#rc.rev.record.getId()#</cfoutput>" />

    <table>
    <tr>
        <td><label>Special Use Subtype: </label></td>   
        <td>
            <select name="registrationSubtype">
                <cfoutput query="rc.lookups.registrationSubtypes"><option value="#CODE#" <cfif rc.rev.record.getRegistrationSubtype().getCode() EQ CODE >selected="selected"</cfif> >#DESCRIPTION#</option></cfoutput>
            </select>
        </td>
    </tr>
    <tr>
        <td><label>Approval Date: </label></td>
        <td><cfoutput><input name="approved" type="text" class="datepicker" value="#DateFormat(rc.rev.record.getApproved(),'mm/dd/yyyy')#" /></cfoutput></td>
    </tr>
    <tr>
        <td><label>Product OR Registration Number: </label></td>
        <td><cfoutput><input style="width:500px;" id="Product" class="autocomplete" data-src="Products" data-minLength="6" value="#rc.rev.record.getProduct().getDescription()#"></cfoutput></td>
    </tr>
    <tr>
        <td><label>Label PDF <cfif !isNull(rc.rev.record.getLabel())><cfoutput>(<a href="#rc.rev.record.getLabel()#" target="_blank">view</a>)</cfoutput></cfif>: </label></td>
        <td>
            <input id="applyStamp" name="applyStamp" type="checkbox"><label for="applyStamp">&nbsp;apply electronic stamp</label>&nbsp;
            <input type="file" name="labelFile">
        </td>
    </tr>
    <table>

    <p>
    <h3>Associated Pests <img src="assets/img/pest.png" height="15"></h3>
    <select name="pests" multiple="yes" class="multiselect" data-src="Pests">
        <cfloop array="#rc.rev.record.getPests()#" index="i">
            <cfoutput><option value="#i.getPest().getCode()#" selected="selected">#i.getPest().getDescription()#</option></cfoutput>
        </cfloop>
    </select>
    </p>

    <p>
    <h3>Associated Counties <img src="assets/img/counties.png" height="15"></h3>
    <select name="counties" multiple="yes" class="multiselect" data-src="Counties">
        <cfloop array="#rc.rev.record.getCounties()#" index="i">
            <cfoutput><option value="#i.getCounty().getCode()#" selected="selected">#i.getCounty().getDescription()#</option></cfoutput>
        </cfloop>
    </select>
    </p>

    <input type="button" name="next" value="Save and Continue" onclick="javascript:window.location='editSites.cfm?revisionId=3&mode=add'"/>
    <input type="button" name="saveClose" value="Save" onclick="javascript:window.location='?revisionId=3'"/>
    <input type="button" name="cancel" value="Close Revision" onclick="javascript:window.location='editApplication.cfm?specialUseNumber=1234'"/>
</form>