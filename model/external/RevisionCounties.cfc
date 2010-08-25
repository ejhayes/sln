/**
 * @persistent
 */
component schema="SPECUSE" table="ARC_APPLICATION_REV_COUNTIES" 
{
    property name="Id" fieldtype="id" generator="sequence" ormtype="int" params="{sequence='ARC_SEQ'}";
    property name="Revision" fkcolumn="AR_ID" cfc="Revisions" fieldtype="one-to-one";
    property name="County" fkcolumn="C_CODE" cfc="Counties" fieldtype="one-to-one";
    
    // Auditing fields
    property name="CreatedBy" column="CREATED_USER";
    property name="Created" column="CREATED_DATE";
    property name="UpdatedBy" column="UPDATED_USER";
    property name="Updated" column="UPDATED_DATE" fieldtype="timestamp";  
}