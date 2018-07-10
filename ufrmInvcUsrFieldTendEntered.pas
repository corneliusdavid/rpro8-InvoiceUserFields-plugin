unit ufrmInvcUsrFieldTendEntered;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons,
  {$IFDEF UseCodeSite} CodeSiteLogging, {$ENDIF}
  RDA2_TLB;

type
  TfrmUserFieldsTenderEntered = class(TForm)
    BitBtn1: TBitBtn;
    tmrCountdown: TTimer;
    lbFields: TListBox;
    lblSID: TLabel;
    lblRecNum: TLabel;
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure tmrCountdownTimer(Sender: TObject);
  private
    { Private declarations }
  public
    class procedure ShowFields(RdaDoc: IRdaDocument);
  end;



implementation

{$R *.DFM}

class procedure TfrmUserFieldsTenderEntered.ShowFields(RdaDoc: IRdaDocument);
var
  i: Integer;
  s: string;
  IsNull: WordBool;
  UserFieldList: TStringList;
begin
  {$IFDEF UseCodeSite}CodeSite.EnterMethod('TfrmUserFieldsTenderEntered.ShowFields');{$ENDIF}

  with TfrmUserFieldsTenderEntered.Create(nil) do
    try
      UserFieldList := TStringList.Create;
      try
        for i := 0 to 9 do begin
          s := RdaDoc.GetString(fidInvcUsr0 + i, IsNull);
          if IsNull then
            Break;
          UserFieldList.Add(IntToStr(i) + ': ' + s);
        end;

        lbFields.Items := UserFieldList;
      finally
        UserFieldList.Free;
      end;

      lblSID.Caption := IntToStr(RdaDoc.GetInt64(fidDocSID, IsNull));
      lblRecNum.Caption := IntToStr(RdaDoc.GetInteger(fidInvcNum, IsNull));

      Show;
      repeat
        Application.ProcessMessages;
      until not Visible;
    finally
      Free;
    end;

  {$IFDEF UseCodeSite}CodeSite.ExitMethod('TfrmUserFieldsTenderEntered.ShowFields');{$ENDIF}
end;

procedure TfrmUserFieldsTenderEntered.FormShow(Sender: TObject);
begin
  {$IFDEF UseCodeSite}CodeSite.EnterMethod(Self, 'FormShow');{$ENDIF}

  Top := 300;
  Left := 100;

  {$IFDEF UseCodeSite}CodeSite.ExitMethod(Self, 'FormShow');{$ENDIF}
end;

procedure TfrmUserFieldsTenderEntered.BitBtn1Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmUserFieldsTenderEntered.tmrCountdownTimer(Sender: TObject);
begin
  Close;
end;

end.

