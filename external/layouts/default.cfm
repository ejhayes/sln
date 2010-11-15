<cfscript>
    if( getSectionAndItem() == "main.about" ){
        rc.title = "#this.config.name# Query";
    } else {
        rc.title = "#rc.title# - #this.config.name#";
    }
</cfscript>

<!--- Application specific header code --->
<cfsavecontent variable="head">
    <link rel="stylesheet"  href="assets/css/app.css" type="text/css" />
	<link type="text/css" rel="stylesheet" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.7.2/themes/base/ui.all.css" />
    <link type="text/css" rel="stylesheet" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.2/themes/smoothness/jquery-ui.css" />
	<link rel="stylesheet"  href="assets/css/ui.multiselect.css" type="text/css" />
    <link rel="stylesheet"  href="assets/css/tablesorter.css" type="text/css" />
    <style>
        #middle_column .ui-multiselect ul li { margin-bottom:0; }
        #middle_column .tablesorter thead tr th { color: black };
    </style>
	<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script> 
	<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.2/jquery-ui.min.js"></script>
	<script type="text/javascript" src="assets/js/tmpl/jquery.tmpl.1.1.1.js"></script> 
	<script type="text/javascript" src="assets/js/blockUI/jquery.blockUI.js"></script> 
    <script type="text/javascript" src="assets/js/jquery.placeholder.js"></script>
    <script type="text/javascript" src="assets/js/ui.multiselect.js"></script>
    <script type="text/javascript" src="assets/js/jquery.tablesorter.min.js"></script>
    <script type="text/javascript" src="assets/js/jquery.metadata.js"></script>
	<script type="text/javascript" src="assets/js/app.js"></script>
</cfsavecontent>

<cfsavecontent variable="pageBody">
<cfoutput>
<h1>#rc.title#</h1>

<cfswitch expression="#getSectionAndItem()#">
    <cfcase value="main.search">
        <ul id="breadcrumbs">
            <li><a href="#buildURL('search:')#">Start</a></li>
            <li>Search Results</li>
        </ul>
    </cfcase>
    <cfcase value="main.report">
        <ul id="breadcrumbs">
            <li><a href="#buildURL('search:')#">Start</a></li>
            <li>Search Results</li>
            <li>Full Report</li>
        </ul>
    </cfcase>
    <cfcase value="main.index">
        <p><a href="#buildURL('admin:main.about')#">Back to the overview page</a></p>
    </cfcase>
</cfswitch>
</cfoutput>

<cfif StructKeyExists(rc,"notice")>
    <div class="<cfoutput>#rc.notice.type#</cfoutput>"><image src="<cfoutput>assets/img/#rc.notice.type#.png</cfoutput>" height="15" />&nbsp;<cfoutput>#rc.notice.message#</cfoutput></div>
</cfif>

<cfoutput>#body#</cfoutput>
</cfsavecontent>

<cfscript>
param name="rc.title" default="California Department of Pesticide Regulation";
param name="rc.head" default="";
param name="rc.template" default="home_1col";

// Use the state template wrapping
if (!structKeyExists(this,'stateTemplate')){
    this.stateTemplate = new "resources.cfc.ca-template"();
}

// Apply the State Template
WriteOutput(
    this.stateTemplate.getWebPage(
        template:rc.template,
        title:rc.title,
        head: rc.head & head,
        page:pageBody)
);
</cfscript>