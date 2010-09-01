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
            sortList: eval($(this).attr('data-sort'))
        });
    });
    
    $(".autocomplete").each(function() {
        
        $(this).autocomplete({
            source: "index.cfm?action=admin:main.autocomplete&src=" + $(this).attr("data-src"),
            minLength: $(this).attr("data-minLength"),
            change: function(event, ui){
                var thisObj = $(this);
                var thisId = "#" + thisObj.attr("id");
                var updateTo = "";
                if(ui.item!=null) updateTo = ui.item.id;
                
                //update the existing value
                $(thisId + "-value").attr("value",updateTo);
            }
        });
        
        $("<input />")
            .attr("type","hidden")
            .attr("id",$(this).attr("id")+"-value")
            .attr("name", $(this).attr("id"))
            .attr("value", $(this).attr("data-value"))
            .insertAfter(this);
    });
    
    $(".datepicker").datepicker();
    
    $(".checkAll").click(function() {
        $("input[name=" + $(this).attr('data-target') + "]").attr('checked', $(this).is(':checked'))
    });
});