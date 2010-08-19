/**
 * @persistent
 */
component schema="LABEL" table="SPECIAL_STATUS" readonly="true"
{
    property name="Code" column="SPECSTAT_CD" fieldtype="id";
    property name="Description" column="SPECSTAT_DSC";
}