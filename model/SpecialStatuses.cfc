/**
 * @persistent
 */
component schema="LABEL" table="SPECIAL_STATUS" readonly="true"
{
    property name="Code" column="TYPEPEST_CD" fieldtype="id" ormtype="char";
    property name="Description" column="TYPEPEST_CAT";
}