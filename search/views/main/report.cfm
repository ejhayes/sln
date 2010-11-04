<cfset helper = new assets.cfc.helpers(this.config) />

<cfset rc.notice = {type="notice", message="Click the back button on your browser to generate another report from your query results."} />    
<div class="report">
<cfloop array="#rc.data#" index="i">
    <div class="application">
        <cfoutput>
            <cfif this.isInternal >
                <a href="#buildURL('admin:registration.app&id=' & i.getId())#">#i.getRegistrationType().getDescription()# #i.getOfficialName()#</a>
            <cfelse>
                #i.getRegistrationType().getDescription()# #i.getOfficialName()#
            </cfif>
            (issued #DateFormat(i.getIssued(),"m/d/yyyy")#<cfif !isNull(i.getExpired())>, expires #DateFormat(i.getExpired(),"m/d/yyyy")#</cfif>), #i.getStatus().getDescription()#
        </cfoutput>
    </div>
    
    <cfif this.isInternal AND i.getInternalComments() NEQ "" >
        <h3>Internal Comments</h3>
        <p><cfoutput>#i.getInternalComments()#</cfoutput></p>
    </cfif>
    
    <cfif i.hasRevisions()>
        <div style="padding-left:15px">
        <cfloop array="#i.getRevisions()#" index="i">
            <table width="100%" border="1"> 
                <tbody>
                    <tr><td colspan="2" class="revision"><strong>
                    <cfoutput>
                    <cfif this.isInternal >
                        <a href="#buildURL('admin:registration.rev&id=' & i.getId())#">#i.getRevisionName()#</a>
                    <cfelse>
                        #i.getRevisionName()#
                    </cfif>

                    <cfif !isNull(i.getLabel()) >
                        ,&nbsp;<img src="assets/img/pdf.png" /> <a target="_blank" href="#helper.linkTo('Label',i.getLabel())#">View Label</a>
                    </cfif>
                    
                    <cfif !isNull(i.getDescription()) >
                        &nbsp;<strong><em>(#i.getDescription()#)</em></strong>
                    </cfif>
                    </cfoutput>
                    </strong></td></tr>
                    <tr>
                        <td width="130px"><strong>Tracking ID</strong></td>
                        <td><cfoutput>
                            <cfif this.isInternal >
                                <a href="#helper.LinkTo('TrackingSystem',i.getCorrespondence().getCode())#" target="_blank">#i.getCorrespondence().getCode()#</a>
                            <cfelse>
                                #i.getCorrespondence()#
                            </cfif>
                            </cfoutput>
                        </td>
                    </tr>
                    <tr>
                        <td width="130px"><strong>Approved</strong></td>
                        <td><cfoutput>#DateFormat(i.getApproved(),"m/d/yyyy")#</cfoutput></td>
                    </tr>
                    <tr>
                        <td><strong>Subtype</strong></td>
                        <td><cfif !isNull(i.getRegistrationSubtype())><cfoutput>#i.getRegistrationSubtype().getDescription()#</cfoutput></cfif></td>
                    </tr>
                    <tr>
                        <td><strong>Product Details</strong></td>
                        <td>
                            <cfif i.hasProduct() >
                                <cfoutput>
                                <cfif i.getProduct().hasRestrictedStatuses() >
                                    <cfset restrictedStatuses=EntityToQuery(i.getProduct().getRestrictedStatuses()) />
                                    <strong>Special Status: </strong>
                                    <span style="color:red">#ValueList(restrictedStatuses.DESCRIPTION,", ")#</span><br />
                                </cfif>
                                
                                <cfif i.getProduct().hasWarning() >
                                    <strong>Signal Word: </strong>
                                    <span style="color:red">#i.getProduct().getWarning().getDescription()#</span><br />
                                </cfif>
                                
                                <br />
                                <a target ="_blank" href="#helper.linkTo('Product',i.getProduct().getCode())#">#i.getProduct().getDescription()#</a>, 
                                <strong>#i.getProduct().getStatus().getDescription()#</strong><br /><br />
                                
                                <cfif i.getProduct().hasChemicals()>
                                    <strong>Ingredient(s):</strong><br />
                                    <cfloop array="#i.getProduct().getChemicals()#" index="product">
                                        #product.getPercent()#% <a href="#helper.linkTo('Chemical',product.getChemical().getCode())#" target="_blank">#product.getChemical().getDescription()#</a><br />
                                    </cfloop>
                                    <br />
                                </cfif>
                                
                                <cfif i.getProduct().hasTypes()>
                                    <strong>Pesticide Type:</strong><br />
                                    <cfloop array="#i.getProduct().getTypes()#" index="pesticide">
                                        #pesticide.getDescription()#<br />
                                    </cfloop>
                                </cfif>
                                </cfoutput>
                            </cfif>
                        </td>
                    </tr>
                    <tr>
                        <td><strong>Pests</strong></td>
                        <td>
                            <cfif i.hasPests()>
                                <cfloop array="#i.getPests()#" index="pest">
                                    <cfoutput>#pest.getPest().getDescription()#</cfoutput><br />
                                </cfloop>
                            </cfif>
                        </td>
                    </tr>
                    <tr>
                        <td><strong>Counties</strong></td>
                        <td>
                            <cfif i.hasCounties()>
                                <cfloop array="#i.getCounties()#" index="county">
                                    <cfoutput>#county.getCounty().getDescription()#</cfoutput><br />
                                </cfloop>
                            </cfif>
                        </td>
                    </tr>
                    <tr>
                        <td><cfoutput>
                            <cfif this.isInternal>
                                <a href="#buildURL('admin:registration.sites&id=' & i.getId())#"><strong>Sites</strong></a>
                            <cfelse>
                                <strong>Sites</strong>
                            </cfif>
                        </cfoutput></td>
                        <td>
                            <cfif i.hasSites()>
                                <cfloop array="#ormExecuteQuery('from RevisionSites where Revision.Id=? order by Site.Description',[i.getId()])#" index="site">
                                    <cfoutput>
                                        #site.getSite().getDescription()#,
                                        <span style="color:green">PHI:</span> <cfif isNull(site.getPreHarvestInterval())><em>not specified</em><cfelse>#site.getPreHarvestInterval()# #site.getPreHarvestIntervalMeasurement().getDescription()#</cfif>,
                                        <span style="color:green">RE:</span> <cfif isNull(site.getReEntryInterval())><em>not specified</em><cfelse>#site.getReEntryInterval()# #site.getReEntryIntervalMeasurement().getDescription()#</cfif>
                                    </cfoutput><br />
                                </cfloop>
                            </cfif>
                        </td>
                    </tr>
                </tbody>
            </table>
            <br>
        </cfloop>
        </div>
    <cfelse>
        <em>This application does not currently contain any data.</em>
    </cfif>
    <hr style="margin:25px 0px 25px 0px;">
</cfloop>
</div>