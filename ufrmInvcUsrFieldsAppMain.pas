unit ufrmInvcUsrFieldsAppMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, urdiRProDB, urdiRProTable, urdiRProReceipt, StdCtrls, ExtCtrls;

type
  TfrmInvcUsrFieldsAppMain = class(TForm)
    rdiRProReceipt: TrdiRProReceipt;
    rdiRProDB: TrdiRProDB;
    edtInvcNum: TLabeledEdit;
    btnShowUserField1: TButton;
    edtNewValue: TLabeledEdit;
    btnSetUserField1: TButton;
    procedure btnShowUserField1Click(Sender: TObject);
    procedure rdiRProDBBeforeConnect(Sender: TObject);
    procedure rdiRProDBAfterConnect(Sender: TObject);
    procedure btnSetUserField1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmInvcUsrFieldsAppMain: TfrmInvcUsrFieldsAppMain;

implementation

{$R *.dfm}

uses
  RDA2_TLB;

procedure TfrmInvcUsrFieldsAppMain.btnSetUserField1Click(Sender: TObject);
begin
  if not rdiRProReceipt.Active then
    rdiRProReceipt.Open;
  if rdiRProReceipt.SearchByReceiptNum(StrToInt(edtInvcNum.Text)) then
    if Length(edtNewValue.Text) > 0 then begin
      rdiRProReceipt.RProTable.Document.EditMode := True;
      rdiRProReceipt.RProTable.Document.SetString(edtNewValue.Text, fidInvcUsr0);
      rdiRProReceipt.RProTable.PostRecord;
      ShowMessage('Value set!');
    end;
end;

procedure TfrmInvcUsrFieldsAppMain.btnShowUserField1Click(Sender: TObject);
var
  IsNull: WordBool;
begin
  if not rdiRProReceipt.Active then
    rdiRProReceipt.Open;
  if rdiRProReceipt.SearchByReceiptNum(StrToInt(edtInvcNum.Text)) then
    ShowMessage(rdiRProReceipt.RProTable.Document.GetString(fidInvcUsr0, IsNull));
end;

procedure TfrmInvcUsrFieldsAppMain.rdiRProDBAfterConnect(Sender: TObject);
begin
  Screen.Cursor := crDefault;
end;

procedure TfrmInvcUsrFieldsAppMain.rdiRProDBBeforeConnect(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;
end;

end.
