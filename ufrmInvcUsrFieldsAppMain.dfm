object frmInvcUsrFieldsAppMain: TfrmInvcUsrFieldsAppMain
  Left = 0
  Top = 0
  Caption = 'Invoice User Field Test'
  ClientHeight = 269
  ClientWidth = 355
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object edtInvcNum: TLabeledEdit
    Left = 32
    Top = 40
    Width = 121
    Height = 21
    EditLabel.Width = 79
    EditLabel.Height = 13
    EditLabel.Caption = 'Invoice Number:'
    TabOrder = 0
  end
  object btnShowUserField1: TButton
    Left = 32
    Top = 72
    Width = 121
    Height = 25
    Caption = 'Show User Field 1'
    TabOrder = 1
    OnClick = btnShowUserField1Click
  end
  object edtNewValue: TLabeledEdit
    Left = 32
    Top = 144
    Width = 121
    Height = 21
    EditLabel.Width = 54
    EditLabel.Height = 13
    EditLabel.Caption = 'New Value:'
    TabOrder = 2
  end
  object btnSetUserField1: TButton
    Left = 32
    Top = 171
    Width = 121
    Height = 25
    Caption = 'Set User Field 1'
    TabOrder = 3
    OnClick = btnSetUserField1Click
  end
  object rdiRProReceipt: TrdiRProReceipt
    IndexID = 1
    IndexName = 'Receipt Num'
    RProDB = rdiRProDB
    Left = 272
    Top = 120
  end
  object rdiRProDB: TrdiRProDB
    Connected = False
    DBPath = 'C:\Retail85\Rpro'
    OnBeforeConnect = rdiRProDBBeforeConnect
    OnAfterConnect = rdiRProDBAfterConnect
    Left = 248
    Top = 56
  end
end
