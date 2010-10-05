/**
 * @persistent
 */
component schema="SPECUSE" table="A_APPLICATIONS"
{
    property name="Id" fieldtype="id" generator="sequence" ormtype="int" params="{sequence='A_SEQ'}";
    property name="SpecialUseNumber" column="SPECUSE_NO" ormtype="int";
    property name="RegistrationType" fkcolumn="SPECUSE_IND" cfc="RegistrationTypes" fieldtype="one-to-one";
    property name="Status" fkcolumn="S_CODE" cfc="Statuses" fieldtype="one-to-one";
    property name="Issued" column="ISSUE_DATE" ormtype="date";
    property name="Expired" column="EXPIRE_DATE" ormtype="date";
    property name="PublicComments" column="COMMENTS_PUBLIC";
    
    // Application Revisions
    property name="Revisions" fkcolumn="A_ID" cfc="Revisions" type="array" fieldtype="one-to-many" orderby="CREATED_DATE asc";
    
    // Auditing fields
    property name="CreatedBy" column="CREATED_USER";
    property name="Created" column="CREATED_DATE";
    property name="UpdatedBy" column="UPDATED_USER";
    property name="Updated" column="UPDATED_DATE" fieldtype="timestamp";

    // pad with zeros
    function getSpecialUseNumber(){
        return repeatString("0", 6 - len(variables.SpecialUseNumber)) & variables.SpecialUseNumber;
    }
    
    // get the official name of the record
    function getOfficialName(){
        if( this.getSpecialUseNumber() == "" ) return "UNKNOWN";
        else return "CA-" & this.getSpecialUseNumber();
    }
    
    // get the unique products associated with a record
    function getUniqueProducts(){
        // the map technique returns a java.util.HashMap object
        return ormExecuteQuery("select new map(Product.Code as Code, Product.ShortDescription as Description, Product.RegistrationNumber as RegistrationNumber, Id as Id, Label as Label) from Revisions where Application.Id = ? order by Created", [this.getId()]);
    }
    
    // get the most current revision of the record
    function getCurrentRevision(){
        if( arrayLen(this.getRevisions()) > 0)
            return EntityLoadByPK("Revisions", ormExecuteQuery("select max(Id) from Revisions where Application.Id=" & this.getId())[1]);
        else return null;
    }
}