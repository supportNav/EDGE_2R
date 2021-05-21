/// <summary>
/// PageExtension Get Sales Shipment Extension (ID 50106) extends Record Get Shipment Lines.
/// </summary>
pageextension 50106 "Get Sales Shipment Extension" extends "Get Shipment Lines"
{
    layout
    {
        addafter("Document No.")
        {
            field(OrderNo; Rec."Order No.")
            {
                ApplicationArea = All;
            }
        }
    }
}
