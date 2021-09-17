//CSV - séparateur ';'
//Entête :
//FOURN;CODE FAMILLE;FAMILLE;REFERENCE;DESIGNATION;FT;TARIF PUBLIC;PRIX ACHAT;MANUEL;IMAGE

xmlport 50100 "Import ItemCategory"
{
    Caption = 'Import ItemCategory';
    Format = VariableText;
    FieldSeparator = ';';
    TextEncoding = UTF8;
    RecordSeparator = '<NewLine>';

    schema
    {
        textelement(Root)
        {
            tableelement(Item; Item)
            {
                UseTemporary = TRUE;
                AutoReplace = TRUE;
                textelement(FOURN)
                {
                }
                textelement(CODE_FAMILLE)
                {
                }
                textelement(DESIG_FAMILLE)
                {
                }
                textelement(CODE_ARTICLE)
                {
                }
                textelement(DESIGNATION)
                {
                }
                textelement(FICHE_TECHNIQUE)
                {
                }
                textelement(TARIF_PUBLIC)
                {
                }
                textelement(PRIX_ACHAT)
                {
                }
                textelement(MANUEL)
                {
                }
                textelement(IMAGE)
                {
                }

                trigger OnAfterInsertRecord()
                begin
                    Main();
                end;

                trigger OnAfterModifyRecord()
                begin
                    Main();
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    trigger OnPreXmlPort()
    var
        itemCategRec: Record "Item Category";
    begin
        itemCategRec.DeleteAll();
    end;

    procedure Main()
    var
        itemCategRec: Record "Item Category";
        itemRec: Record Item;
        UnitPrice: Decimal;
        UnitCost: Decimal;
    begin
        //---------------Import Familles----------------
        //FOURNISSEUR
        itemCategRec.Reset();
        Clear(itemCategRec);
        if not itemCategRec.Get(FOURN) then begin
            itemCategRec.Init();
            itemCategRec.Code := FOURN;
            itemCategRec.Description := FOURN;
            itemCategRec."Parent Category" := '';
            itemCategRec.Indentation := 0;
            itemCategRec.Insert(FALSE);
        end;

        //FAMILLE ARTICLE
        itemCategRec.Reset();
        Clear(itemCategRec);
        itemCategRec.SetRange(Code, CODE_FAMILLE);
        itemCategRec.SetRange("Parent Category", FOURN);
        if not itemCategRec.FindFirst() then begin
            if not itemCategRec.Get(CODE_FAMILLE) then begin
                itemCategRec.Init();
                itemCategRec.Code := CODE_FAMILLE;
                itemCategRec.Description := DESIG_FAMILLE;
                itemCategRec."Parent Category" := FOURN;
                itemCategRec.Indentation := 1;
                itemCategRec.Insert(FALSE);
            end;
        end;

        //Application des modifications
        Commit();

        //---------------Import Articles----------------
        itemRec.Reset();
        Clear(itemRec);
        if not itemRec.GET(CODE_ARTICLE) then begin
            itemRec.Init();
            itemRec.Validate("No.", CODE_ARTICLE);
            if StrLen(DESIGNATION) > 100 then begin
                itemRec.Validate(Description, CopyStr(DESIGNATION, 1, 100));
            end else begin
                itemRec.Validate(Description, DESIGNATION);
            end;
            Evaluate(UnitPrice, TARIF_PUBLIC);
            Evaluate(UnitCost, PRIX_ACHAT);
            itemRec.Validate("Unit Price", UnitPrice);
            itemRec.Validate("Unit Cost", UnitCost);
            itemRec.Validate("Item Category Code", CODE_FAMILLE);
            if FICHE_TECHNIQUE <> '' then begin
                itemRec."Fiche technique" := FICHE_TECHNIQUE;
            end;
            if MANUEL <> '' then begin
                itemRec."Manuel utilisateur" := MANUEL;
            end;
            if IMAGE <> '' then begin
                itemRec."Image URL" := IMAGE;
            end;
            itemRec.INSERT(FALSE);
        end else begin
            if StrLen(DESIGNATION) > 100 then begin
                itemRec.Validate(Description, CopyStr(DESIGNATION, 1, 100));
            end else begin
                itemRec.Validate(Description, DESIGNATION);
            end;
            itemRec.Validate("Item Category Code", CODE_FAMILLE);
            if FICHE_TECHNIQUE <> '' then begin
                itemRec."Fiche technique" := FICHE_TECHNIQUE;
            end;
            if MANUEL <> '' then begin
                itemRec."Manuel utilisateur" := MANUEL;
            end;
            if IMAGE <> '' then begin
                itemRec."Image URL" := IMAGE;
            end;
            itemRec.MODIFY(FALSE);
        end;

        //Application des modifications
        Commit();

        //Ajout de l'image dans l'article
        if itemRec.Get(CODE_ARTICLE) then begin
            if IMAGE <> '' then begin
                InsertPicture(itemRec."No.", IMAGE);
            end;
        end;
    end;

    procedure InsertPicture(ItemNo: Code[20]; PictureURL: Text)
    var
        Item: Record Item;
        Client: HttpClient;
        Response: HttpResponseMessage;
        InStr: InStream;
    begin
        Client.Get(PictureURL, Response);
        Response.Content().ReadAs(InStr);
        Item.Get(ItemNo);
        Item.Picture.ImportStream(InStr, 'Picture From URL');
        Item.Modify();
    end;
}

