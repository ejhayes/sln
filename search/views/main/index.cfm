<form action="<cfoutput>#buildURL('main.search')#</cfoutput>" method="post">
    
    <div class="criteria">
    <table class="padded">
        <tbody>
            <tr>
                <th><strong>Status:</strong></th>
                <th colspan="2"><strong>Issued between (m/d/yyyy):</strong></th>
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
    <h3>Other criteria you can search by:</h3>
    <h3 class="toggleMultiselect"><em>Site/Crop</em></h3>
    <select name="sites" multiple="yes" class="multiselect" data-src="Sites" data-collapse="true"></select>
    
    <h3 class="toggleMultiselect"><em>Pest</em></h3>
    <select name="pests" multiple="yes" class="multiselect container" data-src="Pests" data-collapse="true"></select>
    
    <h3 class="toggleMultiselect"><em>County</em></h3>
    <select name="Counties" multiple="yes" class="multiselect" data-src="Counties" data-collapse="true"></select>

    
    <h3 class="toggleMultiselect"><em>Chemical</em></h3>
    <select name="chemicals" multiple="yes" class="multiselect" data-src="Chemicals" data-collapse="true"></select>


    <h3 class="toggleMultiselect"><em>Brand Name</em></h3>
    <select name="products" multiple="yes" class="multiselect" data-src="Products" data-collapse="true"></select>


    <h3 class="toggleMultiselect"><em>Pesticide Type</em></h3>
    <select name="pesticideTypes" multiple="yes" class="multiselect" data-src="PesticideTypes" data-collapse="true"></select>
    <br />
    
    <input type="submit" name="generate" value="Search" />
    <cfoutput><input type="button" name="newSearch" value="Start Over" onclick="javascript:window.location='#buildURL('')#'" /></cfoutput>
</form>
<br />
<h3>Or you can open a specific SLN:</h3>
<div class="criteria">
    
    <form action="<cfoutput>#buildURL('main.report')#</cfoutput>" method="post">
        CA-<input name="specialUseNumber" type="text" />
        <input name="open" type="submit" value="Open" />
    </form>
</div>