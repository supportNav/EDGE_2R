pageextension 50102 "Contact List Extension" extends "Contact List"
{
    layout
    {
        addafter("E-mail")
        {
            field("Job Title"; Rec."Job Title")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }
}
