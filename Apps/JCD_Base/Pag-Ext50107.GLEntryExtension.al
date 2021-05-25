/// <summary>
/// PageExtension GL Entry Extension (ID 50107) extends Record General Ledger Entries.
/// </summary>
pageextension 50107 "GL Entry Extension" extends "General Ledger Entries"
{
    actions
    {
        addafter(ReverseTransaction)
        {
            action(CorrectionEcriture)
            {
                Caption = 'Correction écriture';
                ApplicationArea = Basic, Suite;
                Image = Entries;
                RunPageMode = Edit;
                RunObject = Page "Correction ecriture";
                RunPageLink = "Entry No." = FIELD("Entry No.");
            }
        }
    }
}
