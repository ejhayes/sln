component {
	function init() {
		// nothing
        return "hey!";
	}
    
    function index() {
		var ret = {};
        ret.incomplete = ormExecuteQuery('from Applications where specuse_no is null');
        ret.totalActiveRecords = ormExecuteQuery("select count(*) from Applications where s_code = 'A'")[1];
        
        return ret;
    }
}