/*
	Special Use Tracking System
    Copyright (c) 2010, California Department of Pesticide Regulation

	Provides support functionality for the admin area.
*/
component {
	function init() {
		// do nothing
	}
    
    function index() {
		var ret = {};
        ret.incomplete = ormExecuteQuery("from Applications where specuse_no is null order by updated_date desc");
        ret.recent = ormExecuteQuery("from Applications order by updated_date desc",false,{maxResults=5});
        ret.totalPendingRecords = ormExecuteQuery("select count(*) from Applications where s_code = 'P'")[1];
        ret.totalActiveRecords = ormExecuteQuery("select count(*) from Applications where s_code = 'A'")[1];
        ret.totalInactiveRecords = ormExecuteQuery("select count(*) from Applications where s_code = 'I'")[1];
        ret.totalDeniedRecords = ormExecuteQuery("select count(*) from Applications where s_code = 'D'")[1];
        ret.totalRecords = ret.totalInactiveRecords + ret.totalActiveRecords;
        return ret;
    }
    
    // MULTISELECT LOOKUP FUNCTION
    function lookup(string src="", string q="") {
        // do the prep work
        if( arguments.src == "" ) return ""; // no need to do more work
        arguments.q = UCase(arguments.q); // capitalize for a case insensitive search
        
        // hibernate may give us any number of issues and we should be graceful
        try {
            // prepare the return query stuff
            if( q == "" ) return EntityToQuery(ormExecuteQuery("from #arguments.src# order by Description", false, {maxresults=60}));
            return EntityToQuery(ormExecuteQuery("from #arguments.src# where upper(Description) like '%" & arguments.q & "%' order by Description", false, {maxresults=250}));
        } catch(java.lang.Exception e){
            return ""; // an error should just be nothing yo
        }
        catch(Exception e){
            return e;
        }
    }
    
    // AUTOCOMPLETE LOOKUP FUNCTION
    function autocomplete(string src="", string term="") {
        // this is pretty much the lookup function with a different function signature
        return lookup(src=arguments.src, q=arguments.term);
    }
}