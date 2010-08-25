/**
 * @persistent
 */
component schema="LABEL" table="TYPE_PESTICIDE" readonly="true"
{
    property name="Code" column="TYPEPEST_CD" fieldtype="id" ormtype="char";
    property name="Description" column="TYPEPEST_CAT";
}