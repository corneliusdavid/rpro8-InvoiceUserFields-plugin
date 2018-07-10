unit uInvcUsrFieldsPlugin;

interface

uses
  RProAPI, RDA2_TLB;

type
  TSetInvoiceUserField0 = class(TSideButton)
  private
    FRdaDoc: IRdaDocument;
    FRProApp: TRProApp;
  public
    procedure Initialize(RProApp: TRProApp; Doc: IRdaDocument); override;
    class function Menu: TSideMenu; override;
    class function Caption: string; override;
    class function PictureFileName: string; override;
    function Enabled: boolean; override;
    function Execute: TActionRequestSet; override;
  end;

  TShowInvoiceUserFields = class(TSideButton)
  private
    FRdaDoc: IRdaDocument;
    FRProApp: TRProApp;
  public
    procedure Initialize(RProApp: TRProApp; Doc: IRdaDocument); override;
    class function Menu: TSideMenu; override;
    class function Caption: string; override;
    class function PictureFileName: string; override;
    function Enabled: boolean; override;
    function Execute: TActionRequestSet; override;
  end;

  TShowUserFieldsWhenTenderEntered = class(TTenderChanged)
  private
    FRdaDoc: IRdaDocument;
    FRProApp: TRProApp;
  public
    procedure Initialize(RProApp: TRProApp; Doc: IRdaDocument); override;
    procedure TenderScreenEntered; override;
    procedure Changed; override;
  end;


implementation

uses
  SysUtils, Classes, Windows, Dialogs,
  {$IFDEF UseCodeSite} CodeSiteLogging, {$ENDIF}
  ufrmInvcUsrFieldTendEntered;


procedure RProClassesAvailable(RProClassArrayProc: TRProClassArrayProc);
begin
  RProClassArrayProc([TSetInvoiceUserField0, TShowInvoiceUserFields, TShowUserFieldsWhenTenderEntered]);
end;

exports
  RProClassesAvailable;

{ TSetInvoiceUserField0 }

procedure TSetInvoiceUserField0.Initialize(RProApp: TRProApp; Doc: IRdaDocument);
begin
  FRdaDoc := Doc;
  FRProApp := RProApp;
end;

class function TSetInvoiceUserField0.Menu: TSideMenu;
begin
  Result := smReceipts;
end;

class function TSetInvoiceUserField0.Caption: string;
begin
  Result := 'Set 1st Blank User Field';
end;

class function TSetInvoiceUserField0.PictureFileName: string;
begin
  Result := EmptyStr;
end;

function TSetInvoiceUserField0.Enabled: boolean;
begin
  // called frequently by RetailPro
  Result := True;
end;

function TSetInvoiceUserField0.Execute: TActionRequestSet;
var
  s, t: string;
  i: Integer;
  IsNull: WordBool;
begin
  s := InputBox('Set First Blank User Field', 'Enter a string:', EmptyStr);

  if Length(s) > 0 then begin
    for i := 0 to 9 do begin
      t := FRdaDoc.GetString(fidInvcUsr0 + i, IsNull);
      if Length(t) = 0 then
        Break;
    end;

    if Length(t) = 0 then
      FRdaDoc.SetString(IntToStr(FRdaDoc.GetInt64(fidDocSID, IsNull)) + ': ' + s, fidInvcUsr0 + i)
    else
      ShowMessage('No empty user fields available.');
  end;

  Result := [];
end;

{ TShowInvoiceUserFields }

procedure TShowInvoiceUserFields.Initialize(RProApp: TRProApp; Doc: IRdaDocument);
begin
  FRdaDoc := Doc;
  FRProApp := RProApp;
end;

class function TShowInvoiceUserFields.Menu: TSideMenu;
begin
  Result := smReceiptList;
end;

class function TShowInvoiceUserFields.Caption: string;
begin
  Result := 'Show User Fields';
end;

class function TShowInvoiceUserFields.PictureFileName: string;
begin
  Result := EmptyStr;
end;

function TShowInvoiceUserFields.Enabled: boolean;
begin
  // called frequently by RetailPro
  Result := True;
end;

function TShowInvoiceUserFields.Execute: TActionRequestSet;
var
  i: Integer;
  s: string;
  IsNull: WordBool;
  UserFieldList: TStringList;
begin
  UserFieldList := TStringList.Create;
  try
    for i := 0 to 9 do begin
      s := FRdaDoc.GetString(fidInvcUsr0 + i, IsNull);
      if IsNull then
        Break;
      UserFieldList.Add(IntToStr(i) + ': ' + s);
    end;

    if UserFieldList.Count > 0 then
      MessageBox(0, UserFieldList.GetText, PChar('undocumented user fields'), MB_OK + MB_ICONINFORMATION + MB_TASKMODAL)
    else
      MessageBox(0, 'No user fields used', PChar('undocumented user fields'), MB_OK + MB_ICONINFORMATION + MB_TASKMODAL);
  finally
    UserFieldList.Free;
  end;

  Result := [];
end;

{ TShowUserFieldsWhenTenderEntered }

procedure TShowUserFieldsWhenTenderEntered.Initialize(RProApp: TRProApp; Doc: IRdaDocument);
begin
  {$IFDEF UseCodeSite}CodeSite.EnterMethod(Self, 'Initialize');{$ENDIF}

  FRdaDoc := Doc;
  FRProApp := RProApp;

  {$IFDEF UseCodeSite}CodeSite.ExitMethod(Self, 'Initialize');{$ENDIF}
end;

procedure TShowUserFieldsWhenTenderEntered.Changed;
begin
  {$IFDEF UseCodeSite}CodeSite.EnterMethod(Self, 'Changed');{$ENDIF}

  // not used

  {$IFDEF UseCodeSite}CodeSite.ExitMethod(Self, 'Changed');{$ENDIF}
end;

procedure TShowUserFieldsWhenTenderEntered.TenderScreenEntered;
begin
  {$IFDEF UseCodeSite}CodeSite.EnterMethod(Self, 'TenderScreenEntered');{$ENDIF}

  TfrmUserFieldsTenderEntered.ShowFields(FRdaDoc);

  {$IFDEF UseCodeSite}CodeSite.ExitMethod(Self, 'TenderScreenEntered');{$ENDIF}
end;

end.

