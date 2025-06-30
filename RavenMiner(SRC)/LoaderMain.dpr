program LoaderMain;

uses
  Vcl.Forms,
  Main in 'Main.pas' {Form2},
  UClient in '..\..\..\Documents\Embarcadero\Studio\Projects\UClient.pas',
  notification in '..\..\..\Documents\Embarcadero\Studio\Projects\notification.pas' {Form3},
  Unit5 in 'Unit5.pas' {RunExecute};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TRunExecute, RunExecute);
  Application.Run;
end.
