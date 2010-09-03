<cfif this.isInternal>
    <cfset rc.notice = {type="notice", message="<i>When contacting IT please provide the following text with your request</i>: <b>APP:</b> #this.config.short_name#, <b>STEWARD:</b> #this.config.steward#, <b>DSN:</b> #this.config.dsn#, <b>ENVIRONMENT:</b> #this.config.environment#, <b>STAGE:</b> #this.config.stage#"} />    
<cfelse>
    <h1><cfoutput>#this.config.name# - #rc.title#</cfoutput></h1>
</cfif>

<p>The Department of Pesticide Regulation (DPR), under the authority of Section 24(c) of FIFRA (Federal Insecticide Fungicide Rodenticide Act), may register an additional use of a federally registered pesticide product, or a new end use product to meet a special local need if certain conditions exist.</p>

<p>This application is designed to allow users to search for all active and inactive special local need (SLN) registrations issued by DPR.  Users can enter various search criteria (crop/site, EPA registration number, chemical, etc.) to generate a list of matching special local need registrations in addition to their associated labels.</p>

<cfif !this.isInternal>
<ul>
    <li><cfoutput><a href="#buildURL('search:')#">Search the SLN database</a></cfoutput></li>
</ul>
</cfif>

For search-related questions, please contact:<br />
<cfoutput>
#this.config.steward#<br />
Phone: (#Left(this.config.steward_phone, 3)#) #Mid(this.config.steward_phone, 4,3)#-#Right(this.config.steward_phone, 4)#<br />
E-mail: <a href="mailto:#this.config.steward_email#">#this.config.steward_email#</a><br />
</cfoutput>