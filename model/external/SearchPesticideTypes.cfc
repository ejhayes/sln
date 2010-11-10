/**
 * @persistent
 */
component schema="SPECUSE" table="VW_PESTICIDES" readonly="true"
{
    property name="Code" column="TYPEPEST_CD" fieldtype="id";
    property name="Description" column="TYPEPEST_CAT";
}