/**
 * @persistent
 */
component schema="LABEL" table="PRODUCT" readonly="true"
{
    property name="Code" column="PRODNO" fieldtype="id" ormtype="int";
    property name="Description" formula="PRODUCT_NAME || ' (' || REGEXP_REPLACE(show_regno, '\s', '') || ')'";
    property name="ShortDescription" column="PRODUCT_NAME";
    property name="RegistrationNumber" formula="REGEXP_REPLACE(show_regno, '\s', '')";
    
    // Pesticide Type Classifications
    property name="Types" fieldtype="many-to-many" cfc="PesticideTypes" linktable="PROD_TYPE_PESTICIDE" fkcolumn="PRODNO" inversejoincolumn="TYPEPEST_CD" readonly="true" orderby="TYPEPEST_CAT";
    
    // Pesticide Chemicals
    property name="Chemicals" fieldtype="many-to-many" cfc="Chemicals" linktable="PROD_CHEM" fkcolumn="PRODNO" inversejoincolumn="CHEM_CODE" readonly="true" orderby="COMNAME";
}