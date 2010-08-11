<!--- This function was provided in CF901.  When we update to 901 this can be removed --->
<cfcomponent>
<cffunction name="upload">
    <cfargument name="formfield" required="yes" hint="form field that contains the uploaded file">
    <cfargument name="dest" required="yes" hint="folder to save file. relative to web root">
    <cfargument name="conflict" required="no" type="string" default="Overwrite">
    <cfargument name="mimeTypesList" required="no" type="string" hint="mime types allowed to be uploaded" default="application/pdf">

    <cffile action="upload" fileField="#arguments.formField#" destination="#arguments.dest#" accept="#arguments.mimeTypesList#" nameConflict="#arguments.conflict#">

    <cfreturn cffile>
</cffunction>
</cfcomponent>