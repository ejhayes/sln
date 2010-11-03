$(function() {
    $('.toggleMultiselect').click(function(){
        $(this).toggleClass("active").next(".multiselect").multiselect('slideToggle');
    });

    $('form[data-confirm]').submit(function() {
        return confirm($(this).attr("data-confirm"));
    });
    
    $('.multiselect').each(function() { $(this).multiselect({hidden: $(this).attr('data-collapse') ? $(this).attr('data-collapse'): false, remoteUrl:"index.cfm?action=admin:main.lookup", remoteParams: {src:$(this).attr('data-src')}}); })
    
    $.tablesorter.defaults.widgets = ['zebra']; 
    $('.tablesorter').each(function() { 
        $(this).tablesorter({ 
            sortList: eval($(this).attr('data-sort')),
            textExtraction: function(node) { 
                // extract data from markup and return it  
                return (node.childNodes[0].innerHTML == undefined) ? node.childNodes[1].innerHTML : node.childNodes[0].innerHTML;
            } 
        });
    });
    
    $(".autocomplete").each(function() {
        
        $(this).autocomplete({
            source: "index.cfm?action=admin:main.autocomplete&src=" + $(this).attr("data-src"),
            minLength: $(this).attr("data-minLength"),
            focus: function(event, ui){
                // replace whatever value is in there
                $("#" + this.id + "-value").attr("value",ui.item.id);
            }
        });
        
        // prevent trying to refresh the page with an autocomplete textbox
        if ($.browser.mozilla) {
            $(this).keypress(checkForEnter);
        } else {
            $(this).keydown(checkForEnter);
        }

        function checkForEnter(event) {
            if (event.keyCode == 13) {
                event.preventDefault();
                    return false;
            }
        }
        
        // if we end up selecting nothing, make sure to clear out our value!
        $(this).blur(function(){
            if( this.value=="" ){
                $("#" + this.id + "-value").attr("value","");
            }
        });
        
        $("<input />")
            .attr("type","hidden")
            .attr("id",$(this).attr("id")+"-value")
            .attr("name", $(this).attr("id"))
            .attr("value", $(this).attr("data-value"))
            .insertAfter(this);
    });
    
    $(".datepicker").datepicker({
        changeMonth: true,
        changeYear: true
    });
    
    $(".checkAll").click(function() {
        $("input[name=" + $(this).attr('data-target') + "]").attr('checked', $(this).is(':checked'))
    });
});