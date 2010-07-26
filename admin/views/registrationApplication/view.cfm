A application view page.

<cfdump var="#rc#" />

<cfscript>
/*
a = EntityNew("Applications");
a.setSpecialUseNumber(123467);
a.setIssued("1/1/2010");
a.setExpired("1/2/2010");
a.setStatus("A");
a.setType("B0");
a.setInternalComments("An internal comment");
a.setPublicComments("A public comment");
EntitySave(a);
*/
WriteDump(EntityLoad("Pests",1));
</cfscript>