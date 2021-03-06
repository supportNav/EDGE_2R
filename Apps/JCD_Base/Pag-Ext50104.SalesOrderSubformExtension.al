/// <summary>
/// PageExtension Sales Order Subform Extension (ID 50104) extends Record Sales Order Subform.
/// </summary>
pageextension 50104 "Sales Order Subform Extension" extends "Sales Order Subform"
{
    layout
    {
        addafter("Line Amount")
        {
            field("Date de préparation"; Rec."Shipment Date")
            {
                ApplicationArea = All;
                Editable = true;
                Visible = true;
            }
        }
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
        modify("Drop Shipment")
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
