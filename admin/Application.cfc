component extends="framework" {
	this.name = "WII";
	this.sessionManagement = true;
    
    // location of config file
	this.configFile = "#GetDirectoryFromPath(GetCurrentTemplatePath())#config.ini";
	
	// load environment settings
	this.config = new Config(this.configFile).getSettings();
    
	variables.framework = {
        defaultItem = 'list',
		reloadApplicationOnEveryRequest = true
	};
}