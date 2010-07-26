/**
 * @persistent
 */
component schema="LABEL" table="PRODUCT" readonly="true"
{
    property name="Code" column="PRODNO" fieldtype="id" ormtype="int";
    property name="Description" column="PRODUCT_NAME";
    property name="RegistrationNumber" formula="REGEXP_REPLACE(show_regno, '\s', '')";
}