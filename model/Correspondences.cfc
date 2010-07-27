/**
 * @persistent
 */
component schema="track" table="STATINFO" readonly="true"
{
    property name="Code" column="TrackID" fieldtype="id" ormtype="int";
    property name="CorrespondenceType" column="REGTYPE" fkcolumn="REGTYPE" cfc="TrackingTypes" fieldtype="one-to-one";
    property name="FirmName" column="FIRM_NAME";
    property name="Description" column="ADDED_USE";
}