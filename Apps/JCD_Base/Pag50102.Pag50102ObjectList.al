page 50102 "ObjectList"
{
    Caption = 'Liste des objets';
    Editable = false;
    PageType = List;
    ApplicationArea = All;
    PromotedActionCategories = 'New,Process,Report,Filter';
    UsageCategory = Administration;
    SourceTable = AllObjWithCaption;
    SourceTableView = where("Object Type" = filter(= Table | Page | Query | Report | XMLport | Codeunit));

    layout
    {
        area(Content)
        {
            repeater(TableList)
            {
                field("Object Type"; Rec."Object Type")
                {
                    ApplicationArea = All;
                }
                field("Object ID"; Rec."Object ID")
                {
                    ApplicationArea = All;
                }
                field("Object Name"; Rec."Object Name")
                {
                    ApplicationArea = All;
                }
                field("Object Caption"; Rec."Object Caption")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Run Selected Object")
            {
                Caption = 'Run';
                ApplicationArea = All;
                Image = ExecuteBatch;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                Scope = Repeater;

                trigger OnAction()
                begin
                    RunObject();
                end;
            }
            action("Tables")
            {
                Caption = 'Tables';
                ApplicationArea = All;
                Image = Filter;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Category4;

                trigger OnAction()
                begin
                    FilterObjects(Rec."Object Type"::Table);
                end;
            }
            action("Pages")
            {
                Caption = 'Pages';
                ApplicationArea = All;
                Image = Filter;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Category4;

                trigger OnAction()
                begin
                    FilterObjects(Rec."Object Type"::Page);
                end;
            }
            action("Reports")
            {
                Caption = 'Reports';
                ApplicationArea = All;
                Image = Filter;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Category4;

                trigger OnAction()
                begin
                    FilterObjects(Rec."Object Type"::Report);
                end;
            }
            action("Queries")
            {
                Caption = 'Queries';
                ApplicationArea = All;
                Image = Filter;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Category4;

                trigger OnAction()
                begin
                    FilterObjects(Rec."Object Type"::Query);
                end;
            }
            action("XMLports")
            {
                Caption = 'XMLports';
                ApplicationArea = All;
                Image = Filter;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Category4;

                trigger OnAction()
                begin
                    FilterObjects(Rec."Object Type"::XMLport);
                end;
            }
            action("Codeunits")
            {
                Caption = 'Codeunits';
                ApplicationArea = All;
                Image = Filter;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Category4;

                trigger OnAction()
                begin
                    FilterObjects(Rec."Object Type"::Codeunit);
                end;
            }
            action("Reset Filter")
            {
                Caption = 'Reset Filter';
                ApplicationArea = All;
                Image = ResetStatus;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Category4;

                trigger OnAction()
                begin
                    ResetFilter();
                end;
            }

        }
    }

    local procedure RunObject()
    begin
        case Rec."Object Type" of
            Rec."Object Type"::Table:
                Hyperlink(GetUrl(ClientType::Current, CompanyName, ObjectType::Table, Rec."Object ID"));
            Rec."Object Type"::Query:
                Hyperlink(GetUrl(ClientType::Current, CompanyName, ObjectType::Query, Rec."Object ID"));
            Rec."Object Type"::Page:
                PAGE.RUN(Rec."Object ID");
            Rec."Object Type"::Report:
                REPORT.RUN(Rec."Object ID");
            Rec."Object Type"::XMLport:
                XMLPORT.RUN(Rec."Object ID");
            Rec."Object Type"::Codeunit:
                CODEUNIT.RUN(Rec."Object ID");
        end;
    end;

    local procedure ResetFilter()
    begin
        Rec.Reset();
        Rec.SetFilter("Object Type", '%1|%2|%3|%4|%5|%6', Rec."Object Type"::Table, Rec."Object Type"::Page, Rec."Object Type"::Report, Rec."Object Type"::Query, Rec."Object Type"::XMLport, Rec."Object Type"::Codeunit);
        Rec.FindFirst();
    end;

    local procedure FilterObjects(ObjectType: Integer)
    begin
        Rec.Reset();
        Rec.SetRange("Object Type", ObjectType);
        Rec.FindFirst();
    end;
}
