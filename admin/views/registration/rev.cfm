<h3>Revision Details</h3>
Tracking ID <a href="http://registration/track/reports/trackid_action.cfm?RequestTimeout=500&track_id=121266" target="_blank">121266</a>

<form action="#buildURL('registration.saveRev')#">
    <table>
    <tr>
        <td><label>Special Use Subtype: </label></td>   
        <td>
            <select name="registrationSubtype">
                <cfoutput query="#rc.lookups.registrationSubtypes#"><option value="#CODE#">#DESCRIPTION#</option></cfoutput>
            </select>
        </td>
    </tr>
    <tr>
        <td><label>Approval Date: </label></td>
        <td><input name="approvalDate" type="text" class="datepicker" /></td>
    </tr>
    <tr>
        <td><label>Product OR Registration Number: </label></td>
        <td><input style="width:500px;" id="Product" class="autocomplete" data-src="Products"></td>
    </tr>
    <tr>
        <td><label>Label PDF (<a href="SLN-56012-0.pdf" target="_blank">view</a>): </label></td>
        <td>
            <input name="deepCopy" type="checkbox"><label>&nbsp;apply electronic stamp</label>&nbsp;
            <input type="file" name="labelFile">
        </td>
    </tr>
    <table>

    <p>
    <h3>Associated Pests <img src="assets/img/pest.png" height="15"></h3>
    <select name="pests" multiple="yes" class="multiselect" data-src="Pests"></select>
    </p>

    <p>
    <h3>Associated Counties <img src="assets/img/counties.png" height="15"></h3>
    <select name="counties" multiple="yes" class="multiselect" data-src="Counties"></select>
    </p>

    <hr>
    <input type="button" name="next" value="Save and Continue" onclick="javascript:window.location='editSites.cfm?revisionId=3&mode=add'"/>
    <input type="button" name="saveClose" value="Save" onclick="javascript:window.location='?revisionId=3'"/>
    <input type="button" name="cancel" value="Close Revision" onclick="javascript:window.location='editApplication.cfm?specialUseNumber=1234'"/>
</form>