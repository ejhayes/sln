<cfset helper = new assets.cfc.helpers() />

<cfloop array="#rc.data#" index="i">
    <h2><cfoutput>#i.getOfficialName()# (#DateFormat(i.getIssued(),"m/d/yyyy")# - #DateFormat(i.getExpired(),"m/d/yyyy")#), #i.getStatus().getDescription()#</cfoutput></h2>
    
    <h3>Internal Comments</h3>
    <p><cfoutput>#i.getInternalComments()#</cfoutput></p>
    
    <h3>External Comments</h3>
    <p><cfoutput>#i.getPublicComments()#</cfoutput></p>
    
    <cfif i.hasRevisions()>
        <cfloop array="#i.getRevisions()#" index="i">
            <table width="100%" border="1"> 
                <thead>
                    <th colspan="2"><h4><cfoutput><a href="#buildURL('admin:registration.rev&id=' & i.getId())#">Revision #i.getRevisionNumber()#</a><cfif !isNull(i.getLabel())> (<a href="#helper.linkTo('Label',i.getLabel())#">view label</a>)</cfif></cfoutput></h4></th>
                </thead>
                <tbody>
                    <tr>
                        <td width="130px"><h5>Tracking ID</h5></td>
                        <td><cfoutput><a href="#helper.LinkTo('TrackingSystem',i.getCorrespondence().getCode())#" target="_blank">#i.getCorrespondence().getCode()#</a></cfoutput></td>
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
                            <cfoutput>
                            <h4 style="color:red">CALIFORNIA RESTRICTED</h4>
                            <a href="#helper.linkTo('Product',i.getProduct().getCode())#">#i.getProduct().getDescription()#</a>, <span style="color:red">INACTIVE</span>, <strong>CAUTION</strong><br /><br />
                            <strong>Ingredient(s):</strong><br />
                            <cfif i.getProduct().hasChemicals()>
                                <cfloop array="#i.getProduct().getChemicals()#" index="product">
                                    #product.getPercent()#% <a href="#helper.linkTo('Chemical',product.getChemical().getCode())#" target="_blank">#product.getChemical().getDescription()#</a><br />
                                </cfloop>
                            </cfif>
                            
                            <br /><strong>Pesticide Type:</strong><br />
                            <cfif i.getProduct().hasTypes()>
                                <cfloop array="#i.getProduct().getTypes()#" index="pesticide">
                                    #pesticide.getDescription()#<br />
                                </cfloop>
                            </cfif>
                            </cfoutput>
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