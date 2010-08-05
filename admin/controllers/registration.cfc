component {
    function init(fw) {
        variables.fw = fw;
    }
    
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
    }
    
    function endSave(any rc){
        if( !isNull(rc.data.error) ){
            rc.notice = {type="error", message=rc.data.error.message};
            rc.id = rc.data.app.getId();
            variables.fw.redirect("registration.app","notice,id");
        } else {
            rc.id = rc.data.app.getId();
            variables.fw.redirect(action="registration.app",append="id");
        }
    }
    
    function endSaveRevision(any rc){
        if( !isNull(rc.data.error) ){
            rc.notice = {type="error", message=rc.data.error.message};
            rc.id = rc.data.rev.getId();
            variables.fw.redirect("registration.rev","notice,id");
        } else {
            rc.id = rc.data.rev.getId();
            variables.fw.redirect(action="registration.rev",append="id");
        }
    }
    
    function startRev(any rc){
        loadRev(rc);
    }
    
    function endRev(any rc){
        //rc.title="Details: SLN CA-56012-1";
        //rc.designId="I-3-0";
        
        if( isNull(rc.rev) ){
            rc.notice = {type="error", message="Record " & rc.specialUseNumber & " does not exist"};
            variables.fw.redirect("","notice");
        }
    
        // set the page title
        rc.title = "Edit Revision: " & rc.rev.name;
        
    }
}