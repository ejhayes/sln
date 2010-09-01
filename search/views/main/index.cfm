<form action="<cfoutput>#buildURL('main.search')#</cfoutput>" method="post">
    <h3>Search by application status, issued date, or EPA registration number...</h3>
    <div class="criteria">
    <table class="padded">
        <tbody>
            <tr>
                <th><strong>Status:</strong></th>
                <th colspan="2"><strong>Issued between:</strong></th>
                <th><strong>Registration Number:</strong></th>
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
    </div>
    <h3>Also, look for SLN applications that...</h3>
    <h3 class="toggleMultiselect"><em>are applicable to these sites/crops (garlic, potato, radish, etc.)</em></h3>
    <select name="sites" multiple="yes" class="multiselect" data-src="Sites" data-collapse="true"></select>
    
    <h3 class="toggleMultiselect"><em>target these pests (blue mold, flying insects, fleas, etc.)</em></h3>
    <select name="pests" multiple="yes" class="multiselect container" data-src="Pests" data-collapse="true"></select>
    
    <h3 class="toggleMultiselect"><em>are valid in these counties (sacramento, alpine, butte, etc.)</em></h3>
    <select name="Counties" multiple="yes" class="multiselect" data-src="Counties" data-collapse="true"></select>

    
    <h3 class="toggleMultiselect"><em>contain pesticides with any of these chemicals (cetyl alcohol, arsenic acid, etc.)</em></h3>
    <select name="chemicals" multiple="yes" class="multiselect" data-src="Chemicals" data-collapse="true"></select>


    <h3 class="toggleMultiselect"><em>are for any of these pesticide products (ar-101, aquabrome tablets, etc.)</em></h3>
    <select name="products" multiple="yes" class="multiselect" data-src="Products" data-collapse="true"></select>


    <h3 class="toggleMultiselect"><em>are for any of these types of pesticides (adjuvant, defoliant, miticide, etc.)</em></h3>
    <select name="pesticides" multiple="yes" class="multiselect" data-src="PesticideTypes" data-collapse="true"></select>
    <br />
    
    <input type="submit" name="generate" value="Search" />
    <cfoutput><input type="button" name="newSearch" value="Start Over" onclick="javascript:window.location='#buildURL('')#'" /></cfoutput>
</form>