program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  TextDB in 'TextDB.pas' {Form4},
  BaseTypes in 'BaseTypes.pas',
  BaseAlg in 'BaseAlg.pas',
  ImageMenu in 'Lib\ImageMenu.pas',
  ImageImproveMeth in 'Lib\ImageImproveMeth.pas',
  Unit3 in 'Lib\Unit3.pas',
  WebBase in 'Lib\WebBase.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
