/**
 * @persistent
 */
component schema="SPECUSE" table="ARS_APPLICATION_REV_SITES" 
{
    property name="Id" fieldtype="id" generator="sequence" ormtype="int" params="{sequence='ARS_SEQ'}";
    property name="Revision" fkcolumn="AR_ID" cfc="Revisions" fieldtype="one-to-one";
    property name="Site" fkcolumn="SITE_CODE" cfc="Sites" fieldtype="one-to-one";
    property name="Qualifier" fkcolumn="Q_CODE" cfc="Qualifiers" fieldtype="one-to-one";
    property name="ReEntryInterval" column="RE_INTERVAL";
    property name="ReEntryIntervalMeasurement" fkcolumn="RE_MSMT_IND" cfc="ReEntryMeasurements" fieldtype="one-to-one";
    property name="PreHarvestInterval" column="PH_INTERVAL";
    property name="PreHarvestIntervalMeasurement" fkcolumn="PH_MSMT_IND" cfc="PreHarvestMeasurements" fieldtype="one-to-one";
    
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
}