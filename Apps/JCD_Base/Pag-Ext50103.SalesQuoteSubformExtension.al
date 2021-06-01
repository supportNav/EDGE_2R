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
            field(MargeGlobale; MargeGlobale)
            {
                Caption = 'Marge globale';
                ApplicationArea = All;
                Editable = true;

                trigger OnValidate()
                begin
                    SHeader.GET(Rec."Document Type", Rec."Document No.");

                    SHeader.Validate("Marge globale", MargeGlobale);
                    SHeader.Modify(true);

                    DocTotals.RefreshSalesLine(Rec);
                end;
            }
        }
        modify("Unit Cost (LCY)")
        {
            Visible = true;
        }

    }
    trigger OnAfterGetCurrRecord()
    begin
        SHeader.GET(Rec."Document Type", Rec."Document No.");

        MargeGlobale := SHeader."Marge globale";
    end;

    var
        MargeGlobale: Decimal;
        SHeader: Record "Sales Header";
        DocTotals: Codeunit "Document Totals";
}
