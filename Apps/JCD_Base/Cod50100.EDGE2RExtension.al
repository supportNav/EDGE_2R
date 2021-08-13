/// <summary>
/// Codeunit EDGE 2R Extension (ID 50100).
/// </summary>
codeunit 50100 "EDGE 2R Extension"
{
    Permissions = TableData "G/L Entry" = m,
        TableData "Cust. Ledger Entry" = m,
        TableData "Item Ledger Entry" = m,
        TableData "Sales Invoice Header" = m,
        TableData "Sales Cr.Memo Header" = m,
        TableData "Purch. Inv. Header" = m,
        TableData "Purch. Inv. Line" = m,
        TableData "Purch. Cr. Memo Hdr." = m,
        TableData "Purch. Cr. Memo Line" = m,
        TableData "VAT Entry" = m,
        TableData "Bank Account Ledger Entry" = m,
        TableData "Detailed Cust. Ledg. Entry" = m,
        TableData "Detailed Vendor Ledg. Entry" = m,
        TableData "Value Entry" = m;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Sales-Post", 'OnAfterInsertPostedHeaders', '', true, true)]
    local procedure TransfertSpecFields(var SalesHeader: Record "Sales Header"; var SalesShipmentHeader: Record "Sales Shipment Header"; var SalesInvoiceHeader: Record "Sales Invoice Header"; var SalesCrMemoHdr: Record "Sales Cr.Memo Header"; var ReceiptHeader: Record "Return Receipt Header")
    begin
        IF SalesHeader.Invoice THEN BEGIN
            SalesInvoiceHeader."Assigned User ID" := SalesHeader."Assigned User ID";
            SalesInvoiceHeader.Modify(true);
        END;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterValidateEvent', 'Marge globale', true, true)]
    local procedure T36SalesHeader_OnAfterValidateMargeGlobale(var Rec: Record "Sales Header")
    var
        SalesLine: Record "Sales Line";
    begin
        SalesLine.Reset;
        SalesLine.SetRange("Document Type", Rec."Document Type");
        SalesLine.SetRange("Document No.", Rec."No.");
        SalesLine.SetFilter(Quantity, '<>%1', 0);
        if SalesLine.FindFirst then
            repeat
                SalesLine.Validate("Profit %", Rec."Marge Globale");
                SalesLine.Modify(true)
            until SalesLine.Next = 0;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header Archive", 'OnAfterInsertEvent', '', true, true)]
    local procedure T5107_OnAfterInsertSalesHeaderArchive(var Rec: Record "Sales Header Archive")
    var
        SalesHeaderArchive: Record "Sales Header Archive";
    begin
        Rec."Last Archive" := true;
        Rec.Modify;

        SalesHeaderArchive.Reset;
        SalesHeaderArchive.SetRange("Document Type", Rec."Document Type");
        SalesHeaderArchive.SetRange("No.", Rec."No.");
        SalesHeaderArchive.SetFilter("Version No.", '<%1', Rec."Version No.");
        if SalesHeaderArchive.FindFirst then
            repeat
                SalesHeaderArchive.Validate("Last Archive", false);
                SalesHeaderArchive.Modify(false);
            until SalesHeaderArchive.Next = 0;

    end;
    /// <summary>
    /// RoundAndBlankZero.
    /// </summary>
    /// <param name="NumberFormated">Text.</param>
    /// <returns>Return value of type Text.</returns>
    procedure RoundAndBlankZero(NumberFormated: Text): Text
    var
        Number: Integer;
    begin
        IF Evaluate(Number, NumberFormated) and (Number = 0) then
            exit('')
        ELSE
            exit(NumberFormated);
    end;
    /// <summary>
    /// StyleSalesDescr.
    /// </summary>
    /// <param name="SalesLine">Record "Sales Line".</param>
    /// <returns>Return value of type Text.</returns>
    procedure SalesCommentDescr(SalesLine: Record "Sales Line"): Text
    begin
        If SalesLine.Type = SalesLine.Type::" " then
            exit(SalesLine.Description)
        else
            exit('');
    end;
    /// <summary>
    /// SalesItemDescr.
    /// </summary>
    /// <param name="SalesLine">Record "Sales Line".</param>
    /// <returns>Return value of type Text.</returns>
    procedure SalesItemDescr(SalesLine: Record "Sales Line"): Text
    begin
        If SalesLine.Type = SalesLine.Type::" " then
            exit('')
        else
            exit(SalesLine.Description);
    end;
}
