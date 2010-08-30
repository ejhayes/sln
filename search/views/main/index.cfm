<form action="<cfoutput>#buildURL('main.search')#</cfoutput>" method="post">
    <table class="padded">
        <tbody>
            <tr>
                <th>Status:</th>
                <th colspan="2">Issued between:</th>
                <th>Registration Number:</th>
            </tr>
            <tr>
                <td>
                    <select name="status">
                        <option value="">Any</option>
                        <cfoutput query="rc.lookups.statuses"><option value="#CODE#" >#DESCRIPTION#</option></cfoutput>
                    </select>
                </td>
                <td><input name="issuedStart" type="text" class="datepicker" /> AND</td>
                <td><input name="issuedEnd" type="text" class="datepicker" /></td>
                <td><input name="registrationNumber" type="text" /></td>
            </tr>
        </tbody>
    </table>

    <h3 class="collapseTrigger">Sites</h3>
    
        <select id="bog" name="sites" multiple="yes" class="multiselect" data-src="Sites"></select>
    

    
    <h3 class="collapseTrigger">Pests</h3>
    <div class="collapse">
        <select name="pests" multiple="yes" class="multiselect" data-src="Pests"></select>
    </div>
    
    <h3 class="collapseTrigger">County</h3>
    <div class="collapse">
        <select name="Counties" multiple="yes" class="multiselect" data-src="Counties"></select>
    </div>
    
    <h3 class="collapseTrigger">Chemical Ingredients</h3>
    <div class="collapse">
        <select name="chemicals" multiple="yes" class="multiselect" data-src="Chemicals"></select>
    </div>

    <h3 class="collapseTrigger">Brand Names</h3>
    <div class="collapse">
        <select name="products" multiple="yes" class="multiselect" data-src="Products"></select>
    </div>

    <h3 class="collapseTrigger">Pesticide Type</h3>
    <div class="collapse">
        <select name="pesticides" multiple="yes" class="multiselect" data-src="PesticideTypes"></select>
    </div>
    <br />
    
    <input type="submit" name="generate" value="Generate Report" />
    <cfoutput><input type="button" name="newSearch" value="New Search" onclick="javascript:window.location='#buildURL('')#'" /></cfoutput>
</form>