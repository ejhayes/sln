/*
	Special Use Tracking System
    Copyright (c) 2010, California Department of Pesticide Regulation

	Provides view specific functionality to special use registrations.
*/
component {
    function init(fw) {
        variables.fw = fw;
    }
    
    // OTHER WAYS TO RENDER PAGES (e.g. json)
    private function jsonView(){
        // we will be calling a service that will return the results in our json screen
        variables.fw.setView("registration.json");
    }
    
    // LOADING FUNCTIONS
    private function loadApp(any rc){ // provides us with lookups, app persistent model, and official application name
        // load app dependencies
        variables.fw.service("registration.lookups","lookups");
        
        // load the app
        if( structKeyExists(rc, "id") || structKeyExists(rc, "specialUseNumber") ) variables.fw.service("registration.get","app");
        else variables.fw.service("registration.new","app");
    }
    
    private function loadRev(any rc){ // provides us with lookups, app persistent model, and official application revision name
        // load rev dependencies
        variables.fw.service("registration.revisionLookups","lookups");
        
        // load the revision (we will never create a stub)
        if( structKeyExists(rc,"id") ) variables.fw.service("registration.getRevision","rev");
    }
    
    private function loadRevSite(any rc){ // provides us with lookups, app persistent model, and official application revision name
        // load site detail dependencies
        variables.fw.service("registration.revisionSiteLookups","lookups");
        
        // load the site details (from the revision)
        if( structKeyExists(rc,"id") ) variables.fw.service("registration.getRevision","rev");
    }
    
    // REGISTRATION APPLICATIONS
    function startApp(any rc) {
        loadApp(rc);
    }
    
    function endApp(any rc) {
        if( isNull(rc.app) ){
            rc.notice = {type="error", message="Record " & rc.specialUseNumber & " does not exist"};
            variables.fw.redirect("","notice");
        }
    
        // set the page title
        rc.title = "Edit Application: " & rc.app.name;
        
        // set the designId information
        if( rc.app.name == "NEW" ){
            rc.designId = "I-2.0";
            rc.title = rc.app.name;
        }
        else rc.designId = "I-2.1";
    }
    
    function endSave(any rc){
        // did we create a revision too?
        if( StructKeyExists(rc.data,"rev") ){
            // we did, so defer to the controller that already exists for revisions
            endAddRevision(rc);
        } else {
            // only the application was created, so handle normally!
            // was there an error?
            if( !isNull(rc.data.error) ){
                rc.notice = {type="error", message=rc.data.error.message};
            } else {
                rc.notice = {type="success", message="Record saved"};
            }
            rc.id = rc.data.app.getId();
            variables.fw.redirect("registration.app","notice","id");
        }
        
    }
    
    // REGISTRATION APPLICATION REVISIONS
    function endAddRevision(any rc){
        // was there an error?
        if( !isNull(rc.data.error) ){
            rc.notice = {type="error", message=rc.data.error.message};
            rc.id = rc.application; // the application id that was in scope when we tried to add this
            variables.fw.redirect("registration.app","notice","id");
        } else {
            // oki doki, to the page!
            rc.notice = {type="success", message="Revision created."};
            rc.id = rc.data.rev.getId();
            variables.fw.redirect("registration.rev","notice","id");
        }
    }
    
    function startRev(any rc){
        loadRev(rc);
    }
    
    function endRev(any rc){
        if( isNull(rc.rev) ){
            rc.notice = {type="error", message="Record " & rc.specialUseNumber & " does not exist"};
            variables.fw.redirect("","notice");
        }
    
        // set the page title
        if( rc.rev.record.getRevisionNumber() == 0 ) rc.title = rc.rev.name;
        else rc.title = "Details: " & rc.rev.name;
        rc.designId="I-3.0";
    }
    
    function startSaveRevision(any rc){
        rc.approvee = rc.user.getproperty('cn');
        rc.username = rc.user.getproperty('sAMAccountName');
    }
    
    function endSaveRevision(any rc){
        // was there an error?
        if( !isNull(rc.data.error) ){
            rc.notice = {type="error", message=rc.data.error.message};
        } else {
            rc.notice = {type="success", message="Record saved"};
        }

        // oki doki, to the page!
        rc.id = rc.data.rev.getId();
        
        if( StructKeyExists(rc,"continue") ) variables.fw.redirect("registration.sites","notice","id");
        else variables.fw.redirect("registration.rev","notice","id");
    }
    
    // REGISTRATION APPLICATION REVISION SITE INFORMATION (shortened to "Sites")
    // THIS IS THE "MEAT" OF THE APPLICATION!
    function startSites(any rc){
        loadRevSite(rc);
    }
    
    function endSites(any rc){
        if( isNull(rc.rev) ){
            rc.notice = {type="error", message="Record does not exist"};
            variables.fw.redirect("","notice");
        }
        
        param name="rc.mode" default="add";
        param name="rc.revisionSites" default="";
    
        // set the page title
        rc.title = "Sites: " & rc.rev.name;
        
        // set the designId
        switch(rc.mode){
            case "add":
                rc.designId = "I-9.1";
                break;
            case "edit":
                rc.designId = "I-9.2";
                break;
        }
    }
    
    function startSaveSites(any rc){
        // if we are about to start an edit, no additional processing is needed here
        if(rc.save == "Edit"){
            rc.mode = 'edit';
            variables.fw.redirect("registration.sites","revisionSites","id,mode");
        }
        
        // all additional processing will be done by the service
        rc.mode = LCase(rc.save);
    }
    
    function endSaveSites(any rc){
        // was there an error?
        if( !isNull(rc.data.error) ){
            rc.notice = {type="error", message=rc.data.error.message};
        } else {
            rc.notice = {type="success", message="Record saved"};
        }

        // oki doki, to the page!
        rc.id = rc.id;
        variables.fw.redirect("registration.sites","notice","id");
    }
    
    // SOME REMOTE FUNCTIONS WE WANT TO EXPOSE
    function removeLabel(any rc){
        jsonView();
    }
}