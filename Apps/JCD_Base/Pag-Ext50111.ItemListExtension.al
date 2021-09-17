pageextension 50111 ItemListExtension extends "Item List"
{
    layout
    {
        addafter("Vendor No.")
        {
            field("Catégorie article"; Rec."Item Category Code")
            {
                ApplicationArea = All;
            }
            field(Manuel; Rec."Manuel utilisateur")
            {
                ApplicationArea = All;
            }
            field("Fiche technique"; Rec."Fiche technique")
            {
                ApplicationArea = All;
            }
            field("Image URL"; Rec."Image URL")
            {
                ApplicationArea = All;
            }
        }
    }
}
