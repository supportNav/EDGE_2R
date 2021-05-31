/// <summary>
/// Codeunit EDGE 2R Extension (ID 50100).
/// </summary>
codeunit 50100 "EDGE 2R Extension"
{
    EventSubscriberInstance = StaticAutomatic;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Sales-Post", 'OnInsertPostedHeadersOnBeforeInsertInvoiceHeader', '', true, true)]
    local procedure TransfertSpecFields(SalesHeader: Record "Sales Header"; var IsHandled: Boolean; SalesInvHeader: Record "Sales Invoice Header")
    begin
        SalesInvHeader."Assigned User ID" := SalesHeader."Assigned User ID";
        SalesInvHeader.Modify(true);
    end;

    [EventSubscriber(ObjectType::Table, 36, 'OnAfterValidateEvent', 'Marge globale', true, true)]
    local procedure T36SalesHeader_OnAfterValidateMargeGlobale(var Rec: Record "Sales Header")
    var
        SalesLine: Record "Sales Line";
    begin
        MESSAGE('OK');
        SalesLine.Reset;
        SalesLine.SetRange("Document Type", Rec."Document Type");
        SalesLine.SetRange("Document No.", Rec."No.");
        SalesLine.SetFilter(Quantity, '<>%1', 0);
        if SalesLine.FindFirst then
            repeat
                SalesLine.Validate("Profit %", rec."Marge globale");
                SalesLine.Modify(true)
            until SalesLine.Next = 0;
    end;
}
