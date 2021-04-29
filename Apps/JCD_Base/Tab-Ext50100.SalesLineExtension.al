/// <summary>
/// TableExtension Sales Line Extension (ID 50100) extends Record Sales Line.
/// </summary>
tableextension 50100 "Sales Line Extension" extends "Sales Line"
{
    fields
    {
        modify("Profit %")
        {
            trigger OnAfterValidate()
            begin
                UpdateSalesPrice;
            end;
        }
        modify("Unit Cost (LCY)")
        {
            trigger OnAfterValidate()
            begin
                UpdateSalesPrice;
            end;
        }
    }

    /// <summary>
    /// UpdateSalesPrice.
    /// </summary>
    procedure UpdateSalesPrice();
    begin
        Validate("Unit Price", "Unit Cost (LCY)" * (100 + "Profit %") / 100);
    end;
}
