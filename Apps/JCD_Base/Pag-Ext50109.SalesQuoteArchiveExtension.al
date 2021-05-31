/// <summary>
/// PageExtension Sales Quote Archive Extension (ID 50109) extends Record Sales Quote Archive.
/// </summary>
pageextension 50109 "Sales Quote Archive Extension" extends "Sales Quote Archive"
{

    layout
    {
        addafter("Quote Valid Until Date")
        {
            field("Motif refus devis"; Rec."Motif refus devis")
            {
                ApplicationArea = All;
            }
        }
    }
}
