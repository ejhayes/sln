/**
 * @persistent
 */
component schema="MASTER" table="CHEM_COM" readonly="true"
{
    property name="Code" column="CHEMCODE" fieldtype="id" ormtype="int";
    property name="Description" column="COMNAME";
}