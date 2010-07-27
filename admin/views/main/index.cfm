<h3>Enter a Special Use Number to edit (or create a <a href="<cfoutput>#buildURL('registration.app')#</cfoutput>">new one</a>)</h3>

<form action="<cfoutput>#buildURL('registration.app')#</cfoutput>" method="post">
    <input name="application" type="text"></input>
    <input name="edit" type="submit" value="Edit"></input>
</form>

<br />

<h3>Statistics at a Glance</h3>
<ul>
<li>There are <a href="#">4 active applications</a>.</li>
<li>There are <a href="#">2 active applications with inactive products</a>.</li>
</ul>
<h3>Incomplete Applications</h3>
<p>
The following applications do not currently have a special use number associated with them.
</p>
<table width="100%"> 
    <thead> 
        <tr> 
            <th>Type</th> 
            <th>Issue Date</th> 
            <th>Expiration Date</th> 
            <th>Status</th> 
            <th>Created</th>
            <th>Revisions</th>
            <th>Actions</th> 
        </tr> 
    </thead> 
    <tbody> 
        <tr> 
            <td>SLN</td> 
            <td>1/1/2010</td> 
            <td>1/1/2011</td> 
            <td>ACTIVE</td> 
            <td>2 days ago by Eric Hayes</td> 
            <td>0</td>
            <td><a href="<cfoutput>#buildURL('registration.app&specialUseNumber=1234')#</cfoutput>">Open</a></td>
        </tr> 
    </tbody> 
</table> 