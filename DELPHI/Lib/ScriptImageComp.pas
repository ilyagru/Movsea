unit ScriptImageComp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls,
  unit1,TextDB, BaseTypes, ImageImproveMeth;

type

  vec6 = array[0..5] of double;

  TForm3 = class(TForm)
    mmo1: TMemo;
    Edit1: TEdit;
    btn1: TButton;
    mmo2: TMemo;
    Edit2: TEdit;
    btn2: TButton;
    btn3: TButton;
    btn5: TButton;
    lbledt20: TLabeledEdit;
    lbledt19: TLabeledEdit;
    cbb3: TComboBox;
    btn6: TButton;
    mmo3: TMemo;
    btn7: TButton;
    btn8: TButton;
    Edit3: TEdit;
    chk1: TCheckBox;
    chk2: TCheckBox;
    chk3: TCheckBox;
    lbledt1: TLabeledEdit;
    chk4: TCheckBox;
    btn4: TButton;
    procedure btn6Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure cbb3Change(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure btn8Click(Sender: TObject);
    procedure btn7Click(Sender: TObject);
    procedure btn4Click(Sender: TObject);
    procedure btn5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  Tresult = record
      FileL,FileR:string;
      res1:Real;
  end;

  TScriptManager = class
      GoodFilePairs : array of array[0..1] of string;
      BadFilePairs : array of array[0..1] of string;
      AlgComands : array of array[0..10] of string;
      Results : array of array[0..10] of string;
      GoodRes:array of array[0..4] of real;
      BadRes:array of array[0..4] of real;
      GLArrs,GRArrs:array of TPicArr;
      BLArrs,BRArrs:array of TPicArr;
      Section:Byte;
      Alg:integer;
      State:Byte;
      CurFilePair:Integer;
      CurResult:array[0..10] of string;
      AvgResultBad:Real;
      AvgResultGood:Real;
      AvgDiffGood:real;
      AvgDiffBad:real;
      AvgNormResBad:Real;
      AvgNormResGood:Real;
      procedure PreloadImages();
      procedure LoadScript(Filename:string);
      procedure LoadMethods;
      procedure WorkWith(MethName,Param1,Param2:string);
      procedure WorkWithInter();
      procedure Start();
      procedure Stop() ;
      procedure Pause();
      procedure ReadScript();
      procedure AddMeth(str:string);
      procedure AddBad(str:string);
      procedure AddGood(str:string);
      procedure CalcResult();
      function MadeAndCheck(Pair,Alg:integer): TResult ;
      procedure GetResult();
      procedure MainWork() ;
      function CheckBright(var image:TPicArr):vec6;
  private
    procedure Made;
  end;

  TWorkingThread = class(TThread)
     Started:Boolean;
     SM:TScriptManager;
     procedure Execute; override;
  end;

var
  Form3: TForm3;
  ScriptManager:TScriptManager;
  WorkThread : TWorkingThread;
  TDB:TTexdDBManager;

implementation

{$R *.dfm}

{ ScriptManager }

procedure TScriptManager.AddMeth(str: string);
begin

end;

procedure TScriptManager.AddBad(str: string);
begin

end;

procedure TScriptManager.GetResult;
begin

end;

procedure TScriptManager.AddGood(str: string);
begin

end;

procedure TScriptManager.LoadScript(Filename:string);
begin

end;

procedure TScriptManager.Made;
begin

end;

function TScriptManager.MadeAndCheck(Pair, Alg: integer): TResult;
var
 PicL,PicR:TPicArr;
 NPicL,NPicR:TPicArr;
 Meth:TIIAlg;
 Res1,Res2,Res3:real;
 Bit1,Bit2:TBitmap;
 Param1,Param2:string;
begin
  if self.Section=1 then
  begin
    LoadJpegToBitmap(self.GoodFilePairs[Pair][1],Bit2);
    LoadJpegToBitmap(self.GoodFilePairs[Pair][0],Bit1);
    PicL:=Api.FromPicToArr(Bit1,Api.Sett);
    PicR:=Api.FromPicToArr(Bit2,Api.Sett);
    NPicL:=CopyPicArr(PicL);
    NPicR:=CopyPicArr(PicR);
  end;

  if self.Section=2 then
  begin
    LoadJpegToBitmap(self.BadFilePairs[Pair][1],Bit2);
    LoadJpegToBitmap(self.BadFilePairs[Pair][0],Bit1);
    PicL:=Api.FromPicToArr(Bit1,Api.Sett);
    PicR:=Api.FromPicToArr(Bit2,Api.Sett);
    NPicL:=CopyPicArr(PicL);
    NPicR:=CopyPicArr(PicR);
  end;

  case Alg of
  91:begin
     Meth:=TIIAlgSteper.Create;
     (Meth as TIIAlgSteper).Range:=StrToInt(Param1);

  end;
  11:begin
    meth:=TIIAlgEqalise.Create;
  end;
  21:begin
    meth:=TIIAlgNormalize.Create;
    (Meth as TIIAlgNormalize).Range:=255;
  end;

  22:begin
    meth:=TIIAlgSQR.Create;
    (Meth as TIIAlgSqr).AlgType:=StrToInt(Param1);
  end;

  31:begin
    meth:=TIIAlgMatrix.Create(AlgCont);
    (Meth as TIIAlgMatrix).LoadMatrix(StrToInt(Param1));
  end;
  41:begin
    meth:=TIIAlgRED.Create;
    (Meth as TIIAlgRED).treshold:=StrTofloat(Param1);
    (Meth as TIIAlgRED).Sqare:=StrToInt(Param2);
  end;
  42:begin
    meth:=TIIGreyScale.Create;
    (Meth as TIIGreyScale).AlgType:=strtoint(Param1);
  end;

  43:begin
    meth:=TIIAlgREDclear.Create;
    (Meth as TIIAlgREDclear).treshold:=StrTofloat(Param1);
    (Meth as TIIAlgREDclear).Sqare:=StrToInt(Param2);
  end;

  44:begin
    meth:=TIIAlgRGB.Create;
    (Meth as TIIAlgRGB).treshold:=StrToFloat(Param1);
    (Meth as TIIAlgRGB).Sqare:=StrToInt(Param2);
  end;

  45:begin
    meth:=TIIAlgRGBclear.Create;
    (Meth as TIIAlgRGBclear).treshold:=StrToFloat(Param1);
    (Meth as TIIAlgRGBclear).Sqare:=StrToInt(Param2);
  end;
  62:begin
    meth:=TIIAlgBrightChangeTo.Create;
    (Meth as TIIAlgBrightChangeTo).targetbright:=StrToint(Param1);
  end;

  end;

  Meth.Made(PicL,NpicL);
  Meth.Made(PicR,NpicR);

  //оценка

  //вывод результата

  //очистка


end;

procedure TScriptManager.MainWork;
var
  I,J:integer;
  Result:Tresult;
begin
  Self.Section:=1;
  for I:=0 to Length(Self.GoodFilePairs) do
  begin
    for J:=0 to Length(self.AlgComands) do
    begin
      self.CurFilePair:=I;
      self.Alg:=J;
      Result:=self.MadeAndCheck(I,J);
      //Add res to array
    end;
  end;
  Self.Section:=2;
  for I:=0 to Length(Self.BadFilePairs) do
  begin
    for J:=0 to Length(self.AlgComands) do
    begin
      self.CurFilePair:=I;
      self.Alg:=J;
      Result:=self.MadeAndCheck(I,J);
      //Add res to array
    end;
  end;

end;

procedure TScriptManager.Pause;
begin

end;

procedure TScriptManager.ReadScript;
var I:Integer;
MethAm,GoodAm,BadAm:Integer;
CL:Integer;
begin
  GoodAm:=strtoint(Form3.mmo1.lines[0]);
  BadAm:=strtoint(Form3.mmo1.lines[1]);
  SetLength(Self.GoodFilePairs,GoodAm);
  SetLength(Self.BadFilePairs,BadAm);
  for I:=0 to GoodAm-1 do
  begin
      self.GoodFilePairs[I][0]:=Form3.lbledt1.Text+Copy(Form3.mmo1.lines[I+2],1,Pos(' ',Form3.mmo1.lines[I+2]));
      self.GoodFilePairs[I][1]:=Form3.lbledt1.Text+Copy(Form3.mmo1.lines[I+2],Pos(' ',Form3.mmo1.lines[I+2])+1,100);
  end;
  for I:=0 to BadAm-1 do
  begin
      self.BadFilePairs[I][0]:=Form3.lbledt1.Text+Copy(Form3.mmo1.lines[I+3+GoodAm],1,Pos(' ',Form3.mmo1.lines[I+3+GoodAm]));
      self.BadFilePairs[I][1]:=Form3.lbledt1.Text+Copy(Form3.mmo1.lines[I+3+GoodAm],Pos(' ',Form3.mmo1.lines[I+3+GoodAm])+1,100);
  end;
  {CL:=4; //+1 for splitter (======)
  for I:=CL to CL+MethAM-1 do
    self.AddMeth(Form3.mmo1.Lines[I]);
  CL:=CL+methAm;
  for I:=CL to CL+GoodAM-1 do
    self.AddGood(Form3.mmo1.Lines[I]);
  CL:=CL+GoodAm;
  for I:=CL to CL+BadAM-1 do
    self.AddBad(Form3.mmo1.Lines[I]);
  }
end;

procedure TScriptManager.Start;
begin

end;

procedure TScriptManager.Stop;
begin

end;

procedure TForm3.btn6Click(Sender: TObject);
begin
    mmo1.Lines.SaveToFile(Edit1.Text);
    TextDBMan.AddFile(mmo1.Lines,Edit1.Text);
end;

procedure TForm3.btn3Click(Sender: TObject);
begin
    ScriptManager.LoadMethods();
    ScriptManager.ReadScript();
    ScriptManager.WorkWithInter();


   { if not WorkThread.Started then
    begin
        WorkThread:=TWorkingThread.Create(False);
        WorkThread.SM:=ScriptManager;
    end; }
end;

procedure TScriptManager.WorkWithInter;
var I,J:integer;
begin
  if Form3.chk4.Checked then Self.PreloadImages();
  for I:=0 to length(Self.AlgComands)-1 do
  begin
    Form3.mmo2.clear;

    self.WorkWith(Self.AlgComands[i,0],Self.AlgComands[i,1],Self.AlgComands[i,2]);
    ScriptManager.CalcResult();
    Form3.mmo2.lines.savetofile(Self.AlgComands[i,0]+'-'+Self.AlgComands[i,1]+'-'+Self.AlgComands[i,2]+'.txt');
    TextDBMan.AddFile(Form3.mmo2.lines,Self.AlgComands[i,0]+'-'+Self.AlgComands[i,1]+'-'+Self.AlgComands[i,2]+'.txt');
  end;

end;  


procedure TForm3.FormCreate(Sender: TObject);
begin
    ScriptManager:=TScriptManager.Create;
    WorkThread:=TWorkingThread.Create(True);
    cbb3.ItemIndex:=0;
    TDB:=TextDB.TextDBMan;
end;

procedure TForm3.btn1Click(Sender: TObject);
begin
    mmo1.Lines.LoadFromFile(Edit1.Text);
end;

procedure TForm3.cbb3Change(Sender: TObject);
var
  Num:integer;
begin
  Num:=StrToInt(Copy(cbb3.Text,1,2));
    lbledt19.EditLabel.Caption:='None';
    lbledt19.Enabled:=False;
    lbledt20.EditLabel.Caption:='None';
    lbledt20.Enabled:=False;
    lbledt19.Text:='';
    lbledt20.Text:='';
    case num of
    91: begin
      lbledt19.EditLabel.Caption:='Step';
      lbledt19.Enabled:=True;
      lbledt19.Hint:='целое 4-16, ем больше тем сильнее округляется цвет(резче) ';
      lbledt19.ShowHint:=True;
      lbledt19.Text:='6';
      end;
    22: begin
      lbledt19.EditLabel.Caption:='Alg Type';
      lbledt19.Enabled:=True;
      lbledt19.Hint:='целое 1-4, определяет по разному принцип работы ';
      lbledt19.ShowHint:=True;
      lbledt19.Text:='1';
      end;

    31: begin
      lbledt19.EditLabel.Caption:='Matrix Num';
      lbledt19.Hint:='используй 0-6 каждое значение это разная матрица, пока норм работает только 1,2';
      lbledt19.ShowHint:=True;
      lbledt19.Enabled:=True;
      lbledt19.Text:='1';
    end;
    41:begin
      lbledt19.EditLabel.Caption:='treshold';
      lbledt20.EditLabel.Caption:='sqare Size';
      lbledt19.Hint:='Порог окраски в красный от 0.3 до 3.0 шаг около 0.1';
      lbledt19.ShowHint:=True;
      lbledt20.Hint:='Рамер квадрата который будет проанализирован покрашен';
      lbledt20.ShowHint:=True;
      lbledt19.Enabled:=True;
      lbledt20.Enabled:=True;
      lbledt19.Text:='1';
      lbledt20.Text:='8';
    end;
    42:begin
      lbledt19.EditLabel.Caption:='Alg Type';
      lbledt19.Hint:='используй 0-3, 0 - без коэфициентов';
      lbledt19.ShowHint:=True;
      lbledt19.Enabled:=True;
      lbledt19.Text:='1';
    end;
    62: begin
      lbledt19.EditLabel.Caption:='Target bright';
      lbledt19.Hint:='используй 50-120, это яркость до которой надо поднять';
      lbledt19.ShowHint:=True;
      lbledt19.Enabled:=True;
      lbledt19.Text:='1';
    end;
    43:begin
      lbledt19.EditLabel.Caption:='treshold';
      lbledt20.EditLabel.Caption:='sqare Size';
      lbledt19.Hint:='Порог окраски в красный от 0.3 до 3.0 шаг около 0.1';
      lbledt19.ShowHint:=True;
      lbledt20.Hint:='Рамер квадрата который будет проанализирован покрашен';
      lbledt20.ShowHint:=True;
      lbledt19.Enabled:=True;
      lbledt20.Enabled:=True;
      lbledt19.Text:='1';
      lbledt20.Text:='8';
    end;

    44:begin
      lbledt19.EditLabel.Caption:='treshold';
      lbledt20.EditLabel.Caption:='sqare Size';
      lbledt19.Hint:='Порог окраски в от 0.3 до 3.0 шаг около 0.1';
      lbledt19.ShowHint:=True;
      lbledt20.Hint:='Рамер квадрата который будет проанализирован покрашен';
      lbledt20.ShowHint:=True;
      lbledt19.Enabled:=True;
      lbledt20.Enabled:=True;
      lbledt19.Text:='1';
      lbledt20.Text:='8';
    end;

    45:begin
      lbledt19.EditLabel.Caption:='treshold';
      lbledt20.EditLabel.Caption:='sqare Size';
      lbledt19.Hint:='Порог окраски от 0.3 до 3.0 шаг около 0.1';
      lbledt19.ShowHint:=True;
      lbledt20.Hint:='Рамер квадрата который будет проанализирован покрашен';
      lbledt20.ShowHint:=True;
      lbledt19.Enabled:=True;
      lbledt20.Enabled:=True;
      lbledt19.Text:='1';
      lbledt20.Text:='8';
    end;
    end;
end;

procedure TForm3.btn2Click(Sender: TObject);
begin
  mmo2.Lines.SaveToFile(Edit2.Text);
end;

procedure TScriptManager.CalcResult;
var
  I,J:integer;
  AvgResGood:array[0..4] of Double;
  AvgResBad:array[0..4] of Double;
  CurRes:array[0..4] of Double;
  NormCurres:array[0..4] of Double;
  AvgDifGood:array[0..4] of Double;
  AvgDifBad:array[0..4] of Double;
  DifGood:array[0..4] of Double;
  DifBad:array[0..4] of Double;
  SomeStr:string[20];
  PlusAm:array[0..4] of Double;
  IgnG,IgnB:integer;
begin
  IgnG:=0;
  IgnB:=0;
  CurRes[0]:=0;
  CurRes[1]:=0;
  CurRes[2]:=0;
  CurRes[3]:=0;
  PlusAm[0]:=0;
  PlusAm[1]:=0;
  PlusAm[2]:=0;
  PlusAm[3]:=0;
  NormCurRes[0]:=0;
  NormCurRes[1]:=0;
  NormCurRes[2]:=0;
  NormCurRes[3]:=0;
  AvgResGood[0]:=0;
  AvgResGood[1]:=0;
  AvgResGood[2]:=0;
  AvgResGood[3]:=0;
  AvgResBad[0]:=0;
  AvgResBad[1]:=0;
  AvgResBad[2]:=0;
  AvgResBad[3]:=0;
  Form3.mmo2.Lines.Add('==========================  2. Evaluation ==============');
  Form3.mmo2.Lines.Add('2.1 Sign of diff:');
  Form3.mmo2.Lines.Add('Выводит больше или меньше был -- к ++,+-,-+.');
  Form3.mmo2.Lines.Add('для good лучше больше +, для  bad больше -');
  Form3.mmo2.Lines.Add('Good');

  DifGood[0]:=0;
  DifGood[1]:=0;
  DifGood[2]:=0;
  for  I:=0 to Length(GoodFilePairs)-1 do
  begin
    SomeStr:='---'+IntToStr(I);
    if  self.GoodRes[I][1]*self.GoodRes[I][2]*self.GoodRes[I][3]=0 then
    begin
      SomeStr:='Ignore0_'+IntToStr(I);
      inc(ignG);
    end else
    if ((self.goodres[I][0] / self.GoodRes[I][1]) < 2) and
    ((self.goodres[I][0] / self.GoodRes[I][2]) < 2) and
    ((self.goodres[I][0] / self.GoodRes[I][3]) < 2) and
     (self.goodres[I][0]<0.8) then
    begin
      if self.GoodRes[I][0] <  self.GoodRes[I][1] then
      begin
      SomeStr[1]:='+';
       plusAm[0]:= plusAm[0]+1;
      end;
      if self.GoodRes[I][0] <  self.GoodRes[I][2] then
      begin
      SomeStr[2]:='+';
       plusAm[1]:= plusAm[1]+1;
      end;
      if self.GoodRes[I][0] <  self.GoodRes[I][3] then
      begin
        SomeStr[3]:='+';
         plusAm[2]:= plusAm[2]+1;
      end;
    end else
    begin
     SomeStr:='Ignore28_'+inttostr(I);
     inc(ignG);
    end;
    Curres[0]:=Curres[0]+self.GoodRes[I][0];
    Curres[1]:=Curres[1]+self.GoodRes[I][1];
    Curres[2]:=Curres[2]+self.GoodRes[I][2];
    Curres[3]:=Curres[3]+self.GoodRes[I][3];
    Form3.mmo2.Lines.Add(SomeStr);
    DifGood[0]:=DifGood[0]+(Curres[1]-Curres[0]);
    DifGood[1]:=DifGood[1]+(Curres[2]-Curres[0]);
    DifGood[2]:=DifGood[2]+(Curres[3]-Curres[0]);
  end;
  AvgResGood[0]:=Curres[0] / Length(GoodFilePairs);
  AvgResGood[1]:=Curres[1] / Length(GoodFilePairs);
  AvgResGood[2]:=Curres[2] / Length(GoodFilePairs);
  AvgResGood[3]:=Curres[3] / Length(GoodFilePairs);

  AvgDifGood[0]:=DifGood[0]/ Length(GoodFilePairs);
  AvgDifGood[1]:=DifGood[1]/ Length(GoodFilePairs);
  AvgDifGood[2]:=DifGood[2]/ Length(GoodFilePairs);

  Form3.mmo2.Lines.Add('------------');
  Form3.mmo2.Lines.Add(floattostr(PlusAm[0])+'-'+floattostr(PlusAm[1])+'-'+floattostr(PlusAm[2]));
  Form3.mmo2.Lines.Add(floattostr(PlusAm[0]/(Length(GoodFilePairs)- IgnG))+'-'+floattostr(PlusAm[1]/(Length(GoodFilePairs)- IgnG))+'-'+floattostr(PlusAm[2]/(Length(GoodFilePairs) - IgnB)));

  CurRes[0]:=0;
  CurRes[1]:=0;
  CurRes[2]:=0;
  CurRes[3]:=0;
  DifBad[0]:=0;
  DifBad[1]:=0;
  DifBad[2]:=0;
  PlusAm[0]:=0;
  PlusAm[1]:=0;
  PlusAm[2]:=0;
  PlusAm[3]:=0;

  Form3.mmo2.Lines.Add('Bad =======');

  for I:=0 to Length(BadFilePairs)-1 do
  begin
    SomeStr:='---'+IntToStr(I) ;
    if  self.BadRes[I][1]*self.BadRes[I][2]*self.BadRes[I][3]=0 then
    begin
      SomeStr:='Ignore0_'+IntToStr(I);
      inc(ignB);
    end else
    if ((self.Badres[I][0] / self.BadRes[I][1]) < 2) and
    ((self.Badres[I][0] / self.BadRes[I][2]) < 2) and
    ((self.Badres[I][0] / self.BadRes[I][3]) < 2) and
     (self.Badres[I][0]<0.8) then
    begin
      if self.BadRes[I][0] <  self.BadRes[I][1] then
      begin
         SomeStr[1]:='+';
         plusAm[0]:= plusAm[0]+1;
      end;
      if self.BadRes[I][0] <  self.BadRes[I][2] then
      begin
         SomeStr[2]:='+';
         plusAm[1]:= plusAm[1]+1;
      end;
      if self.BadRes[I][0] <  self.BadRes[I][3] then
      begin
         SomeStr[3]:='+';
         plusAm[2]:= plusAm[2]+1;
      end;
    end else
    begin
     SomeStr:='Ignore'+inttostr(I);
     inc(ignB);
    end;

    Curres[0]:=Curres[0]+self.BadRes[I][0];
    Curres[1]:=Curres[1]+self.BadRes[I][1];
    Curres[2]:=Curres[2]+self.BadRes[I][2];
    Curres[3]:=Curres[3]+self.BadRes[I][3];
    Form3.mmo2.Lines.Add(SomeStr);
    DifBad[0]:=DifBad[0]+(Curres[1]-Curres[0]);
    DifBad[1]:=DifBad[1]+(Curres[2]-Curres[0]);
    DifBad[2]:=DifBad[2]+(Curres[3]-Curres[0]);
  end;

  AvgDifBad[0]:=DifBad[0] / (Length(BadFilePairs)- IgnB);
  AvgDifBad[1]:=DifBad[1]/ (Length(BadFilePairs)- IgnB);
  AvgDifBad[2]:=DifBad[2] / (Length(BadFilePairs)- IgnB);

  Form3.mmo2.Lines.Add('------------');
  Form3.mmo2.Lines.Add(floattostr(PlusAm[0])+'-'+floattostr(PlusAm[1])+'-'+floattostr(PlusAm[2]));
  Form3.mmo2.Lines.Add(floattostr(PlusAm[0]/(Length(BadFilePairs)- IgnB))+'-'+floattostr(PlusAm[1]/(Length(BadFilePairs)- IgnB))+'-'+floattostr(PlusAm[2]/(Length(BadFilePairs)- IgnB)));
  Form3.mmo2.Lines.Add('==========================');
  Form3.mmo2.Lines.Add(' 2.2  Avg Result:');
  Form3.mmo2.Lines.Add('Выводит средний показатель похожести ');
  Form3.mmo2.Lines.Add('для Good лучше чтобы ++, -+, +- были больше --');
  AvgResBad[0]:=Curres[0] / Length(BadFilePairs);
  AvgResBad[1]:=Curres[1] / Length(BadFilePairs);
  AvgResBad[2]:=Curres[2] / Length(BadFilePairs);
  AvgResBad[3]:=Curres[3] / Length(BadFilePairs);
  Form3.mmo2.Lines.Add('Good');
  Form3.mmo2.Lines.Add('Avg --   :' +floattostr(AvgResGood[0]));
  Form3.mmo2.Lines.Add('Avg ++ :' +floattostr(AvgResGood[1]));
  Form3.mmo2.Lines.Add('Avg +-  :' +floattostr(AvgResGood[2]));
  Form3.mmo2.Lines.Add('Avg -+  :' +floattostr(AvgResGood[3]));

  Form3.mmo2.Lines.Add('Baad');
  Form3.mmo2.Lines.Add('Avg --   :' +floattostr(AvgResbad[0]));
  Form3.mmo2.Lines.Add('Avg ++ :' +floattostr(AvgResbad[1]));
  Form3.mmo2.Lines.Add('Avg +-  :' +floattostr(AvgResbad[2]));
  Form3.mmo2.Lines.Add('Avg -+  :' +floattostr(AvgResbad[3]));

  Form3.mmo2.Lines.Add('==========================');
  Form3.mmo2.Lines.Add('   2.3  Differense:');
  Form3.mmo2.Lines.Add('2.3.1  Summ:');
  Form3.mmo2.Lines.Add('Выводит сумму показателя разницы похожести ');
  Form3.mmo2.Lines.Add('для Good лучше чтобы ++, -+, +- были >0; для Bad наоборот');
  Form3.mmo2.Lines.Add('Good');
  Form3.mmo2.Lines.Add('++ :'  +floattostr(DifGood[0]));
  Form3.mmo2.Lines.Add('+-  :' +floattostr(DifGood[1]));
  Form3.mmo2.Lines.Add('-+  :' +floattostr(DifGood[2]));

  Form3.mmo2.Lines.Add('Bad');
  Form3.mmo2.Lines.Add('++ :'  +floattostr(DifBad[0]));
  Form3.mmo2.Lines.Add('+-  :' +floattostr(DifBad[1]));
  Form3.mmo2.Lines.Add('-+  :' +floattostr(DifBad[2]));

  Form3.mmo2.Lines.Add('2.3.2  Avg:');
  Form3.mmo2.Lines.Add('Выводит средний показатель разницы похожести ');
  Form3.mmo2.Lines.Add('для Good лучше чтобы ++, -+, +- были >0; для Bad наоборот');
  Form3.mmo2.Lines.Add('Good');
  Form3.mmo2.Lines.Add('++ :'  +floattostr(AvgDifGood[0]));
  Form3.mmo2.Lines.Add('+-  :' +floattostr(AvgDifGood[1]));
  Form3.mmo2.Lines.Add('-+  :' +floattostr(AvgDifGood[2]));

  Form3.mmo2.Lines.Add('Bad');
  Form3.mmo2.Lines.Add('++ :'  +floattostr(AvgDifBad[0]));
  Form3.mmo2.Lines.Add('+-  :' +floattostr(AvgDifBad[1]));
  Form3.mmo2.Lines.Add('-+  :' +floattostr(AvgDifBad[2]));

  Form3.mmo2.Lines.Add('==========================');
  Form3.mmo2.Lines.Add('   2.4  Normal Differense:');
  Form3.mmo2.Lines.Add('Выводит относительную разницу ');
  Form3.mmo2.Lines.Add('для Good лучше чтобы ++, -+, +- были >0; для Bad наоборот');
  Form3.mmo2.Lines.Add('Good');
  for I:=0 to Length(GoodFilePairs)-1 do
  begin

    if self.GoodRes[I][0]>0 then
    begin
      Curres[0]:=(self.GoodRes[I][1]-self.GoodRes[I][0])/self.GoodRes[I][0];
      Curres[1]:=(self.GoodRes[I][2]-self.GoodRes[I][0])/self.GoodRes[I][0];
      Curres[2]:=(self.GoodRes[I][3]-self.GoodRes[I][0])/self.GoodRes[I][0];
      Form3.mmo2.Lines.Add(IntToStr(I));
      Form3.mmo2.Lines.Add('++ :'  +floattostr(Curres[0]));
      Form3.mmo2.Lines.Add('+-  :' +floattostr(Curres[1]));
      Form3.mmo2.Lines.Add('-+  :' +floattostr(Curres[2]));
      NormCurres[0]:=NormCurres[0]+Curres[0];
      NormCurres[1]:=NormCurres[1]+Curres[1];
      NormCurres[2]:=NormCurres[2]+Curres[2];
    end else
    Form3.mmo2.Lines.Add('Ignore ++0');
  end;

  Form3.mmo2.Lines.Add('---------');
  NormCurres[0]:=NormCurres[0] / (Length(GoodFilePairs)- IgnG);
  NormCurres[1]:=NormCurres[1] / (Length(GoodFilePairs)- IgnG);
  NormCurres[2]:=NormCurres[2] / (Length(GoodFilePairs)- IgnG);
  Form3.mmo2.Lines.Add('++ :'  +floattostr(NormCurres[0]));
  Form3.mmo2.Lines.Add('+-  :' +floattostr(NormCurres[1]));
  Form3.mmo2.Lines.Add('-+  :' +floattostr(NormCurres[2]));

  Form3.mmo2.Lines.Add('  ');
  Form3.mmo2.Lines.Add('Bad');
  for I:=0 to Length(BadFilePairs)-1 do
  begin
    if self.BadRes[I][0]>0 then
    begin
    Curres[0]:=(self.BadRes[I][1]-self.BadRes[I][0])/self.BadRes[I][0];
    Curres[1]:=(self.BadRes[I][2]-self.BadRes[I][0])/self.BadRes[I][0];
    Curres[2]:=(self.BadRes[I][3]-self.BadRes[I][0])/self.BadRes[I][0];
    NormCurres[0]:=NormCurres[0]+Curres[0];
    NormCurres[1]:=NormCurres[1]+Curres[1];
    NormCurres[2]:=NormCurres[2]+Curres[2];
    Form3.mmo2.Lines.Add(IntToStr(I));
    Form3.mmo2.Lines.Add('++ :'  +floattostr(Curres[0]));
    Form3.mmo2.Lines.Add('+-  :' +floattostr(Curres[1]));
    Form3.mmo2.Lines.Add('-+  :' +floattostr(Curres[2]));
    end else
    Form3.mmo2.Lines.Add('Ignore ++0');

  end;
  Form3.mmo2.Lines.Add('---------');
  NormCurres[0]:=NormCurres[0] / (Length(BadFilePairs)- IgnB);
  NormCurres[1]:=NormCurres[1] / (Length(BadFilePairs)- IgnB);
  NormCurres[2]:=NormCurres[2] / (Length(BadFilePairs)- IgnB);
  Form3.mmo2.Lines.Add('++ :'  +floattostr(NormCurres[0]));
  Form3.mmo2.Lines.Add('+-  :' +floattostr(NormCurres[1]));
  Form3.mmo2.Lines.Add('-+  :' +floattostr(NormCurres[2]));



end;

procedure TForm3.btn8Click(Sender: TObject);
begin
    mmo3.Lines.LoadFromFile(Edit3.text);
end;

procedure TForm3.btn7Click(Sender: TObject);
begin
    mmo3.Lines.SavetoFile(Edit3.text);
end;

procedure TScriptManager.LoadMethods;
var I:Integer;
begin
  SetLength(self.AlgComands,StrToInt(form3.mmo3.Lines[0]));
  with Form3.mmo3 do
  begin
  for I:=0 to StrToInt(form3.mmo3.Lines[0])-1 do
  begin
      self.AlgComands[I,0]:=Lines[1+I*3];
      self.AlgComands[I,1]:=Lines[2+I*3];
      self.AlgComands[I,2]:=Lines[3+I*3];
  end;
  end;

end;

procedure TScriptManager.WorkWith(MethName, Param1, Param2: string);
var
  Meth:TIIAlg;
  Num:integer;
  I,J:Integer;
  PicL,PicR:TPicArr;
  NPicL,NPicR:TPicArr;
  Bit1,Bit2:TBitmap;
  HashL,HashR,NHashL,NHashR:TFrameArr;
  TempBit:TBitmap;
  Res:array[0..4] of real;
  Nres:array[0..4] of Real;
  result:vec6;
  preloaded:Boolean;
begin

  num:=StrToInt(Copy(methname,1,2));
  Bit1:=TBitmap.Create;
  bit2:=TBitmap.Create;
  Bit1.Width:=640;
  Bit1.Height:=360;
  Bit2.Width:=640;
  Bit2.Height:=360;
  SetLength(self.GoodRes, Length(Self.GoodFilePairs));
  SetLength(self.BadRes, Length(Self.BadFilePairs));

  case Num of
  91:begin
     Meth:=TIIAlgSteper.Create;
     (Meth as TIIAlgSteper).Range:=StrToInt(param1);

  end;
  11:begin
    meth:=TIIAlgEqalise.Create;
  end;
  21:begin
    meth:=TIIAlgNormalize.Create;
    (Meth as TIIAlgNormalize).Range:=255;
  end;

  22:begin
    meth:=TIIAlgSQR.Create;
    (Meth as TIIAlgSqr).AlgType:=StrToInt(param1);
  end;

  31:begin
    meth:=TIIAlgMatrix.Create(AlgCont);
    (Meth as TIIAlgMatrix).LoadMatrix(StrToInt(param1));
  end;
  41:begin
    meth:=TIIAlgRED.Create;
    (Meth as TIIAlgRED).treshold:=StrTofloat(param1);
    (Meth as TIIAlgRED).Sqare:=StrToInt(param2);
  end;
  42:begin
    meth:=TIIGreyScale.Create;
    (Meth as TIIGreyScale).AlgType:=strtoint(param1);
  end;

  43:begin
    meth:=TIIAlgREDclear.Create;
    (Meth as TIIAlgREDclear).treshold:=StrTofloat(param1);
    (Meth as TIIAlgREDclear).Sqare:=StrToInt(param2);
  end;

  44:begin
    meth:=TIIAlgRGB.Create;
    (Meth as TIIAlgRGB).treshold:=StrToFloat(param1);
    (Meth as TIIAlgRGB).Sqare:=StrToInt(param2);
  end;

  45:begin
    meth:=TIIAlgRGBclear.Create;
    (Meth as TIIAlgRGBclear).treshold:=StrToFloat(param1);
    (Meth as TIIAlgRGBclear).Sqare:=StrToInt(param2);
  end;
  62:begin
    meth:=TIIAlgBrightChangeTo.Create;
    (Meth as TIIAlgBrightChangeTo).targetbright:=StrToint(param1);
  end;
  end;


  preloaded:=Form3.chk4.Checked;
  form3.mmo2.Lines.Add('================   1.CHECKING  ===================');
  form3.mmo2.Lines.Add(MethName);
  form3.mmo2.Lines.Add(param1);
  form3.mmo2.Lines.Add(param2);
  form3.mmo2.Lines.Add('1.1 Start Good Pairs');
  for I:=0 to Length(self.GoodFilePairs)-1 do
  begin
    if preloaded then
    begin
        PicL:=self.GLArrs[I];
        PicR:=self.GRArrs[I];
        NPicL:=CopyPicArr(Picl);
        NPicR:=CopyPicArr(PicR);
    end else
    begin
        tempbit:=tbitmap.create;
        LoadJpegToBitmap(Self.GoodFilePairs[i,0],TempBit);
        bit1.Canvas.StretchDraw(Rect(0,0,640,360),TempBit);
        TempBit.free;
        tempbit:=tbitmap.create;
        LoadJpegToBitmap(Self.GoodFilePairs[i,1],TempBit);
        bit2.Canvas.StretchDraw(Rect(0,0,640,360),TempBit);
        TempBit.Free;
        picl:=Api.FromPicToArr(bit1,Api.Sett);
        picR:=Api.FromPicToArr(bit2,Api.Sett);
        NPicL:=CopyPicArr(Picl);
        NPicR:=CopyPicArr(PicR);
    end;
    Meth.Made(Picl,NPicL);
    Meth.Made(PicR,NPicR);
    HashL:=Api.Hash(PicL,Api.Sett);
    HashR:=Api.Hash(PicR,Api.Sett);
    NHashL:=Api.Hash(NPicL,Api.Sett);
    NHashR:=Api.Hash(NPicR,Api.Sett);
    with Form3.mmo2 do
    begin
      Res[0]:=Api.CheckSomeHashs(HashL,HashR);
      Res[1]:=Api.CheckSomeHashs(NHashL,NHashR);
      Res[2]:=Api.CheckSomeHashs(NHashL,HashR);
      Res[3]:=Api.CheckSomeHashs(HashL,NHashR);
      Lines.Add('');
      Lines.Add(inttostr(I)+'. '+Self.GoodFilePairs[i,0]+' with '+Self.GoodFilePairs[i,1]);
      Lines.Add('--   : '+FloatToStr(Res[0]));
      Lines.Add('++ : '  +FloatToStr(Res[1]));
      Lines.Add('+-  : ' +FloatToStr(Res[2]));
      Lines.Add('-+  : ' +FloatToStr(Res[3]));
      self.GoodRes[i,0]:=res[0];
      self.GoodRes[i,1]:=res[1];
      self.GoodRes[i,2]:=res[2];
      self.GoodRes[i,3]:=res[3];

      result:=CheckBright(Picl);
      Form3.mmo2.Lines.Add('L  Bright: R:'+floattostr(result[0])+' 2:'+floattostr(result[1])+' s:'+floattostr(result[2])+' A'+floattostr(result[3]));
      result:=CheckBright(PicR);
      Form3.mmo2.Lines.Add('R  Bright: R:'+floattostr(result[0])+' 2:'+floattostr(result[1])+' s:'+floattostr(result[2])+' A'+floattostr(result[3]));
      result:=CheckBright(NPicL);
      Form3.mmo2.Lines.Add('NL Bright: R:'+floattostr(result[0])+' 2:'+floattostr(result[1])+' s:'+floattostr(result[2])+' A'+floattostr(result[3]));
      result:=CheckBright(NPicR);
      Form3.mmo2.Lines.Add('NR Bright: R:'+floattostr(result[0])+' 2:'+floattostr(result[1])+' s:'+floattostr(result[2])+' A'+floattostr(result[3]));
    end;

  end;
  form3.mmo2.Lines.Add('2.2 Start Bad Pairs');
  for I:=0 to Length(self.BadFilePairs)-1 do
  begin
    if preloaded then
    begin
        PicL:=self.BLArrs[I];
        PicR:=self.BRArrs[I];
        NPicL:=CopyPicArr(Picl);
        NPicR:=CopyPicArr(PicR);
    end else
    begin
      tempbit:=tbitmap.create;
      LoadJpegToBitmap(Self.BadFilePairs[i,0],TempBit);
      bit1.Canvas.StretchDraw(Rect(0,0,640,360),TempBit);
      TempBit.free;
      tempbit:=tbitmap.create;
      LoadJpegToBitmap(Self.BadFilePairs[i,1],TempBit);
      bit2.Canvas.StretchDraw(Rect(0,0,640,360),TempBit);
      TempBit.Free;
      picl:=Api.FromPicToArr(bit1,Api.Sett);
      picR:=Api.FromPicToArr(bit2,Api.Sett);
      NPicL:=CopyPicArr(Picl);
      NPicR:=CopyPicArr(PicR);
    end;
    Meth.Made(Picl,NPicL);
    Meth.Made(PicR,NPicR);
    HashL:=Api.Hash(PicL,Api.Sett);
    HashR:=Api.Hash(PicR,Api.Sett);
    NHashL:=Api.Hash(NPicL,Api.Sett);
    NHashR:=Api.Hash(NPicR,Api.Sett);
    with Form3.mmo2 do
    begin
      Res[0]:=Api.CheckSomeHashs(HashL,HashR);
      Res[1]:=Api.CheckSomeHashs(NHashL,NHashR);
      Res[2]:=Api.CheckSomeHashs(NHashL,HashR);
      Res[3]:=Api.CheckSomeHashs(HashL,NHashR);
      Lines.Add(inttostr(I)+'. '+Self.BadFilePairs[i,0]+' with '+Self.badFilePairs[i,1]);
      Lines.Add('--   : '+FloatToStr(Res[0]));
      Lines.Add('++ : '  +FloatToStr(Res[1]));
      Lines.Add('+-  : ' +FloatToStr(Res[2]));
      Lines.Add('-+  : ' +FloatToStr(Res[3]));
      self.BadRes[i,0]:=res[0];
      self.BadRes[i,1]:=res[1];
      self.BadRes[i,2]:=res[2];
      self.BadRes[i,3]:=res[3];
      result:=CheckBright(Picl);
      Form3.mmo2.Lines.Add('L  Bright: R:'+floattostr(result[0])+' 2:'+floattostr(result[1])+' s:'+floattostr(result[2])+' A'+floattostr(result[3]));
      result:=CheckBright(PicR);
      Form3.mmo2.Lines.Add('R  Bright: R:'+floattostr(result[0])+' 2:'+floattostr(result[1])+' s:'+floattostr(result[2])+' A'+floattostr(result[3]));
      result:=CheckBright(NPicL);
      Form3.mmo2.Lines.Add('NL Bright: R:'+floattostr(result[0])+' 2:'+floattostr(result[1])+' s:'+floattostr(result[2])+' A'+floattostr(result[3]));
      result:=CheckBright(NPicR);
      Form3.mmo2.Lines.Add('NR Bright: R:'+floattostr(result[0])+' 2:'+floattostr(result[1])+' s:'+floattostr(result[2])+' A'+floattostr(result[3]));
    end;

  end;
  Bit1.Free;
  Bit2.Free;


end;

function TScriptManager.CheckBright(var image:TPicArr):vec6;
var
Br1,Br2,Br3,Br4:double;
  Br21:double;
  Brs1:double;
  Bra1:double;
  I,J:integer;
begin
   br1:=0;
   br21:=0;
   brs1:=0;
   for I:=0 to length(image)-1 do
     for J:=0 to length(image[0])-1 do
     begin
        Br1:=Br1+image[i,j,0]+image[i,j,1]+image[i,j,2];
        Br21:=Br21+0.2126*image[i,j,2]+0.7152*image[i,j,2]+0.0722*image[i,j,2];
        Brs1:=Brs1+sqrt(0.299*sqr(image[i,j,0])+0.587*sqr(image[i,j,1])+0.114*sqr(image[i,j,2]));
     end;

   Result[0] := Trunc(Br1/(length(image)*length(image[0]))/3);
   Result[1] := Trunc(Br21/(length(image)*length(image[0])));
   Result[2] := Trunc(Brs1/(length(image)*length(image[0])));
   Result[3] :=Trunc((Br1+Br21+Brs1) / 3);

end;


{ WorkingThread }

procedure TWorkingThread.Execute;
var  SM:TScriptManager;
begin
  SM:=TScriptManager.Create();
    self.started:=True;
    SM.LoadMethods();
    SM.ReadScript();
    SM.WorkWithInter();
    self.Started:=True;
end;

procedure TForm3.btn4Click(Sender: TObject);
begin
  TextDB.Form4.Show();
end;

procedure TForm3.btn5Click(Sender: TObject);
begin
  WorkThread.Terminate;
  WorkThread.Started:=False;
end;

procedure TScriptManager.PreloadImages;
var tempbit:TBitmap;
I:Integer;
bit1,bit2:TBitmap;
begin
    Bit1:=TBitmap.Create;
    bit2:=TBitmap.Create;
    Bit1.Width:=640;
    Bit1.Height:=360;
    Bit2.Width:=640;
    Bit2.Height:=360;
    Form3.mmo2.Lines.Add('');
    Form3.mmo2.Lines.Add('');
    SetLength(self.GLArrs,Length(self.GoodFilePairs));
    SetLength(self.GRArrs,Length(self.GoodFilePairs));
    SetLength(self.BLArrs,Length(self.BadFilePairs));
    SetLength(self.BRArrs,Length(self.BadFilePairs));
    for I:=0 to Length(self.GoodFilePairs)-1 do
    begin
        Form3.mmo2.Lines[0]:=IntToStr(I+1);
        tempbit:=tbitmap.create;
        LoadJpegToBitmap(Self.GoodFilePairs[i,0],TempBit);
        bit1.Canvas.StretchDraw(Rect(0,0,640,360),TempBit);
        TempBit.free;
        tempbit:=tbitmap.create;
        LoadJpegToBitmap(Self.GoodFilePairs[i,1],TempBit);
        bit2.Canvas.StretchDraw(Rect(0,0,640,360),TempBit);
        TempBit.Free;
        self.GLArrs[I]:=Api.FromPicToArr(bit1,Api.Sett);
        self.GRArrs[I]:=Api.FromPicToArr(bit2,Api.Sett);
    end;

    for I:=0 to Length(self.BadFilePairs)-1 do
    begin
        Form3.mmo2.Lines[1]:=IntToStr(I+1);
        tempbit:=tbitmap.create;
        LoadJpegToBitmap(Self.BADFilePairs[i,0],TempBit);
        bit1.Canvas.StretchDraw(Rect(0,0,640,360),TempBit);
        TempBit.free;
        tempbit:=tbitmap.create;
        LoadJpegToBitmap(Self.BADFilePairs[i,1],TempBit);
        bit2.Canvas.StretchDraw(Rect(0,0,640,360),TempBit);
        TempBit.Free;
        self.BLArrs[i]:=Api.FromPicToArr(bit1,Api.Sett);
        self.BRArrs[i]:=Api.FromPicToArr(bit2,Api.Sett);
    end;

end;

end.
