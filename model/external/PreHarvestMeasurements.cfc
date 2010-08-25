/**
 * @persistent
 */
component schema="LABEL" table="PREHARVEST_INTERVAL" readonly="true"
{
    property name="Code" column="PH_MSMT_IND" fieldtype="id";
    property name="Description" column="PH_MSMT_DSC";
}