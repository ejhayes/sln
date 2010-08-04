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
            ret.app.setIssued(arguments.issued);
            ret.app.setExpired(arguments.expired);
            ret.app.setInternalComments(arguments.internalComments);
            ret.app.setPublicComments(arguments.publicComments);
            
            EntitySave(ret.app);
            ormFlush(); // if there is an error, it will be reported asap
        }
        catch(java.lang.Exception e) {
            // my name is grace and i'm ful
            // incase hibernate has any issues persisting to the db
            ret.error = e;
        }
        
        return ret;
    }
}