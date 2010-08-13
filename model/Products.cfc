/**
 * @persistent
 */
component schema="LABEL" table="PRODUCT" readonly="true"
{
    property name="Code" column="PRODNO" fieldtype="id" ormtype="int";
    property name="Description" formula="PRODUCT_NAME || ' (' || REGEXP_REPLACE(show_regno, '\s', '') || ')'";
    property name="ShortDescription" column="PRODUCT_NAME";
    property name="RegistrationNumber" formula="REGEXP_REPLACE(show_regno, '\s', '')";
}