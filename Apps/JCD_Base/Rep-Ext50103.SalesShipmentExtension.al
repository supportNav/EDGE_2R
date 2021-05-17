/// <summary>
/// SalesQuoteExt (ID 50101) extends Record Standard Sales - Quote.
/// </summary>
reportextension 50103 SalesShipmentExt extends "Sales - Shipment"
{

    dataset
    {
        add("Sales Shipment Header")
        {
            column(APECode; InfoCompany."APE Code") { }
            column(TradeRegister; InfoCompany."Trade Register") { }
            column(SIRET; InfoCompany."Registration No.") { }
            column(ShipAgent; "Sales Shipment Header"."Shipping Agent Name") { }
            column(ShipAgentPresta; "Sales Shipment Header"."Shipping Agent Service Descr.") { }
            column(RealizedByLbl; RealizedBy) { }
            column(WebSiteLbl_Lbl; WebSiteLbl) { }
            column(TelLbl_Lbl; TelLbl) { }
            column(EmailTxtLbl_Lbl; EmailTxtLbl) { }
            column(ShippingAgentLbl_Blb; ShippingAgentLbl) { }
            column(ShipAgentPrestaLbl_Lbl; ShipAgentPrestaLbl) { }
            column(SelltoContactName; "Sales Shipment Header"."Sell-to Contact") { }
            column(OrderDate; FORMAT("Sales Shipment Header"."Order Date")) { }
            column(OrderDateLbl_Lbl; OrderDate_Lbl) { }
            column(SIRETLbl_Lbl; SIRETLbl_Lbl) { }
        }
        add("Sales Shipment Line")
        {
            column(ReferenceLbl_Lbl; ReferenceLbl) { }
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
        SIRETLbl_Lbl: Label 'Registration No.';

}