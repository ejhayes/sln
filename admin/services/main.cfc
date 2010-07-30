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
    
    remote function lookup(string q="") {
        if( q == "" ) return EntityToQuery(EntityLoad("Counties"));
        return EntityToQuery(ormExecuteQuery("from Counties where description like '%" & arguments.q & "%'"));
    }
}