/// <summary>
/// PageExtension Sales Shipment List Extension (ID 50105) extends Record Posted Sales Shipments.
/// </summary>
pageextension 50105 "Sales Shipment List Extension" extends "Posted Sales Shipments"
{
    layout
    {
        addafter("Sell-to Customer No.")
        {
            field(OrderNo; Rec."Order No.")
            {
                ApplicationArea = All;
            }
        }
    }
}