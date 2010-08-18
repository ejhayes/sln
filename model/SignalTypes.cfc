/**
 * @persistent
 */
component schema="LABEL" table="SIGNAL_WORD" readonly="true"
{
    property name="Code" column="TYPEPEST_CD" fieldtype="id" ormtype="char";
    property name="Description" column="TYPEPEST_CAT";
}