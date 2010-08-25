/**
 * @persistent
 */
component schema="CHEM_SYN" table="CHEM_COM" readonly="true"
{
    property name="Code" column="CHEMCODE" fieldtype="id" ormtype="int";
    property name="Description" column="COMNAME";
}