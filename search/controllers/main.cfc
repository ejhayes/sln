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
    
        rc.notice = {type="notice",message="Hovering your mouse over a criteria (registration number, issue date, chemical, etc.) will display additional help information."};
    
		rc.title = "Search Criteria";
        rc.designId = "I-4.0";
	}
    
    function endSearch(any rc){
        // prepare the search results to display to the user
        local.helper = new assets.cfc.helpers();
        rc.title = ArrayLen(rc.data) & helper.pluralize(ArrayLen(rc.data)," Result") & " found";
        rc.designId = "I-5.0";
    }
}