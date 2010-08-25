/**
 * @persistent
 */
component schema="MASTER" table="PRODUCT_STATUS" readonly="true"
{
    property name="Code" column="PRODSTAT_IND" fieldtype="id";
    property name="Description" column="PRODSTAT_DSC";
}