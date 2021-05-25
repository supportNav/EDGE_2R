/// <summary>
/// PageExtension Sales Order Subform Extension (ID 50104) extends Record Sales Order Subform.
/// </summary>
pageextension 50104 "Sales Order Subform Extension" extends "Sales Order Subform"
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
        modify("Drop Shipment")
        {
            Visible = true;
        }
    }
}
