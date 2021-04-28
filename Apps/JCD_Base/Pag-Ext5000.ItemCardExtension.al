pageextension 50100 "Item Card Extension" extends "Item Card"
{
    layout
    {
        addafter(Description)
        {
            Field("Description 2"; Rec."Description 2")
            {
                ApplicationArea = All;
            }
        }
    }
}
