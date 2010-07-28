component {
    function init(fw) {
        variables.fw = fw;
    }
    
    function startSave(){
        // we need to capture all the form args!
        
    }
    
    function endSave(){
        // prepare a save message and reload the application details
        
        
        rc.notice = { type="success", message="Record saved"};
        rc.application = rc.data.app.getId();
        variables.fw.redirect(action='registration.app', preserve="notice", append='application');
    }
    
    function startApp() {
        // if an application has not been defined, go ahead and start a stub record
        if( !IsDefined('rc.application') or rc.application EQ "" ) rc.application = 'NEW';
    }
    
    function endApp() {
        // set some stuff
        rc.data['Statuses'] = EntityToQuery(rc.data['Statuses']);
        rc.data['registrationTypes'] = EntityToQuery(rc.data['registrationTypes']);
        
        // set the page title
        if( isNull(rc.data.app.getId()) ){
            rc.title = "Create New SLN Application"; 
        } else {
            rc.title = "Edit Application CA-" & rc.data.app.getSpecialUseNumber();
        }
    }
}