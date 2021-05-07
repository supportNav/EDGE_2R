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
        }
    }
    var
        ShippingAgent: Record "Shipping Agent";
        ShippingAgentPrest: Record "Shipping Agent Services";
        InfoCompany: Record "Company Information";
        ReferenceLbl: Label 'Item Reference';
        WebSiteLbl: Label 'Website :';
        TelLbl: Label 'Phone No. :';
        EMailTxtLbl: Label 'E-mail : ';
        RealizedBy: Label 'Realized by :';
}