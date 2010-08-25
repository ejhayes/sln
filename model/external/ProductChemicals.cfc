/**
 * @persistent
 */
component schema="LABEL" table="PROD_CHEM" readonly="true"
{
    property name="Product" fkcolumn="PRODNO" cfc="Products" fieldtype="id,many-to-one";
    property name="Chemical" fkcolumn="CHEM_CODE" cfc="Chemicals" fieldtype="id,many-to-one";
    property name="Percent" column="PRODCHEM_PCT";
}