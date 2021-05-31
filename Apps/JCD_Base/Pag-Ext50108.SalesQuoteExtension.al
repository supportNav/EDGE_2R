/// <summary>
/// PageExtension Sales Quote Extension (ID 50108) extends Record Sales Quote.
/// </summary>
pageextension 50108 "Sales Quote Extension" extends "Sales Quote"
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
