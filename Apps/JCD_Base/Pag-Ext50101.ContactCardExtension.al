/// <summary>
/// PageExtension Contact Card Extension (ID 50101) extends Record Contact Card.
/// </summary>
pageextension 50101 "Contact Card Extension" extends "Contact Card"
{
    layout
    {
        addafter("Salesperson Code")
        {
            field("Job title"; Rec."Job Title")
            {
                Editable = (rec.Type <> rec.Type::Company);
                ApplicationArea = All;
            }
        }
    }
}
