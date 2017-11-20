unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, jpeg, ComCtrls;

type
  TForm1 = class(TForm)
    pnl1: TPanel;
    img1: TImage;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    btn1: TButton;
    btn2: TButton;
    Edit7: TEdit;
    ud1: TUpDown;
    btn3: TButton;
    Edit8: TEdit;
    btn4: TButton;
    procedure btn3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  THash1000 =  array[0..1000] of array[0..2] of Integer;

  TmainAlg = class
    Images : array[0..50] of TBitmap;
    MaxImage:Integer;
    Hashs : array of  THash1000;

//    function HashIt(Image:TBitmap):THash1000;
//    procedure PrintOn(Hash:THash1000);
  end;

var
  Form1: TForm1;
  Main : TmainAlg;

implementation

{$R *.dfm}

procedure TForm1.btn3Click(Sender: TObject);
begin
    Main.Images[Main.MaxImage]:= Tbitmap.Create();
    img1.Picture.LoadFromFile(Edit8.Text);
    Sleep(4000);
    //Main.Images[Main.MaxImage].Assign(img1.Picture.Bitmap);
    inc(Main.MaxImage);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
    Main:=TmainAlg.Create();
end;

end.
