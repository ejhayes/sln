/**
 * @persistent
 */
component schema="SPECUSE" table="US_USE_SUBTYPES" readonly="true"
{
    property name="Code" column="CODE" fieldtype="id";
    property name="Description" column="DESCRIPTION";
    property name="RegistrationType" column="SPECUSE_IND" fkcolumn="SPECUSE_IND" cfc="RegistrationTypes" fieldtype="one-to-one";
}