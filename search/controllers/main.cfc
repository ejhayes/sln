component {
    function init(fw) {
        variables.fw = fw;
    }

    // LOADING FUNCTIONS
    private function loadSearch(any rc){ // provides us with lookups, app persistent model, and official application name
        // load search dependencies
        variables.fw.service("main.lookups","lookups");
    }

	function index(any rc) {
        loadSearch(rc);
    
        rc.notice = {type="notice",message="Hovering your mouse over a criteria (registration number, issue date, chemical, etc.) will display additional help information."};
    
		rc.title = "Search Criteria";
        rc.designId = "I-4.0";
	}
}