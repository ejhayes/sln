<cfscript>
    if (this.config.environment EQ "DEVELOPMENT") {
        if (isDefined("rc.designId")){
            pageHeader = designId;
        } else {
            pageHeader = this.config.name;
        }
        
        if (isDefined("rc.title")){
           pageTitle = this.config.short_name & " - " & rc.title;
        } else {
            pageTitle = this.config.name;
        }
    }
    else
    {
        if (isDefined("variables.pageTitle")){
           pageTitle = this.config.short_name & " - " & rc.title;
        } else {
            pageTitle = this.config.name;
        }
        pageHeader = pageTitle;
    }

</cfscript>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <cfoutput>
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
    <title><cfoutput>#pageHeader#</cfoutput></title>
	<link rel="stylesheet" href="assets/css/common.css" type="text/css" />
	<link rel="stylesheet" href="assets/css/app.css" type="text/css" />
	<link type="text/css" rel="stylesheet" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.7.2/themes/base/ui.all.css" />
	<link rel="stylesheet"  href="assets/css/ui.multiselect.css" type="text/css" />
	<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script> 
	<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.2/jquery-ui.min.js"></script>
	<script type="text/javascript" src="assets/js/ui.multiselect.js"></script>
    </cfoutput>
	<script type="text/javascript">
	$(function() {
		$(".multiselect").multiselect();
	});
	</script>
</head>
<body>
<div id="wrapper">
    <div id="header">
		<h1><cfoutput>#pageTitle#</cfoutput></h1>
        <p><cfoutput>Logged in as Eric Hayes (EHayes)</cfoutput></p>
		<p><a href=".">Home</a> | <a href="searchCriteria.cfm">Search</a> | <a href="about.cfm">About</a></p>
	</div>
    
    <cfoutput>#body#</cfoutput>

    <div id="footer">
    <p>
    <i>&copy;<cfoutput>#dateFormat(now(),"YYYY")#</cfoutput> Department of Pesticide Regulation.  
    <cfif this.config.debug EQ True>Page generated in <cfoutput>#DateDiff("s", GetPageContext().GetFusionContext().GetStartTime(), Now())#</cfoutput> seconds.  </cfif>
    Problems?  <a href="http://csd" target="_blank">Submit a Track-It ticket</a> 
    or <a href="mailto:<cfoutput>#this.config.steward_email#</cfoutput>">Contact the Data Steward</a>.</i></p>
    </div>
</div>

</body>
</html>