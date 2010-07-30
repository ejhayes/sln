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
    
    remote function lookup(string src="", string q="") {
    
        local.description = ORMGetSessionFactory().getClassMetaData('Sites').getPropertyColumnNames('Description')[1];
        //local.code = ORMGetSessionFactory().getClassMetaData('Sites').getPropertyColumnNames('Code')[1];
        
        if( arguments.src == "" ) return ""; // no need to do more work
        arguments.q = UCase(arguments.q); // capitalize for a case insensitive search
        try {
            if( q == "" ) return EntityToQuery(ormExecuteQuery("from #arguments.src#"));
            return EntityToQuery(ormExecuteQuery("from #arguments.src# where upper(#local.description#) like '%" & arguments.q & "%'"));
        } catch(java.lang.Exception e){
            return ""; // an error should just be nothing yo
        }
        catch(Exception e){
            return "";
        }
    }
}