/**
 * @persistent
 */
component schema="LABEL" table="SIGNAL_WORD" readonly="true"
{
    property name="Code" column="SIGNLWRD_IND" fieldtype="id" ormtype="int";
    property name="Description" column="SIGNLWRD_DSC";
}