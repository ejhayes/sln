component {
    function init(fw) {
        variables.fw = fw;
    }

    // LOADING FUNCTIONS
    private function loadSearchCriteria(any rc){ // provides us with lookups, app persistent model, and official application name
        // load search dependencies
        variables.fw.service("main.lookups","lookups");
    }

	function index(any rc) {
        loadSearchCriteria(rc);
        
        if( isNull(rc.notice) ){    
            rc.notice = {type="notice",message="Choose one or more criteria.  When you are finished, click the 'Search' button.  <br><br><strong>This database contains SLN information since 2000.  Historical data will be added on an ongoing basis.</strong>"};
        }
    
		rc.title = "Search Criteria";
        rc.designId = "I-4.0";
	}
    
    function endSearch(any rc){
        // prepare the search results to display to the user
        if( StructKeyExists(rc.data,"error") ){
            rc.notice = {type="error",message=rc.data.error };
            variables.fw.redirect("","NOTICE");
        }
        
        if( ArrayLen(rc.data.results) == 0 ){
            rc.notice = {type="error",message="No records found."};
            variables.fw.redirect("","ALL");
        } else {
            local.helper = new assets.cfc.helpers();
            rc.title = ArrayLen(rc.data.results) & helper.pluralize(ArrayLen(rc.data.results)," Result") & " found";
            rc.designId = "I-5.0";
        }
    }
    
    function endReport(any rc){
        // prepare the report page
        if( isNull(rc.data) || arrayLen(rc.data) == 0 ){
            rc.notice = {type="error",message="No records found."};
            variables.fw.redirect("main.index","ALL");
        } else {
            local.helper = new assets.cfc.helpers();
            rc.title = "Full Information " & helper.pluralize(ArrayLen(rc.data),"Report");
            rc.designId = "I-6.0";
        }
    }
}