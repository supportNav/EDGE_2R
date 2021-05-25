/// <summary>
/// TableExtension Purchase Header Extension (ID 50104) extends Record Purchase Header.
/// </summary>
tableextension 50104 "Purchase Header Extension" extends "Purchase Header"
{
    fields
    {
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
