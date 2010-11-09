<cfset helper = new assets.cfc.helpers(this.config) />
The following criteria were used for your search:

<ul>
<cfloop collection=#rc.data.parameters# item="i">
    <li><cfoutput>#rc.data.parameters[i]#</cfoutput></li>
</cfloop>
</ul>

<div class="notice"><img src="assets/img/notice.png" height="15" style="float:left" /><div style="padding-left:25px;">
    Check one or more special use registrations below for a full information report.
    When you are finished, click the 'Generate Report' button.  You can sort any column by clicking on the column header.</div>
</div>

<form action="<cfoutput>#buildURL('main.report')#</cfoutput>" method="post">
    <table width="100%" class="tablesorter" data-sort="[[1,0]]">
        <thead>
            <tr>
                <th class="{sorter: false}"><input type="checkbox" class="checkAll" data-target="applications" />&nbsp;All</th>
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
                    <cfset isFirstLoop = true />
                    <cfloop array="#i.getUniqueProducts()#" index="j">
                        <cfif this.isInternal>
                            <a href="#buildURL('admin:registration.rev&id=' & j['Id'])#">#Left(j['Description'],40)#</a>
                        <cfelse>
                            #Left(j['Description'],40)#
                        </cfif>
                        <cfif StructKeyExists(j,"Label") >
                            &nbsp;<a target="_blank" href="#helper.linkTo('Label',j['Label'])#" style="color:green"><strong>VIEW LABEL</strong></a> <img src="./assets/img/document.png" height="11" />
                        </cfif>
                        <cfif isFirstLoop >
                            <span style="color:orange"><strong>&larr; CURRENT</strong></span>
                            <cfset isFirstLoop = false />
                        </cfif>
                    <br /></cfloop>
                    
                </td>
                <td>#i.getStatus().getDescription()#</td>
                <td>
                    <cfif this.isInternal >
                        <a href="#buildURL('admin:registration.app&id=' & i.getId())#">#i.getOfficialName()#</a>
                    <cfelse>
                        #i.getOfficialName()#
                    </cfif>
                </td>
                <td>#DateFormat(i.getExpired(),"m/d/yyyy")#</td>
            </tr>
            </cfoutput>
            </cfloop>
        </tbody>
    </table>
    <input type="submit" name="generate" value="Generate Report" />    
    <cfoutput><input type="button" name="newSearch" value="New Search" href="#buildURL('')#" /></cfoutput>
</form>