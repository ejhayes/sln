component {
    function init(fw) {
        variables.fw = fw;
    }
    
    private function newApp(any rc){
        // prepares a default app model
        rc.app = EntityNew("Applications");
        rc.app.setStatus(EntityLoad("Statuses","P",true));
        rc.app.setRegistrationType(EntityLoad("RegistrationTypes","B0",true));
    }
    
    private function loadApp(any rc){
        // loads the app model from existing, or a new one
        if( rc.application EQ "" ){
            // Set some defaults
            rc.app = EntityNew('Applications');
            rc.app.setStatus(EntityLoad("Statuses","P",true));
            rc.app.setRegistrationType(EntityLoad("RegistrationTypes","B0",true));
        } else {
            // or load an existing one
            rc.app = EntityLoadByPK('Applications', request.context.application);
        }
        
        // now return lookup details
        rc.statuses = EntityToQuery(EntityLoad('Statuses'));
        rc.registrationTypes = EntityToQuery(EntityLoad('RegistrationTypes'));
        
        // Format the dates nicely
        ret.app.setIssued(DateFormat(ret.app.getIssued(),"m/dd/yyyy"));
        ret.app.setExpired(DateFormat(ret.app.getExpired(),"m/dd/yyyy"));
    }
    
    function startSave(){
        // we need to capture all the form args!
        var app = "";
        
        if( rc.id EQ "" ){
            app = EntityNew('Applications');
        } else {
            app = EntityLoad('Applications',rc.id,true);
        }
        
        rc.status = EntityLoad('Statuses', rc.status, true);
        rc.registrationType = EntityLoad('RegistrationTypes', rc.registrationType, true);
        
        try {
            variables.fw.populate(app,'status,registrationType,internalComments,publicComments,specialUseNumber,issued,expired');
            // Save, flush, and check for errors!
            //EntitySave(app);
            //ORMFlush();
            rc.data.app = app;
            
            
            rc.application = app.getId();
            rc.notice = {type="success",message="Record saved"};
            variables.fw.redirect(action='registration.app', preserve="notice", append="application");
            //variables.fw.setView('registration.app');
        }
        catch(java.lang.Exception e) {
            rc.application = app.getId();
            rc.notice = {type="error",message=e};
            //variables.fw.setView('registration.app');
            variables.fw.redirect(action='registration.app', preserve="notice,data.app", append="application");
        }
    }
    
    function endSave(){
        // prepare a save message and reload the application details
        
        
        //rc.notice = { type="success", message="Record saved"};
        //rc.application = rc.data.app.getId();
        //variables.fw.redirect(action='registration.app', preserve="all");
    }
    
    function startApp() {
        // if an application has not been defined, go ahead and start a stub record
        if( !IsDefined("rc.application") ) rc.application = "";
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