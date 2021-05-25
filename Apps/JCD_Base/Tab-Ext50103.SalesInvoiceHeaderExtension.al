/// <summary>
/// TableExtension Sales Header Extension (ID 50101) extends Record Sales Header.
/// </summary>
tableextension 50103 "Sales Inv. Header Extension" extends "Sales Invoice Header"
{
    fields
    {
        field(50110; "Assigned User ID"; Code[50])
        {
            Caption = 'Assigned User ID';
            DataClassification = EndUserIdentifiableInformation;
            TableRelation = "User Setup";
        }
        field(50102; "Assigned User Mail"; Text[100])
        {
            FieldClass = FlowField;
            Caption = 'Assigned User Mail';
            CalcFormula = Lookup("User Setup"."E-mail" WHERE("User ID" = Field("Assigned User ID")));

        }
        field(50103; "Assigned User Phone"; Text[100])
        {
            FieldClass = FlowField;
            Caption = 'Assigned User Phone';
            CalcFormula = Lookup("User Setup"."Phone No." WHERE("User ID" = Field("Assigned User ID")));

        }
    }
}
