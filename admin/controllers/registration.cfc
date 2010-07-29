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
    
    function startRev(any rc){
    
    }
}