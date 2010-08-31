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

    <h3 class="toggleMultiselect">Sites</h3>
    <select name="sites" multiple="yes" class="multiselect" data-src="Sites" data-collapse="true"></select>
    
    <h3 class="toggleMultiselect">Pests</h3>
    <select name="pests" multiple="yes" class="multiselect" data-src="Pests" data-collapse="true"></select>
    
    <h3 class="toggleMultiselect">County</h3>
    <select name="Counties" multiple="yes" class="multiselect" data-src="Counties" data-collapse="true"></select>

    
    <h3 class="toggleMultiselect">Chemical Ingredients</h3>
    <select name="chemicals" multiple="yes" class="multiselect" data-src="Chemicals" data-collapse="true"></select>


    <h3 class="toggleMultiselect">Brand Names</h3>
    <select name="products" multiple="yes" class="multiselect" data-src="Products" data-collapse="true"></select>


    <h3 class="toggleMultiselect">Pesticide Type</h3>
    <select name="pesticides" multiple="yes" class="multiselect" data-src="PesticideTypes" data-collapse="true"></select>
    <br />
    
    <input type="submit" name="generate" value="Generate Report" />
    <cfoutput><input type="button" name="newSearch" value="New Search" onclick="javascript:window.location='#buildURL('')#'" /></cfoutput>
</form>