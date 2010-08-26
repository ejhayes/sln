<cfset helper = new assets.cfc.helpers() />

<cfloop array="#rc.data#" index="i">
    <h2>
        <cfoutput>
            <cfif this.isInternal >
                <a href="#buildURL('admin:registration.app&id=' & i.getId())#">#i.getOfficialName()#</a>
            <cfelse>
                #i.getOfficialName()#
            </cfif>
            (#DateFormat(i.getIssued(),"m/d/yyyy")# - #DateFormat(i.getExpired(),"m/d/yyyy")#), #i.getStatus().getDescription()#
        </cfoutput>
    </h2>
    
    <cfif this.isInternal AND i.getInternalComments() NEQ "" >
    <div class="notice">
    <h3>Internal Comments</h3>
    <p><cfoutput>#i.getInternalComments()#</cfoutput></p>
    </div>
    </cfif>
    
    <cfif i.getPublicComments() NEQ "" >
    <h3>External Comments</h3>
    <p><cfoutput>#i.getPublicComments()#</cfoutput></p>
    </cfif>
    
    <cfif i.hasRevisions()>
        <cfloop array="#i.getRevisions()#" index="i">
            <table width="100%" border="1"> 
                <tbody>
                    <tr>
                        <td colspan="2">
                            <h4><cfoutput>
                                <cfif this.isInternal >
                                    <a href="#buildURL('admin:registration.rev&id=' & i.getId())#">Revision #i.getRevisionNumber()#</a>
                                <cfelse>
                                    Revision #i.getRevisionNumber()#
                                </cfif>

                                &nbsp;(<a href="#helper.linkTo('Label',i.getLabel())#">view label</a>)
                            </cfoutput></h4>
                        </td>
                    </tr>
                    <tr>
                        <td width="130px"><h5>Tracking ID</h5></td>
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
                        <td width="130px"><h5>Approved</h5></td>
                        <td><cfoutput>#DateFormat(i.getApproved(),"m/d/yyyy")#</cfoutput></td>
                    </tr>
                    <tr>
                        <td><h5>Subtype</h5></td>
                        <td><cfif !isNull(i.getRegistrationSubtype())><cfoutput>#i.getRegistrationSubtype().getDescription()#</cfoutput></cfif></td>
                    </tr>
                    <tr>
                        <td><h5>Product Details</h5></td>
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
                                <a href="#helper.linkTo('Product',i.getProduct().getCode())#">#i.getProduct().getDescription()#</a>, 
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
                        <td><h5>Pests</h5></td>
                        <td>
                            <cfif i.hasPests()>
                                <cfloop array="#i.getPests()#" index="pest">
                                    <cfoutput>#pest.getPest().getDescription()#</cfoutput><br />
                                </cfloop>
                            </cfif>
                        </td>
                    </tr>
                    <tr>
                        <td><h5>Counties</h5></td>
                        <td>
                            <cfif i.hasCounties()>
                                <cfloop array="#i.getCounties()#" index="county">
                                    <cfoutput>#county.getCounty().getDescription()#</cfoutput><br />
                                </cfloop>
                            </cfif>
                        </td>
                    </tr>
                    <tr>
                        <td><h5><cfoutput><a href="#buildURL('admin:registration.sites&id=' & i.getId())#">Sites</a></cfoutput></h5></td>
                        <td>
                            <cfif i.hasSites()>
                                <cfloop array="#i.getSites()#" index="site">
                                    <cfoutput>
                                        #site.getSite().getDescription()#,
                                        PHI: #site.getPreHarvestInterval()# #site.getPreHarvestIntervalMeasurement().getDescription()#,
                                        RE: #site.getReEntryInterval()# #site.getReEntryIntervalMeasurement().getDescription()#
                                    </cfoutput><br />
                                </cfloop>
                            </cfif>
                        </td>
                    </tr>
                </tbody>
            </table>
            <br>
        </cfloop>
    </cfif>
    
</cfloop>