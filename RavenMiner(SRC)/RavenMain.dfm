object Form4: TForm4
  Left = 0
  Top = 0
  Caption = 'Raven'
  ClientHeight = 446
  ClientWidth = 634
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 15
  object EdLog: TMemo
    Left = 14
    Top = 246
    Width = 602
    Height = 187
    Lines.Strings = (
      'EdLog')
    TabOrder = 0
  end
  object EdNickName: TEdit
    Left = 14
    Top = 26
    Width = 450
    Height = 23
    TabOrder = 1
    Text = 'EdNickName'
  end
  object EdHost: TEdit
    Left = 14
    Top = 89
    Width = 225
    Height = 23
    TabOrder = 2
    Text = '127.0.0.1'
  end
  object EdPort: TEdit
    Left = 245
    Top = 89
    Width = 219
    Height = 23
    TabOrder = 3
    Text = 'Port'
  end
  object BtnConnect: TButton
    Left = 470
    Top = 21
    Width = 146
    Height = 33
    Caption = 'Connect'
    TabOrder = 4
  end
  object BtnDisconnect: TButton
    Left = 470
    Top = 84
    Width = 146
    Height = 33
    Caption = 'Disconnect'
    TabOrder = 5
    OnClick = BtnDisconnectClick
  end
  object EdMessage: TEdit
    Left = 14
    Top = 217
    Width = 602
    Height = 23
    TabOrder = 6
    Text = 'EdMessage'
    OnKeyDown = EdMessageKeyDown
  end
  object C: TDzTCPClient
    Host = '0'
    KeepAlive = True
    AutoReconnect = True
    AutoReconnectInterval = 2000
    AutoReconnectAttempts = 99999
    OnLoginRequest = CLoginRequest
    OnLoginResponse = CLoginResponse
    OnDisconnect = CDisconnect
    OnRead = CRead
    OnError = CError
    OnConnectionLost = CConnectionLost
    Left = 464
    Top = 120
  end
end
