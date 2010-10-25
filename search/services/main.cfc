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
    
    function search(boolean isInternal, string status="", string issuedStart="", string issuedEnd="", string registrationNumber="",string sites="", string pests="", string counties="", string chemicals="", string products="", string pesticideTypes=""){
        var ret = {}; // the return object
        
        local.ret.results = [];
        local.ret.parameters = {};
        
        local.labelSchema = (arguments.isInternal ? "LABEL" : "MASTER"); // which schema?
        
        // iterate and build our search
        searchQuery = new Query();
        searchArray = [];

        // build up our search query
        // this could be done in a loop, but the search parameters may change over time
        // therefore i will build it in a procedural manner
        
        // STATUS
        if( arguments.status != "" ){
            local.ret.parameters.status = "Record status is: " & EntityLoadByPK("Statuses",arguments.status).getDescription();
            searchQuery.addParam(name="status",value="#arguments.status#",cfsqltype="cf_sql_varchar"); 
            ArrayAppend(searchArray, "select distinct ID as A_ID from SPECUSE.A_APPLICATIONS where S_CODE = :status");
        }
        
        // ISSUED DATE (range)
        if( arguments.issuedStart != "" || arguments.issuedEnd != "" ){
            if( arguments.issuedStart == "" && arguments.issuedEnd != ""){
                local.ret.parameters.issued = "Issued before " & DateFormat(arguments.issuedEnd,"m/d/yyyy");
            } else if( arguments.issuedStart != "" && arguments.issuedEnd == ""){
                local.ret.parameters.issued = "Issued after " & DateFormat(arguments.issuedStart,"m/d/yyyy");
            } else {
                local.ret.parameters.issued = "Issued between " & DateFormat(arguments.issuedStart,"m/d/yyyy") & " and " & DateFormat(arguments.issuedEnd,"m/d/yyyy");
            }
            searchQuery.addParam(name="issuedStart",value="#arguments.issuedStart#",cfsqltype="cf_sql_cf_sql_varchar",null=(arguments.issuedStart == ""));
            searchQuery.addParam(name="issuedStart",value="#arguments.issuedStart#",cfsqltype="cf_sql_cf_sql_varchar");
            searchQuery.addParam(name="issuedEnd",value="#arguments.issuedEnd#",cfsqltype="cf_sql_cf_sql_varchar",null=(arguments.issuedEnd == "")); 
            searchQuery.addParam(name="issuedEnd",value="#arguments.issuedEnd#",cfsqltype="cf_sql_cf_sql_varchar"); 
            
            ArrayAppend(searchArray, "
                select ID as A_ID from SPECUSE.A_APPLICATIONS 
                where
                    ( :issuedStart IS NULL OR ISSUE_DATE >= to_date( :issuedStart ,'mm/dd/yyyy') ) AND
                    ( :issuedEnd IS NULL OR ISSUE_DATE < to_date( :issuedEnd ,'mm/dd/yyyy')+1 )
            ");
        }
        
        // REGISTRATION NUMBER
        if( arguments.registrationNumber != "" ){
            local.ret.parameters.registrationNumber = "Registration number like " & arguments.registrationNumber;
            searchQuery.addParam(name="registrationNumber",value="#arguments.registrationNumber#",cfsqltype="cf_sql_varchar"); 
            ArrayAppend(searchArray, "select distinct A_ID from SPECUSE.AR_APPLICATION_REVS where PRODNO IN (SELECT PRODNO FROM #local.labelSchema#.product where SHOW_REGNO LIKE '%' || :registrationNumber || '%' )");
        }
        
        // SITES
        if( arguments.sites != "" ){
            local.ret.parameters.sites = "Contains any of these sites: " & ArrayToList(ormExecuteQuery("select Description from Sites where Code in(" & arguments.sites & ")"),", ");
            searchQuery.addParam(name="sites",value="#arguments.sites#",list="true",cfsqltype="cf_sql_varchar"); 
            ArrayAppend(searchArray, "select distinct A_ID from SPECUSE.AR_APPLICATION_REVS where ID IN(select AR_ID from SPECUSE.ARS_APPLICATION_REV_SITES ARS where SITE_CODE in ( :sites ))");
        }
        
        // PESTS
        if( arguments.pests != "" ){
            local.ret.parameters.pests = "Contains any of these pests: " & ArrayToList(ormExecuteQuery("select Description from Pests where Code in(" & arguments.pests & ")"),", ");
            searchQuery.addParam(name="pests",value=arguments.pests,list="true",cfsqltype="cf_sql_varchar"); 
            ArrayAppend(searchArray, "select distinct A_ID from SPECUSE.AR_APPLICATION_REVS where ID IN(select AR_ID from SPECUSE.ARP_APPLICATION_REV_PESTS ARP where P_CODE in ( :pests ))");
        }
        
        // COUNTIES
        if( arguments.counties != "" ){
            local.ret.parameters.counties = "Contains any of these counties: " & ArrayToList(ormExecuteQuery("select Description from Counties where Code in(" & arguments.counties & ")"),", ");
            searchQuery.addParam(name="counties",value=arguments.counties,list="true",cfsqltype="cf_sql_varchar"); 
            ArrayAppend(searchArray, "select distinct A_ID from SPECUSE.AR_APPLICATION_REVS where ID IN(select AR_ID from SPECUSE.ARC_APPLICATION_REV_COUNTIES where C_CODE in ( :counties ))");
        }
        
        // CHEMICALS
        if( arguments.chemicals != "" ){
            local.ret.parameters.chemicals = "Contains any of these chemicals: " & ArrayToList(ormExecuteQuery("select Description from Chemicals where Code in(" & arguments.chemicals & ")"),", ");
            searchQuery.addParam(name="chemicals",value=arguments.chemicals,list="true",cfsqltype="cf_sql_varchar"); 
            ArrayAppend(searchArray, "select  distinct A_ID from SPECUSE.AR_APPLICATION_REVS where PRODNO in (select distinct prodno from #local.labelSchema#.prod_chem where chem_code in ( :chemicals ))");
        }
        
        // PRODUCTS
        if( arguments.products != "" ){
            local.ret.parameters.products = "Contains any of these products: " & ArrayToList(ormExecuteQuery("select ShortDescription from Products where Code in(" & arguments.products & ")"),", ");
            searchQuery.addParam(name="products",value=arguments.products,list="true",cfsqltype="cf_sql_varchar"); 
            ArrayAppend(searchArray, "select distinct A_ID from SPECUSE.AR_APPLICATION_REVS where PRODNO in ( :products )");
        }
        
        // PESTICIDE TYPES
        if( arguments.pesticideTypes != "" ){
            local.ret.parameters.pesticideTypes = "Contains any products classified as: " & ArrayToList(ormExecuteQuery("select Description from PesticideTypes where Code in(" & ListQualify(arguments.pesticideTypes,"'") & ")"),", ");
            searchQuery.addParam(name="pesticideTypes",value=arguments.pesticideTypes,list="true",cfsqltype="cf_sql_varchar"); 
            ArrayAppend(searchArray, "select distinct A_ID from SPECUSE.AR_APPLICATION_REVS where PRODNO in (select distinct prodno from #local.labelSchema#.prod_type_pesticide where TYPEPEST_CD in ( :pesticideTypes ))");
        }

        // just incase somebody doesn't search for anything
        if( ArrayLen(searchArray) != 0 ){
            // now perform the query and intersect (i.e. and them together) the criteria together!
            searchQuery.setSQL(arrayToList(searchArray," intersect "));
            
            // perform the search operation
            local.res = searchQuery.execute().getResult();
            
            if( ValueList(local.res.A_ID) != "" ){
                local.ret.results = report(ValueList(local.res.A_ID));
            }
        } else {
            ret.error = "You must select at least 1 criteria.";
        }
        
        return ret;
    }
    
    function report(applications="",specialUseNumber=""){
        if( applications != "" ){
            return ormExecuteQuery("from Applications where Id in(" & arguments.applications & ")");
        }
        else if( arguments.specialUseNumber != "" && isNumeric(arguments.specialUseNumber) ){
            return ormExecuteQuery("from Applications where SpecialUseNumber = " & arguments.specialUseNumber);
        }
    }
}