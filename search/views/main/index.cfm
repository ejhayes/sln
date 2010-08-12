<table class="padded">
<thead>
<tr>
    <th>Status</th>
    <th colspan="2">Issued Between</th>
    <th>Registration Number</th>
</tr>
</thead>
<tbody>
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

<h3>Sites</h3>
<select name="sites" multiple="yes" class="multiselect" data-src="Sites"></select>

<h3>Pests</h3>
<select name="pests" multiple="yes" class="multiselect" data-src="Pests"></select>

<h3>County</h3>
<select name="Counties" multiple="yes" class="multiselect" data-src="Counties"></select>

<h3>Chemical Ingredients</h3>
<select name="chemicals" multiple="yes" class="multiselect" data-src="Chemicals"></select>

<h3>Brand Names</h3>
<select name="products" multiple="yes" class="multiselect" data-src="Products"></select>

<h3>Sites</h3>
<select name="sites" multiple="yes" class="multiselect" data-src="Sites"></select>

<h3>Pesticide Type</h3>
<select name="pesticides" multiple="yes" class="multiselect" data-src="PesticideTypes"></select>