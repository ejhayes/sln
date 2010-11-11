/**
 * @persistent
 */
component schema="SPECUSE" table="ARP_APPLICATION_REV_PESTS" 
{
    property name="Id" fieldtype="id" generator="sequence" ormtype="int" params="{sequence='ARP_SEQ'}";
    property name="Revision" fkcolumn="AR_ID" cfc="Revisions" fieldtype="one-to-one";
    property name="Pest" fkcolumn="P_CODE" cfc="Pests" fieldtype="one-to-one";
    
    // Auditing fields
    property name="CreatedBy" column="CREATED_USER";
    property name="Created" column="CREATED_DATE";
    property name="UpdatedBy" column="UPDATED_USER";
    property name="Updated" column="UPDATED_DATE" fieldtype="timestamp";  
    
    // Update Parent Revision
    function touchRevision(){
        this.getRevision().touch();
    }
    
    function preUpdate(){
        touchRevision();
    }
    
    function preInsert(){
        touchRevision();
    }
    
    function preDelete(){
        touchRevision();
    }
}