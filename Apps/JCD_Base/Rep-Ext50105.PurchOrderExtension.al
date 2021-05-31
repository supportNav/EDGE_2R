/// <summary>
/// SalesQuoteExt (ID 50101) extends Record Standard Sales - Quote.
/// </summary>
reportextension 50105 PurchOrderExt extends "Standard Purchase - Order"
{

    dataset
    {
        add("Purchase Header")
        {
            column(AssignedUserID; "Purchase Header"."Assigned User ID") { }
            column(APECode; InfoCompany."APE Code") { }
            column(TradeRegister; InfoCompany."Trade Register") { }
            column(RealizedByLbl; RealizedBy) { }
            column(WebSiteLbl_Lbl; WebSiteLbl) { }
            column(TelLbl_Lbl; TelLbl) { }
            column(EmailTxtLbl_Lbl; EmailTxtLbl) { }
            column(ShippingAgentLbl_Blb; ShippingAgentLbl) { }
            column(ShipAgentPrestaLbl_Lbl; ShipAgentPrestaLbl) { }
            column(AssignedUserPhone; "Purchase Header"."Assigned User Phone") { }
            column(AssignedUserMail; "Purchase Header"."Assigned User Mail") { }
            column(SelltoContactName; "Purchase Header"."Buy-from Contact") { }
            column(OrderDate; FORMAT("Purchase Header"."Order Date")) { }
            column(OrderDateLbl_Lbl; OrderDate_Lbl) { }
            column(OrderReference_Lbl; OrderReference_Lbl) { }
            column(BuyFromVendorName; "Purchase header"."Buy-from Vendor Name") { }
        }
        add("Purchase Line")
        {
            column(ReferenceLbl_Lbl; ReferenceLbl) { }
            column(UnitPriceRounded; ROUND("Purchase Line"."Direct Unit Cost", 0.01))
            {
                AutoFormatExpression = "Currency Code";
                AutoFormatType = 2;
            }
        }
    }
    trigger OnPreReport()
    Begin
        InfoCompany.GET;
    end;

    var
        ShippingAgent: Record "Shipping Agent";
        ShippingAgentPrest: Record "Shipping Agent Services";
        InfoCompany: Record "Company Information";
        ReferenceLbl: Label 'Item Reference';
        WebSiteLbl: Label 'Website :';
        TelLbl: Label 'Phone No. :';
        EMailTxtLbl: Label 'E-mail : ';
        RealizedBy: Label 'Realized by :';
        ShippingAgentLbl: Label 'Shipping Agent Name';
        ShipAgentPrestaLbl: Label 'Shipping Agent Services';
        OrderDate_Lbl: Label 'Order Date';
        OrderReference_Lbl: Label 'Sales Order Reference';
}