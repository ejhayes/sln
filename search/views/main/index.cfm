<h1 style="color:red">This database contains comprehensive SLN data for 2000 onwards.  Historical data will be added on an ongoing basis.</h1><br>
<form action="<cfoutput>#buildURL('main.search')#</cfoutput>" method="post">
    
    <div class="criteria">
    <table class="padded" width="50%">
        <tbody>
            <tr>
                <th>Status:</th>
                <th>Issued between (m/d/yyyy):</th>
                <th>Registration Number:</th>
            </tr>
            <tr>
                <td>
                    <select name="status">
                        <option value="">Any</option>
                        <cfoutput query="rc.lookups.statuses"><option value="#CODE#" >#DESCRIPTION#</option></cfoutput>
                    </select>
                </td>
                <td><input name="issuedStart" type="text" class="datepicker" /> AND <input name="issuedEnd" type="text" class="datepicker" /></td>
                <td><input name="registrationNumber" type="text" /></td>
            </tr>
        </tbody>
    </table>
    </div>
    <h3>Other criteria you can search by:</h3>
    <p>The lists below contain partial information.  If you are looking for something specific use the search box.</p>
    <h3 class="toggleMultiselect"><em>Site/Crop</em></h3>
    <select name="sites" multiple="yes" class="multiselect" data-src="SearchSites" data-collapse="true"></select>
    
    <h3 class="toggleMultiselect"><em>Pest</em></h3>
    <select name="pests" multiple="yes" class="multiselect container" data-src="SearchPests" data-collapse="true"></select>
    
    <h3 class="toggleMultiselect"><em>County</em></h3>
    <select name="Counties" multiple="yes" class="multiselect" data-src="Counties" data-collapse="true"></select>

    
    <h3 class="toggleMultiselect"><em>Chemical</em></h3>
    <select name="chemicals" multiple="yes" class="multiselect" data-src="SearchChemicals" data-collapse="true"></select>


    <h3 class="toggleMultiselect"><em>Brand Name</em></h3>
    <select name="products" multiple="yes" class="multiselect" data-src="SearchProducts" data-collapse="true"></select>


    <h3 class="toggleMultiselect"><em>Pesticide Type</em></h3>
    <select name="pesticideTypes" multiple="yes" class="multiselect" data-src="SearchPesticideTypes" data-collapse="true"></select>
    <br />
    
    <input type="submit" name="generate" value="Search" />
    <cfoutput><input type="button" name="newSearch" value="Start Over" href="#buildURL('')#" /></cfoutput>
</form>
<br />
<h3>Or you can open a specific SLN:</h3>
<div class="criteria">
    
    <form action="<cfoutput>#buildURL('main.report')#</cfoutput>" method="post">
        CA-<input name="specialUseNumber" type="text" />
        <input name="open" type="submit" value="Open" />
    </form>
</div>