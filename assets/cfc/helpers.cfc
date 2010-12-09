// Provides helper functions that can be used to make writing views less tedious and error prone
// and thus more readable (hopefully)
component {
    function init(struct config=structNew()){
        this.config = arguments.config;
    }

    function approvalStamp(string header, string approvalDivision, string approvalDate, string approvalName, string registrationNumber, numeric border=5, sizeFactor=.75, string dpr_logo="dpr.gif", numeric dpr_width=60, numeric dpr_height=45, string state_seal="california.jpg", numeric state_width=60, numeric state_height=60){
        var width = round(300 * arguments.sizeFactor);
        var height = round(193 * arguments.sizeFactor);
        var currentHeight = round(40 * arguments.sizeFactor);
        var textSize = round(20 * arguments.sizeFactor);
        var lineSpacing = round(3  * arguments.sizeFactor);
        var dprLogo = ImageRead(arguments.dpr_logo);
        var stateSeal = ImageRead(arguments.state_seal);
        var dpr_blue ="00247e";
        var dpr_green = "028536";
        var imgUtil = new imageUtils();
        var stamp=ImageNew("",width, height,"","white");
        var imageAttributes = {
            size = JavaCast("string",textSize),
            font = "Arial",
            style = "bold",
            lineHeight = JavaCast("string", textSize + lineSpacing),
            textAlign = "center"
        };
        
        // Resize image if needed
        ImageResize(dprLogo,arguments.dpr_width * arguments.sizeFactor,arguments.dpr_height * arguments.sizeFactor);
        ImageResize(stateSeal,arguments.state_width * arguments.sizeFactor,arguments.state_height * arguments.sizeFactor);
        
        // Add a border and make everything antialiased!
        ImageAddBorder(stamp,arguments.border,dpr_blue);
        ImageSetAntialiasing(stamp, "on");
        
        // Add the dpr logo to the bottom right
        ImagePaste(stamp, dprLogo,  width - round(arguments.dpr_width * arguments.sizeFactor), height - round(arguments.dpr_height * arguments.sizeFactor));
        
        // Add the california seal to the bottom left
        ImagePaste(stamp, stateSeal, 10, height - round(arguments.state_height * arguments.sizeFactor));
        
        // Set the headers
        ImageSetDrawingColor(stamp,dpr_blue);
        imgUtil.DrawTextArea(stamp, UCase(arguments.header), 0, currentHeight, width + (arguments.border*2), imageAttributes);
        currentHeight += imageAttributes['lineHeight'];
        
        // Add the DPR information
        textSize = textSize - lineSpacing - 1;
        imageAttributes['size'] = JavaCast("string",textSize);
        imageAttributes['lineHeight'] = JavaCast("string", textSize + lineSpacing);
        
        imgUtil.DrawTextArea(stamp, "State of California", 0, currentHeight, width + (arguments.border*2), imageAttributes);
        currentHeight += imageAttributes['lineHeight'];
        
        imgUtil.DrawTextArea(stamp, "Department of Pesticide Regulation", 0, currentHeight, width + (arguments.border*2 * (arguments.sizeFactor >= 1 ? -1: 1)), imageAttributes);
        currentHeight += imageAttributes['lineHeight'];
        
        imgUtil.DrawTextArea(stamp, arguments.approvalDivision, 0, currentHeight, width + (arguments.border*2), imageAttributes);
        currentHeight += imageAttributes['lineHeight'];
        
        // And additional label information
        ImageSetDrawingColor(stamp,dpr_green);
        
        imgUtil.DrawTextArea(stamp, arguments.approvalDate, 0, currentHeight, width + (arguments.border*2), imageAttributes);
        currentHeight += imageAttributes['lineHeight'];
        
        imgUtil.DrawTextArea(stamp, arguments.approvalName, 0, currentHeight, width + (arguments.border*2), imageAttributes);
        currentHeight += imageAttributes['lineHeight'];
        
        imgUtil.DrawTextArea(stamp, arguments.registrationNumber, 0, currentHeight, width + (arguments.border*2), imageAttributes);
        currentHeight += imageAttributes['lineHeight'];
        
        // return our spiffy image object
        return stamp;
    }
    
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
        
        // INTERNAL places we can go
        if( request.context.isInternal ){
            local.locations = {
                "TrackingSystem"="http://registration/track/reports/trackid_action.cfm?RequestTimeout=500&track_id=",
                "Label"="./assets/registration/labels/",
                "LabelUpload"="./assets/registration/labels/",
                "Chemical"="http://apps.cdpr.ca.gov/cgi-bin/mon/bycode.pl?p_chemcode=",
                "Product"="/label/cgi-bin/nl/pir.pl?p_prodno="
            };
        } else {
            // EXTERNAL Places we can go
            local.locations = {
                "Label"="http://www.cdpr.ca.gov/docs/label/pdf/sln/",
                "Chemical"="http://apps.cdpr.ca.gov/cgi-bin/mon/bycode.pl?p_chemcode=",
                "Product"="http://apps.cdpr.ca.gov/cgi-bin/label/label.pl?typ=pir&prodno="
            };
        }
        
        return locations[arguments.location] & arguments.id;
    }
    
    function pluralize(numeric quantity,string single,string plural=""){
        if( arguments.plural == "" ) arguments.plural = arguments.single & "s";
        return iif(quantity EQ 1,de(arguments.single),de(arguments.plural));
    }
}
