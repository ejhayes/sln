<cfscript>
    if (this.config.stage EQ "DEVELOPMENT") {
        if (isDefined("rc.designId")){
            pageHeader = rc.designId;
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
        if (isDefined("rc.title")){
           pageTitle = this.config.short_name & " - " & rc.title;
        } else {
            pageTitle = this.config.short_name;
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
    <link type="text/css" rel="stylesheet" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.2/themes/smoothness/jquery-ui.css" />
	<link rel="stylesheet"  href="assets/css/ui.multiselect.css" type="text/css" />
	<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script> 
	<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.2/jquery-ui.min.js"></script>
	<script type="text/javascript" src="assets/js/tmpl/jquery.tmpl.1.1.1.js"></script> 
	<script type="text/javascript" src="assets/js/blockUI/jquery.blockUI.js"></script> 
    <script type="text/javascript" src="assets/js/ui.multiselect.js"></script>
    </cfoutput>
	<script type="text/javascript">
	$(function() {
        $('.multiselect').each(function() { $(this).multiselect({remoteUrl:"index.cfm?action=admin:main.lookup", remoteParams: {src:$(this).attr('data-src')}}); })
        
        $(".autocomplete").each(function() {
			
			$(this).autocomplete({
                source: "index.cfm?action=admin:main.autocomplete&src=" + $(this).attr("data-src"),
                minLength: $(this).attr("data-minLength"),
                change: function(event, ui){
                    var thisObj = $(this);
                    var thisId = "#" + thisObj.attr("id");
                    var updateTo = "";
                    if(ui.item!=null) updateTo = ui.item.id;
                    
                    //console.debug(thisObj);
                    //console.debug(thisId);
                    
                    //update the existing value
                    $(thisId + "-value").attr("value",updateTo);
                }
            });
            
            $("<input />")
                .attr("type","hidden")
                .attr("id",$(this).attr("id")+"-value")
                .attr("name", $(this).attr("id"))
                .attr("value", $(this).attr("data-value"))
                .insertAfter(this);
        });
        
        $(".datepicker").datepicker();
	});
	</script>
</head>
<body>
<div id="wrapper">
    <div id="header">
        <cfoutput>
		<h1>#pageTitle#</h1>
        <p>Logged in as Eric Hayes (EHayes)</p>
		<p><a href="#buildURL('admin:')#">Home</a> | <a href="#buildURL('search:')#">Search</a> | <a href="#buildURL('admin:main.about')#">About</a></p>
        </cfoutput>
	</div>
    <cfif StructKeyExists(rc,"notice")>
    <div class="<cfoutput>#rc.notice.type#</cfoutput>"><image src="<cfoutput>assets/img/#rc.notice.type#.png</cfoutput>" height="15" />&nbsp;<cfoutput>#rc.notice.message#</cfoutput></div>
    </cfif>
    <cfoutput>#body#</cfoutput>

    <div id="footer">
    <p>
        <i>
            <!--- Format the footer in a friendly way --->
            &copy;<cfoutput>#dateFormat(now(),"YYYY")#</cfoutput> Department of Pesticide Regulation.  
            <cfif this.config.debug EQ True>
                Page generated in <cfoutput>#DateDiff("s", GetPageContext().GetFusionContext().GetStartTime(), Now())#</cfoutput> seconds.  
            </cfif>
            Problems?  <a href="http://csd" target="_blank">Submit a Track-It ticket</a> 
            or <a href="mailto:<cfoutput>#this.config.steward_email#</cfoutput>">Contact the Data Steward</a>.
        </i>
    </p>
    </div>
</div>

</body>
</html>