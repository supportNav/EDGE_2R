/// <summary>
/// SalesQuoteExt (ID 50101) extends Record Standard Sales - Credit Memo.
/// </summary>
reportextension 50106 SalesCrMemoExt extends "Standard Sales - Credit Memo"
{

    dataset
    {
        add(Header)
        {
            column(APECode; InfoCompany."APE Code") { }
            column(TradeRegister; InfoCompany."Trade Register") { }
            column(IBAN; InfoCompany.IBAN) { }
            column(BIC; InfoCOmpany."SWIFT Code") { }
            column(SIRET; InfoCompany."Registration No.") { }
            column(RealizedByLbl; RealizedBy) { }
            column(WebSiteLbl_Lbl; WebSiteLbl) { }
            column(TelLbl_Lbl; TelLbl) { }
            column(EmailTxtLbl_Lbl; EmailTxtLbl) { }
            column(ShippingAgentLbl_Blb; ShippingAgentLbl) { }
            column(ShipAgentPrestaLbl_Lbl; ShipAgentPrestaLbl) { }
            column(SelltoContactName; Header."Sell-to Contact") { }
            column(OrderDate; FORMAT(Header."Posting Date")) { }
            column(OrderDateLbl_Lbl; OrderDate_Lbl) { }
            column(SIRETLbl_Lbl; SIRETLbl_Lbl) { }
            column(LogoInfoSociete; InfoCOmpany.Picture) { }
            column(OrderReference_Lbl; OrderReference_Lbl) { }
            column(BICLbl; BICLbl) { }
            column(IBANLbl; IBANLbl) { }
            column(AssignedUserPhone; Header."Assigned User Phone") { }
            column(AssignedUserMail; Header."Assigned User Mail") { }
            column(Assigned_User_ID; "Assigned User ID") { }
        }
        add(Line)
        {
            column(ReferenceLbl_Lbl; ReferenceLbl) { }
            column(UnitPriceRounded; EDGECOdeunit.RoundAndBlankZero(FORMAT(ROUND(Line."Unit Price", 0.01))))
            {
                AutoFormatExpression = GetCurrencyCode;
                AutoFormatType = 2;
            }
        }
    }
    trigger OnPreReport()
    Begin
        InfoCompany.GET;
        InfoCompany.CalcFields(Picture);
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
        OrderDate_Lbl: Label 'Posting Date';
        SIRETLbl_Lbl: Label 'Registration No.';
        OrderReference_Lbl: Label 'Sales Order Reference';
        BICLbl: Label 'BIC';
        IBANLbl: Label 'IBAN';

        EDGECOdeunit: Codeunit "EDGE 2R Extension";
}