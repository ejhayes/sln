component {
	function init() {
		// do nothing
	}
    
    // LOOKUP FUNCTIONS
    function lookups(){
        // returns lookups needed by apps
        ret = {};
        ret['statuses'] = EntityToQuery(EntityLoad("Statuses"));
        
        return ret;
    }
    
    function search(){
        // perform the search operation
        return ormExecuteQuery("from Applications");
    }
}