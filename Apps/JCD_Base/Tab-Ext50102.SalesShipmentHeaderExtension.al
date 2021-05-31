/// <summary>
/// TableExtension Sales Shipment Header Extension (ID 50102) extends Record Sales Shipment Header.
/// </summary>
tableextension 50102 "Sales Shipment Header Ext." extends "Sales Shipment Header"
{
    fields
    {
        field(50100; "Shipping Agent Name"; Text[100])
        {
            FieldClass = FlowField;
            Caption = 'Shipping Agent Name';
            CalcFormula = Lookup("Shipping Agent"."Name" WHERE("Code" = Field("Shipping Agent Code")));
        }
        field(50101; "Shipping Agent Service Descr."; Text[100])
        {
            FieldClass = FlowField;
            Caption = 'Shipping Agent Service Description';
            CalcFormula = Lookup("Shipping Agent Services"."Description" WHERE("Shipping Agent Code" = Field("Shipping Agent Code"), "Code" = Field("Shipping Agent Service Code")));
        }
        field(50104; "Motif refus devis"; Text[200])
        {
            Caption = 'Motif refus devis';
            Editable = true;
        }
        field(50105; "Marge globale"; Decimal)
        {
            Caption = 'Marge globale';
            Editable = true;
        }
    }
}
