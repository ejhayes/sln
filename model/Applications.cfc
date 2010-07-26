/**
 * @persistent
 */
component schema="SPECUSE" table="A_APPLICATIONS" 
{
    property name="Id" fieldtype="id" generator="sequence" ormtype="int" params="{sequence='A_SEQ'}";
    property name="SpecialUseNumber" column="SPECUSE_NO" ormtype="int";
    property name="RegistrationType" fkcolumn="SPECUSE_IND" cfc="RegistrationTypes" fieldtype="one-to-one";
    property name="Status" fkcolumn="S_CODE" cfc="Statuses" fieldtype="one-to-one";
    property name="Issued" column="ISSUE_DATE";
    property name="Expired" column="EXPIRE_DATE";
    property name="InternalComments" column="COMMENTS_INTERNAL";
    property name="PublicComments" column="COMMENTS_PUBLIC";
    property name="CreatedBy" column="CREATED_USER";
    property name="Created" column="CREATED_DATE";
    property name="UpdatedBy" column="UPDATED_USER";
    property name="Updated" column="UPDATED_DATE" fieldtype="timestamp";  
}