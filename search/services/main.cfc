component {
	function init() {
		// nothing
        return "hey!";
	}
    
    // LOOKUP FUNCTIONS
    function lookups(){
        // returns lookups needed by apps
        ret = {};
        ret['statuses'] = EntityToQuery(EntityLoad("Statuses"));
        
        return ret;
    }
}