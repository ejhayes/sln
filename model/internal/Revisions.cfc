/**
 * @persistent
 */
component schema="SPECUSE" table="AR_APPLICATION_REVS" 
{
    property name="Id" fieldtype="id" generator="sequence" ormtype="int" params="{sequence='AR_SEQ'}";
    property name="Application" fkcolumn="A_ID" cfc="Applications" fieldtype="one-to-one";
    property name="Description" column="DESCRIPTION";
    property name="Correspondence" fkcolumn="TRACKID" cfc="Correspondences" fieldtype="one-to-one";
    property name="Product" fkcolumn="PRODNO" cfc="Products" fieldtype="one-to-one";
    property name="RegistrationSubtype" fkcolumn="US_CODE" cfc="RegistrationSubtypes" fieldtype="one-to-one";
    property name="Approved" column="APPROVAL_DATE";
    property name="Label" column="LABEL_FILENAME";
    
    // Revision Specific Counties
    property name="Sites" type="array" fieldtype="one-to-many" fkcolumn="AR_ID" cfc="RevisionSites";
    property name="Pests" type="array" fieldtype="one-to-many" fkcolumn="AR_ID" cfc="RevisionPests";
    property name="Counties" type="array" fieldtype="one-to-many" fkcolumn="AR_ID" cfc="RevisionCounties";
    
    // Auditing fields
    property name="CreatedBy" column="CREATED_USER";
    property name="Created" column="CREATED_DATE";
    property name="UpdatedBy" column="UPDATED_USER";
    property name="Updated" column="UPDATED_DATE" fieldtype="timestamp";  
    
    // how we retrieve the revision number
    function getRevisionNumber(){
        return ormExecuteQuery("select count(*) from Revisions where Application.Id = "
            & this.getApplication().getId() 
            & " and Created < '"
            & this.getCreated() & "'")[1];
            
    }
    
    function getOfficialName(){
        var officialName = this.getApplication().getOfficialName();
        
        // initial revisions don't need to display rev. 0!
        if( this.getRevisionNumber() == 0 ) return officialName;
        else return officialName & " rev. " & this.getRevisionNumber();
    }
    
    function getRevisionName(){
        var revNo = this.getRevisionNumber();
        if(revNo == 0){
            return "Original";
        } else {
            return "Revision " & revNo;
        }
    }
    
    // touch functionality
    function touch(){
        this.setUpdatedBy( cgi.auth_user);
        this.setUpdated( now() );
    }
    
    // Update Parent Application
    function touchApplication(){
        this.getApplication().touch();
    }
    
    function preUpdate(){
        touchApplication();
    }
    
    function preInsert(){
        touchApplication();
    }
}