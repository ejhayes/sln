component {
	function init() {
		// nothing
        return "hey!";
	}
    
    function index() {
		var ret = {};
        ret.incomplete = ormExecuteQuery('from Applications where specuse_no is null order by updated_date desc');
        ret.totalActiveRecords = ormExecuteQuery("select count(*) from Applications where s_code = 'A'")[1];
        return ret;
    }
    
    function lookup(string src="", string q="") {
        // do the prep work
        if( arguments.src == "" ) return ""; // no need to do more work
        arguments.q = UCase(arguments.q); // capitalize for a case insensitive search
        
        // hibernate may give us any number of issues and we should be graceful
        try {
            // Get the physical column names we perform lookup on!
            local.description = ORMGetSessionFactory().getClassMetaData(arguments.src).getPropertyColumnNames('Description')[1];
            local.code = ORMGetSessionFactory().getClassMetaData(arguments.src).getPropertyColumnNames('Code')[1];

            // prepare the return query stuff
            if( q == "" ) return EntityToQuery(ormExecuteQuery("from #arguments.src#", false, {maxresults=20}));
            return EntityToQuery(ormExecuteQuery("from #arguments.src# where upper(#local.description#) like '%" & arguments.q & "%'", false, {maxresults=20}));
        } catch(java.lang.Exception e){
            return ""; // an error should just be nothing yo
        }
        catch(Exception e){
            return "";
        }
    }
    
    function autocomplete(string src="", string term="") {
        // this is pretty much the lookup function with a different function signature
        return lookup(src=arguments.src,q=arguments.term);
    }
}