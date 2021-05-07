/// <summary>
/// TableExtension Sales Header Extension (ID 50101) extends Record Sales Header.
/// </summary>
tableextension 50101 "Sales Header Extension" extends "Sales Header"
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
    }
}
