/// <summary>
/// TableExtension Sales Header Extension (ID 50101) extends Record Sales Header.
/// </summary>
tableextension 50101 "Sales Header Extension" extends "Sales Header"
{
    fields
    {
        field(50100; "Shipping Agent Name"; Text[100])
        {
            FieldClass = FlowField;
            Caption = 'Shipping Agent Name';
            CalcFormula = Lookup("Shipping Agent"."Name" WHERE("Code" = Field("Shipping Agent Code")));
        }
        field(50101; "Shipping Agent Service Descr."; Text[100])
        {
            FieldClass = FlowField;
            Caption = 'Shipping Agent Service Description';
            CalcFormula = Lookup("Shipping Agent Services"."Description" WHERE("Shipping Agent Code" = Field("Shipping Agent Code"), "Code" = Field("Shipping Agent Service Code")));
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
        field(50104; "Motif refus devis"; Text[200])
        {
            Caption = 'Motif refus devis';
            Editable = true;
        }
        field(50105; "Marge globale"; Decimal)
        {
            Caption = 'Marge globale';
            Editable = true;
        }
        field(50106; "Refused"; Boolean)
        {
            Caption = 'Refusé';
            Editable = true;
        }
        field(50107; "TransformedInOrder"; Code[20])
        {
            Caption = 'Transformé en commande';
            Editable = true;
        }
        field(50108; "PrixRevientTotal"; Decimal)
        {
            Caption = 'Prix de revient total';
            Editable = true;
        }
        field(50109; "Marge brut"; Decimal)
        {
            Caption = 'Marge brut';
            Editable = true;
        }

    }
}
