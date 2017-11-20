unit TextDB;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm4 = class(TForm)
    lst1: TListBox;
    mmo1: TMemo;
    btn1: TButton;
    btn2: TButton;
    btn3: TButton;
    mmo2: TMemo;
    Edit1: TEdit;
    btn4: TButton;
    btn6: TButton;
    procedure lst1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure btn6Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TTexdDBManager = class
      DefaultMemo:TMemo;
      DefaultListBx:TListBox;
      Texts:array of TStringlist;
      Count,Capacity:integer;
      TempLog:array[0..20] of TStringList;
      TextDescs:array of array[0..10] of string;
      procedure AddFile(Strs:TStrings; Path:string; from:string='XZ');
      procedure DeleteFileByName(Name:string);
      procedure UpdateFileByName(Name:string);
      procedure ShowFileByName(Name:string; how:Byte=1); //1 - DefaultMemo
      procedure DumpDB(filepath:string);
      procedure ReadDB(filepath:string);
      procedure PreSize(FileAm:Byte);
      procedure ShowFiles(how:Byte=1) ; //1 - default listbox
      procedure LogTo(Str:string; Id:byte=0);
      constructor Create();
  protected
      function GetFileIndexByName(Name:string):Integer;
  end;

var
  Form4 : TForm4;
  TextDBMan : TTexdDBManager;


implementation

{$R *.dfm}

{ TTexdDBManager }

procedure TTexdDBManager.AddFile(Strs: TStrings; Path, from: string);
begin
    if self.Count<self.Capacity then
    begin
       self.Texts[self.Count]:=TStringList.Create;
       self.Texts[self.Count].Text:=Strs.Text;
       self.TextDescs[Self.Count][0]:=Copy(Path,1,200)+Copy(from,1,200);
       Inc(self.Count);
    end else
    begin
       self.PreSize(Self.Count+10);
       self.Texts[self.Count]:=TStringList.Create;
       self.Texts[self.Count].Text:=Strs.Text;
       self.TextDescs[Self.Count][0]:=Copy(Path,1,200)+Copy(from,1,200);
       Inc(self.Count);
    end;
end;

constructor TTexdDBManager.Create;
begin
    self.Count:=0;
    Self.Capacity:=0;
    Self.PreSize(20);
end;

procedure TTexdDBManager.DeleteFileByName(Name: string);
begin

end;

procedure TTexdDBManager.DumpDB(filepath: string);
begin

end;

function TTexdDBManager.GetFileIndexByName(Name: string): Integer;
var
  I:Integer;
begin
      result:=-1;
     for I:=0 to Count-1 do
      if self.TextDescs[i,0]=Name then
       begin
        Result:= I;
        Break;
       end;
end;

procedure TTexdDBManager.LogTo(Str: string; Id: byte);
begin
    TempLog[Id].Add(Str);
end;

procedure TTexdDBManager.PreSize(FileAm: Byte);
begin
    SetLength(self.Texts,FileAm);
    SetLength(self.TextDescs,FileAm);
    Self.Capacity:=FileAm;
end;

procedure TTexdDBManager.ReadDB(filepath: string);
begin

end;

procedure TTexdDBManager.ShowFileByName(Name: string; how: Byte);
var Ind:Integer;
begin
  ind:=Form4.lst1.ItemIndex;
  if ind>-1 then
      if how=1 then
      begin
          DefaultMemo.Lines.Text:=self.Texts[ind].Text;
      end;
end;

procedure TTexdDBManager.ShowFiles(how: Byte);
var I:integer;
begin
    self.DefaultListBx.Clear;
    for I:=0 to self.Count-1 do
    begin
       self.DefaultListBx.Items.Add(Self.TextDescs[I,0]);
    end;
end;

procedure TTexdDBManager.UpdateFileByName(Name: string);
begin

end;

procedure TForm4.lst1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if lst1.itemindex>=0 then
    TextDBMan.ShowFileByName(lst1.Items[lst1.itemindex]);
end;

procedure TForm4.FormCreate(Sender: TObject);
begin
    TextDBMan:=TTexdDBManager.Create;
    TextDBMan.DefaultMemo:=mmo1;
    TextDBMan.DefaultListBx:=lst1;
end;

procedure TForm4.btn6Click(Sender: TObject);
var i:Integer;
begin
   for I:=0 to TextDBMan.Count-1 do
   begin
     TextDBMan.DefaultMemo.Text:=TextDBMan.DefaultMemo.Text+TextDBman.texts[I].Text;
   end;
end;

procedure TForm4.FormShow(Sender: TObject);
begin
      TextDBMan.ShowFiles();
end;

end.
