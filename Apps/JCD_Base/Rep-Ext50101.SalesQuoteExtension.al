/// <summary>
/// SalesQuoteExt (ID 50101) extends Record Standard Sales - Quote.
/// </summary>
reportextension 50101 SalesQuoteExt extends "Standard Sales - Quote"
{
    dataset
    {
        add(Header)
        {
            column(AssignedUserID; Header."Assigned User ID") { }
            column(APECode; InfoCompany."APE Code") { }
            column(TradeRegister; InfoCompany."Trade Register") { }
            column(ShipAgent; header."Shipping Agent Name") { }
            column(ShipAgentPresta; Header."Shipping Agent Service Descr.") { }
            column(RealizedByLbl; RealizedBy) { }
            column(WebSiteLbl_Lbl; WebSiteLbl) { }
            column(TelLbl_Lbl; TelLbl) { }
            column(EmailTxtLbl_Lbl; EmailTxtLbl) { }
            column(ShippingAgentLbl_Blb; ShippingAgentLbl) { }
            column(ShipAgentPrestaLbl_Lbl; ShipAgentPrestaLbl) { }
            column(AssignedUserPhone; Header."Assigned User Phone") { }
            column(AssignedUserMail; header."Assigned User Mail") { }
            column(SelltoContactName; Header."Sell-to Contact") { }
        }
        add(Line)
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
}