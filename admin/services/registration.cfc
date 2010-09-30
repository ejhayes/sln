/*
	Special Use Tracking System
    Copyright (c) 2010, California Department of Pesticide Regulation

	Provides support functionality for special use registrations.
*/
component {
	function init() {
        // do nothing
	}
    
    // LOOKUP FUNCTIONS
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
    
    function revisionSiteLookups(){
        // returns lookups needed by application revisions
        ret = {};
        ret['preHarvestMeasurements'] = EntityToQuery(EntityLoad("PreHarvestMeasurements"));
        ret['reEntryMeasurements'] = EntityToQuery(EntityLoad("ReEntryMeasurements"));
        
        return ret;
    }
    
    // MODEL CREATION FUNCTIONS
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
    
    function addRevision(string correspondenceCode="", string application="", deepCopy=""){
        // create a new revision for the current application
        var ret = {};
        
        try {
            local.correspondence = EntityLoadByPK("Correspondences",arguments.correspondenceCode);

            if( isNull(local.correspondence.getCorrespondenceType()) || !Find("24", local.correspondence.getCorrespondenceType().getCode() ) ) 
                throw "Invalid tracking id";
        
            if( deepCopy == "" ) {
                // create a new revision with no basis
                ret.rev = EntityNew("Revisions");
        
                // setup the correspondence and parent application on the new revision object
                ret.rev.setCorrespondence(local.correspondence);
                ret.rev.setApplication(EntityLoadByPK("Applications",arguments.application));
            } else {
                // TODO: use saveRevision() function instead of the code below
                // create a new revision based on the most recent revision
                // copy the following: revisionSites, revisionCounties, revisionPests, subtype, product
                
                // what is the most recent revision?
                local.rev = EntityLoadByPK("Applications",arguments.application).getCurrentRevision();
                
                // set revision details
                ret.rev = EntityNew("Revisions");
                ret.rev.setCorrespondence(local.correspondence);
                ret.rev.setApplication(local.rev.getApplication());
                ret.rev.setRegistrationSubtype(local.rev.getRegistrationSubtype());
                ret.rev.setProduct(local.rev.getProduct());
                
                // save the revision so we can get a revision id
                EntitySave(ret.rev);
                ormFlush(); // report an error if it occurs asap!
                
                // we should now have an id that we can use
                // for the relation properties
                
                // deep copy the pests
                local.pests = local.rev.getPests();
                for( i = 1; i <= arrayLen(local.pests); i++){
                    // create a stub object
                    local.pest = EntityNew("RevisionPests");
                    local.pest.setRevision(ret.rev);
                    local.pest.setPest(local.pests[i].getPest());
                    EntitySave(local.pest);
                }
                
                // deep copy the counties
                local.counties = local.rev.getCounties();
                for( i = 1; i <= arrayLen(local.counties); i++){
                    // create a stub object
                    local.county = EntityNew("RevisionCounties");
                    local.county.setRevision(ret.rev);
                    local.county.setCounty(local.counties[i].getCounty());
                    EntitySave(local.county);
                }
                
                // deep copy the sites
                local.sites = local.rev.getSites();
                for( i = 1; i <= arrayLen(local.sites); i++){
                    // create a stub object
                    local.site = EntityNew("RevisionSites");
                    local.site.setRevision(ret.rev);
                    local.site.setSite(local.sites[i].getSite());
                    local.site.setQualifier(local.sites[i].getQualifier());
                    local.site.setReEntryInterval(local.sites[i].getReEntryInterval());
                    local.site.setReEntryIntervalMeasurement(local.sites[i].getReEntryIntervalMeasurement());
                    local.site.setPreHarvestInterval(local.sites[i].getPreHarvestInterval());
                    local.site.setPreHarvestIntervalMeasurement(local.sites[i].getPreHarvestIntervalMeasurement());
                    EntitySave(local.site);
                }
            }
            
            // save the revision
            EntitySave(ret.rev);
            ormFlush(); // if there is an error, it will be reported asap
        }
        catch(java.lang.Exception e){
            // incase hibernate throws any errors at us
            ret.error = {message=e};
        }
        catch(Any e){
            // incase hibernate throws any errors at us
            ret.error = {message=e};
        }
        
        return ret;
    }
    
    // GET FUNCTIONS
    function get(string id, string specialUseNumber){
        // this function grabs an application
        var ret = {};
        if( StructKeyExists(arguments,"id") && isNumeric(arguments.id) ) ret.record = EntityLoadByPK("Applications", arguments.id);
        else if( StructKeyExists(arguments,"specialUseNumber") && isNumeric(arguments.specialUseNumber) ) ret.record = EntityLoad("Applications",{specialUseNumber=arguments.specialUseNumber},true);
        else return;
        
        // if we get nothing, return nothing
        if( isNull(ret.record) ) return;
        
        ret.name = ret.record.getOfficialName();
        
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
        
        ret.name = ret.record.getOfficialName();
        
        return ret;
    }
    
    // SAVE FUNCTIONS
    function save(string id, string status, string specialUseNumber, string registrationType, string issued, string expired, string internalComments, string publicComments, string correspondenceCode=""){
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
            
            /*
            SHORTCUT QUICK ADD INITIAL REVISION (per John Inouye, 9/29/2010 DEV NOTES):
            Since a tracking id can be provided, we can easily perform this step
            here.  Additional details about the reasoning is located with the
            registration.app view.
            */
            
            if( arguments.correspondenceCode != "" ){
                // call the add revision function
                local.retTemp = local.ret;
                ret = addRevision(arguments.correspondenceCode, ret.app.getId());
                if( StructKeyExists(ret,"error") ){
                    local.retTemp.error = local.ret.error; // grab the error
                    local.ret = local.retTemp; // reset out return structure
                    throw ret.error.message; // now throw an error and return normally as if we only created an app
                } else {
                    return ret; // return as if we created a revision
                }
            }
        }
        catch(java.lang.Exception e) {
            // my name is grace and i'm ful
            // incase hibernate has any issues persisting to the db do nothing
            ret.error = {message=e};
        }
        catch(any e) {
            // my name is grace and i'm ful
            // incase hibernate has any issues persisting to the db do nothing
            ret.error = {message=e};
        }
        
        return ret;
    }
    
    function saveRevision(string id, string registrationSubtype="", string approved="", string product="", string labelFile="", string pests="", string counties=""){
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
            if( arguments.registrationSubtype == "" ) ret.rev.setRegistrationSubtype(JavaCast("null",""));
            else ret.rev.setRegistrationSubtype(EntityLoadByPK("RegistrationSubtypes",arguments.registrationSubtype));
            
            // approval date
            if( arguments.approved == "" ) ret.rev.setApproved(JavaCast("null",""));
            else ret.rev.setApproved(arguments.approved);
            
            // pesticide product
            if( arguments.product == "" ) ret.rev.setProduct(JavaCast("null",""));
            else ret.rev.setProduct(EntityLoadByPK("Products",arguments.product));
            
            // counties
            local.countyActions = processDiff(
                ormExecuteQuery("select County.Code from RevisionCounties where Revision.Id=?",[arguments.id]), 
                ListToArray(arguments.counties)
            ); // which counties need to be added or removed?
            
            // add each county and link to the rev
            for( i=1; i<= ArrayLen(local.countyActions.add); i++ ){
                local.revisionCounty = EntityNew("RevisionCounties");
                local.revisionCounty.setRevision(ret.rev);
                local.revisionCounty.setCounty(EntityLoadByPK("Counties",local.countyActions.add[i]));
                EntitySave(local.revisionCounty);
            }
            
            // remove each county and unlink from the rev
            for( i=1; i<= ArrayLen(local.countyActions.remove); i++ ){
                EntityDelete(
                    EntityLoad("RevisionCounties",
                        {
                            Revision=ret.rev,
                            County=EntityLoadByPK("Counties",local.countyActions.remove[i])
                        },
                        true
                    )
                );
            }
            
            // pests
            local.pestActions = processDiff(
                ormExecuteQuery("select Pest.Code from RevisionPests where Revision.Id=?",[arguments.id]), 
                ListToArray(arguments.pests)
            ); // which pests need to be added or removed?
            
            // add each pest and link to the rev
            for( i=1; i<= ArrayLen(local.pestActions.add); i++ ){
                local.revisionPest = EntityNew("RevisionPests");
                local.revisionPest.setRevision(ret.rev);
                local.revisionPest.setPest(EntityLoadByPK("Pests",local.pestActions.add[i]));
                EntitySave(local.revisionPest);
            }
            
            // remove each pest and unlink from the rev
            for( i=1; i<= ArrayLen(local.pestActions.remove); i++ ){
                EntityDelete(
                    EntityLoad("RevisionPests",
                        {
                            Revision=ret.rev,
                            Pest=EntityLoadByPK("Pests",local.pestActions.remove[i])
                        },
                        true
                    )
                );
            }
            
            // upload the file
            if( arguments.labelFile != "" ){
                local.fileObj = new assets.cfc.file();
                local.helper = new assets.cfc.helpers();
                local.destination = ExpandPath(local.helper.linkTo('LabelUpload'));
                local.ret.fileRes = local.fileObj.upload("FORM.labelFile", local.destination & "/" & local.ret.rev.getCorrespondence().getCode() & ".pdf");
                
                // label
                //if( arguments.label == "" ) ret.rev.setLabel(JavaCast("null",""));
                //else ret.rev.setLabel(arguments.label);
                ret.rev.setLabel(local.ret.rev.getCorrespondence().getCode() & ".pdf");
            }
            
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
    
    function saveSites(
        string mode, // Add|Update|Edit|Delete
        string id,
        string revisionSites="", // if we are updating this will not be empty
        string sites, 
        string qualifier, 
        string reEntryInterval, 
        string reEntryIntervalMeasurement, 
        string preHarvestInterval, 
        string preHarvestIntervalMeasurement){
    
        // save site information for the revision
        local.ret = {};
                
        // set it, save it, love it
        try {
            // these parameters need to be set if we aren't deleting!
            if( arguments.mode != "delete" ){
                local.qualifier = EntityLoadByPK("Qualifiers",arguments.qualifier);
                local.reEntryIntervalMeasurement = EntityLoadByPK("ReEntryMeasurements",arguments.reEntryIntervalMeasurement);
                local.preHarvestIntervalMeasurement = EntityLoadByPK("preHarvestMeasurements",arguments.preHarvestIntervalMeasurement);
            }
        
            switch(arguments.mode){
                // ADD SITES: Create new entities, apply properties, persist
                case "add":
                    for( i = 1; i <= ListLen(arguments.sites); i++){
                        local.revSite = EntityNew("RevisionSites");
                        local.revSite.setRevision(EntityLoadByPK("Revisions", arguments.id));
                        local.revSite.setSite(EntityLoadByPK("Sites",ListGetAt(arguments.sites,i)));
                        local.revSite.setQualifier(local.Qualifier);
                        local.revSite.setReEntryInterval(arguments.reEntryInterval);
                        local.revSite.setReEntryIntervalMeasurement(local.reEntryIntervalMeasurement);
                        local.revSite.setPreHarvestInterval(arguments.preHarvestInterval);
                        local.revSite.setPreHarvestIntervalMeasurement(local.preHarvestIntervalMeasurement);
                        EntitySave(local.revSite);
                    }
                    break;
                
                // DELETE SITES: Loop through entities, delete
                case "delete":
                    for( i = 1; i <= ListLen(arguments.revisionSites); i++){
                        EntityDelete(EntityLoadByPK("RevisionSites", ListGetAt(arguments.revisionSites,i)));
                    }
                    break;
                    
                // UPDATE SITES: Load entities, modify, persist
                case "update":
                    for( i = 1; i <= ListLen(arguments.revisionSites); i++){
                        local.revSite = EntityLoadByPK("RevisionSites", ListGetAt(arguments.revisionSites,i));
                        local.revSite.setQualifier(local.Qualifier);
                        local.revSite.setReEntryInterval(arguments.reEntryInterval);
                        local.revSite.setReEntryIntervalMeasurement(local.reEntryIntervalMeasurement);
                        local.revSite.setPreHarvestInterval(arguments.preHarvestInterval);
                        local.revSite.setPreHarvestIntervalMeasurement(local.preHarvestIntervalMeasurement);
                        EntitySave(local.revSite);
                    }
                    break;
            }

            ormFlush(); // if there is an error, it will be reported asap
        }
        catch(java.lang.Exception e) {
            // my name is grace and i'm ful
            // incase hibernate has any issues persisting to the db do nothing
            ret.error = {message=e};
        }
        
        return ret;
    }
    
    // HELPER FUNCTIONS
    private function processDiff(any ormData, any userData){
        /* determines what needs to be added and what needs to be removed
         * uses underlying java set class for speed and access to set
         * operations such as intersect/disjoint!
         */
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
        ret["remove"] = [];
        ret["remove"].addAll(CreateObject( "java", "java.util.Arrays" ).AsList(toRemove.toArray()));
        
        // what needs to be added?
        toAdd.removeAll(local.matching);
        ret["add"] = [];
        ret["add"].addAll(CreateObject( "java", "java.util.Arrays" ).AsList(toAdd.toArray()));
        
        // thank you!
        return ret;
    }
}