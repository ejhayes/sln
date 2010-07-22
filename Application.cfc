component extends="framework" {
    // location of config file
	this.configFile = "#GetDirectoryFromPath(GetCurrentTemplatePath())#config.ini";
	
	// load environment settings
	this.config = new Config(this.configFile).getSettings();
    
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
		logsql="true"
	};
    
    // the environment will determine the layout subsystem
    switch(UCase(this.config.environment)){
        case "STAGING":
        case "PRODUCTION":
            layoutSubsystem="external";
            break;
        case "DEVELOPMENT":
        case "TESTING":
        default:
            layoutSubsystem="internal";
    }
    
    // Setup the application
	variables.framework = {
        usingSubsystems = true,
        defaultSubsystem = 'admin',
        defaultItem = 'main.default',
        siteWideLayoutSubsystem = layoutSubsystem,
		reloadApplicationOnEveryRequest = true
	};
    
    // if necessary, reset the application
    public function setupRequest() {
		if(structKeyExists(url, "init")) {
			setupApplication();
			ormReload();
			location(url="index.cfm",addToken=false);
		}	
	}
}