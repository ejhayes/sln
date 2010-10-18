component extends="assets.cfc.framework" {
	// load environment configuration settings
	this.config = new assets.cfc.Config(ExpandPath("./config.ini")).getSettings();
    
    // and set our mode of operation
    this.isInternal = (LCase(this.config.environment) == 'internal');
    
    // set the application information
    this.sessionManagement = true;
    this.name = this.config.short_name;
    
    // setup orm properties
    this.dataSource = this.config.dsn;
	this.ormEnabled = true;
	this.ormsettings = {
        dialect="Oracle10g",
		cfclocation="./model/" & LCase(this.config.environment),
		eventhandling="true",
		eventhandler="model.EventHandler",
		logsql="false",
        savemapping="true"
	};
    
    // Setup the application
	variables.framework = {
        usingSubsystems = true,
        defaultSubsystem = (this.isInternal ? 'admin' : 'search'), // set default subsystem!
        defaultItem = 'index',
        siteWideLayoutSubsystem = LCase(this.config.environment),
		reloadApplicationOnEveryRequest = this.config.debug,
        maxNumContextsPreserved=2,
        preserveKeyURLKey='p'
	};
    
    // if necessary, reset the application
    public function setupRequest() {
		if(structKeyExists(url, "init")) {
            // remove the generated hbxml files since they don't remove themselves
            hibernateFiles = directoryList(ExpandPath(this.ormsettings.cfclocation),false,"path","*.hbmxml");
            for(i=1;i LTE arrayLen(hibernateFiles); i++){
                FileDelete(hibernateFiles[i]);
            }
            
            // now reload the orm and app
            ormReload();
            setupApplication();
		}
        
        if( this.isInternal and isNull(request.context.user) ){
            request.context.user = createObject('component','common_cfc.ldap_security.ldap').getUser(reReplaceNoCase(cgi.auth_user,'DPRNTDOM\\',''));
        }
        
        // since not everything has access to this variable
        request.context.isInternal = this.isInternal;
	}
}