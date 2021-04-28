/// <summary>
/// SalesQuoteExt (ID 50101) extends Record Standard Sales - Quote.
/// </summary>
reportextension 50101 SalesQuoteExt extends "Standard Sales - Quote"
{
    dataset
    {
        add(Header)
        {
            column(fromTableBase; Header."Assigned User ID") { }
        }
    }
    var
        ReferenceLbl: Label 'Item Reference';
        WebSiteLbl: Label 'Website :';
        TelLbl: Label 'Phone No. :';
        EMailTxtLbl: Label 'E-mail : ';
        RealizedBy: Label 'Realized by :';

}