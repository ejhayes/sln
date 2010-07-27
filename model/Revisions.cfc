/**
 * @persistent
 */
component schema="SPECUSE" table="AR_APPLICATION_REVS" 
{
    property name="Id" fieldtype="id" generator="sequence" ormtype="int" params="{sequence='AR_SEQ'}";
    property name="Application" fkcolumn="A_ID" cfc="Applications" fieldtype="one-to-one";
    property name="Correspondence" fkcolumn="TRACKID" cfc="Correspondences" fieldtype="one-to-one";
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
}