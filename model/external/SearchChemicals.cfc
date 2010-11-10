/**
 * @persistent
 */
component schema="SPECUSE" table="VW_CHEMICALS" readonly="true"
{
    property name="Code" column="CHEM_CODE" fieldtype="id" ormtype="int";
    property name="Description" column="CHEMNAME";
}