/// <summary>
/// PageExtension GL Entry Extension (ID 50107) extends Record General Ledger Entries.
/// </summary>
pageextension 50110 "Post. Sales Invoice Extension" extends "Posted Sales Invoices"
{
    //
    actions
    {
        addafter(CorrectInvoice)
        {
            action(CorrectionEcriture)
            {
                Caption = 'Correction écriture';
                ApplicationArea = Basic, Suite;
                Image = Entries;
                RunPageMode = Edit;
                RunObject = Page "Correction ecriture";
                RunPageLink = "Document No." = FIELD("No."), "Posting Date" = FIELD("Posting Date");
            }
        }
    }
}
