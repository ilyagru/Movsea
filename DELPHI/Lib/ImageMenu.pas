unit ImageMenu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls,
  Unit1,BaseTypes;

type
  TForm2 = class(TForm)
    lst1: TListBox;
    btn1: TButton;
    btn2: TButton;
    img1: TImage;
    btn3: TButton;
    Edit1: TEdit;
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
    procedure lst1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;
  ImgComp:TImageCompareManager;
  ImgPath:string;

implementation

{$R *.dfm}

procedure TForm2.btn1Click(Sender: TObject);
begin


    ImgComp.ULbuf.Free;
    ImgComp.ULbuf:=TBitmap.Create;
    ImgComp.LoadPictureFromFile(Edit1.Text+lst1.Items[lst1.itemIndex],0);
    SetLength(ImgComp.ULPicArr,0);
    ImgComp.ULPicArr:=Api.FromPicToArr(ImgComp.ULbuf,Api.Sett);
    ImgComp.Flip(0);
end;

procedure TForm2.btn2Click(Sender: TObject);
begin
    ImgComp.DLbuf.Free;
    ImgComp.DLbuf:=TBitmap.Create;
    ImgComp.LoadPictureFromFile(Edit1.Text+lst1.Items[lst1.itemIndex],2);
    SetLength(ImgComp.DLPicArr,0);
    ImgComp.DLPicArr:=Api.FromPicToArr(ImgComp.DLbuf,Api.Sett);
    ImgComp.Flip(2);
end;

procedure TForm2.btn3Click(Sender: TObject);
var
  searchResult : TSearchRec;
begin
  lst1.Clear;
  if FindFirst(Edit1.Text+'*.jpg', faAnyFile, searchResult) = 0 then
  begin
    repeat
      begin
      lst1.Items.Add(searchResult.Name)
      end;
    until FindNext(searchResult) <> 0;
    FindClose(searchResult);
  end;
end;

procedure TForm2.lst1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  Buf:TBitmap;
begin
  buf:=TBitmap.Create;
  LoadJpegToBitmap(Edit1.Text+lst1.Items[lst1.itemIndex], Buf);
  img1.Canvas.StretchDraw(Rect(0,0,217,122),buf);
  buf.Free;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
      Edit1.Text:=ImgPath;
end;

end.
