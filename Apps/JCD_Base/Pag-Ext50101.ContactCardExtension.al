pageextension 50101 "Contact Card Extension" extends "Contact Card"
{
    layout
    {
        addafter("Salesperson Code")
        {
            field("Job title"; Rec."Job Title")
            {
                Editable = (Type <> Type::Company);
                ApplicationArea = All;
            }
        }
    }
}
