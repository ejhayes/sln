<cfset helper = new assets.cfc.helpers(this.config) />

<script>
$(function() {
    // for removing a label file
    $("#removeLabel").bind("click", function(){
        $.ajax({
            type:'POST',
            url:'<cfoutput>#buildURL("registration.removeLabel")#</cfoutput>',
            data: {
                revisionId: '<cfoutput>#rc.rev.record.getId()#</cfoutput>',
            },
            success: function(data, textStatus) {
                // remove the quicklinks
                if(data.success){
                    $("#labelQuicklinks").remove();
                } else {
                    alert(data.error);
                }
            },
            dataType: "json"
        });
    });
});
</script>

<h3>Details</h3>
<cfoutput>Tracking ID <a href="#helper.linkTo('TrackingSystem',rc.rev.record.getCorrespondence().getCode())#" target="_blank">#rc.rev.record.getCorrespondence().getCode()#</a> #rc.rev.record.getCorrespondence().getProductName()#</cfoutput>

<form action="<cfoutput>#buildURL('registration.saveRevision')#</cfoutput>" method="post" enctype="multipart/form-data">
    <!--- Hold the ID of the current application revision record --->
    <input name="id" type="hidden" value="<cfoutput>#rc.rev.record.getId()#</cfoutput>" />

    <table class="padded">
    <tr>
        <td><label>Description: </label></td>
        <td><cfoutput><input style="width:500px;" name="description" value="#rc.rev.record.getDescription()#"></cfoutput></td>
    </tr>
    <tr>
        <td><label>Special Use Subtype: </label></td>   
        <td>
            <select name="registrationSubtype">
                <option value=""></option>
                <cfoutput query="rc.lookups.registrationSubtypes"><option value="#CODE#" <cfif !isNull(rc.rev.record.getRegistrationSubtype())><cfif rc.rev.record.getRegistrationSubtype().getCode() EQ CODE >selected="selected"</cfif></cfif> >#DESCRIPTION#</option></cfoutput>
            </select>
        </td>
    </tr>
    <tr>
        <td><label>Approval Date<br>(m/d/yyyy): </label></td>
        <td><cfoutput><input name="approved" type="text" class="datepicker" value="#DateFormat(rc.rev.record.getApproved(),'mm/dd/yyyy')#" /></cfoutput></td>
    </tr>
    <tr>
        <td><label>Product: </label></td>
        <td><cfoutput><input style="width:500px;" id="Product" class="autocomplete" data-src="Products" data-minLength="6" data-value="<cfif !isNull(rc.rev.record.getProduct())>#rc.rev.record.getProduct().getCode()#</cfif>" value="<cfif !isNull(rc.rev.record.getProduct())>#rc.rev.record.getProduct().getDescription()#</cfif>"></cfoutput></td>
    </tr>
    <tr>
        <td><label>Label PDF<cfif !isNull(rc.rev.record.getLabel())><br><cfoutput><span id="labelQuicklinks">(<a href="#helper.linkTo('Label',rc.rev.record.getLabel())#" target="_blank">view</a> | <a id="removeLabel" href="##">remove</a>)</span></cfoutput></cfif>: </label></td>
        <td>
            <input id="applyStamp" name="applyStamp" type="checkbox"><label for="applyStamp">&nbsp;apply electronic stamp</label>&nbsp;
            <input type="file" name="labelFile">
        </td>
    </tr>
    </table>
    <br />
    
    <h3>Associated Pests <img src="assets/img/pest.png" height="15"></h3>
    <select name="pests" multiple="yes" class="multiselect" data-src="Pests">
        <cfloop array="#rc.rev.record.getPests()#" index="i">
            <cfoutput><option value="#i.getPest().getCode()#" selected="selected">#i.getPest().getDescription()#</option></cfoutput>
        </cfloop>
    </select>
    <br />

    
    <h3>Associated Counties <img src="assets/img/counties.png" height="15"></h3>
    <select name="counties" multiple="yes" class="multiselect" data-src="Counties">
        <cfloop array="#rc.rev.record.getCounties()#" index="i">
            <cfoutput><option value="#i.getCounty().getCode()#" selected="selected">#i.getCounty().getDescription()#</option></cfoutput>
        </cfloop>
    </select>
    <br />

    <input type="submit" name="Save" value="Save" />
    <input type="submit" name="Continue" value="Save and Continue"/>
    <input type="button" name="Close" value="Close" href="<cfoutput>#buildURL('registration.app&id=' & rc.rev.record.getApplication().getId())#</cfoutput>"/>
    
</form>