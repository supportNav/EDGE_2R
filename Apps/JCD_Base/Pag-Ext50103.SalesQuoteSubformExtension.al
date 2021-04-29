/// <summary>
/// PageExtension Sales Quote Subform Extension (ID 50103) extends Record Sales Quote Subform.
/// </summary>
pageextension 50103 "Sales Quote Subform Extension" extends "Sales Quote Subform"
{
    layout
    {
        addafter("Unit Cost (LCY)")
        {
            field("Profit %"; Rec."Profit %")
            {
                ApplicationArea = All;
                Editable = true;
            }
        }
        modify("Unit Cost (LCY)")
        {
            Visible = true;
        }
    }
}
