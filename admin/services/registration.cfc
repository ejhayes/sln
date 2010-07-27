component {
	function init() {
		// nothing
        return "hey!";
	}
    
    function app() {
        // Should provide information for all drop down items
        // as well as load record information
        var ret = StructNew();
        
        // return application details
        if( request.context.application EQ "NEW" ){
            ret['app'] = EntityNew('Applications');
        } else {
            app = EntityLoad('Applications', request.context.application, true);
            if( isNull(app) ){
                ret['app'] = EntityNew('Applications');
            } else {
                ret['app'] = app;
            }
        }
        
        // now return lookup details
        ret['statuses'] = EntityLoad('Statuses');
        ret['registrationTypes'] = EntityLoad('RegistrationTypes');
        
        // and set any default record information
        if( isNull(ret.app.getStatus()) ) ret.app.setStatus(EntityLoad("Statuses","P",true));
        if( isNull(ret.app.getRegistrationType()) ) ret.app.setRegistrationType(EntityLoad("RegistrationTypes","B0",true));
        
        // Format the dates nicely
        ret.app.setIssued(DateFormat(ret.app.getIssued(),"m/dd/yyyy"));
        ret.app.setExpired(DateFormat(ret.app.getExpired(),"m/dd/yyyy"));
        return ret;
    }
    
    function save() {
        // persist stuff to the database
        //return EntitySave(request.context.data.app);
    }
}