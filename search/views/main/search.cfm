The following criteria were used for your search:

<ul>
    <li>Smell like catfish</li>
    <li>Tells jokes that aren't funny.  Like, not at all.  Seriously.</li>
</ul>

<div class="notice"><img src="assets/img/notice.png" height="15" /> Place a checkbox next to each application you want a full report on.  Once you have made your selection click the "Generate Report" button.</div>

<table>
    <thead>
        <tr>
            <th></th>
            <th>Brand Name</th>
            <th>Status</th>
            <th>SLN Number</th>
            <th>Expiration Date</th>
            <th>Labels</th>
        </tr>
    </thead>
    <tbody>
        <cfloop array="#rc.data#" index="i">
        <cfoutput>
        <tr>
            <td></td>
            <td></td>
            <td>#i.getStatus().getDescription()#</td>
            <td>#i.getOfficialName()#</td>
            <td>#DateFormat(i.getExpired(),"m/d/yyyy")#</td>
            <td>Nothing Yet</td>
        </tr>
        </cfoutput>
        </cfloop>
    </tbody>
</table>