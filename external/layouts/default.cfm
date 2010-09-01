<!--- Application specific header code --->
<cfsavecontent variable="head">
    <link rel="stylesheet"  href="assets/css/app.css" type="text/css" />
	<link type="text/css" rel="stylesheet" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.7.2/themes/base/ui.all.css" />
    <link type="text/css" rel="stylesheet" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.2/themes/smoothness/jquery-ui.css" />
	<link rel="stylesheet"  href="assets/css/ui.multiselect.css" type="text/css" />
    <style>
        #middle_column .ui-multiselect ul li { margin-bottom:0; }        
    </style>
    <link rel="stylesheet"  href="assets/css/tablesorter.css" type="text/css" />
	<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script> 
	<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.2/jquery-ui.min.js"></script>
	<script type="text/javascript" src="assets/js/tmpl/jquery.tmpl.1.1.1.js"></script> 
	<script type="text/javascript" src="assets/js/blockUI/jquery.blockUI.js"></script> 
    <script type="text/javascript" src="assets/js/ui.multiselect.js"></script>
    <script type="text/javascript" src="assets/js/jquery.tablesorter.min.js"></script>
    <script type="text/javascript" src="assets/js/jquery.metadata.js"></script>
	<script type="text/javascript" src="assets/js/app.js">
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
        page:body)
);
</cfscript>