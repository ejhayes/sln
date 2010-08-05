component {
	function init() {
        // do nothing
	}
    
    function lookups(){
        // returns lookups needed by apps
        ret = {};
        ret['statuses'] = EntityToQuery(EntityLoad("Statuses"));
        ret['registrationTypes'] = EntityToQuery(EntityLoad("RegistrationTypes"));
        
        return ret;
    }
    
    function revisionLookups(){
        // returns lookups needed by application revisions
        ret = {};
        ret['registrationSubtypes'] = EntityToQuery(EntityLoad("RegistrationSubtypes"));
        
        return ret;
    }
    
    function new(){
        // return a new skeleton app
        var ret = {};
        ret.record = EntityNew("Applications");
        ret.name = "NEW";
        
        // set some defaults
        ret.record.setStatus(EntityLoadByPK("Statuses","P"));
        ret.record.setRegistrationType(EntityLoadByPK("RegistrationTypes","B0"));

        return ret;
    }
    
    function addRevision(string correspondenceCode="", string application=""){
        // create a new revision for the current application
        var ret = {};
        var app = EntityLoadByPK("Applications",arguments.application);
        ret.rev = EntityNew("Revisions");
        
        // set the correspondence on the new revision object
        ret.rev.setCorrespondence(EntityLoadByPK("Correspondences",arguments.correspondenceCode));
        
        try {
            // save the revision (done implicitly)
            app.addRevisions(rev);
        }
        catch(java.lang.Exception e){
            // incase hibernate throws any errors at us
            ret.error = e;
        }
        
        return ret;
    }
    
    function get(string id, string specialUseNumber){
        // this function grabs an application
        var ret = {};
        if( StructKeyExists(arguments,"id") && isNumeric(arguments.id) ) ret.record = EntityLoadByPK("Applications", arguments.id);
        else if( StructKeyExists(arguments,"specialUseNumber") && isNumeric(arguments.specialUseNumber) ) ret.record = EntityLoad("Applications",{specialUseNumber=arguments.specialUseNumber},true);
        else return;
        
        // if we get nothing, return nothing
        if( isNull(ret.record) ) return;
        
        if( ret.record.getSpecialUseNumber() == "" ) ret.name = "UNKNOWN";
        else ret.name = "CA-" & ret.record.getSpecialUseNumber();
        
        return ret;
    }
    
    function getRevision(string id, string correspondenceCode){
        // retrieves  and application revision
        var ret = {};
        
        if( StructKeyExists(arguments,"id") && isNumeric(arguments.id) ) ret.record = EntityLoadByPK("Revisions", arguments.id);
        else if( StructKeyExists(arguments,"correspondenceCode") && isNumeric(arguments.correspondenceCode) ){
            // setup a skeleton object that meets the criteria we desire
            local.cor = EntityNew("Correspondence");
            local.cor.setCode(arguments.correspondenceCode);
            local.rev = EntityNew("Revisions");
            local.rev.setCorrespondence(local.cor);
            
            // and load it  by "Example" (true so we don't get an array returned!)
            ret.record = EntityLoadByExample(local.rev, true);
        }
        else return;
        
        // if we get nothing, return nothing
        if( isNull(ret.record) ) return;
        
        if( ret.record.getCorrespondence().getCode() == "" ) ret.name = "UNKNOWN";
        else ret.name = "CA-" & ret.record.getApplication().getSpecialUseNumber() & " rev. " & ret.record.getCorrespondence().getCode();
        
        return ret;
    }
    
    function save(string id, string status, string specialUseNumber, string registrationType, string issued, string expired, string internalComments, string publicComments){
        // save the app
        local.ret = {};
        local.registrationType = EntityLoadByPK("RegistrationTypes",arguments.registrationType);
        local.status = EntityLoadByPK("Statuses",arguments.status);
        
        // prepare stub app object
        if( arguments.id == "" ) ret.app = EntityNew("Applications");
        else ret.app = EntityLoadByPK("Applications",arguments.id);
        
        // set it, save it, love it
        try {
            ret.app.setStatus(local.status);
            if( arguments.specialUseNumber == "" ) ret.app.setSpecialUseNumber(JavaCast("null",""));
            else ret.app.setSpecialUseNumber(arguments.specialUseNumber);
            ret.app.setRegistrationType(local.registrationType);
            
            // issued
            if( arguments.issued == "" ) ret.app.setIssued(JavaCast("null",""));
            else ret.app.setIssued(arguments.issued);
            
            // expired
            if( arguments.expired == "" ) ret.app.setExpired(JavaCast("null",""));
            else ret.app.setExpired(arguments.expired);
            
            //internal comments
            if( arguments.internalComments == "" ) ret.app.setInternalComments(JavaCast("null",""));
            else ret.app.setInternalComments(arguments.internalComments);
            
            //public comments
            if( arguments.publicComments == "" ) ret.app.setPublicComments(JavaCast("null",""));
            else ret.app.setPublicComments(arguments.publicComments);
            
            EntitySave(ret.app);
            ormFlush(); // if there is an error, it will be reported asap
        }
        catch(java.lang.Exception e) {
            // my name is grace and i'm ful
            // incase hibernate has any issues persisting to the db do nothing
            ret.error = {message=e};
        }
        
        return ret;
    }
    
    private function processDiff(array ormData, array userData){
        // determines what needs to be added and what needs to be removed
        // uses underlying java set class for speed and access to set
        // operations such as intersect/disjoint!
        var ret = {};
        var toAdd = createObject("java", "java.util.HashSet").init(arguments.userData);
        var currentData = ArrayNew(1);
        
        // alleviate casting issues between cf and underlying java
        for( i=1; i<=ArrayLen(arguments.ormData); i++){
            ArrayAppend(local.currentData,javaCast("string",arguments.ormData[i]));
        }
        
        // use our converted data here
        local.matching = createObject("java", "java.util.HashSet").init(local.currentData);
        local.toRemove = createObject("java", "java.util.HashSet").init(local.currentData);
        
        // determine what is matching
        matching.retainAll(arguments.userData);
        
        // what needs to be removed?
        toRemove.removeAll(local.matching);
        ret.remove = local.toRemove.toArray();
        
        // what needs to be added?
        toAdd.removeAll(local.matching);
        ret.add = local.toAdd.toArray();
        
        // thank you!
        return ret;
    }
    
    function saveRevision(string id, string registrationSubtype="", string approved="", string product="", string label="", string pests="", string counties=""){
        // save the revision
        local.ret = {};
        
        // can i get your name please?
        if( arguments.id == "" ){
            ret.error = {message="Revision not specified"};
            return ret;
        }
        
        // i have a large order of fries good to go
        ret.rev = EntityLoadByPK("Revisions",arguments.id);
        
        // my bad, there were no fries.  have a nice day
        if( isNull(ret.rev) ){
            ret.error = {message="Could not find revision with id " & arguments.id};
            return ret;
        }
        
        // set it, save it, love it
        try {
            // registration subtype
            if( arguments.registrationSubtype == "" ) ret.rev.setRegtistrationSubtype(JavaCast("null",""));
            else ret.rev.setRegistrationSubtype(EntityLoadByPK("RegistrationSubtypes",arguments.registrationSubtype));
            
            // approval date
            if( arguments.approved == "" ) ret.rev.setApproved(JavaCast("null",""));
            else ret.rev.setApproved(arguments.approved);
            
            // pesticide product
            if( arguments.product == "" ) ret.rev.setProduct(JavaCast("null",""));
            else ret.rev.setProduct(EntityLoadByPK("Products",arguments.product));

            // label
            if( arguments.label == "" ) ret.rev.setLabel(JavaCast("null",""));
            else ret.rev.setLabel(arguments.label);
            
            // counties
            local.countyActions = processDiff(
                ormExecuteQuery("select County.Code from RevisionCounties where Revision.Id=?",[arguments.id]), 
                ListToArray(arguments.counties)
            ); // which counties need to be added or removed?
            
            // pests
            local.pestActions = processDiff(
                ormExecuteQuery("select Pest.Code from RevisionPests where Revision.Id=?",[arguments.id]), 
                ListToArray(arguments.pests)
            ); // which pests need to be added or removed?
            
            // save it all up
            EntitySave(ret.rev);
            ormFlush(); // if there is an error, it will be reported asap
        }
        catch(java.lang.Exception e) {
            // my name is grace and i'm ful
            // incase hibernate has any issues persisting to the db do nothing
            ret.error={message=e};
        }
        
        return ret;
    }
}