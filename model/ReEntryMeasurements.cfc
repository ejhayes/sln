/**
 * @persistent
 */
component schema="LABEL" table="REENTRY_INTERVAL" readonly="true"
{
    property name="Code" column="RE_MSMT_IND" fieldtype="id";
    property name="Description" column="RE_MSMT_DSC";
}