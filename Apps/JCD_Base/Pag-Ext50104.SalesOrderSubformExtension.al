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
        addafter("Invoice Discount Amount")
        {
            field(MargeGlobale; TotalSalesHeader."Marge globale")
            {
                Caption = 'Marge globale';
                ApplicationArea = All;
                Editable = true;

                trigger OnValidate()
                begin
                    CurrPage.UPDATE;
                end;
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
