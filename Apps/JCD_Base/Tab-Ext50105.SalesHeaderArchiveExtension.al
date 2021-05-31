/// <summary>
/// TableExtension Sales Header Archive Extension (ID 50105) extends Record Sales Header Archive.
/// </summary>
tableextension 50105 "Sales Header Archive Extension" extends "Sales Header Archive"
{
    fields
    {
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
