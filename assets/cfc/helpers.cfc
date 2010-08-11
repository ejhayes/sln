// Provides helper functions that can be used to make writing views less tedious and error prone
// and thus more readable (hopefully)
component {
    function relativeDate(required date dt){
        /*
         * Friendly Date Parse:
         * Displays a date in a human readable format as it is relative to the current time:
         * 
         * Within an hour:
         * x minutes ago
         * 
         * Within the day (<24 hours):
         * x hours ago
         * 
         * Within 2 weeks (<14 days):
         * x days ago
         * 
         * Within the year:
         * mmm/dd
         * 
         * Older:
         * m/d/yy
         */
        var time=now();
        var mins = datediff('n',dt,time);
        var hours = datediff('h',dt,time);
        var days = datediff('d',dt,time);
        
        // Process the date!
        if( mins == 1 ) return "1 minute ago";
        else if( mins < 60 ) return mins & " minutes ago";
        
        if( hours == 1) return "1 hour ago";
        else if( hours < 24 ) return hours & " hours ago";
        
        if( days == 1 ) return "1 day ago";
        if( days < 14 ) return days & " days ago";
        
        if( year(time) == year(dt) ) return DateFormat(dt, "mmm d");
        else return DateFormat(dt,"m/d/yy");
    }
    
    function linkTo(string location, string id=""){
        // returns a URL to a DPR point of interest
        
        // Places we can go
        var locations = {
            "TrackingSystem"="http://registration/track/reports/trackid_action.cfm?RequestTimeout=500&track_id=",
            "PDF"="http://docs.google.com/viewer?url=",
            "Label"="./assets/registration/labels/"
        };
        
        return locations[arguments.location] & arguments.id;
    }
}
