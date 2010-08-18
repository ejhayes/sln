<cfset helper = new assets.cfc.helpers() />
The following criteria were used for your search:

<ul>
<cfloop collection=#rc.data.parameters# item="i">
    <li><cfoutput>#rc.data.parameters[i]#</cfoutput></li>
</cfloop>
</ul>

<div class="notice"><img src="assets/img/notice.png" height="15" /> Place a checkbox next to each application you want a full report on.  Once you have made your selection click the "Generate Report" button.</div>

<form action="<cfoutput>#buildURL('main.report')#</cfoutput>" method="post">
    <table width="100%" class="tablesorter" data-sort="[[2,0],[1,0]]">
        <thead>
            <tr>
                <th class="{sorter: false}"><input type="checkbox" class="checkAll" data-target="applications" /></th>
                <th>Brand Name</th>
                <th>Status</th>
                <th>SLN Number</th>
                <th>Expiration Date</th>
            </tr>
        </thead>
        <tbody>
            <cfloop array="#rc.data.results#" index="i">
            <cfoutput>
            <tr>
                <td><input type="checkbox" name="applications" value="#i.getId()#" /></td>
                <td>
                    <cfloop array="#i.getUniqueProducts()#" index="j">
                        <a href="#buildURL('admin:registration.rev&id=' & j['Id'])#">#Left(j['Description'],40)#</a>
                        <cfif StructKeyExists(j,"Label") >
                            &nbsp;<a href="#helper.linkTo('Label',j['Label'])#" style="color:green"><strong>VIEW LABEL</strong></a> <img src="./assets/img/document.png" height="11" />
                        </cfif>
                        
                    <br /></cfloop>
                    
                </td>
                <td>#i.getStatus().getDescription()#</td>
                <td><a href="#buildURL('admin:registration.app&id=' & i.getId())#">#i.getOfficialName()#</a></td>
                <td>#DateFormat(i.getExpired(),"m/d/yyyy")#</td>
            </tr>
            </cfoutput>
            </cfloop>
        </tbody>
    </table>
    <input type="submit" name="generate" value="Generate Report" />    
    <cfoutput><input type="button" name="newSearch" value="New Search" onclick="javascript:window.location='#buildURL('')#'" /></cfoutput>
</form>