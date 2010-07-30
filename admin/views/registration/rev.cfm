<cfset countyFields = [
	['01','Alameda'],             
    ['02','Alpine'],              
    ['03','Amador'],              
    ['04','Butte'],               
    ['05','Calaveras'],           
    ['06','Colusa'],              
    ['07','Contra Costa'],        
    ['08','Del Norte'],           
    ['09','El Dorado'],           
    ['10','Fresno'],              
    ['11','Glenn'],               
    ['12','Humboldt'],            
    ['13','Imperial'],            
    ['14','Inyo'],                
    ['15','Kern'],                
    ['16','KINGS'],               
    ['17','Lake'],                
    ['18','Lassen'],              
    ['19','Los Angeles'],         
    ['20','Madera'],              
    ['21','Marin'],               
    ['22','Mariposa'],            
    ['23','Mendocino'],           
    ['24','Merced'],              
    ['25','Modoc'],               
    ['26','Mono'],                
    ['27','Monterey'],            
    ['28','Napa'],                
    ['29','Nevada'],              
    ['30','Orange'],              
    ['31','Placer'],              
    ['32','Plumas'],              
    ['33','Riverside'],           
    ['34','Sacramento'],          
    ['35','San Benito'],          
    ['36','San Bernardino'],      
    ['37','San Diego'],           
    ['38','San Francisco'],       
    ['39','San Joaquin'],         
    ['40','San Luis Obispo'],     
    ['41','San Mateo'],           
    ['42','Santa Barbara'],       
    ['43','Santa Clara'],         
    ['44','Santa Cruz'],          
    ['45','Shasta'],              
    ['46','Sierra'],              
    ['47','Siskiyou'],            
    ['48','Solano'],              
    ['49','Sonoma'],              
    ['50','Stanislaus'],          
    ['51','Sutter'],              
    ['52','Tehama'],              
    ['53','Trinity'],             
    ['54','Tulare'],              
    ['55','Tuolumne'],            
    ['56','Ventura'],             
    ['57','Yolo'],                
    ['58','Yuba'],                
    ['00','Regional Office'] 
] />

<cfset displayFields = [
	['MICROORGANISMS (UNSPECIFIED)','MICROORGANISMS (UNSPECIFIED)'], 
	['SLIME-FORMING BACTERIA','SLIME-FORMING BACTERIA'], 
	['LEUCOTHRIX', 'LEUCOTHRIX'], 
	['AEROBIC HETEROTROPHIC BACTERIA', 'AEROBIC HETEROTROPHIC BACTERIA'], 
	['MINE ACID FORMATION BACTERIA', 'MINE ACID FORMATION BACTERIA'], 
	['DETERIORATION/SPOILAGE BACTERIA', 'DETERIORATION/SPOILAGE BACTERIA'],
	['THERMOPHILIC BACTERIA', 'THERMOPHILIC BACTERIA']
] />

<h3>Revision Details</h3>
Tracking ID <a href="http://registration/track/reports/trackid_action.cfm?RequestTimeout=500&track_id=121266" target="_blank">121266</a>

<cfform>
    <table>
    <tr><td><label>Special Use Subtype: </label></td></td><td><cfselect name="specialUseSubtype"><option value="firstParty">First Party</option><option value="thirdParty">Third Party</option></cfselect></td></tr>
    <tr><td><label>Approval Date: </label></td></td><td><cfinput name="approvalDate" type="datefield" /></td></tr>
    <tr><td><label>Product OR Registration Number: </label></td></td><td><cfinput style="width:500px;" name="product" autosuggest="BLUE SHIELD SAF-T-SHOCK (21268-50005-AA),ARTHITROL 0.5% DURSBAN ANT AND ROACH BAIT (11649-17-AA),ELGETOL (279-1853-AA),PRO GUARD LITHIUM HYPOCHLORITE (5185-340-ZB-35572)"></td></tr>
    <tr><td><label>Label PDF (<a href="SLN-56012-0.pdf" target="_blank">view</a>): </label></td></td><td><cfinput name="deepCopy" type="checkbox"><label>&nbsp;apply electronic stamp</label>&nbsp;<cfinput type="file" name="labelFile"></td></tr>
    <table>
<br />
<h3>Associated Pests <img src="pest.png" height="15"></h3>
<p>

<cfselect name="pests" multiple="yes" class="multiselect">
    <cfloop array="#displayFields#" index="field">
        <cfoutput>
            <option value="#field[1]#" <cfif ArrayContains(session.fields,"#field[1]#")>selected="selected"</cfif>>#field[2]#</option>
        </cfoutput>
    </cfloop>
</cfselect>
</p>
<h3>Associated Counties <img src="counties.png" height="15"></h3>
<p>

<cfselect name="counties" multiple="yes" class="multiselect">
    <cfloop array="#countyFields#" index="field">
        <cfoutput>
            <option value="#field[1]#" <cfif ArrayContains(session.fields,"#field[1]#")>selected="selected"</cfif>>#field[2]#</option>
        </cfoutput>
    </cfloop>
</cfselect>
</p>
<hr>
<cfinput type="button" name="next" value="Save and Continue" onclick="javascript:window.location='editSites.cfm?revisionId=3&mode=add'"/>
<cfinput type="button" name="saveClose" value="Save" onclick="javascript:window.location='?revisionId=3'"/>
<cfinput type="button" name="cancel" value="Close Revision" onclick="javascript:window.location='editApplication.cfm?specialUseNumber=1234'"/>
</cfform>