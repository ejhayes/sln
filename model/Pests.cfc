/**
 * @persistent
 */
component schema="SPECUSE" table="P_PESTS" readonly="true"
{
    property name="Code" column="CODE";
    property name="Description" column="DESCRIPTION";
    property name="FederalPest" column="USEPA_CODE" fkcolumn="USEPA_CODE" cfc="FederalPests" fieldtype="one-to-one";
}