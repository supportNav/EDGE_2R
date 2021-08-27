/// <summary>
/// Page Sales Quote and Archive List (ID 50101).
/// </summary>
page 50101 "Sales Quote and Archive List"
{

    ApplicationArea = All;
    Caption = 'Devis en-cours et archivés';
    PageType = List;
    SourceTable = "Sales Header";
    UsageCategory = Lists;
    SourceTableTemporary = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Document Type"; Rec."Document Type")
                {
                    ToolTip = 'Specifies the value of the Document Type field';
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field';
                    ApplicationArea = All;
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ToolTip = 'Specifies the value of the Sell-to Customer Name field';
                    ApplicationArea = All;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ToolTip = 'Specifies the value of the Sell-to Customer No. field';
                    ApplicationArea = All;
                }
                field("Sell-to Customer Name 2"; Rec."Sell-to Customer Name 2")
                {
                    ToolTip = 'Specifies the value of the Sell-to Customer Name 2 field';
                    ApplicationArea = All;
                }
                field("Sell-to Address"; Rec."Sell-to Address")
                {
                    ToolTip = 'Specifies the value of the Sell-to Address field';
                    ApplicationArea = All;
                }
                field("Sell-to Address 2"; Rec."Sell-to Address 2")
                {
                    ToolTip = 'Specifies the value of the Sell-to Address 2 field';
                    ApplicationArea = All;
                }
                field("Sell-to Post Code"; Rec."Sell-to Post Code")
                {
                    ToolTip = 'Specifies the value of the Sell-to Post Code field';
                    ApplicationArea = All;
                }
                field("Sell-to City"; Rec."Sell-to City")
                {
                    ToolTip = 'Specifies the value of the Sell-to City field';
                    ApplicationArea = All;
                }
                field("Sell-to Contact"; Rec."Sell-to Contact")
                {
                    ToolTip = 'Specifies the value of the Sell-to Contact field';
                    ApplicationArea = All;
                }
                field("Sell-to Contact No."; Rec."Sell-to Contact No.")
                {
                    ToolTip = 'Specifies the value of the Sell-to Contact No. field';
                    ApplicationArea = All;
                }
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    ToolTip = 'Specifies the value of the Ship-to Code field';
                    ApplicationArea = All;
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ToolTip = 'Specifies the value of the Ship-to Name field';
                    ApplicationArea = All;
                }
                field("Ship-to Name 2"; Rec."Ship-to Name 2")
                {
                    ToolTip = 'Specifies the value of the Ship-to Name 2 field';
                    ApplicationArea = All;
                }
                field("Ship-to Address"; Rec."Ship-to Address")
                {
                    ToolTip = 'Specifies the value of the Ship-to Address field';
                    ApplicationArea = All;
                }
                field("Ship-to Address 2"; Rec."Ship-to Address 2")
                {
                    ToolTip = 'Specifies the value of the Ship-to Address 2 field';
                    ApplicationArea = All;
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    ToolTip = 'Specifies the value of the Ship-to Post Code field';
                    ApplicationArea = All;
                }
                field("Ship-to City"; Rec."Ship-to City")
                {
                    ToolTip = 'Specifies the value of the Ship-to City field';
                    ApplicationArea = All;
                }
                field("Bill-to Name"; Rec."Bill-to Name")
                {
                    ToolTip = 'Specifies the value of the Bill-to Name field';
                    ApplicationArea = All;
                }
                field("Bill-to Name 2"; Rec."Bill-to Name 2")
                {
                    ToolTip = 'Specifies the value of the Bill-to Name 2 field';
                    ApplicationArea = All;
                }
                field("Bill-to Address"; Rec."Bill-to Address")
                {
                    ToolTip = 'Specifies the value of the Bill-to Address field';
                    ApplicationArea = All;
                }
                field("Bill-to Address 2"; Rec."Bill-to Address 2")
                {
                    ToolTip = 'Specifies the value of the Bill-to Address 2 field';
                    ApplicationArea = All;
                }
                field("Bill-to Post Code"; Rec."Bill-to Post Code")
                {
                    ToolTip = 'Specifies the value of the Bill-to Post Code field';
                    ApplicationArea = All;
                }
                field("Bill-to City"; Rec."Bill-to City")
                {
                    ToolTip = 'Specifies the value of the Bill-to City field';
                    ApplicationArea = All;
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    ToolTip = 'Specifies the value of the Assigned User ID field';
                    ApplicationArea = All;
                }
                field("Assigned User Mail"; Rec."Assigned User Mail")
                {
                    ToolTip = 'Specifies the value of the Assigned User Mail field';
                    ApplicationArea = All;
                }
                field("Assigned User Phone"; Rec."Assigned User Phone")
                {
                    ToolTip = 'Specifies the value of the Assigned User Phone field';
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field';
                    ApplicationArea = All;
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    ToolTip = 'Specifies the value of the Amount Including VAT field';
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ToolTip = 'Specifies the value of the Document Date field';
                    ApplicationArea = All;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ToolTip = 'Specifies the value of the External Document No. field';
                    ApplicationArea = All;
                }
                field("No. of Archived Versions"; Rec."No. of Archived Versions")
                {
                    ToolTip = 'Specifies the value of the No. of Archived Versions field';
                    ApplicationArea = All;
                }
                field("Marge globale"; Rec."Marge globale")
                {
                    ToolTip = 'Specifies the value of the Marge globale field';
                    ApplicationArea = All;
                }
                field("Motif refus devis"; Rec."Motif refus devis")
                {
                    ToolTip = 'Specifies the value of the Motif refus devis field';
                    ApplicationArea = All;
                }
                field("Order Date"; Rec."Order Date")
                {
                    ToolTip = 'Specifies the value of the Order Date field';
                    ApplicationArea = All;
                }
                field("Quote Accepted"; Rec."Quote Accepted")
                {
                    ToolTip = 'Specifies the value of the Quote Accepted field';
                    ApplicationArea = All;
                }
                field("Quote Accepted Date"; Rec."Quote Accepted Date")
                {
                    ToolTip = 'Specifies the value of the Quote Accepted Date field';
                    ApplicationArea = All;
                }
                field("Quote Sent to Customer"; Rec."Quote Sent to Customer")
                {
                    ToolTip = 'Specifies the value of the Quote Sent to Customer field';
                    ApplicationArea = All;
                }
                field("Quote Valid Until Date"; Rec."Quote Valid Until Date")
                {
                    ToolTip = 'Specifies the value of the Quote Valid To Date field';
                    ApplicationArea = All;
                }
                field("Requested Delivery Date"; Rec."Requested Delivery Date")
                {
                    ToolTip = 'Specifies the value of the Requested Delivery Date field';
                    ApplicationArea = All;
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ToolTip = 'Specifies the value of the Salesperson Code field';
                    ApplicationArea = All;
                }
                field("Your Reference"; Rec."Your Reference")
                {
                    ToolTip = 'Specifies the value of the Your Reference field';
                    ApplicationArea = All;
                }
                field(Refused; Rec.Refused)
                {
                    ToolTip = 'Devis refusé (oui ou non)';
                    ApplicationArea = All;
                    Editable = FALSE;

                }
                field(TransformedInOrder; Rec.TransformedInOrder)
                {
                    ToolTip = 'N° commande';
                    ApplicationArea = All;
                    Editable = FALSE;

                }
                field(PrixRevientTotal; Rec.PrixRevientTotal)
                {
                    ToolTip = 'Somme des coûts';
                    ApplicationArea = All;
                    Editable = FALSE;

                }
                field("Marge brut"; Rec."Marge brut")
                {
                    ToolTip = 'Pourcentage prix de vente / coûts';
                    ApplicationArea = All;
                    Editable = FALSE;

                }

            }
        }
    }

    trigger OnOpenPage()
    begin
        InitTempTable();
    end;

    local procedure InitTempTable()
    var
        SalesHeader: Record "Sales Header";
        SalesHeaderArch: Record "Sales Header Archive";
        SheaderArch: Record "Sales Header Archive";
        NbRec: Integer;
        Window: Dialog;
        i: Integer;
        TxtProgressQuote: Label 'Parcours des devis... @1@@@@@@@@@@';
        TxtProgressQuoteArch: Label 'Parcours des devis archivés... @1@@@@@@@@@@';
        SalesHeaderSearch: Record "Sales Header";
        SalesLine: Record "Sales Line";
        SalesLineArchive: Record "Sales Line Archive";
        TotalCost: Decimal;
        TotalPrice: Decimal;
    begin
        Rec.DeleteAll;

        //verification coche Last Archive
        SalesHeaderArch.Reset;
        SalesHeaderArch.SetRange("Last Archive", TRUE);
        IF NOT SalesHeaderArch.FindFirst then begin
            SalesHeaderArch.Reset;
            SalesHeaderArch.SetRange("Document Type", SalesHeaderArch."Document Type"::Quote);
            if SalesHeaderArch.FindFirst then
                repeat
                    SheaderArch.Reset;
                    SHeaderArch.SetRange("Document Type", SalesHeaderArch."Document Type");
                    SHeaderArch.SetRange("No.", SalesHeaderArch."No.");
                    SHeaderArch.SetFilter("Version No.", '>%1', SalesHeaderArch."Version No.");
                    if not SHeaderArch.FindFirst then begin
                        SalesHeaderArch."Last Archive" := true;
                        SalesHeaderArch.Modify(false)
                    end;
                until SalesHeaderArch.Next = 0;
        end;

        //Parcours devis en cours
        SalesHeader.Reset;
        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Quote);
        IF SalesHeader.FindFirst then begin
            i := 0;
            NbRec := SalesHeader.Count;
            Window.Open(TxtProgressQuote);
            repeat
                Window.UPDATE(1, ROUND(i / NbRec * 10000, 1));
                Rec := SalesHeader;
                //recheche du n° commande si devis transformé en commande
                SalesHeaderSearch.Reset();
                SalesHeaderSearch.SetRange("Document Type", SalesHeaderSearch."Document Type"::Order);
                SalesHeaderSearch.SetRange("Quote No.", SalesHeader."No.");
                IF SalesHeaderSearch.FindFirst() then begin
                    rec.TransformedInOrder := SalesHeaderSearch."No.";
                end;
                rec.Insert(FALSE);

                //Devis refusé
                IF Rec."Motif refus devis" <> '' then begin
                    Rec.Refused := TRUE;
                end else begin
                    Rec.Refused := FALSE;
                end;
                //Calcul de la marge et du cout
                TotalCost := 0;
                TotalPrice := 0;
                SalesLine.Reset();
                SalesLine.SetRange("Document No.", Rec."No.");
                SalesLine.SetRange("Document Type", SalesLine."Document Type"::Quote);
                SalesLine.CalcSums("Unit Cost", "Unit Price");
                TotalCost := SalesLine."Unit Cost";
                TotalPrice := SalesLine."Unit Price";
                Rec.PrixRevientTotal := TotalCost;
                if TotalPrice <> 0 then begin
                    Rec."Marge brut" := (TotalPrice - TotalCost) / TotalPrice * 100;
                end else begin
                    Rec."Marge brut" := 100;
                end;

                Rec.MODIFY(FALSE);

                i := i + 1;
            Until SalesHeader.Next = 0;

            Window.Close;
        end;

        SalesHeader.Reset;

        //Parcours dernières archives
        SalesHeaderArch.Reset;
        SalesHeaderArch.SetRange("Document Type", SalesHeaderArch."Document Type"::Quote);
        SalesHeaderArch.SetRange("Last Archive", true);
        if SalesHeaderArch.FindFirst then begin
            i := 0;
            NbRec := SalesHeaderArch.Count;
            Window.Open(TxtProgressQuoteArch);

            repeat
                Window.UPDATE(1, ROUND(i / NbRec * 10000, 1));
                IF not SalesHeader.GET(SalesHeaderArch."Document Type", SalesHeaderArch."No.") then begin
                    rec.Init;
                    Rec.TransferFields(SalesHeaderArch);
                    //recheche du n° commande si devis transformé en commande
                    SalesHeaderSearch.Reset();
                    SalesHeaderSearch.SetRange("Document Type", SalesHeaderSearch."Document Type"::Order);
                    SalesHeaderSearch.SetRange("Quote No.", SalesHeaderArch."No.");
                    IF SalesHeaderSearch.FindFirst() then begin
                        rec.TransformedInOrder := SalesHeaderSearch."No.";
                    end;

                    rec.Insert(false);

                    //Devis refusé
                    IF Rec."Motif refus devis" <> '' then begin
                        Rec.Refused := TRUE;
                    end else begin
                        Rec.Refused := FALSE;
                    end;
                    //Calcul de la marge et du cout
                    TotalCost := 0;
                    TotalPrice := 0;
                    SalesLineArchive.Reset();
                    SalesLineArchive.SetRange("Document No.", Rec."No.");
                    SalesLineArchive.SetRange("Document Type", SalesLineArchive."Document Type"::Quote);
                    SalesLineArchive.CalcSums("Unit Cost", "Unit Price");
                    TotalCost := SalesLineArchive."Unit Cost";
                    TotalPrice := SalesLineArchive."Unit Price";
                    Rec.PrixRevientTotal := TotalCost;
                    if TotalPrice <> 0 then begin
                        Rec."Marge brut" := (TotalPrice - TotalCost) / TotalPrice * 100;
                    end else begin
                        Rec."Marge brut" := 100;
                    end;


                    Rec.MODIFY(FALSE);
                end;

                i := i + 1;
            until SalesHeaderArch.Next = 0;

            Window.Close;
        end;
    end;

    VAR
        Refused: Boolean;
        TransformedInOrder: Code[20];
}
