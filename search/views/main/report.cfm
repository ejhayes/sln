Report Page<br /><br />

<cfscript>
WriteDump(EntityToQuery(ormExecuteQuery("from Sites where Code in(" & "14022,14023" & ")")));
</cfscript>

