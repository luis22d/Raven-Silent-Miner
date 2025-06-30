unit notification;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, scControls, scGPControls,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TForm3 = class(TForm)
    scGPPanel9: TscGPPanel;
    Image1: TImage;
    TimerFadeOut: TTimer;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure TimerFadeOutTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

procedure TForm3.FormCreate(Sender: TObject);
begin
AlphaBlend := True;
  AlphaBlendValue := 255; // Start fully visible

  // Set position (e.g., bottom right of screen)
  Left := Screen.Width - Width - 20;
  Top := Screen.Height - Height - 50;

  // Make form stay on top
  FormStyle := fsStayOnTop;
end;

procedure TForm3.TimerFadeOutTimer(Sender: TObject);
const
  FADE_STEP = 15;
var
  ThisForm: TForm3;
begin
      with Sender as TTimer do
  begin
    ThisForm := Owner as TForm3; // Get reference to the form that owns this timer

    if Tag <= FADE_STEP then
    begin
      // When fully transparent, close this specific form
      ThisForm.Close;
      Free; // Free the timer
    end
    else
    begin
      // Decrease opacity
      Tag := Tag - FADE_STEP;
      ThisForm.AlphaBlendValue := Tag;
    end;
  end;
end;

end.
