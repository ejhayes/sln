/**
 * @persistent
 */
component schema="track" table="STATINFO" readonly="true"
{
    property fieldtype="id" name="TrackingId" column="TrackID" ormtype="int";
    property name="TrackingType" column="REGTYPE" fkcolumn="REGTYPE" cfc="TrackingTypes" fieldtype="one-to-one";
    property name="FirmName" column="FIRM_NAME";
    property name="Description" column="ADDED_USE";
}