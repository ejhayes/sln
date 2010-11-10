/**
 * @persistent
 */
component schema="SPECUSE" table="VW_SITES" readonly="true"
{
    property name="Code" column="SITE_CODE" ormtype="int" fieldtype="id";
    property name="Description" column="SITE_NAME";
}