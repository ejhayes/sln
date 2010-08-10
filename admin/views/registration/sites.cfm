<cfdump var="#rc#" />
<cfabort />
<cfparam name="url.mode" default="add" />
<cfparam name="url.revisionid" default="1" />

<cfswitch expression="#url.mode#">
    <cfcase value="add">
        <cfset variables.pageTitle="Sites: SLN CA-56012-" & url.revisionId />
        <cfset variables.interfaceId="I-9-1" />
    </cfcase>
    <cfcase value="edit">
        <cfset variables.pageTitle="Sites: SLN CA-56012-" & url.revisionId />
        <cfset variables.interfaceId="I-9-2" />
    </cfcase>
    <cfcase value="delete">
    
    </cfcase>
    <cfcase value="view">
        <cfset variables.pageTitle="Sites: SLN CA-56012-" & url.revisionId />
        <cfset variables.interfaceId="I-9-0" />
    </cfcase>
    <cfdefaultcase>
        <h1>Invalid Mode</h1>
        <cfabort />
    </cfdefaultcase>
</cfswitch>

<cfform>

<cfif url.mode EQ "add">
<div class="notice">
<h3>Add New Sites</h3>
<table>
<tr>
<td>
    <select name="sites" multiple="yes" class="multiselect" data-src="Sites">
        
    </select>
</td>
<td>

</td>
</tr>
</table><br />
<cfelseif url.mode EQ "edit">
<div class="notice">
<h3>Editing Application Details for these sites</h3>
<ul>
    <li>Blackberries</li>
    <li>Peaches</li>
    <li>Cobbler</li>
    <li>Raisins</li>
</ul>
<br />
</cfif>
<cfif url.mode EQ "edit" OR url.mode EQ "add">
<h3>Usage Details <img src="usage.png" height="15"></h3>
<table>
    <tr><td><label>Qualifier: </label></td><td><input style="width:200px;" id="Qualifier" class="autocomplete" data-src="Qualifiers" data-minLength="3" data-value="" value=""></td></tr>
    <tr><td><label>Pre-Harvest Interval: </label></td></td><td><cfinput type="text" style="width:30px;" name="preHarvestInterval" /> <cfselect name="preHarvestIntervalMeasurement"><option value="day">Day(s)</option><option value="hour">Hour(s)</option><option value="minute">Minute(s)</option></cfselect></td></tr>
    <tr><td><label>Re-Entry Interval: </label></td></td><td><cfinput type="text" style="width:30px;" name="reEntryInterval" /> <cfselect name="reEntryIntervalMeasurement"><option value="day">Day(s)</option><option value="hour">Hour(s)</option><option value="minute">Minute(s)</option></cfselect></td></tr>
</table>
<cfif url.mode EQ "edit">
    <cfinput type="button" name="saveClose" value="Save" onclick="javascript:window.location='?revisionId=2&mode=view'"/>
    <cfinput type="button" name="cancel" value="Cancel" onclick="javascript:window.location='?revisionId=2&mode=view'"/>
<cfelse>
    <cfinput type="button" name="saveClose" value="Add" onclick="javascript:window.location='?revisionId=2&mode=view'"/>
    <cfinput type="button" name="cancel" value="Cancel" onclick="javascript:window.location='?revisionId=2&mode=view'"/>
</cfif>

</div>
</cfif>
</cfform>

<br />

<h3>Associated Sites <img src="site.png" height="15"><cfif url.mode NEQ "add"> (<a href="?revisionId=3&mode=add">add more</a>)</cfif></h3>
<table width="100%">
<thead>
    <th></th>
    <th>Site</th>
    <th>Qualifier</th>
    <th>Pre-Harvest Interval</th>
    <th>Re-Entry Interval</th>
</thead>
<tbody>
<tr>
    <td><input type="checkbox" /></td>
    <td>GARLIC</td>
    <td>POULTRY DROPPINGS</td>
    <td>1 day(s)</td>
    <td>18 minute(s)</td>
</tr>
<tr>
    <td><input type="checkbox" /></td>
    <td>GARLIC</td>
    <td>POULTRY DROPPINGS</td>
    <td>1 day(s)</td>
    <td>18 minute(s)</td>
</tr>
<tr>
    <td><input type="checkbox" /></td>
    <td>GARLIC</td>
    <td>POULTRY DROPPINGS</td>
    <td>1 day(s)</td>
    <td>18 minute(s)</td>
</tr>
<tr>
    <td><input type="checkbox" /></td>
    <td>GARLIC</td>
    <td>POULTRY DROPPINGS</td>
    <td>1 day(s)</td>
    <td>18 minute(s)</td>
</tr>
<tr>
    <td><input type="checkbox" /></td>
    <td>GARLIC</td>
    <td>POULTRY DROPPINGS</td>
    <td>1 day(s)</td>
    <td>18 minute(s)</td>
</tr>
</tbody>
</table>

<input type="button" value="Edit" onclick="javascript:window.location='?revisionId=28&mode=edit'" />
<input type="button" value="Delete" onclick="javascript:window.location='?revisionId=28&mode=delete'" />

<br /><br /><hr>
<input type="button" value="Back to Revision Details" onclick="javascript:window.location='editRevision.cfm?revisionId=28'" />
<input type="button" value="Close Revision" onclick="javascript:window.location='editApplication.cfm?specialUseNumber=1234'" />