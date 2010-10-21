/**
 * @persistent
 */
component schema="LABEL" table="PRODUCT" readonly="true"
{
    property name="Code" column="PRODNO" fieldtype="id" ormtype="int";
    property name="Description" formula="'(' || PRODSTAT_IND || ') ' || PRODUCT_NAME || ' (' || REGEXP_REPLACE(show_regno, '\s', '') || ')'";
    property name="ShortDescription" column="PRODUCT_NAME";
    property name="RegistrationNumber" formula="REGEXP_REPLACE(show_regno, '\s', '')";
    property name="Status" fkcolumn="PRODSTAT_IND" cfc="ProductStatuses" fieldtype="one-to-one";
    property name="Warning" fkcolumn="SIGNLWRD_IND" cfc="WarningTypes" fieldtype="one-to-one";
    
    // Pesticide Type Classifications
    property name="Types" fieldtype="many-to-many" cfc="PesticideTypes" linktable="PROD_TYPE_PESTICIDE" fkcolumn="PRODNO" inversejoincolumn="TYPEPEST_CD" readonly="true" orderby="TYPEPEST_CAT";
    
    // Pesticide Special Registration Status (i.e. is it restricted?)
    property name="RestrictedStatuses" fieldtype="many-to-many" cfc="RestrictedStatuses" linktable="PROD_SPECIAL_STATUS" fkcolumn="PRODNO" inversejoincolumn="SPECSTAT_CD" readonly="true" orderby="SPECSTAT_DSC";
    
    // Pesticide Chemicals
    property name="Chemicals" type="array" fieldtype="one-to-many" fkcolumn="PRODNO" cfc="ProductChemicals" orderby="PRODCHEM_PCT desc";
}