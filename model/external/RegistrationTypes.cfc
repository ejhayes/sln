/**
 * @persistent
 */
component schema="MASTER" table="SPECIAL_USE" readonly="true"
{
    property name="Code" column="SPECUSE_IND" fieldtype="id";
    property name="Description" column="SPECUSE_DSC";
}