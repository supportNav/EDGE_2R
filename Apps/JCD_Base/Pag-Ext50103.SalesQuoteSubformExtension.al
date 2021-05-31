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
    }
}
