component extends="assets.cfc.framework" {
	// load environment configuration settings
	this.config = new assets.cfc.Config(ExpandPath("./config.ini")).getSettings();
    
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
		eventhandler="model.eventHandler",
		logsql="false",
        savemapping="true"
	};
    
    // Setup the application
	variables.framework = {
        usingSubsystems = true,
        defaultSubsystem = 'admin',
        defaultItem = 'index',
        siteWideLayoutSubsystem = this.config.environment,
		reloadApplicationOnEveryRequest = this.config.debug,
        maxNumContextsPreserved=2,
        preserveKeyURLKey='p'
	};
    
    // if necessary, reset the application
    public function setupRequest() {
		if(structKeyExists(url, "init")) {
            // remove the generated xml files since they don't remove themselves
            hibernateFiles = directoryList(ExpandPath(this.ormsettings.cfclocation),false,"path","*.hbmxml");
            for(i=1;i LTE arrayLen(hibernateFiles); i++){
                FileDelete(hibernateFiles[i]);
            }
            
            // now reload the orm and app
            ormReload();
            setupApplication();
		}
	}
}