/// <summary>
/// Page Correction ecriture (ID 50100).
/// </summary>
page 50100 "Correction ecriture"
{

    Caption = 'Correction ecriture';
    PageType = Card;
    SourceTable = "G/L Entry";
    DeleteAllowed = False;
    Permissions = TableData "G/L Entry" = m,
            TableData "Cust. Ledger Entry" = m,
            TableData "Item Ledger Entry" = m,
            TableData "Sales Invoice Header" = m,
            TableData "Sales Cr.Memo Header" = m,
            TableData "Purch. Inv. Header" = m,
            TableData "Purch. Inv. Line" = m,
            TableData "Purch. Cr. Memo Hdr." = m,
            TableData "Purch. Cr. Memo Line" = m,
            TableData "VAT Entry" = m,
            TableData "Bank Account Ledger Entry" = m,
            TableData "Detailed Cust. Ledg. Entry" = m,
            TableData "Detailed Vendor Ledg. Entry" = m,
            TableData "Value Entry" = m;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(DocNo; Rec."Document No.")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = True;
                    Editable = false;
                }
                field(PostingDate; Rec."Posting Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }

                field(Descr; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }

                field(NewDocDate; NewDocumentDate)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Nouvelle date';
                    Editable = True;
                }


                field(OLine; OneLine)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Une seule ligne';
                    Editable = TRUE;
                }
                field(ALines; AllLines)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Toutes les lignes';
                    Editable = true;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(CorrigerEcriture)
            {
                Caption = 'Corriger ecriture(s)';
                ApplicationArea = Basic, Suite;
                Promoted = true;
                PromotedIsBig = true;
                Image = Apply;
                PromotedCategory = Process;

                trigger OnAction()
                BEGIN
                    //->RPE210316
                    IF Controlcorrection() = TRUE THEN BEGIN
                        MESSAGE(Text002);
                        CurrPage.CLOSE;
                    END;
                    //<-RPE210316
                END;
            }
        }
    }
    VAR
        Text001: Label 'Aucune modification a effectuer !';
        Text002: Label 'Les donnees ont ete modifiees.';
        Text003: Label 'Facture vente enregistree';
        Text004: Label 'Avoir vente enregistre';
        Text005: Label 'Expedition vente enregistree';
        Text006: Label 'Relances emises';
        Text007: Label 'Factures d''int‚rˆts ‚mises';
        Text008: Label 'Facture achat enregistr‚e';
        Text009: Label 'Avoir achat enregistr‚';
        Text010: Label 'R‚ception achat enregistr‚e';
        Text011: Label 'Le num‚ro de document a ‚t‚ utilis‚ plusieurs fois.';
        Text012: Label 'Cette combinaison de num‚ro de document et de date de comptabilisation a ‚t‚ utilis‚e plusieurs fois.';
        Text013: Label 'Il n''existe pas d''enregistrement comptabilis‚ avec ce num‚ro de document.';
        Text014: Label 'Il n''existe pas d''enregistrement pour cette combinaison de num‚ro de document et de date de comptabilisation.';
        Text015: Label 'Trop de documents externes ont ‚t‚ trouv‚s. Veuillez sp‚cifier un identifiant tiers.';
        Text016: Label 'Trop de documents externes ont ‚t‚ trouv‚s. Utilisez la fonction Naviguer … partir des ‚critures comptables correspondantes.';
        Text017: Label 'R‚ception retour enreg.';
        Text018: Label 'Exp‚dition retour enreg.';
        Text019: Label 'Exp‚dition transfert enreg.';
        Text020: Label 'R‚ception transfert enreg.';
        Text021: Label 'Commande vente';
        Text022: Label 'Facture vente';
        Text023: Label 'Retour vente';
        Text024: Label 'Avoir vente';
        Text025: Label 'Ordre d''assemblage valid‚';
        Text026: Label 'Banque %1 %2';
        Text027: Label 'Compte banque %1 introuvable !';
        sText003: Label 'Facture service enreg.';
        sText004: Label 'Avoir service enreg.';
        sText005: Label 'Exp‚dition service enreg.';
        sText021: Label 'Commande service';
        sText022: Label 'Facture service';
        sText024: Label 'Avoir service';
        Text99000000: Label 'Ordre de fabrication';
        docentry: Record 265 temporary;
        DocNoFilter: Code[250];
        PostingDateFilter: Text[250];
        NewDocNo: Code[20];
        NewDocumentDate: Date;
        NewJob: Code[20];
        NewGlaccount: Code[20];
        NewDescription: Code[20];
        NewReporting: Code[20];
        OneLine: Boolean;
        AllLines: Boolean;
        EnableLines: Boolean;
        DimSetEntry: Record 480;
        JobSetup: Record 315;
        GlSetup: Record 98;
        CPTLine: Integer;
        FIN: Boolean;
        DimSetEntry2: Record 480;
        NextNoLine: Integer;
        axe1: Boolean;
        axe2: Boolean;
        CPTLinesReporitng: Integer;
        dimvalue: Record 349;
        DimTreeNode: Record 481;
        DimTreeNode2: Record 481;
        DimTreeNode3: Record 481;
        trouve: Boolean;
        iddim: Integer;
        GenJnlLine: Record 81;
        i: Integer;
        DimSetID: Integer;
        Job: Record 167;
        JobOnly: Boolean;
        OldJobNo: Code[50];
        NewQuantity: Decimal;
        EcrClient: Record 21;
        NewDueDate: Date;
        DateEch: Date;
        EcrFourn: Record 25;
        NewBankAccount: Code[20];

    trigger OnOpenPage()
    begin
        AllLines := TRUE;
    end;

    PROCEDURE Correctionalllines();
    VAR
        SalesShptHeader: Record 110;
        SalesShptLine: Record 111;
        SalesShptLine2: Record 111;
        SalesShptLine3: Record 111;
        SalesInvHeader: Record 112;
        SalesInvLine: Record 113;
        SalesInvLine2: Record 113;
        SalesInvLine3: Record 113;
        ReturnRcptHeader: Record 6660;
        ReturnRcptLine: Record 6661;
        SalesCrMemoHeader: Record 114;
        SalesCrMemoLine: Record 115;
        IssuedReminderHeader: Record 297;
        IssuedReminderLine: Record 298;
        PurchRcptHeader: Record 120;
        PurchRcptLine: Record 121;
        PurchRcptLine2: Record 121;
        PurchInvHeader: Record 122;
        PurchInvLine: Record 123;
        PurchInvLine2: Record 123;
        ReturnShptHeader: Record 6650;
        ReturnShptLine: Record 6651;
        PurchCrMemoHeader: Record 124;
        PurchCrMemoLine: Record 125;
        TransShptHeader: Record 5744;
        TransShptLine: Record 5745;
        TransRcptHeader: Record 5746;
        TransRcptLine: Record 5747;
        PostedWhseRcptLine: Record 7319;
        PostedWhseShptLine: Record 7323;
        GLEntry: Record 17;
        VATEntry: Record 254;
        CustLedgEntry: Record 21;
        DtldCustLedgEntry: Record 379;
        VendLedgEntry: Record 25;
        DtldVendLedgEntry: Record 380;
        ItemLedgEntry: Record 32;
        PhysInvtLedgEntry: Record 281;
        ResLedgEntry: Record 203;
        ValueEntry: Record 5802;
        BankAccLedgEntry: Record 271;
        CheckLedgEntry: Record 272;
        ReminderEntry: Record 300;
        FALedgEntry: Record 5601;
        WhseEntry: Record 7312;
        CostEntry: Record 1104;
        PaymentHeader: Record 10865;
        ArchPaymentHeader: Record 10867;
        PaymentLine: Record 10866;
        ARchPaymentLine: Record 10868;
        Jobentry: Record 169;
    BEGIN
        GlSetup.GET;
        JobSetup.GET;
        OldJobNo := Rec."Global Dimension 1 Code";

        // Modify general ledger entries
        GLEntry.RESET;
        GLEntry.SETRANGE("Posting Date", Rec."Posting Date");
        GLEntry.SETRANGE("Document No.", Rec."Document No.");
        IF JobOnly THEN GLEntry.SETRANGE("Job No.", OldJobNo);
        IF GLEntry.FINDFIRST THEN
            REPEAT
                IF NewDocNo <> '' THEN BEGIN
                    GLEntry."Document No." := NewDocNo;
                    GLEntry.MODIFY(TRUE);
                END;
                IF NewQuantity <> Rec.Quantity THEN BEGIN
                    GLEntry.Quantity := NewQuantity;
                    GLEntry.MODIFY(TRUE);
                END;
                IF NewDocumentDate <> 0D THEN BEGIN
                    GLEntry."Document Date" := NewDocumentDate;
                    GLEntry."Posting Date" := NewDocumentDate;
                    GLEntry.MODIFY(TRUE);
                END;
                IF NewJob <> '' THEN BEGIN
                    GLEntry."Global Dimension 1 Code" := NewJob;
                    //GLEntry."Dimension Set ID" := CalcDimSetID2(GLEntry."Dimension Set ID", GLEntry."Global Dimension 1 Code", GLEntry."Global Dimension 2 Code");
                    //DimSetID := GLEntry."Dimension Set ID";
                    GLEntry."Job No." := NewJob;
                    GLEntry.MODIFY(TRUE);
                END;
                IF NewReporting <> '' THEN BEGIN
                    GLEntry."Global Dimension 2 Code" := NewReporting;
                    //GLEntry."Dimension Set ID" := CalcDimSetID2(GLEntry."Dimension Set ID", GLEntry."Global Dimension 1 Code", GLEntry."Global Dimension 2 Code");
                    //DimSetID := GLEntry."Dimension Set ID";
                    GLEntry.MODIFY(TRUE);
                END;
            UNTIL (GLEntry.NEXT = 0);

        // Modify VAT entries
        VATEntry.RESET;
        VATEntry.SETRANGE("Posting Date", Rec."Posting Date");
        VATEntry.SETRANGE("Document No.", Rec."Document No.");
        IF VATEntry.FINDFIRST THEN
            REPEAT
                IF NewDocNo <> '' THEN BEGIN
                    VATEntry."Document No." := NewDocNo;
                    VATEntry.MODIFY(TRUE);
                END;
                IF NewDocumentDate <> 0D THEN BEGIN
                    VATEntry."Document Date" := NewDocumentDate;
                    VATEntry."Posting Date" := NewDocumentDate;
                    VATEntry.MODIFY(TRUE);
                END;
            UNTIL (VATEntry.NEXT = 0);

        // Modify customer entries
        CustLedgEntry.RESET;
        CustLedgEntry.SETRANGE("Posting Date", Rec."Posting Date");
        CustLedgEntry.SETRANGE(CustLedgEntry."Document No.", Rec."Document No.");
        IF JobOnly THEN CustLedgEntry.SETRANGE("Global Dimension 1 Code", OldJobNo);
        IF CustLedgEntry.FINDFIRST THEN
            REPEAT
                IF NewDocNo <> '' THEN BEGIN
                    CustLedgEntry."Document No." := NewDocNo;
                    CustLedgEntry.MODIFY(TRUE);
                END;
                IF NewDocumentDate <> 0D THEN BEGIN
                    CustLedgEntry."Document Date" := NewDocumentDate;
                    CustLedgEntry."Posting Date" := NewDocumentDate;
                    CustLedgEntry.MODIFY(TRUE);
                END;
                IF NewDueDate <> 0D THEN BEGIN
                    CustLedgEntry."Due Date" := NewDueDate;
                    CustLedgEntry.MODIFY(TRUE);
                END;
                IF NewJob <> '' THEN BEGIN
                    CustLedgEntry."Global Dimension 1 Code" := NewJob;
                    CustLedgEntry."Dimension Set ID" := DimSetID;
                    CustLedgEntry.MODIFY(TRUE);
                END;
                IF NewReporting <> '' THEN BEGIN
                    CustLedgEntry."Global Dimension 2 Code" := NewReporting;
                    CustLedgEntry."Dimension Set ID" := DimSetID;
                    CustLedgEntry.MODIFY(TRUE);
                END;
            UNTIL (CustLedgEntry.NEXT = 0);

        // Modify Job entries
        Jobentry.RESET;
        Jobentry.SETRANGE("Posting Date", Rec."Posting Date");
        Jobentry.SETRANGE(Jobentry."Document No.", Rec."Document No.");
        IF JobOnly THEN Jobentry.SETRANGE("Job No.", OldJobNo);
        IF Jobentry.FINDFIRST THEN
            REPEAT
                IF NewDocNo <> '' THEN BEGIN
                    Jobentry."Document No." := NewDocNo;
                    Jobentry.MODIFY(TRUE);
                END;
                IF NewDocumentDate <> 0D THEN BEGIN
                    Jobentry."Document Date" := NewDocumentDate;
                    Jobentry."Posting Date" := NewDocumentDate;
                    Jobentry.MODIFY(TRUE);
                END;
                IF NewJob <> '' THEN BEGIN
                    Jobentry."Global Dimension 1 Code" := NewJob;
                    Jobentry."Job No." := NewJob;
                    Jobentry."Dimension Set ID" := DimSetID;
                    Jobentry.MODIFY(TRUE);
                END;
                IF NewReporting <> '' THEN BEGIN
                    Jobentry."Global Dimension 2 Code" := NewReporting;
                    Jobentry."Dimension Set ID" := DimSetID;
                    Jobentry.MODIFY(TRUE);
                END;
            UNTIL (Jobentry.NEXT = 0);

        // Modify customer detailled entries
        DtldCustLedgEntry.RESET;
        DtldCustLedgEntry.SETRANGE("Posting Date", Rec."Posting Date");
        DtldCustLedgEntry.SETRANGE("Document No.", Rec."Document No.");
        IF JobOnly THEN DtldCustLedgEntry.SETRANGE("Initial Entry Global Dim. 1", OldJobNo);
        IF DtldCustLedgEntry.FINDFIRST THEN
            REPEAT
                IF NewDocNo <> '' THEN BEGIN
                    DtldCustLedgEntry."Document No." := NewDocNo;
                    DtldCustLedgEntry.MODIFY(TRUE);
                END;
                IF NewJob <> '' THEN BEGIN
                    DtldCustLedgEntry."Initial Entry Global Dim. 1" := NewJob;
                    DtldCustLedgEntry.MODIFY(TRUE);
                END;
                IF NewDueDate <> 0D THEN BEGIN
                    DtldCustLedgEntry."Initial Entry Due Date" := NewDueDate;
                    DtldCustLedgEntry.MODIFY(TRUE);
                END;
                IF NewReporting <> '' THEN BEGIN
                    DtldCustLedgEntry."Initial Entry Global Dim. 2" := NewReporting;
                    DtldCustLedgEntry.MODIFY(TRUE);
                END;
            UNTIL (DtldCustLedgEntry.NEXT = 0);

        // Modify VendLedgEntry
        VendLedgEntry.RESET;
        VendLedgEntry.SETRANGE("Posting Date", Rec."Posting Date");
        VendLedgEntry.SETRANGE("Document No.", Rec."Document No.");
        IF JobOnly THEN VendLedgEntry.SETRANGE("Global Dimension 1 Code", OldJobNo);
        IF VendLedgEntry.FINDFIRST THEN
            REPEAT
                IF NewDocNo <> '' THEN BEGIN
                    VendLedgEntry."Document No." := NewDocNo;
                    VendLedgEntry.MODIFY(TRUE);
                END;
                IF NewDocumentDate <> 0D THEN BEGIN
                    VendLedgEntry."Document Date" := NewDocumentDate;
                    VendLedgEntry."Posting Date" := NewDocumentDate;
                    VendLedgEntry.MODIFY(TRUE);
                END;
                IF NewDueDate <> 0D THEN BEGIN
                    VendLedgEntry."Due Date" := NewDueDate;
                    VendLedgEntry.MODIFY(TRUE);
                END;
                IF NewJob <> '' THEN BEGIN
                    VendLedgEntry."Global Dimension 1 Code" := NewJob;
                    VendLedgEntry."Dimension Set ID" := DimSetID;
                    VendLedgEntry.MODIFY(TRUE);
                END;
                IF NewReporting <> '' THEN BEGIN
                    VendLedgEntry."Global Dimension 2 Code" := NewReporting;
                    VendLedgEntry."Dimension Set ID" := DimSetID;
                    VendLedgEntry.MODIFY(TRUE);
                END;
            UNTIL (VendLedgEntry.NEXT = 0);

        // Modify detailled vendor entries
        DtldVendLedgEntry.RESET;
        DtldVendLedgEntry.SETRANGE("Posting Date", Rec."Posting Date");
        DtldVendLedgEntry.SETRANGE("Document No.", Rec."Document No.");
        IF JobOnly THEN
            DtldVendLedgEntry.SETRANGE("Initial Entry Global Dim. 1", OldJobNo);
        IF DtldVendLedgEntry.FINDFIRST THEN
            REPEAT
                IF NewDocNo <> '' THEN BEGIN
                    DtldVendLedgEntry."Document No." := NewDocNo;
                    DtldVendLedgEntry.MODIFY(TRUE);
                END;
                IF NewJob <> '' THEN BEGIN
                    DtldVendLedgEntry."Initial Entry Global Dim. 1" := NewJob;
                    DtldVendLedgEntry.MODIFY(TRUE);
                END;
                IF NewDueDate <> 0D THEN BEGIN
                    DtldVendLedgEntry."Initial Entry Due Date" := NewDueDate;
                    DtldVendLedgEntry.MODIFY(TRUE);
                END;
                IF NewReporting <> '' THEN BEGIN
                    DtldVendLedgEntry."Initial Entry Global Dim. 2" := NewJob;
                    DtldVendLedgEntry.MODIFY(TRUE);
                END;
                IF NewDocumentDate <> 0D THEN begin
                    DtldVendLedgEntry."Posting Date" := NewDocumentDate;
                    DtldVendLedgEntry.Modify(TRUE);
                end;
            UNTIL (DtldVendLedgEntry.NEXT = 0);

        // Modify ItemLedgEntry
        ItemLedgEntry.RESET;
        ItemLedgEntry.SETRANGE("Posting Date", Rec."Posting Date");
        ItemLedgEntry.SETRANGE("Document No.", Rec."Document No.");
        IF JobOnly THEN ItemLedgEntry.SETRANGE("Global Dimension 1 Code", OldJobNo);
        IF ItemLedgEntry.FINDFIRST THEN
            REPEAT
                IF NewDocNo <> '' THEN BEGIN
                    ItemLedgEntry."Document No." := NewDocNo;
                    ItemLedgEntry.MODIFY(TRUE);
                END;
                IF NewDocumentDate <> 0D THEN BEGIN
                    ItemLedgEntry."Document Date" := NewDocumentDate;
                    ItemLedgEntry."Posting Date" := NewDocumentDate;
                    ItemLedgEntry.MODIFY(TRUE);
                END;
                IF NewJob <> '' THEN BEGIN
                    ItemLedgEntry."Global Dimension 1 Code" := NewJob;
                    ItemLedgEntry."Dimension Set ID" := DimSetID;
                    ItemLedgEntry.MODIFY(TRUE);
                END;
                IF NewReporting <> '' THEN BEGIN
                    ItemLedgEntry."Global Dimension 2 Code" := NewReporting;
                    ItemLedgEntry."Dimension Set ID" := DimSetID;
                    ItemLedgEntry.MODIFY(TRUE);
                END;
            UNTIL (ItemLedgEntry.NEXT = 0);

        // Modify PhysInvtLedgEntry
        PhysInvtLedgEntry.RESET;
        PhysInvtLedgEntry.SETRANGE("Posting Date", Rec."Posting Date");
        PhysInvtLedgEntry.SETRANGE("Document No.", Rec."Document No.");
        IF JobOnly THEN PhysInvtLedgEntry.SETRANGE("Global Dimension 1 Code", OldJobNo);
        IF PhysInvtLedgEntry.FINDFIRST THEN
            REPEAT
                IF NewDocNo <> '' THEN BEGIN
                    PhysInvtLedgEntry."Document No." := NewDocNo;
                    PhysInvtLedgEntry.MODIFY(TRUE);
                END;
                IF NewJob <> '' THEN BEGIN
                    PhysInvtLedgEntry."Global Dimension 1 Code" := NewJob;
                    PhysInvtLedgEntry."Dimension Set ID" := DimSetID;
                    PhysInvtLedgEntry.MODIFY(TRUE);
                END;
                IF NewReporting <> '' THEN BEGIN
                    PhysInvtLedgEntry."Global Dimension 2 Code" := NewReporting;
                    PhysInvtLedgEntry."Dimension Set ID" := DimSetID;
                    PhysInvtLedgEntry.MODIFY(TRUE);
                END;
            UNTIL (PhysInvtLedgEntry.NEXT = 0);

        // Modify ResLedgEntry
        ResLedgEntry.RESET;
        ResLedgEntry.SETRANGE("Posting Date", Rec."Posting Date");
        ResLedgEntry.SETRANGE("Document No.", Rec."Document No.");
        IF JobOnly THEN
            ResLedgEntry.SETRANGE("Global Dimension 1 Code", OldJobNo);
        IF ResLedgEntry.FINDFIRST THEN
            REPEAT
                IF NewDocNo <> '' THEN BEGIN
                    ResLedgEntry."Document No." := NewDocNo;
                    ResLedgEntry.MODIFY(TRUE);
                END;
                IF NewDocumentDate <> 0D THEN BEGIN
                    ResLedgEntry."Document Date" := NewDocumentDate;
                    ResLedgEntry."Posting Date" := NewDocumentDate;
                    ResLedgEntry.MODIFY(TRUE);
                END;
                IF NewJob <> '' THEN BEGIN
                    ResLedgEntry."Global Dimension 1 Code" := NewJob;
                    ResLedgEntry."Dimension Set ID" := DimSetID;
                    ResLedgEntry."Job No." := NewJob;
                    ResLedgEntry.MODIFY(TRUE);
                END;
                IF NewReporting <> '' THEN BEGIN
                    ResLedgEntry."Global Dimension 2 Code" := NewReporting;
                    ResLedgEntry."Dimension Set ID" := DimSetID;
                    ResLedgEntry.MODIFY(TRUE);
                END;
            UNTIL (ResLedgEntry.NEXT = 0);

        // Modify ValueEntry
        ValueEntry.RESET;
        ValueEntry.SETRANGE("Posting Date", Rec."Posting Date");
        ValueEntry.SETRANGE("Document No.", Rec."Document No.");
        IF JobOnly THEN ValueEntry.SETRANGE("Job No.", OldJobNo);
        IF ValueEntry.FINDFIRST THEN
            REPEAT
                IF NewDocNo <> '' THEN BEGIN
                    ValueEntry."Document No." := NewDocNo;
                    ValueEntry.MODIFY(TRUE);
                END;
                IF NewDocumentDate <> 0D THEN BEGIN
                    ValueEntry."Document Date" := NewDocumentDate;
                    ValueEntry."Posting Date" := NewDocumentDate;
                    ValueEntry.MODIFY(TRUE);
                END;
                IF NewJob <> '' THEN BEGIN
                    ValueEntry."Job No." := NewJob;
                    ValueEntry."Global Dimension 1 Code" := NewJob;
                    ValueEntry."Dimension Set ID" := DimSetID;
                    ValueEntry.MODIFY(TRUE);
                END;
                IF NewReporting <> '' THEN BEGIN
                    ValueEntry."Global Dimension 2 Code" := NewReporting;
                    ValueEntry."Dimension Set ID" := DimSetID;
                    ValueEntry.MODIFY(TRUE);
                END;
            UNTIL (ValueEntry.NEXT = 0);

        // Modify BankAccLedgEntry
        BankAccLedgEntry.RESET;
        BankAccLedgEntry.SETRANGE("Posting Date", Rec."Posting Date");
        BankAccLedgEntry.SETRANGE("Document No.", Rec."Document No.");
        IF JobOnly THEN BankAccLedgEntry.SETRANGE("Global Dimension 1 Code", OldJobNo);
        IF BankAccLedgEntry.FINDFIRST THEN
            REPEAT
                IF NewDocNo <> '' THEN BEGIN
                    BankAccLedgEntry."Document No." := NewDocNo;
                    BankAccLedgEntry.MODIFY(TRUE);
                END;
                IF NewDocumentDate <> 0D THEN BEGIN
                    BankAccLedgEntry."Document Date" := NewDocumentDate;
                    BankAccLedgEntry."Posting Date" := NewDocumentDate;
                    BankAccLedgEntry.MODIFY(TRUE);
                END;
                IF NewJob <> '' THEN BEGIN
                    BankAccLedgEntry."Global Dimension 1 Code" := NewJob;
                    BankAccLedgEntry."Dimension Set ID" := DimSetID;
                    BankAccLedgEntry.MODIFY(TRUE);
                END;
                IF NewReporting <> '' THEN BEGIN
                    BankAccLedgEntry."Global Dimension 2 Code" := NewReporting;
                    BankAccLedgEntry."Dimension Set ID" := DimSetID;
                    BankAccLedgEntry.MODIFY(TRUE);
                END;
            UNTIL (BankAccLedgEntry.NEXT = 0);

        // Modify CheckLedgEntry
        CheckLedgEntry.RESET;
        CheckLedgEntry.SETRANGE("Posting Date", Rec."Posting Date");
        CheckLedgEntry.SETRANGE("Document No.", Rec."Document No.");
        IF CheckLedgEntry.FINDFIRST THEN
            REPEAT
                IF NewDocNo <> '' THEN BEGIN
                    CheckLedgEntry."Document No." := NewDocNo;
                    CheckLedgEntry.MODIFY(TRUE);
                END;
            UNTIL (CheckLedgEntry.NEXT = 0);

        // Modify ReminderEntry
        ReminderEntry.RESET;
        ReminderEntry.SETRANGE("Posting Date", Rec."Posting Date");
        ReminderEntry.SETRANGE("Document No.", Rec."Document No.");
        IF ReminderEntry.FINDFIRST THEN
            REPEAT
                IF NewDocNo <> '' THEN BEGIN
                    ReminderEntry."Document No." := NewDocNo;
                    ReminderEntry.MODIFY(TRUE);
                END;

                IF NewDueDate <> 0D THEN BEGIN
                    ReminderEntry."Due Date" := NewDueDate;
                    ReminderEntry.MODIFY(TRUE);
                END;
            UNTIL (ReminderEntry.NEXT = 0);

        // Modify FALedgEntry
        FALedgEntry.RESET;
        FALedgEntry.SETRANGE("Posting Date", Rec."Posting Date");
        FALedgEntry.SETRANGE("Document No.", Rec."Document No.");
        IF JobOnly THEN FALedgEntry.SETRANGE("Global Dimension 1 Code", OldJobNo);
        IF FALedgEntry.FINDFIRST THEN
            REPEAT
                IF NewDocNo <> '' THEN BEGIN
                    FALedgEntry."Document No." := NewDocNo;
                    FALedgEntry.MODIFY(TRUE);
                END;

                IF NewDocumentDate <> 0D THEN BEGIN
                    FALedgEntry."Document Date" := NewDocumentDate;
                    FALedgEntry."Posting Date" := NewDocumentDate;
                    FALedgEntry.MODIFY(TRUE);
                END;

                IF NewJob <> '' THEN BEGIN
                    FALedgEntry."Global Dimension 1 Code" := NewJob;
                    FALedgEntry."Dimension Set ID" := DimSetID;
                    FALedgEntry.MODIFY(TRUE);
                END;

                IF NewReporting <> '' THEN BEGIN
                    FALedgEntry."Global Dimension 2 Code" := NewReporting;
                    FALedgEntry."Dimension Set ID" := DimSetID;
                    FALedgEntry.MODIFY(TRUE);
                END;
            UNTIL (FALedgEntry.NEXT = 0);

        // Modify CostEntry
        CostEntry.RESET;
        CostEntry.SETRANGE("Posting Date", Rec."Posting Date");
        CostEntry.SETRANGE("Document No.", Rec."Document No.");
        IF CostEntry.FINDFIRST THEN
            REPEAT
                IF NewDocNo <> '' THEN BEGIN
                    CostEntry."Document No." := NewDocNo;
                    CostEntry.MODIFY(TRUE);
                END;
            UNTIL (GLEntry.NEXT = 0);

        //Modify SalesShptHeader
        SalesShptHeader.RESET;

        //SalesShptHeader.SETRANGE("Posting Date",Rec."Posting Date");

        SalesShptHeader.SETRANGE("No.", Rec."Document No.");
        IF SalesShptHeader.FINDFIRST THEN BEGIN
            SalesShptLine.RESET;
            SalesShptLine.SETRANGE("Document No.", Rec."Document No.");
            IF JobOnly THEN SalesShptLine.SETRANGE("Job No.", OldJobNo);
            IF SalesShptLine.FINDFIRST THEN;
            IF NewDocumentDate <> 0D THEN BEGIN
                SalesShptHeader."Document Date" := NewDocumentDate;
                SalesShptHeader."Posting Date" := NewDocumentDate;
                SalesShptHeader.MODIFY(TRUE);
            END;

            IF NewDueDate <> 0D THEN BEGIN
                SalesShptHeader."Due Date" := NewDueDate;
                SalesShptHeader.MODIFY(TRUE);
            END;

            IF NewJob <> '' THEN BEGIN
                IF SalesShptLine.FINDFIRST THEN
                    REPEAT
                        SalesShptLine."Job No." := NewJob;
                        SalesShptLine."Shortcut Dimension 1 Code" := NewJob;
                        SalesShptLine."Dimension Set ID" := DimSetID;
                        SalesShptLine.MODIFY(TRUE);
                    UNTIL (SalesShptLine.NEXT = 0);
            END;

            IF NewReporting <> '' THEN BEGIN
                IF SalesShptLine.FINDFIRST THEN
                    REPEAT
                        SalesShptLine."Shortcut Dimension 2 Code" := NewReporting;
                        SalesShptLine."Dimension Set ID" := DimSetID;
                        SalesShptLine.MODIFY(TRUE);
                    UNTIL (SalesShptLine.NEXT = 0);
            END;

            IF NewDocNo <> '' THEN BEGIN
                IF SalesShptLine.FINDFIRST THEN
                    REPEAT
                        IF SalesShptLine.Quantity <> 0 THEN BEGIN
                            IF SalesShptLine2.GET(NewDocNo, SalesShptLine."Line No.") THEN BEGIN
                                IF SalesShptLine2.Quantity = 0 THEN
                                    SalesShptLine2.DELETE(TRUE);
                            END;

                            IF SalesShptLine2.GET(SalesShptLine."Document No.", SalesShptLine."Line No.") THEN BEGIN
                                IF NOT SalesShptLine3.GET(NewDocNo, SalesShptLine2."Line No.")
                                  THEN
                                    SalesShptLine2.RENAME(NewDocNo, SalesShptLine2."Line No.")
                                ELSE BEGIN
                                    SalesShptLine3.Quantity := SalesShptLine3.Quantity + SalesShptLine2.Quantity;
                                    SalesShptLine3."Quantity (Base)" := SalesShptLine3."Quantity (Base)" + SalesShptLine2."Quantity (Base)";
                                    SalesShptLine3."Qty. Shipped Not Invoiced" := SalesShptLine3."Qty. Shipped Not Invoiced" + SalesShptLine2."Qty. Shipped Not Invoiced";
                                    SalesShptLine3.MODIFY;

                                    SalesShptLine2.DELETE;
                                END;
                            END;
                        END;
                    UNTIL (SalesShptLine.NEXT = 0);
            END;
        END;

        // Modify SalesinvHeader
        SalesInvHeader.RESET;

        //SalesInvHeader.SETRANGE("Posting Date",Rec."Posting Date");

        SalesInvHeader.SETRANGE("No.", Rec."Document No.");
        IF SalesInvHeader.FINDFIRST THEN BEGIN
            SalesInvLine.RESET;
            SalesInvLine.SETRANGE("Document No.", Rec."Document No.");
            IF JobOnly THEN
                SalesInvLine.SETRANGE("Job No.", OldJobNo);
            IF SalesInvLine.FINDFIRST THEN;

            IF NewDocumentDate <> 0D THEN BEGIN
                SalesInvHeader."Document Date" := NewDocumentDate;
                SalesInvHeader."Posting Date" := NewDocumentDate;
                SalesInvHeader.MODIFY(TRUE);
            END;

            IF NewDueDate <> 0D THEN BEGIN
                SalesInvHeader."Due Date" := NewDueDate;
                SalesInvHeader.MODIFY(TRUE);
            END;

            IF NewJob <> '' THEN BEGIN
                IF SalesInvLine.FINDFIRST THEN
                    REPEAT
                        SalesInvLine."Job No." := NewJob;
                        SalesInvLine."Shortcut Dimension 1 Code" := NewJob;
                        SalesInvLine."Dimension Set ID" := DimSetID;
                        SalesInvLine.MODIFY(TRUE);
                    UNTIL (SalesInvLine.NEXT = 0);
            END;

            IF NewReporting <> '' THEN BEGIN
                IF SalesInvLine.FINDFIRST THEN
                    REPEAT
                        SalesInvLine."Shortcut Dimension 2 Code" := NewReporting;
                        SalesInvLine."Dimension Set ID" := DimSetID;
                        SalesInvLine.MODIFY(TRUE);
                    UNTIL (SalesInvLine.NEXT = 0);
            END;

            IF NewDocNo <> '' THEN BEGIN
                IF SalesInvLine.FINDFIRST THEN
                    REPEAT
                        IF SalesInvLine.Quantity <> 0 THEN BEGIN
                            IF SalesInvLine2.GET(NewDocNo, SalesInvLine."Line No.") THEN BEGIN
                                IF SalesInvLine2.Quantity = 0
                                  THEN
                                    SalesInvLine2.DELETE(TRUE);
                            END;

                            IF SalesInvLine2.GET(SalesInvLine."Document No.", SalesInvLine."Line No.") THEN BEGIN
                                IF NOT SalesInvLine3.GET(NewDocNo, SalesInvLine2."Line No.")
                                  THEN
                                    SalesInvLine2.RENAME(NewDocNo, SalesInvLine2."Line No.")
                                ELSE BEGIN
                                    SalesInvLine3.Quantity := SalesInvLine3.Quantity + SalesInvLine2.Quantity;
                                    SalesInvLine3."Quantity (Base)" := SalesInvLine3."Quantity (Base)" + SalesInvLine2."Quantity (Base)";
                                    SalesInvLine3."Line Amount" := SalesInvLine3."Line Amount" + SalesInvLine2."Line Amount";
                                    SalesInvLine3."Line Discount Amount" := SalesInvLine3."Line Discount Amount" + SalesInvLine2."Line Discount Amount";
                                    SalesInvLine3.Amount := SalesInvLine3.Amount + SalesInvLine2.Amount;
                                    SalesInvLine3."Amount Including VAT" := SalesInvLine3."Amount Including VAT" + SalesInvLine2."Amount Including VAT";
                                    SalesInvLine3."VAT Base Amount" := SalesInvLine3."VAT Base Amount" + SalesInvLine2."VAT Base Amount";
                                    SalesInvLine3.MODIFY;

                                    SalesInvLine2.DELETE;
                                END;
                            END;
                        END;
                    UNTIL (SalesInvLine.NEXT = 0);
            END;
        END;

        // Modify SalesCrHeader
        SalesCrMemoHeader.RESET;

        //SalesCrMemoHeader.SETRANGE("Posting Date",Rec."Posting Date");

        SalesCrMemoHeader.SETRANGE("No.", Rec."Document No.");
        IF SalesCrMemoHeader.FINDFIRST THEN BEGIN
            SalesCrMemoLine.RESET;
            SalesCrMemoLine.SETRANGE("Document No.", Rec."Document No.");
            IF JobOnly THEN
                SalesCrMemoLine.SETRANGE("Job No.", OldJobNo);
            IF SalesCrMemoLine.FINDFIRST THEN;
            IF NewDocNo <> '' THEN BEGIN
                SalesCrMemoHeader.RENAME(NewDocNo);
            END;
            IF NewDocumentDate <> 0D THEN BEGIN
                SalesCrMemoHeader."Document Date" := NewDocumentDate;
                SalesCrMemoHeader."Posting Date" := NewDocumentDate;
                SalesCrMemoHeader.MODIFY(TRUE);
            END;
            IF NewDueDate <> 0D THEN BEGIN
                SalesCrMemoHeader."Due Date" := NewDueDate;
                SalesCrMemoHeader.MODIFY(TRUE);
            END;
            IF NewJob <> '' THEN BEGIN
                IF SalesCrMemoLine.FINDFIRST THEN
                    REPEAT
                        SalesCrMemoLine."Job No." := NewJob;
                        SalesCrMemoLine."Shortcut Dimension 1 Code" := NewJob;
                        SalesCrMemoLine."Dimension Set ID" := DimSetID;
                        SalesCrMemoLine.MODIFY(TRUE);
                    UNTIL (SalesCrMemoLine.NEXT = 0);
            END;
            IF NewReporting <> '' THEN BEGIN
                IF SalesCrMemoLine.FINDFIRST THEN
                    REPEAT
                        SalesCrMemoLine."Shortcut Dimension 2 Code" := NewReporting;
                        SalesCrMemoLine."Dimension Set ID" := DimSetID;
                        SalesCrMemoLine.MODIFY(TRUE);
                    UNTIL (SalesCrMemoLine.NEXT = 0);
            END;
        END;

        // Modify ReturnRcptHeader
        ReturnRcptHeader.RESET;
        ReturnRcptHeader.SETRANGE("Posting Date", Rec."Posting Date");
        ReturnRcptHeader.SETRANGE("No.", Rec."Document No.");
        IF ReturnRcptHeader.FINDFIRST THEN BEGIN
            ReturnRcptLine.RESET;
            ReturnRcptLine.SETRANGE("Document No.", Rec."Document No.");
            IF JobOnly THEN ReturnRcptLine.SETRANGE("Job No.", OldJobNo);
            IF ReturnRcptLine.FINDFIRST THEN;
            IF NewDocNo <> '' THEN BEGIN
                ReturnRcptHeader.RENAME(NewDocNo);
            END;
            IF NewDocumentDate <> 0D THEN BEGIN
                ReturnRcptHeader."Document Date" := NewDocumentDate;
                ReturnRcptHeader.MODIFY(TRUE);
            END;
            IF NewDueDate <> 0D THEN BEGIN
                ReturnRcptHeader."Due Date" := NewDueDate;
                ReturnRcptHeader.MODIFY(TRUE);
            END;
            IF NewJob <> '' THEN BEGIN
                IF ReturnRcptLine.FINDFIRST THEN
                    REPEAT
                        ReturnRcptLine."Job No." := NewJob;
                        ReturnRcptLine."Shortcut Dimension 1 Code" := NewJob;
                        ReturnRcptLine."Dimension Set ID" := DimSetID;
                        ReturnRcptLine.MODIFY(TRUE);
                    UNTIL (ReturnRcptLine.NEXT = 0);
            END;
            IF NewReporting <> '' THEN BEGIN
                IF ReturnRcptLine.FINDFIRST THEN
                    REPEAT
                        ReturnRcptLine."Shortcut Dimension 2 Code" := NewReporting;
                        ReturnRcptLine."Dimension Set ID" := DimSetID;
                        ReturnRcptLine.MODIFY(TRUE);
                    UNTIL (ReturnRcptLine.NEXT = 0);
            END;
        END;

        // Modify IssuedReminderHeader
        IssuedReminderHeader.RESET;
        IssuedReminderHeader.SETRANGE("Posting Date", Rec."Posting Date");
        IssuedReminderHeader.SETRANGE("No.", Rec."Document No.");
        IF IssuedReminderHeader.FINDFIRST THEN BEGIN
            IssuedReminderLine.RESET;
            IssuedReminderLine.SETRANGE("Document No.", Rec."Document No.");
            IF IssuedReminderLine.FINDFIRST THEN;
            IF NewDocNo <> '' THEN BEGIN
                IssuedReminderHeader.RENAME(NewDocNo);
            END;
            IF NewDocumentDate <> 0D THEN BEGIN
                IssuedReminderHeader."Document Date" := NewDocumentDate;
                IssuedReminderHeader.MODIFY(TRUE);
            END;
            IF NewDueDate <> 0D THEN BEGIN
                IssuedReminderHeader."Due Date" := NewDueDate;
                IssuedReminderHeader.MODIFY(TRUE);
            END;
            IF NewJob <> '' THEN BEGIN
                IssuedReminderHeader."Shortcut Dimension 1 Code" := NewJob;
                IssuedReminderHeader."Dimension Set ID" := DimSetID;
                IssuedReminderHeader.MODIFY(TRUE);
            END;
            IF NewReporting <> '' THEN BEGIN
                IssuedReminderHeader."Shortcut Dimension 2 Code" := NewReporting;
                IssuedReminderHeader."Dimension Set ID" := DimSetID;
                IssuedReminderHeader.MODIFY(TRUE);
            END;
        END;

        // Modify PurchRcptHeader
        PurchRcptHeader.RESET;
        PurchRcptHeader.SETRANGE("Posting Date", Rec."Posting Date");
        PurchRcptHeader.SETRANGE("No.", Rec."Document No.");
        IF PurchRcptHeader.FINDFIRST THEN BEGIN
            PurchRcptLine.RESET;
            PurchRcptLine.SETRANGE("Document No.", Rec."Document No.");
            IF JobOnly
              THEN
                PurchRcptLine.SETRANGE("Job No.", OldJobNo);
            IF PurchRcptLine.FINDFIRST THEN;
            IF NewDocNo <> ''
              THEN
                PurchRcptHeader.RENAME(NewDocNo);
            IF NewDocumentDate <> 0D THEN BEGIN
                PurchRcptHeader."Document Date" := NewDocumentDate;
                PurchRcptHeader.MODIFY(TRUE);
            END;
            IF NewDueDate <> 0D THEN BEGIN
                PurchRcptHeader."Due Date" := NewDueDate;
                PurchRcptHeader.MODIFY(TRUE);
            END;
            IF NewJob <> '' THEN BEGIN
                IF PurchRcptLine.FINDFIRST THEN
                    REPEAT
                        PurchRcptLine."Job No." := NewJob;
                        PurchRcptLine."Shortcut Dimension 1 Code" := NewJob;
                        PurchRcptLine."Dimension Set ID" := DimSetID;
                        PurchRcptLine.MODIFY(TRUE);
                    UNTIL (PurchRcptLine.NEXT = 0);
            END;
            IF NewReporting <> '' THEN BEGIN
                IF PurchRcptLine.FINDFIRST THEN
                    REPEAT
                        PurchRcptLine."Shortcut Dimension 2 Code" := NewReporting;
                        PurchRcptLine."Dimension Set ID" := DimSetID;
                        PurchRcptLine.MODIFY(TRUE);
                    UNTIL (PurchRcptLine.NEXT = 0);
            END;
            IF NewDocNo <> '' THEN BEGIN
                IF PurchRcptLine.FINDFIRST THEN
                    REPEAT
                        IF PurchRcptLine.Quantity <> 0 THEN BEGIN
                            IF PurchRcptLine2.GET(NewDocNo, PurchRcptLine."Line No.") THEN BEGIN
                                IF PurchRcptLine2.Quantity = 0
                                  THEN
                                    PurchRcptLine2.DELETE(TRUE);
                            END;
                            IF PurchRcptLine2.GET(PurchRcptLine."Document No.", PurchRcptLine."Line No.") THEN
                                PurchRcptLine2.RENAME(NewDocNo, PurchRcptLine2."Line No.");
                        END;
                    UNTIL (PurchRcptLine.NEXT = 0);
            END;
        END;

        // Modify PurchinvHeader
        PurchInvHeader.RESET;
        PurchInvHeader.SETRANGE("Posting Date", Rec."Posting Date");
        PurchInvHeader.SETRANGE("No.", Rec."Document No.");
        IF PurchInvHeader.FINDFIRST THEN BEGIN
            PurchInvLine.RESET;
            PurchInvLine.SETRANGE("Document No.", Rec."Document No.");
            IF JobOnly THEN
                PurchInvLine.SETRANGE("Job No.", OldJobNo);
            IF PurchInvLine.FINDFIRST THEN;
            IF NewDocNo <> '' THEN BEGIN
                PurchInvHeader.RENAME(NewDocNo);
            END;

            IF NewDocumentDate <> 0D THEN BEGIN
                PurchInvHeader."Document Date" := NewDocumentDate;
                PurchInvHeader."Posting Date" := NewDocumentDate;
                PurchInvHeader.MODIFY(TRUE);
            END;

            IF NewDueDate <> 0D THEN BEGIN
                PurchInvHeader."Due Date" := NewDueDate;
                PurchInvHeader.MODIFY(TRUE);
            END;

            IF NewJob <> '' THEN BEGIN
                IF PurchInvLine.FINDFIRST THEN
                    REPEAT
                        PurchInvLine."Job No." := NewJob;
                        PurchInvLine."Shortcut Dimension 1 Code" := NewJob;
                        PurchInvLine."Dimension Set ID" := DimSetID;
                        PurchInvLine.MODIFY(TRUE);
                    UNTIL (PurchInvLine.NEXT = 0);
            END;

            IF NewReporting <> '' THEN BEGIN
                IF PurchInvLine.FINDFIRST THEN
                    REPEAT
                        PurchInvLine."Shortcut Dimension 2 Code" := NewReporting;
                        PurchInvLine."Dimension Set ID" := DimSetID;
                        PurchInvLine.MODIFY(TRUE);
                    UNTIL (PurchInvLine.NEXT = 0);
            END;

            IF NewDocNo <> '' THEN BEGIN
                IF PurchInvLine.FINDFIRST THEN
                    REPEAT
                        IF PurchInvLine.Quantity <> 0 THEN BEGIN
                            IF PurchInvLine2.GET(NewDocNo, PurchInvLine."Line No.") THEN BEGIN
                                IF PurchInvLine2.Quantity = 0
                                  THEN
                                    PurchInvLine2.DELETE(TRUE);
                            END;
                            IF PurchInvLine2.GET(PurchInvLine."Document No.", PurchInvLine."Line No.")
                              THEN
                                PurchInvLine2.RENAME(NewDocNo, PurchInvLine2."Line No.");
                        END;
                    UNTIL (PurchInvLine.NEXT = 0);
            END;
        END;

        // Modify PurchCrHeader
        PurchCrMemoHeader.RESET;
        PurchCrMemoHeader.SETRANGE("Posting Date", Rec."Posting Date");
        PurchCrMemoHeader.SETRANGE("No.", Rec."Document No.");
        IF PurchCrMemoHeader.FINDFIRST THEN BEGIN
            PurchCrMemoLine.RESET;
            PurchCrMemoLine.SETRANGE("Document No.", Rec."Document No.");
            IF JobOnly
              THEN
                PurchCrMemoLine.SETRANGE("Job No.", OldJobNo);
            IF PurchCrMemoLine.FINDFIRST THEN;
            IF NewDocNo <> ''
              THEN
                PurchCrMemoHeader.RENAME(NewDocNo);
            IF NewDocumentDate <> 0D THEN BEGIN
                PurchCrMemoHeader."Document Date" := NewDocumentDate;
                PurchCrMemoHeader.MODIFY(TRUE);
            END;
            IF NewDueDate <> 0D THEN BEGIN
                PurchCrMemoHeader."Due Date" := NewDueDate;
                PurchCrMemoHeader.MODIFY(TRUE);
            END;
            IF NewJob <> '' THEN BEGIN
                IF PurchCrMemoLine.FINDFIRST THEN
                    REPEAT
                        PurchCrMemoLine."Job No." := NewJob;
                        PurchCrMemoLine."Shortcut Dimension 1 Code" := NewJob;
                        PurchCrMemoLine."Dimension Set ID" := DimSetID;
                        PurchCrMemoLine.MODIFY(TRUE);
                    UNTIL (PurchCrMemoLine.NEXT = 0);
            END;
            IF NewReporting <> '' THEN BEGIN
                IF PurchCrMemoLine.FINDFIRST THEN
                    REPEAT
                        PurchCrMemoLine."Shortcut Dimension 2 Code" := NewReporting;
                        PurchCrMemoLine."Dimension Set ID" := DimSetID;
                        PurchCrMemoLine.MODIFY(TRUE);
                    UNTIL (PurchCrMemoLine.NEXT = 0);
            END;
        END;

        // Modify ReturnShptHeader
        ReturnShptHeader.RESET;
        ReturnShptHeader.SETRANGE("Posting Date", Rec."Posting Date");
        ReturnShptHeader.SETRANGE("No.", Rec."Document No.");
        IF ReturnShptHeader.FINDFIRST THEN BEGIN
            ReturnShptLine.RESET;
            ReturnShptLine.SETRANGE("Document No.", Rec."Document No.");
            IF JobOnly THEN ReturnShptLine.SETRANGE("Job No.", OldJobNo);
            IF ReturnShptLine.FINDFIRST THEN;
            IF NewDocNo <> ''
              THEN
                ReturnShptHeader.RENAME(NewDocNo);
            IF NewDocumentDate <> 0D THEN BEGIN
                ReturnShptHeader."Document Date" := NewDocumentDate;
                ReturnShptHeader.MODIFY(TRUE);
            END;
            IF NewDueDate <> 0D THEN BEGIN
                ReturnShptHeader."Due Date" := NewDueDate;
                ReturnShptHeader.MODIFY(TRUE);
            END;
            IF NewJob <> '' THEN BEGIN
                IF ReturnShptLine.FINDFIRST THEN
                    REPEAT
                        ReturnShptLine."Job No." := NewJob;
                        ReturnShptLine."Shortcut Dimension 1 Code" := NewJob;
                        ReturnShptLine."Dimension Set ID" := DimSetID;
                        ReturnShptLine.MODIFY(TRUE);
                    UNTIL (ReturnShptLine.NEXT = 0);
            END;
            IF NewReporting <> '' THEN BEGIN
                IF ReturnShptLine.FINDFIRST THEN
                    REPEAT
                        ReturnShptLine."Shortcut Dimension 2 Code" := NewReporting;
                        ReturnShptLine."Dimension Set ID" := DimSetID;
                        ReturnShptLine.MODIFY(TRUE);
                    UNTIL (ReturnShptLine.NEXT = 0);
            END;
        END;

        // Modify TransShptHeader
        TransShptHeader.RESET;
        TransShptHeader.SETRANGE("Posting Date", Rec."Posting Date");
        TransShptHeader.SETRANGE("No.", Rec."Document No.");
        IF TransShptHeader.FINDFIRST THEN BEGIN
            TransShptLine.RESET;
            TransShptLine.SETRANGE("Document No.", Rec."Document No.");
            IF JobOnly
              THEN
                TransShptLine.SETRANGE("Shortcut Dimension 1 Code", OldJobNo);
            IF TransShptLine.FINDFIRST THEN;
            IF NewDocNo <> ''
             THEN
                TransShptHeader.RENAME(NewDocNo);
            IF NewJob <> '' THEN BEGIN
                IF TransShptLine.FINDFIRST THEN
                    REPEAT
                        TransShptLine."Shortcut Dimension 1 Code" := NewJob;
                        TransShptLine."Dimension Set ID" := DimSetID;
                        TransShptLine.MODIFY(TRUE);
                    UNTIL (TransShptLine.NEXT = 0);
            END;
            IF NewReporting <> '' THEN BEGIN
                IF TransShptLine.FINDFIRST THEN
                    REPEAT
                        TransShptLine."Shortcut Dimension 2 Code" := NewReporting;
                        TransShptLine."Dimension Set ID" := DimSetID;
                        TransShptLine.MODIFY(TRUE);
                    UNTIL (TransShptLine.NEXT = 0);
            END;
        END;

        // Modify TransRcptHeader
        TransRcptHeader.RESET;
        TransRcptHeader.SETRANGE("Posting Date", Rec."Posting Date");
        TransRcptHeader.SETRANGE("No.", Rec."Document No.");
        IF TransRcptHeader.FINDFIRST THEN BEGIN
            TransRcptLine.RESET;
            TransRcptLine.SETRANGE("Document No.", Rec."Document No.");
            IF JobOnly
              THEN
                TransRcptLine.SETRANGE("Shortcut Dimension 1 Code", OldJobNo);
            IF TransRcptLine.FINDFIRST THEN;
            IF NewDocNo <> ''
              THEN
                TransRcptHeader.RENAME(NewDocNo);
            IF NewJob <> '' THEN BEGIN
                IF TransRcptLine.FINDFIRST THEN
                    REPEAT
                        TransRcptLine."Shortcut Dimension 1 Code" := NewJob;
                        TransRcptLine."Dimension Set ID" := DimSetID;
                        TransRcptLine.MODIFY(TRUE);
                    UNTIL (TransRcptLine.NEXT = 0);
            END;
            IF NewReporting <> '' THEN BEGIN
                IF TransRcptLine.FINDFIRST THEN
                    REPEAT
                        TransRcptLine."Shortcut Dimension 2 Code" := NewReporting;
                        TransRcptLine."Dimension Set ID" := DimSetID;
                        TransRcptLine.MODIFY(TRUE);
                    UNTIL (TransRcptLine.NEXT = 0);
            END;
        END;

        // Modify PaymentHeader
        PaymentHeader.RESET;
        PaymentHeader.SETRANGE("Posting Date", Rec."Posting Date");
        PaymentHeader.SETRANGE("No.", Rec."Document No.");
        IF PaymentHeader.FINDFIRST THEN BEGIN
            PaymentLine.RESET;
            PaymentLine.SETRANGE("Document No.", Rec."Document No.");
            IF PaymentLine.FINDFIRST THEN;
            IF NewDocNo <> ''
              THEN
                PaymentHeader.RENAME(NewDocNo);
            IF NewDocumentDate <> 0D THEN BEGIN
                PaymentHeader."Document Date" := NewDocumentDate;
                PaymentHeader.MODIFY(TRUE);
            END;
            IF NewJob <> '' THEN BEGIN
                PaymentHeader."Shortcut Dimension 1 Code" := NewJob;
                PaymentHeader."Dimension Set ID" := DimSetID;
                PaymentHeader.MODIFY(TRUE);
            END;
            IF NewReporting <> '' THEN BEGIN
                PaymentHeader."Shortcut Dimension 2 Code" := NewReporting;
                PaymentHeader."Dimension Set ID" := DimSetID;
                PaymentHeader.MODIFY(TRUE);
            END;
        END;

        // Modify ArchPaymentHeader
        ArchPaymentHeader.RESET;
        ArchPaymentHeader.SETRANGE("Posting Date", Rec."Posting Date");
        ArchPaymentHeader.SETRANGE("No.", Rec."Document No.");
        IF ArchPaymentHeader.FINDFIRST THEN BEGIN
            IF NewDocNo <> ''
              THEN
                ArchPaymentHeader.RENAME(NewDocNo);
            IF NewDocumentDate <> 0D THEN BEGIN
                ArchPaymentHeader."Document Date" := NewDocumentDate;
                ArchPaymentHeader.MODIFY(TRUE);
            END;
            IF NewJob <> '' THEN BEGIN
                ArchPaymentHeader."Shortcut Dimension 1 Code" := NewJob;
                ArchPaymentHeader."Dimension Set ID" := DimSetID;
                ArchPaymentHeader.MODIFY(TRUE);
            END;
            IF NewReporting <> '' THEN BEGIN
                ArchPaymentHeader."Shortcut Dimension 2 Code" := NewReporting;
                ArchPaymentHeader."Dimension Set ID" := DimSetID;
                ArchPaymentHeader.MODIFY(TRUE);
            END;
        END;
    END;

    PROCEDURE Controlcorrection(): Boolean;
    VAR
        Continue: Boolean;
    BEGIN
        IF (NewDocNo = '') AND (NewDocumentDate = 0D) AND (NewJob = '') AND (NewGlaccount = '') AND (NewDescription = '')
         AND (NewReporting = '') AND (Rec.Quantity = NewQuantity) AND (NewDueDate = 0D) AND (STRLEN(NewBankAccount) = 0) THEN BEGIN
            //->RPE210316
            Continue := FALSE;
            MESSAGE(Text001);
        END ELSE BEGIN
            Continue := TRUE;
            //<-RPE210316
            DocNoFilter := Rec."Document No.";
            PostingDateFilter := FORMAT(Rec."Posting Date");
            AllLines := True;

            IF AllLines = TRUE
              THEN
                Correctionalllines
            ELSE
                Correctiononeline;
            //->RPE210316
            IF (Rec."Source Type" = Rec."Source Type"::"Bank Account") AND (STRLEN(Rec."Source No.") <> 0) AND (STRLEN(NewBankAccount) <> 0)
              THEN
                CorrBankLines(Rec."Source No.");
            //<-RPE210316
        END;
        //->RPE210316
        EXIT(Continue);
        //<-RPE210316
    END;

    PROCEDURE Correctiononeline();
    BEGIN
        IF NewDocNo <> '' THEN BEGIN
            Rec."Document No." := NewDocNo;
            Rec.MODIFY(TRUE);
        END;
        IF NewQuantity <> Rec.Quantity THEN BEGIN
            Rec.Quantity := NewQuantity;
            Rec.MODIFY(TRUE);
        END;
        IF NewDocumentDate <> 0D THEN BEGIN
            Rec."Document Date" := NewDocumentDate;
            Rec.MODIFY(TRUE);
        END;
        IF NewGlaccount <> '' THEN BEGIN
            Rec."G/L Account No." := NewGlaccount;
            Rec.MODIFY(TRUE);
        END;
        IF NewDescription <> '' THEN BEGIN
            Rec.Description := NewDescription;
            Rec.MODIFY(TRUE);
        END;

        // Modification nø projet /une seule ‚criture
        IF NewJob <> '' THEN BEGIN
            Rec."Global Dimension 1 Code" := NewJob;
            IF DimSetEntry.GET(Rec."Dimension Set ID", 'CENTRE')
              THEN
                Rec."Dimension Set ID" := CalcDimSetID(Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", DimSetEntry."Dimension Value Code")
            ELSE
                Rec."Dimension Set ID" := CalcDimSetID(Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", '');
            Rec."Job No." := NewJob;
            Rec.MODIFY(TRUE);
        END;

        // Modification axe reporting /une seule ligne
        IF NewReporting <> '' THEN BEGIN
            Rec."Global Dimension 2 Code" := NewReporting;
            IF DimSetEntry.GET(Rec."Dimension Set ID", 'CENTRE')
              THEN
                Rec."Dimension Set ID" := CalcDimSetID(Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", DimSetEntry."Dimension Value Code")
            ELSE
                Rec."Dimension Set ID" := CalcDimSetID(Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", '');
            Rec.MODIFY(TRUE);
        END;
    END;

    LOCAL PROCEDURE CorrBankLines(pBankAccount: Code[10]);
    VAR
        BankAccLedgEntry: Record 271;
        BankAccountPostingGroup: Record 277;
        BankAccount: Record 270;
        Buffer: Text;
        Position: Integer;
    BEGIN
        BankAccLedgEntry.RESET; //RPE210316
        BankAccLedgEntry.SETRANGE("Posting Date", Rec."Posting Date");
        BankAccLedgEntry.SETRANGE("Document No.", Rec."Document No.");
        BankAccLedgEntry.SETRANGE("Bank Account No.", pBankAccount);
        IF BankAccLedgEntry.FINDFIRST THEN BEGIN
            REPEAT
                IF BankAccount.GET(NewBankAccount) THEN BEGIN
                    BankAccLedgEntry."Bank Account No." := NewBankAccount;
                    BankAccLedgEntry."Bank Acc. Posting Group" := BankAccount."Bank Acc. Posting Group";
                    BankAccLedgEntry.Description := STRSUBSTNO(Text026, NewBankAccount, BankAccLedgEntry."Document No.");
                    IF (BankAccLedgEntry."Bal. Account Type" = BankAccLedgEntry."Bal. Account Type"::"Bank Account") AND (BankAccLedgEntry."Bal. Account No." = pBankAccount)
                      THEN
                        BankAccLedgEntry."Bal. Account No." := NewBankAccount;
                    BankAccLedgEntry.MODIFY(TRUE);
                    CorrBankGLEntry(pBankAccount);
                END ELSE
                    ERROR(Text027, NewBankAccount);
            UNTIL (BankAccLedgEntry.NEXT = 0);
        END;
    END;

    LOCAL PROCEDURE CorrBankGLEntry(pSourceNo: Code[20]);
    VAR
        GLEntry: Record 17;
        i: Integer;
    BEGIN
        GLEntry.RESET; //RPE210316
        GLEntry.SETRANGE("Posting Date", Rec."Posting Date");
        GLEntry.SETRANGE("Document No.", Rec."Document No.");
        GLEntry.SETRANGE("Source Type", GLEntry."Source Type"::"Bank Account");
        GLEntry.SETRANGE("Source No.", pSourceNo);
        IF GLEntry.FINDFIRST THEN BEGIN
            IF (STRLEN(NewBankAccount) <> 0) THEN BEGIN
                REPEAT
                    GLEntry."Source No." := NewBankAccount;
                    IF (GLEntry."Bal. Account Type" = GLEntry."Bal. Account Type"::"Bank Account") AND (GLEntry."Bal. Account No." = pSourceNo)
                      THEN
                        GLEntry."Bal. Account No." := NewBankAccount;
                    GLEntry.MODIFY(TRUE);
                UNTIL GLEntry.NEXT = 0;
            END;
        END;
    END;

    PROCEDURE ModificationDV(IDSetEntry: Integer; NewJob: Code[20]; NewReporting: Code[20]) i: Integer;
    VAR
        DimSetEntry: Record 480;
        DimSetEntry2: Record 480;
    BEGIN
        IF DimSetEntry.FINDLAST THEN i := DimSetEntry."Dimension Set ID" + 1;
        DimSetEntry.RESET;
        DimSetEntry.SETRANGE(DimSetEntry."Dimension Set ID", IDSetEntry);
        IF DimSetEntry.FINDFIRST THEN
            REPEAT
                DimSetEntry2.INIT;
                DimSetEntry2 := DimSetEntry;
                DimSetEntry."Dimension Set ID" := i;
                IF NewJob <> '' THEN BEGIN
                    IF DimSetEntry."Dimension Code" = 'DOSSIER'
                      THEN
                        DimSetEntry2."Dimension Value Code" := NewJob;
                END;
                IF NewReporting <> '' THEN BEGIN
                    IF DimSetEntry."Dimension Code" = 'REPORTING'
                      THEN
                        DimSetEntry2."Dimension Value Code" := NewReporting;
                END;
                DimSetEntry2.INSERT(TRUE);
            UNTIL (DimSetEntry.NEXT = 0);
    END;

    PROCEDURE CalcDimSetID(CodeJob: Code[50]; CodeReporting: Code[50]; CodeCentre: Code[50]) DimSetID: Integer;
    BEGIN
        IF GlSetup.GET('') THEN;

        GenJnlLine.RESET;
        GenJnlLine.SETRANGE(GenJnlLine."Journal Template Name", 'REPBAL');
        GenJnlLine.SETRANGE(GenJnlLine."Journal Batch Name", 'DEFAUT');
        IF GenJnlLine.FINDLAST
          THEN
            i := GenJnlLine."Line No." + 10000 ELSE
            i := 10000;

        GenJnlLine.RESET;
        GenJnlLine.INIT;
        GenJnlLine."Journal Template Name" := 'REPBAL';
        GenJnlLine."Journal Batch Name" := 'DEFAUT';
        GenJnlLine.VALIDATE(GenJnlLine."Line No.", i);
        GenJnlLine.Description := 'insertaxe';
        GenJnlLine.INSERT(TRUE);
        GenJnlLine.VALIDATE("Shortcut Dimension 1 Code", CodeJob);
        GenJnlLine.VALIDATE("Shortcut Dimension 2 Code", CodeReporting);
        IF GlSetup."Shortcut Dimension 3 Code" <> ''
          THEN
            GenJnlLine.ValidateShortcutDimCode(3, CodeCentre);
        GenJnlLine.MODIFY;

        DimSetID := GenJnlLine."Dimension Set ID";
        GenJnlLine.DELETE;
    END;

    PROCEDURE CalcDimSetID2(OldDimSetId: Integer; CodeAxe1: Code[50]; CodeAxe2: Code[50]) DimSetID: Integer;
    VAR
        TempDimSetEntry: Record 480 temporary;
        CU408: Codeunit 408;
        DimVal: Record 349;
    BEGIN
        IF GlSetup.GET('') THEN;
        CLEAR(CU408);

        //CU408.GlobalDimNo('XYZ'); //force l'appel GetSetup
        CU408.GetDimensionSet(TempDimSetEntry, OldDimSetId);

        // Axe 1
        DimVal."Dimension Code" := GlSetup."Shortcut Dimension 1 Code";
        IF CodeAxe1 <> ''
          THEN
            DimVal.GET(DimVal."Dimension Code", CodeAxe1);

        //IF NOT CheckDim(DimVal."Dimension Code") THEN ERROR(GetDimErr);
        //IF NOT CheckDimValue(DimVal."Dimension Code",ShortcutDimCode) THEN ERROR(GetDimErr);

        IF TempDimSetEntry.GET(TempDimSetEntry."Dimension Set ID", DimVal."Dimension Code") THEN
            IF TempDimSetEntry."Dimension Value Code" <> CodeAxe1
              THEN
                TempDimSetEntry.DELETE;

        IF CodeAxe1 <> '' THEN BEGIN
            TempDimSetEntry."Dimension Code" := DimVal."Dimension Code";
            TempDimSetEntry."Dimension Value Code" := DimVal.Code;
            TempDimSetEntry."Dimension Value ID" := DimVal."Dimension Value ID";
            IF TempDimSetEntry.INSERT THEN;
        END;

        // Axe 2
        DimVal."Dimension Code" := GlSetup."Shortcut Dimension 2 Code";
        IF CodeAxe2 <> ''
          THEN
            DimVal.GET(DimVal."Dimension Code", CodeAxe2);

        //IF NOT CheckDim(DimVal."Dimension Code") THEN ERROR(GetDimErr);
        //IF NOT CheckDimValue(DimVal."Dimension Code",ShortcutDimCode) THEN ERROR(GetDimErr);

        IF TempDimSetEntry.GET(TempDimSetEntry."Dimension Set ID", DimVal."Dimension Code") THEN
            IF TempDimSetEntry."Dimension Value Code" <> CodeAxe2
              THEN
                TempDimSetEntry.DELETE;

        IF CodeAxe2 <> '' THEN BEGIN
            TempDimSetEntry."Dimension Code" := DimVal."Dimension Code";
            TempDimSetEntry."Dimension Value Code" := DimVal.Code;
            TempDimSetEntry."Dimension Value ID" := DimVal."Dimension Value ID";
            IF TempDimSetEntry.INSERT THEN;
        END;

        DimSetID := CU408.GetDimensionSetID(TempDimSetEntry);
    END;


}
