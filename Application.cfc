component extends="framework" {
	// load environment configuration settings
	this.config = new Config(ExpandPath("./config.ini")).getSettings();
    
    // set the application information
    this.sessionManagement = true;
    this.name = this.config.short_name;
    
    // setup orm properties
    this.dataSource = this.config.dsn;
	this.ormEnabled = true;
	this.ormsettings = {
        dialect="Oracle10g",
		cfclocation="./model",
		eventhandling="true",
		eventhandler="model.eventHandler",
		logsql="false"
	};
    
    // Setup the application
	variables.framework = {
        usingSubsystems = true,
        defaultSubsystem = 'admin',
        defaultItem = 'index',
        siteWideLayoutSubsystem = this.config.environment,
		reloadApplicationOnEveryRequest = this.config.debug
	};
    
    // if necessary, reset the application
    public function setupRequest() {
		if(structKeyExists(url, "init")) {
			setupApplication();
			ormReload();
			location(url=".",addToken=false);
		}	
	}
}