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
                Image = Entries;

                trigger OnAction()
                VAR
                    GLAccount: Record 15;
                BEGIN
                    PAGE.RUN(50059, Rec);
                END;

            }
        }
    }
}
