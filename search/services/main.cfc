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
    
    function search(string status="", string issuedStart="", string issuedEnd="", string registrationNumber="",string sites="", string pests="", string counties="", string chemicals="", string products="", string pesticideTypes=""){
        // use optimized oracle query to retrieve ids of relevant applications
        searchQuery = new Query();

        // iterate and build our search
        searchArray = [];

        // build up our search query
        // this could be done in a loop, but the search parameters may change over time
        // therefore i will build it in a procedural manner
        
        // STATUS
        if( arguments.status != "" ){
            searchQuery.addParam(name="status",value="#arguments.status#",cfsqltype="VARCHAR"); 
            ArrayAppend(searchArray, "select distinct ID as A_ID from SPECUSE.A_APPLICATIONS where S_CODE = :status");
        }
        
        // ISSUED DATE (range)
        if( arguments.issuedStart != "" || arguments.issuedEnd != "" ){
            // PROBLEM HERE
            searchQuery.addParam(name="issuedStart",value="#arguments.issuedStart#",cfsqltype="cf_sql_varchar",null=(arguments.issuedStart == ""));
            searchQuery.addParam(name="issuedStart",value="#arguments.issuedStart#",cfsqltype="cf_sql_varchar");
            searchQuery.addParam(name="issuedEnd",value="#arguments.issuedEnd#",cfsqltype="cf_sql_varchar",null=(arguments.issuedEnd == "")); 
            searchQuery.addParam(name="issuedEnd",value="#arguments.issuedEnd#",cfsqltype="cf_sql_varchar"); 
            
            ArrayAppend(searchArray, "
                select ID as A_ID from SPECUSE.A_APPLICATIONS 
                where
                    ( :issuedStart IS NULL OR ISSUE_DATE >= to_date( :issuedStart ,'mm/dd/yyyy') ) AND
                    ( :issuedEnd IS NULL OR ISSUE_DATE < to_date( :issuedEnd ,'mm/dd/yyyy')+1 )
            ");
        }
        
        // SITES
        if( arguments.sites != "" ){
            searchQuery.addParam(name="sites",value="#arguments.sites#",list="true",cfsqltype="VARCHAR"); 
            ArrayAppend(searchArray, "select distinct A_ID from SPECUSE.AR_APPLICATION_REVS where ID IN(select AR_ID from SPECUSE.ARS_APPLICATION_REV_SITES ARS where SITE_CODE in ( :sites ))");
        }
        
        // PESTS
        if( arguments.pests != "" ){
            searchQuery.addParam(name="pests",value=arguments.pests,list="true",cfsqltype="VARCHAR"); 
            ArrayAppend(searchArray, "select distinct A_ID from SPECUSE.AR_APPLICATION_REVS where ID IN(select AR_ID from SPECUSE.ARP_APPLICATION_REV_PESTS ARP where P_CODE in ( :pests ))");
        }
        
        // COUNTIES
        if( arguments.counties != "" ){
            searchQuery.addParam(name="counties",value=arguments.counties,list="true",cfsqltype="VARCHAR"); 
            ArrayAppend(searchArray, "select distinct A_ID from SPECUSE.AR_APPLICATION_REVS where ID IN(select AR_ID from SPECUSE.ARC_APPLICATION_REV_COUNTIES where C_CODE in ( :counties ))");
        }
        
        // CHEMICALS
        if( arguments.chemicals != "" ){
            searchQuery.addParam(name="chemicals",value=arguments.chemicals,list="true",cfsqltype="VARCHAR"); 
            ArrayAppend(searchArray, "select  distinct A_ID from SPECUSE.AR_APPLICATION_REVS where PRODNO in (select distinct prodno from label.prod_chem where chem_code in ( :chemicals ))");
        }
        
        // PRODUCTS
        if( arguments.products != "" ){
            searchQuery.addParam(name="products",value=arguments.products,list="true",cfsqltype="VARCHAR"); 
            ArrayAppend(searchArray, "select distinct A_ID from SPECUSE.AR_APPLICATION_REVS where PRODNO in ( :products )");
        }
        
        // PESTICIDE TYPES
        if( arguments.pesticideTypes != "" ){
            searchQuery.addParam(name="pesticideTypes",value=arguments.pesticideTypes,list="true",cfsqltype="VARCHAR"); 
            ArrayAppend(searchArray, "select distinct A_ID from SPECUSE.AR_APPLICATION_REVS where PRODNO in (select distinct prodno from label.prod_type_pesticide where TYPEPEST_CD in ( :pesticideTypes ))");
        }

        // just incase somebody doesn't search for anything
        if( ArrayLen(searchArray) == 0 ){
            return;
        } else {
            // now perform the query and intersect (i.e. and them together) the criteria together!
            searchQuery.setSQL(arrayToList(searchArray," intersect "));
            
            // perform the search operation
            local.res = searchQuery.execute().getResult();
            if( ValueList(local.res.A_ID) != "" ){
                return ormExecuteQuery("from Applications where Id in(" & ValueList(local.res.A_ID) & ")");
            } else {
                return;
            }
        }
    }
}