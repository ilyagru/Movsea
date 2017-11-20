{some Doc strings

node - server that take part of task and do it, then sent result(part of Bfr) back

protocol:
    XXXXYYYYZZZZ...ZZZ
  X = Header(ProtoCod)
  Y = ServerID
  Z = Params (may have many blocks)u
}
{Адаптивный RGB смотрит в целом какого цвета меньше всего и красит его, или наоборот
 

}
unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdBaseComponent, IdComponent, IdTCPServer, IdCustomHTTPServer,
  IdHTTPServer, StdCtrls, IdTCPConnection, IdTCPClient, IdHTTP, ExtCtrls,
  ComCtrls, Grids, ExtDlgs, jpeg, IdSimpleServer,ShellApi, math,

  BaseTypes, ImageImproveMeth, TextDB, IdCustomTCPServer, IdContext,
  IdIntercept, IdServerInterceptLogBase, IdServerInterceptLogFile, IdLogBase,
  IdLogFile;

type

  TForm1 = class(TForm)
    chk4: TCheckBox;
    grp1: TGroupBox;
    btn19: TButton;
    IdHTTPServer1: TIdHTTPServer;
    IdHTTP1: TIdHTTP;
    dlgOpenPic1: TOpenPictureDialog;
    dlgOpen1: TOpenDialog;
    NodeServer: TIdHTTPServer;
    pgc1: TPageControl;
    ts1: TTabSheet;
    lbl1: TLabel;
    mmo1: TMemo;
    btn2: TButton;
    lbledt4: TLabeledEdit;
    lbledt5: TLabeledEdit;
    lbledt6: TLabeledEdit;
    btn11: TButton;
    btn12: TButton;
    lst1: TListBox;
    ts2: TTabSheet;
    btn3: TButton;
    lbledt7: TLabeledEdit;
    strngrd1: TStringGrid;
    strngrd2: TStringGrid;
    Edit1: TEdit;
    Edit2: TEdit;
    btn4: TButton;
    lbledt8: TLabeledEdit;
    ud1: TUpDown;
    ud2: TUpDown;
    mmo2: TMemo;
    btn5: TButton;
    cbb1: TComboBox;
    btn13: TButton;
    btn14: TButton;
    Edit3: TEdit;
    ts3: TTabSheet;
    lbledt9: TLabeledEdit;
    btn6: TButton;
    ts4: TTabSheet;
    img1: TImage;
    lbledt10: TLabeledEdit;
    btn7: TButton;
    btn8: TButton;
    btn9: TButton;
    btn10: TButton;
    lbledt11: TLabeledEdit;
    lbledt12: TLabeledEdit;
    lbledt13: TLabeledEdit;
    cbb2: TComboBox;
    mmo3: TMemo;
    ts5: TTabSheet;
    mmo4: TMemo;
    lbledt14: TLabeledEdit;
    btn15: TButton;
    ScrollBox1: TScrollBox;
    chk1: TCheckBox;
    lbledt15: TLabeledEdit;
    btn17: TButton;
    btn20: TButton;
    ts7: TTabSheet;
    lbledt18: TLabeledEdit;
    btn22: TButton;
    btn23: TButton;
    ts8: TTabSheet;
    mmo5: TMemo;
    ts9: TTabSheet;
    img3: TImage;
    img4: TImage;
    img2: TImage;
    img5: TImage;
    btn24: TButton;
    Edit4: TEdit;
    btn25: TButton;
    btn26: TButton;
    btn28: TButton;
    btn27: TButton;
    Edit5: TEdit;
    cbb3: TComboBox;
    btn29: TButton;
    cbb4: TComboBox;
    btn31: TButton;
    lbl2: TLabel;
    lbl3: TLabel;
    btn34: TButton;
    lbl4: TLabel;
    lbl5: TLabel;
    chk2: TCheckBox;
    chk3: TCheckBox;
    lbledt19: TLabeledEdit;
    lbl6: TLabel;
    lbl7: TLabel;
    lbl8: TLabel;
    lbl9: TLabel;
    lbledt20: TLabeledEdit;
    mmo6: TMemo;
    btn30: TButton;
    btn32: TButton;
    btn33: TButton;
    btn21: TButton;
    Edit6: TEdit;
    cbb5: TComboBox;
    Edit7: TEdit;
    btn18: TButton;
    IdLogFile1: TIdLogFile;
    IdServerInterceptLogFile1: TIdServerInterceptLogFile;
    chk5: TCheckBox;
  //{$INCLUDE Form1Incl.pasinc}
    procedure btn2Click(Sender: TObject);
    procedure btn7Click(Sender: TObject);
    procedure btn10Click(Sender: TObject);
    procedure btn8Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn9Click(Sender: TObject);
    procedure btn13Click(Sender: TObject);
    procedure btn4Click(Sender: TObject);
    procedure btn15Click(Sender: TObject);
    procedure chk1Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
    procedure btn5Click(Sender: TObject);
    procedure btn11Click(Sender: TObject);
    procedure btn20Click(Sender: TObject);
    procedure btn21Click(Sender: TObject);
    procedure btn23Click(Sender: TObject);
    procedure btn26Click(Sender: TObject);
    procedure btn28Click(Sender: TObject);
    procedure btn34Click(Sender: TObject);
    procedure btn24Click(Sender: TObject);
    procedure cbb3Change(Sender: TObject);
    procedure btn30Click(Sender: TObject);
    procedure btn32Click(Sender: TObject);
    procedure btn33Click(Sender: TObject);
    procedure btn18Click(Sender: TObject);
    procedure btn19Click(Sender: TObject);
    procedure IdHTTPServer1Connect(AContext: TIdContext);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

  libManager = record

      LibPath:string;
      Edits:array of TEdit;
      Checks:array of TCheckBox;
      MovNames:array of string;
      MovJsons:array of string;
      MovChecks:array of Boolean;
      MovAm:Integer;
  end;

  TmainApi=class;

  TMyThread = class(TThread)
   index:Integer;
   FramesR:TFrames;
   ParentApi:TmainApi;
   BestRes:array of array[0..3] of real;
  protected
    procedure Execute; override;
  end;

  TPostThread = class(TThread)
   Stream:Tstream;
   Strings:string;
  protected
    procedure Execute; override;
  end;



  TmainApi = class
    FramesL, FramesR : Tframes;
    LoadedPicArrs : array of TPicArr;
    PreparedPicArs : array of TPicArr;
    MovLibrary : array of TFrames;
    FFmpegPath : string;
    TempFilesPath : string;
    FFmpegRelTempPath : string;
    Picture : Timage;
    Buf : TFrameArr;
    BuffBit : TBitmap;
    IsUseII:Boolean;
    BitmapBuffer:array of TBitmap;
    SettingsArr : array[0..10] of Tsettings;
    Sett:Tsettings;
    LibPth:string;
    BestFrames:array of array[0..3] of real;
    Timers:array of TMyThread;
    TimerMovs:array of Integer;
    function Hash(var Arr:TPicArr; Sett:Tsettings):TFrameArr;
    procedure PrintHash(Hash:TFrameArr);
    function Check2Hashs(HashL:TFrameArr; HashR: TFrames) : TsomeRes;
    function CheckSomeHashs(HashL,HashR: TFrameArr) : real;
    procedure StartListen;
    function StartOfflineMovTask(Filename:string):integer;
    procedure StartOfflineDotTask;
    procedure UnCodeVideo(Movie:string);
    procedure HashPicFolder(Path:string; debug:Integer=0);
    procedure LoadPicFolder(Path:string; debug:Integer=0);
    procedure HashPics;
    procedure PreparePics();
    function FromPicToArr(var Img:Tbitmap; Sett:Tsettings):TPicArr;
    procedure FromArrToPic(Img:Tbitmap;var PicArr:TPicArr);
    procedure PrintDots(Hash:TFrameArr; LR:Integer=0);
    constructor Create(); overload;
  private
    function CutDotsTo(var Dots:TFrameArr; Amount:Integer):TFrameArr;
  end;

  TSomeApiThread = class(TThread)
    SomeApi:TmainApi;
    Path:string;
  protected
    procedure Execute; override;
  end;



  TImageCompareManager = class
      ULbuf,URbuf,DLbuf,DRbuf:TBitmap;
      ULPicArr,URPicArr,DLPicArr,DRPicArr:TPicArr;
      Buffer: array[0..10] of TBitmap;
      Algs:array[0..50] of TIIAlg;
      procedure LoadPictureFromFile(Filename:string; where:Integer=0);
      procedure FreeAll();
      procedure MadeSomething(What,From:TBitmap);
      procedure Flip(What:Integer);
      procedure CheckThemAll;
      constructor Create();
      procedure ClearThemAll();
      procedure CheckStats();
      procedure PrintDots(Dots:TFrameArr; OnWhat:TBitmap);
      procedure ReinitImages(what:Integer);
  end;


var
  Form1: TForm1;
  Api:TmainApi;
  LibM:libManager;
  Thr:TMyThread;
  AlgCont:TIIAlgContainer;
  CompareManag : TImageCompareManager;
  OfflineThread : TSomeApiThread;

  const
  CheckRad :  Integer = 13;


implementation

{$R *.dfm}

uses ImageMenu, unit3;


procedure TForm1.btn2Click(Sender: TObject);
begin
    IdHTTPServer1.DefaultPort:=8000;
    idHttpServer1.Active:=True;
    mmo1.Lines.Add('I start littening for tasks')
end;


{procedure TForm1.IdHTTPServer1CommandGet(AContext: TIdContext;
  ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
  var
  Number:Integer;
  F:TextFile;
  res:integer;
  SomeApi:TmainApi;
  Str:string;
  I:Integer;
begin
  Randomize;
  mmo1.Lines.Add('I get something');
  if ArequestInfo.CommandType = hcpost then
  begin
      mmo1.Lines.Add('I get Post');
      Number:=Random(10000000);
      AssignFile(F, Api.TempFilesPath+'Videos\'+inttostr(Number)+'.MOV');
      Rewrite(F);     //
      CloseFile(F);
      SomeApi:=TmainApi.Create;
      SomeApi.LibPth:=Api.LibPth;
      SomeApi.FFmpegPath:=Api.FFmpegPath;
      SomeApi.TempFilesPath:=Api.TempFilesPath;
      SomeApi.FFmpegRelTempPath:=Api.FFmpegRelTempPath;
      Form1.mmo1.Lines.Add(IntToStr(ArequestInfo.ContentLength));
      SomeApi.LibPth:=Api.LibPth;
      SomeApi.IsUseII:=chk4.Checked;
      //Res:=SomeApi.StartOfflineMovTask(IntToStr(Number));
      Str:=LibM.MovJsons[1];
      AResponseInfo.ContentStream:=TStringStream.Create(Str);
      SomeApi.Free;
end else mmo1.Lines.Add('It is not post');
end; }



procedure TForm1.IdHTTPServer1Connect(AContext: TIdContext);
var
   SL:TStringList;
   Tmemor:Tmemorystream;
   I:integer;
   ContLengh:integer;
   Len:string;
   Number:Integer;
   SomeApi:TmainApi;
   Res:Integer;
   Strin:string;
   State:Byte;
begin
   TMemor:=TMemoryStream.Create;
   SL:=TStringList.Create;
   SL.Add(AContext.Connection.IOHandler.readln);
   if SL[0] = 'POST / HTTP/1.1' then
   begin
     for I := 0 to 8 do
     begin
        SL.Add(AContext.Connection.IOHandler.readln);
        Form1.mmo1.Lines.Add(SL[i])
     end;
     State:=0;
     ContLengh:=StrToInt(copy(Sl[6],17));
     Form1.mmo1.Lines.Add('ANTON '+copy(Sl[6],17));
   end;

   if SL[0] = 'POST / HTTP/1.0' then
   begin
     for I := 0 to 7 do
     begin
        SL.Add(AContext.Connection.IOHandler.readln);
        Form1.mmo1.Lines.Add(SL[i])
     end;
     State:=0;
     ContLengh:=StrToInt(copy(Sl[3],17));
     Form1.mmo1.Lines.Add('JA '+copy(Sl[3],17));
   end;

  Randomize;
  mmo1.Lines.Add('I get something');
  if State = 0 then
  begin
      Number:=Random(10000000);

      mmo1.Lines.Add('I get Post');
      AContext.Connection.IOHandler.ReadStream(Tmemor,ContLengh-1);
      Tmemor.SaveToFile(Api.TempFilesPath+'Videos\'+inttostr(Number)+'.MOV');
      SomeApi:=TmainApi.Create;
      SomeApi.LibPth:=Api.LibPth;
      SomeApi.FFmpegPath:=Api.FFmpegPath;
      SomeApi.TempFilesPath:=Api.TempFilesPath;
      SomeApi.FFmpegRelTempPath:=Api.FFmpegRelTempPath;
      SomeApi.LibPth:=Api.LibPth;
      SomeApi.IsUseII:=chk4.Checked;
      Res:=SomeApi.StartOfflineMovTask(IntToStr(Number));
      Strin:=LibM.MovJsons[res];
      AContext.Connection.IOHandler.WriteLn('HTTP/1.1 200 OK');
      AContext.Connection.IOHandler.WriteLn('Connection: close');
      AContext.Connection.IOHandler.WriteLn('Content-Type: text/html; charset=ISO-8859-1');
      AContext.Connection.IOHandler.WriteLn('Content-Length: 334');
      AContext.Connection.IOHandler.WriteLn('Date: Sun, 16 Oct 2016 18:24:55 GMT');
      AContext.Connection.IOHandler.WriteLn('');
      AContext.Connection.IOHandler.WriteLn(Strin)

end else mmo1.Lines.Add('It is not post');
end;

procedure TForm1.btn7Click(Sender: TObject);
begin
  img1.Picture.LoadFromFile(lbledt10.Text);
end;

procedure TForm1.btn10Click(Sender: TObject);
begin
    if  dlgOpen1.Execute() then
    begin
      //Jpg:=TjpegImage.Create();
      //Jpg.LoadFromFile(dlgOpen1.FileName);
      //img1.Assign(Jpg);
      Img1.Picture.LoadFromFile(dlgOpen1.FileName);
      Api.BuffBit:=TBitmap.Create();
      LoadJpegToBitmap(dlgOpen1.FileName,Api.BuffBit);
      img1.Picture.Bitmap.Assign(Api.BuffBit);
    end;
end;

{ TmainApi }

function CheckFrArrwithFramBit(HashL: TFrameArr;
  HashR: TFrames): TsomeRes;
var
  I,J,K:Integer;
  Am1,Am2:real;
  Bit:TFramesBits;
begin
  Bit:=TFramesBits.Create;
  Bit.FillBits(HashL);
  SetLength(Result,HashR.FrAm);
  for I:= 0 to HashR.FrAm-1 do
  if HashR.DotsAm[I] < 10 then
  begin
     Result[I][0]:=I;
     Result[I][1]:=0;
  end else

  begin
    Result[I][1]:=BaseTypes.Chech2Bits(HashL,HashR.Arr[I],Bit,HashR.BitArr[i]);
    Result[I][0]:=I;
    //result[I][1]:= (Am1+Am2)/(Length(HashL)+HashR.DotsAM[I]);
   end;
   Bit.Destroy;
end;

function FastCheckFrBits(var HashL: TFrameArr; var BitL:TFramesBits;
  HashR: TFrames): TsomeRes;
var
  I,J,K:Integer;
  Am1,Am2:real;
begin

  SetLength(Result,HashR.FrAm);
  for I:= 0 to HashR.FrAm-1 do
  if HashR.DotsAm[I] < 10 then
  begin
     Result[I][0]:=I;
     Result[I][1]:=0;
  end else

  begin
    Result[I][1]:=BaseTypes.Chech2Bits(HashL,HashR.Arr[I],BitL,HashR.BitArr[i]);
    Result[I][0]:=I;
    //result[I][1]:= (Am1+Am2)/(Length(HashL)+HashR.DotsAM[I]);
   end;
end;

function TmainApi.Check2Hashs(HashL: TFrameArr;
  HashR: TFrames): TsomeRes;
var
  I,J,K:Integer;
  Am1,Am2:Integer;
begin
  SetLength(Result,HashR.FrAm);
  for I:= 0 to HashR.FrAm-1 do
  if HashR.DotsAm[I] < 10 then
  begin
     Result[I][0]:=I;
     Result[I][1]:=0;
  end else
  begin
    Am1:=0;
    for J:=0 to Length(HashL)-1 do
      for K:=0 to HashR.DotsAm[I]-1 do
        if Abs(HashL[J][0] - HashR.Arr[I][K][0]) + Abs(HashL[J][1] - HashR.Arr[I][K][1]) < CheckRad then
        begin
          inc(am1);
          Break;
        end;
    Am2:=0;
    for K:=0 to HashR.DotsAm[I]-1 do
      for J:=0 to Length(HashL)-1 do
        if Abs(HashL[J][0] - HashR.Arr[I][K][0]) + Abs(HashL[J][1] - HashR.Arr[I][K][1]) < CheckRad then
        begin
          inc(am2);
          Break;
        end;

    Result[I][0]:=I;
    Result[I][1]:= (Am1+Am2)/(Length(HashL)+HashR.DotsAM[I]);
   end;
end;

constructor TmainApi.Create;
begin
  inherited;
  Self.IsUseII:=false;
end;


function TmainApi.CutDotsTo(var Dots: TFrameArr; Amount: Integer): TFrameArr;
//var
  {I,J:Integer;
  Dot:array[0..2] of Integer; }
begin
   { Dot[2]:=0;
    for I:=0 to Length(Dots)-1 do
      for J:=I to Length(Dots)-1 do
      begin
          if Dots[I,2]<Dots[J,2] then
          begin
            Dot[0]:=Dots[I,0];
            Dot[1]:=Dots[I,1];
            Dot[2]:=Dots[I,2];
            Dots[I]:=Dots[J];
            Dots[J,0]:=Dot[0];
            Dots[J,1]:=Dot[1];
            Dots[J,2]:=Dot[2];
          end;
      end;
    SetLength(Dots,Amount); ///////////////////////////////////////    }
    result:=Basetypes.CutDotsTo(Dots,Amount)
end;

{function TmainApi.FromPicToArr(Img: TBitmap; Sett:Tsettings): TPicArr;        ///////////////HELLO MF BUG!!!!
var
  I,J:Integer;
  SX,SY:Integer;
  Color:LongInt;
begin

  SX := Img.Width;
  SY := Img.Height;
  SetLength(Result,SX);
  for I:=0 to SX-1 do
  begin
    SetLength(Result[I],SY);
    for J:=0 to SY-1 do
    begin
         Color := ColorToRGB(Img.Canvas.Pixels[I,J]);  //////////////////////
         Result[I,J][0]:=byte(Color);
         Result[I,J][1]:=byte(Color shr 8);
         Result[I,J][2]:=byte(Color shr 16);
    end;


  end;
end; }

function TmainApi.FromPicToArr(var Img: TBitmap; Sett:Tsettings): TPicArr;
  var
  a:    array of TRGBTriple;
  size: dword;
  i,j:Integer;
  iter:Integer;
begin
  iter:=0;
  size:=img.Width*img.Height;
  Setlength(a,size);
  GetBitmapBits(img.Handle,size*3,a);
  SetLength(Result,img.Width);
  for I:=0 to img.Width-1 do
    SetLength(Result[I],img.height);

  try
      for I:=0 to min(359,img.height-1) do
        begin
          for J:=0 to min(639,img.Width-1) do
          begin
               Result[J,I][0]:=a[iter].rgbtred;
               Result[J,I][1]:=a[iter].rgbtGreen;
               Result[J,I][2]:=a[iter].rgbtblue;
               inc(iter);
          end;
      end;
  except
    showmessage(inttostr(j)+'-'+inttostr(i));
  end;

end;




function TmainApi.Hash(var Arr:TPicArr; Sett:Tsettings):TFrameArr;
begin
    result:=BaseTypes.Hash(arr,sett);
end;

procedure TmainApi.HashPicFolder(Path: string; debug:Integer=0);
var
  searchResult : TSearchRec;
  Sl:TStringList;
  I:integer;
  PicArr:TPicArr;
  FileP:string;
  SomeHash:TFrameArr;
begin
  Sl:=TStringList.Create();
  if FindFirst(Path+'\*.bmp', faAnyFile, searchResult) = 0 then
  begin
    repeat
      begin
      Sl.Add(Path+'\'+searchResult.Name)
      end;
    until FindNext(searchResult) <> 0;
    FindClose(searchResult);
  end;
  FramesL:=TFrames.Create;
  FramesL.Resize(Sl.Count);
  SetLength(Self.BitmapBuffer,Sl.Count);

  for I:=0 to SL.Count-1 do
  begin
    FileP:=Path+'\'+'Some'+inttostr(I+1)+'.bmp';
    Self.BitmapBuffer[I]:=TBitmap.Create;
    Self.BitmapBuffer[I].Width:=640;
    Self.BitmapBuffer[I].Height:=360;
    Self.BitmapBuffer[I].LoadFromFile(FileP);
  end;

  for I:=0 to SL.Count-1 do
  begin
    PicArr:=FromPicToArr(Self.BitmapBuffer[I], Sett); ;
    Self.BitmapBuffer[I]:=TBitmap.Create;
    Self.BitmapBuffer[I].Width:=640;
    Self.BitmapBuffer[I].Height:=360;
    Self.BitmapBuffer[I].LoadFromFile(FileP);
    //DumpPicArr(PicArr,'Load-'+inttostr(I)+'.txt');
    SomeHash:=Hash(PicArr, Sett);
    SetLength(PicArr,0);
    FramesL.Assign(Somehash,I);
  end;

  if Form1.chk5.checked then
      FramesL.Bitiarize;
  //FramesL.SaveToFile('Test1.txt');
  Sl.Free;
end;



procedure TmainApi.PrintDots(Hash: TFrameArr; LR:Integer=0);
var
  I:integer;
begin
    if LR = 0 then
    begin
    form1.strngrd1.RowCount:=Length(Hash);
    for I:=0 to Length(Hash) do
      begin
         form1.strngrd1.cells[0,I]:=FloatToStr(Hash[I,0]);
         form1.strngrd1.cells[1,I]:=FloatToStr(Hash[I,1]);
         form1.strngrd1.cells[2,I]:=FloatToStr(Hash[I,2]);
      end;
    end;
    If LR = 1 then
    begin
      form1.strngrd2.RowCount:=Length(Hash);
      for I:=0 to Length(Hash) do
        begin
           form1.strngrd2.cells[0,I]:=FloatToStr(Hash[I,0]);
           form1.strngrd2.cells[1,I]:=FloatToStr(Hash[I,1]);
           form1.strngrd2.cells[2,I]:=FloatToStr(Hash[I,2]);
        end;
    end;

end;

procedure TmainApi.PrintHash(Hash:TFrameArr);
var I:integer;
    X,Y:integer;
    Center:TPoint;
begin
    Center.X:=Self.BuffBit.width div 2;
    Center.Y:=Self.BuffBit.height div 2;
    Self.BuffBit.Canvas.Pen.Color:=clRed;
    Self.BuffBit.Canvas.Brush.Style:=bsClear;
    for I:=0 to Length(Hash) do
    begin
      X:=Hash[I][0]+center.X;
      Y:=Hash[I][1]+Center.Y;
      Self.BuffBit.Canvas.Ellipse(X-2,Y-2,X+2,Y+2);
    end;
end;

procedure TmainApi.StartListen;
begin

end;

procedure TmainApi.StartOfflineDotTask;
begin

end;

function TmainApi.StartOfflineMovTask(Filename:string):integer;
var M,I,J,K:Integer;
 res:TsomeRes;
 step:integer;
 BestFr:array[0..3] of Real;
 BestRes:array of real;
 //ExtendedResDebug:array of Real;  //!!!!!!!!!!!!!!!!!!!!!!!!!!! OK
 FarRes:array of real;
 UsedMovs:integer;
 SN1,SN2:integer;
 UnReady:Boolean;
 TempArray: TFrameArr;
 StartAll:TDateTime;
 StartT:TDateTime;
begin
    StartAll:=time();
    SetLength(BestFrames,0);  //
    SetLength(Timers,0);
    SetLength(TimerMovs,0);
    Self.FramesL:=TFrames.Create;
    UsedMovs:=0;
    UnReady:=True;
    Sett.H:=StrToInt(Form1.lbledt11.Text);
    Sett.S:=StrToInt(Form1.lbledt12.Text);
    Sett.P:=StrToFloat(Form1.lbledt13.Text);
    Api.Sett.H:=StrToInt(Form1.lbledt11.Text);
    Api.Sett.S:=StrToInt(Form1.lbledt12.Text);
    Api.Sett.P:=StrToFloat(Form1.lbledt13.Text);
    UnCodeVideo(Filename);
    Form1.mmo1.Lines.Add('I hashing '+Api.TempFilesPath+'Images\'+Filename);
    // Preparation
    self.HashPicFolder(Api.TempFilesPath+'Images\'+Filename,0);
    {Self.LoadPicFolder(Api.LibPth+'TempH\'+Filename,0);
    Self.PreparePics();
    Self.HashPics; }
    //
    Form1.mmo1.Lines.Add('I hashed ');
    StartT:=time();
    //Api.PrintDots(Api.FramesL.Arr[0]);
    for I:=0 to FramesL.FrAm-1 do
      Form1.mmo1.Lines.Add(IntToStr(FramesL.DotsAm[I]));
    Form1.mmo1.Lines.Add('I get Hash!');

    SetLength(BestFrames,FramesL.FrAm*LibM.MovAm);
    for I:=0 to LibM.MovAm-1 do
      if LibM.Checks[I].Checked then
        Inc(UsedMovs);
    SetLength(Timers,LibM.MovAm);
    SetLength(TimerMovs,LibM.MovAm);
    Form1.mmo1.Lines.Add('Istart '+inttostr(LibM.MovAm)+' timers');
    for I:=0 to LibM.MovAm-1 do
    begin
        Timers[I]:=TMyThread.Create(True);
        TimerMovs[I]:=0;
    end;
    for M:=0 to LibM.MovAm-1 do
      if LibM.Checks[M].Checked then
      begin
        Timers[M].FramesR:=Api.MovLibrary[M];
        Timers[M].Priority:=tpNormal;
        Timers[M].index:=M;
        TimerMovs[M]:=1;
        Timers[M].ParentApi:=Self;
        //Api.Timers[M].OnTimer:=AsyncTimer1Timer;
        Timers[M].Resume;
      end;

    SetLength(BestFrames,FramesL.FrAm*USedMovs);

    while UnReady do
    begin
      Unready:=False;
      for I:=0 to LibM.MovAm-1 do
        if  TimerMovs[I]=1 then Unready:=True;
      Sleep(100);
      //Form1.mmo1.Lines.Add('UnReadyy');
    end;
    Form1.mmo1.Lines.Add('Readyy');



    step:=0;
    for I:=0 to  LibM.MovAm-1 do
    if LibM.Checks[I].Checked then
      for J:=0 to Length(Timers[I].BestRes)-1 do
      begin
          BestFrames[step,0]:=Timers[I].BestRes[J,0];
          BestFrames[step,1]:=Timers[I].BestRes[J,1];
          BestFrames[step,2]:=Timers[I].BestRes[J,2];
          BestFrames[step,3]:=Timers[I].BestRes[J,3];
          inc(step);
      end;

    for I:=0 to LibM.MovAm-1 do
    begin
        Timers[I].Free;
        TimerMovs[I]:=1;
    end;


    for I:=0 to Length(BestFrames)-1 do
      for J:=0 to Length(BestFrames)-1 do
      if BestFrames[I,3]>BestFrames[j,3] then    //!!!
      begin
         BestFr[0]:=BestFrames[I,0];  //!!!
         BestFr[1]:=BestFrames[I,1];
         BestFr[2]:=BestFrames[I,2];
         BestFr[3]:=BestFrames[I,3];
         BestFrames[I]:=BestFrames[j];
         BestFrames[j,0]:=BestFr[0];
         BestFrames[j,1]:=BestFr[1];
         BestFrames[j,2]:=BestFr[2];
         BestFrames[j,3]:=BestFr[3];
      end;

    setlength(BestRes,LibM.MovAm);
    for I:=0 to LibM.MovAm-1 do
        BestRes[I]:=0;
    setlength(FarRes,LibM.MovAm);
    for I:=0 to LibM.MovAm-1 do
        FarRes[I]:=0;
    for I:=0 to length(bestframes)-1 do
    begin
        //Form1.mmo1.Lines.Add(FloatToStr(bestframes[I,0])+'-'+FloatToStr(bestframes[I,1])+'-'+FloatToStr(bestframes[I,2])+'-'+FloatToStr(bestframes[I,3]));
        BestRes[Trunc(bestframes[I][0])]:=BestRes[Trunc(bestframes[I][0])] + (length(bestframes) - I) div (2*UsedMovs);
    end;

    for M:=0 to LibM.MovAm-1 do
      if LibM.checks[M].checked then
      begin
        //Form1.mmo1.Lines.Add('Mov'+inttostr(M)+FloatToStr(FarRes[M]));
        SetLength(res,100);
        SN1:=0;
        for I:=0 to length(bestframes)-1 do
           begin
               if BestFrames[I][0] = M then
               begin
                 res[SN1,0]:=BestFrames[I,2];
                 inc(SN1);
                 //Form1.mmo1.Lines.Add(FloatToStr(BestFrames[I,2]));
               end;
           end;

           for J:=0 to SN1-1 do
            for K:=0 to SN1-1 do
            begin
              if J<>K then
                if abs(res[J,0]-res[k,0]) < 10 then
                  FarRes[M]:=FarRes[M]+2;
            end;

      end;

    form1.mmo1.Lines.Add('BestFr');
    for I:=0 to Length(BestRes)-1 do
      form1.mmo1.Lines.Add(floatToStr(BestRes[I]));

    form1.mmo1.Lines.Add('FarRes');
    for I:=0 to Length(FarRes)-1 do
      form1.mmo1.Lines.Add(floatToStr(FarRes[I]));


    //SomeOnesRemoveDir(Api.LibPth+'TempH\'+Filename+'\'); /////////////////
    for I:=0 to LibM.MovAm-1 do
      BestRes[I]:=BestRes[I]+FarRes[I];
    SN1:=0;
    SN2:=-1;
    for I:=0 to LibM.MovAm-1 do
      if SN1 < BestREs[I] then
      begin
        SN1:= trunc(BestREs[I]);
        SN2:=I;
      end;
      Form1.mmo1.Lines.Add(IntToStr(SN2+1));
      Form1.mmo1.Lines.Add('Time Elapsed = '+floattostr((time-StartT)));
      Form1.mmo1.Lines.Add('Time Elapsed = '+floattostr((time-StartAll)));
      Form1.mmo1.Lines.Add('=================================END==========================================');
      //Form1.mmo1.Lines.SaveToFile('Dump.txt');
    result:=SN2;


    SetLength(BestFrames,0);
    for I:=0 to Length(FramesL.Arr)-1 do
    begin
      TempArray:=FramesL.Arr[i];
      for J:=0 to FramesL.DotsAm[i]-1 do
      begin

      end;
      SetLength(FramesL.Arr[i],0);
    end;


    SetLength(FramesL.DotsAm,0);
    FramesL.Free;
    for I:=0 to length(Self.BitmapBuffer)-1 do
      Self.BitmapBuffer[i].Free;
    SetLength(Self.BitmapBuffer,0);
end;

procedure TmainApi.UnCodeVideo(Movie: string);
var Params:string;
MovP:string;
begin
    MovP:=FFmpegRelTempPath+'Videos\'+Movie;
    form1.mmo1.Lines.Add('I start to uncode video');
    Params:={Api.LibPth+'ffmpeg.exe'+}' -i '+MovP+'.mov'+' -r 2 -s 640x360 '+MovP+'T.mov';
    ExecSomeThing(Api.FFmpegPath,Params,SW_SHOWNORMAL);
    form1.mmo1.Lines.Add(Api.FFmpegPath+'--'+Params);
    Params:=self.TempFilesPath+'Images\'+Movie;
    CreateDir(Params);
    Params:=' -i '+MovP+'T.mov '+FFmpegRelTempPath+'Images\'+Movie+'\Some%d.bmp';  ///BMP!!!!!!!!!
    form1.mmo1.Lines.Add('I start to exec pics from video');
    form1.mmo1.Lines.Add(Api.LibPth+'ffmpeg.exe--'+Params);
    ExecSomeThing(Api.FFmpegPath,Params, SW_SHOWNORMAL);
    //ShowMessage('Ok');
end;

procedure TmainApi.FromArrToPic(Img: Tbitmap; var PicArr: TPicArr);
begin
  BaseTypes.FromArrToPic(Img,PicArr)
end;

function TmainApi.CheckSomeHashs(HashL, HashR: TFrameArr): real;
var
  J,K:Integer;
  Am1,Am2:Integer;
begin
    Am1:=0;
    for J:=0 to Length(HashL)-1 do
      for K:=0 to Length(HashR)-1 do
        if Abs(HashL[J][0] - HashR[K][0]) + Abs(HashL[J][1] - HashR[K][1]) < CheckRad then
        begin
          inc(am1);
          Break;
        end;
    Am2:=0;
    for K:=0 to Length(HashR)-1 do
      for J:=0 to Length(HashL)-1 do
        if Abs(HashL[J][0] - HashR[K][0]) + Abs(HashL[J][1] - HashR[K][1]) < CheckRad then
        begin
          inc(am2);
          Break;
        end;
    Result:= (Am1+Am2)/(Length(HashL)+Length(HashR));
end;



procedure TForm1.btn8Click(Sender: TObject);
var
  PicArr:TPicArr;
  Hash:TFrameArr;
begin
  Api.Sett.H:=StrToInt(lbledt11.Text);
  Api.Sett.S:=StrToInt(lbledt12.Text);
  Api.Sett.P:=StrToFloat(lbledt13.Text);
  PicArr:=Api.FromPicToArr(Api.BuffBit, Api.Sett);
  Hash:=Api.Hash(PicArr, Api.Sett);
  Api.Buf:=Hash;
  Api.PrintDots(Hash);

end;

procedure TForm1.FormCreate(Sender: TObject);
var F:TextFile;
S:string;
begin
    Api:=TmainApi.Create;
    AssignFile(F,'Settings\Sett.txt');
    CompareManag:=TImageCompareManager.Create;
    Reset(F);
    Readln(F,S);
    Api.LibPth:=copy(S,1,100);
    Readln(F,S);
    lbledt14.text:=copy(S,1,100);
    Readln(F,S);
    Api.FFmpegPath:=copy(S,1,100);
    Readln(F,S);
    Api.TempFilesPath:=copy(S,1,100);
    Readln(F,S);
    Api.FFmpegRelTempPath:=copy(S,1,100);
    CloseFile(f);
    Api.Sett.H:=StrToInt(lbledt11.Text);
    Api.Sett.S:=StrToInt(lbledt12.Text);
    cbb3.ItemIndex:=0;
    Api.Sett.P:=StrToFloat(lbledt13.Text);
    //Thr:=TMyThread.Create(False);
    //Thr.Priority:=tpNormal;
    //cbb3Change(Self);
    //btn24Click(Self);
    cbb5.ItemIndex:=0;
    Randomize;
end;

procedure TForm1.btn9Click(Sender: TObject);
begin
    Api.PrintHash(Api.Buf);
    img1.Picture.Assign(Api.BuffBit);
end;

procedure TForm1.btn13Click(Sender: TObject);
var
  buf:TFrameArr;
  I:Integer;
begin
    SetLength(buf,strngrd1.RowCount);
    for I:=0 to strngrd1.RowCount-1 do
    begin
      buf[I][0]:=StrToInt(strngrd1.Cells[0,I]);
      buf[I][1]:=StrToInt(strngrd1.Cells[1,I]);
      buf[I][2]:=StrToInt(strngrd1.Cells[2,I]);
    end;
    Api.FramesL:=TFrames.Create();
    Api.FramesL.Resize(1);
    Api.FramesL.Assign(buf,0);
    Api.FramesL.SaveToFile(lbledt7.Text);
end;

procedure TForm1.btn4Click(Sender: TObject);
begin
    Api.FramesR:=TFrames.Create();
    Api.FramesR.LoadFromFile(lbledt8.Text);
    Api.PrintDots(Api.FramesL.Arr[0],1);
end;




procedure TmainApi.LoadPicFolder(Path: string; debug: Integer);
var
  searchResult : TSearchRec;
  Sl:TStringList;
  I:integer;
  FileP:string;
begin
  Sl:=TStringList.Create();
  if FindFirst(Path+'\*.jpg', faAnyFile, searchResult) = 0 then
  begin
    repeat
      begin
      Sl.Add(Path+'\'+searchResult.Name)
      end;
    until FindNext(searchResult) <> 0;
    FindClose(searchResult);
  end;
  setlength(self.LoadedPicArrs,Sl.Count);
  setlength(self.PreparedPicArs,Sl.Count);
  for I:=0 to SL.Count-1 do
  begin
      FileP:=Path+'\'+'Some'+inttostr(I+1)+'.jpg';
      Form1.mmo4.Lines.Add(FileP);
      BuffBit:=TBitmap.Create();
      LoadJpegToBitmap(FileP,BuffBit);
      self.LoadedPicArrs[I]:=FromPicToArr(BuffBit, Sett);  //leak
      BuffBit.Free;
  end;
end;

procedure TmainApi.PreparePics;
var I:Integer;
    Meth:TIIAlg;
begin
     for I:=0 to Length(Self.LoadedPicArrs)-1 do
        self.PreparedPicArs[i]:=CopyPicArr(Self.LoadedPicArrs[i]);

    if Self.IsUseII then
    begin
      meth:=TIIAlgMatrix.Create(nil);
      (Meth as TIIAlgMatrix).LoadMatrix(3);
      for I:=0 to Length(Self.LoadedPicArrs)-1 do
      begin
        Meth.Made(Self.LoadedPicArrs[i],PreparedPicArs[i]);
      end;
    end;


end;

procedure TmainApi.HashPics;
var I:integer;
begin
      FramesL:=TFrames.Create;
      FramesL.Resize(Length(self.PreparedPicArs));
      for I:=0 to Length(self.PreparedPicArs)-1 do
        FramesL.Assign(Hash(self.PreparedPicArs[i], Sett),I);
end;

{ TMyThread }

procedure TMyThread.Execute;
var
  Sind:string;
  Step:Integer;
  I:integer;
  res:TsomeRes;
  BF1:Integer;
  Best1,Best2,Best3:array[0..2] of Real;
begin
    Step:=0;
    Sind:=IntToStr(Index);
    Form1.mmo1.Lines.Add(Sind+'thread start to work');
    SetLength(BestRes,ParentApi.FramesL.FrAm); //////////////
    res:=nil;
    for I:=0 to ParentApi.FramesL.FrAm-1 do
    begin
        best1[1]:=0;
        best2[1]:=0;
        best3[1]:=0;
        //form1.mmo1.lines.add(Sind+'check '+inttostr(I));
        if Form1.chk5.Checked then

            Res:=FastCheckFrBits(ParentApi.FramesL.Arr[I],ParentApi.FramesL.BitArr[i],FramesR)
        else
            Res:=ParentApi.Check2Hashs(ParentApi.FramesL.Arr[I],FramesR);
        for BF1:=0 to Length(res)-1 do
        begin
           if best1[1]<res[BF1,1] then
           BEGIN
             best3:=best2;
             best2:=best1;
             best1[0]:=res[BF1,0];
             best1[1]:=res[BF1,1];
           end;
        end;
        BestRes[step][2]:=best1[0];
        BestRes[step][3]:=best1[1];
        BestRes[step][0]:=index;
        BestRes[step][1]:=I;
        inc(step);
       // TextDBMan.AddFile(TextDBMan.tempLog[0],'Debug res-',Sind+'-'+inttostr(i));
    end;

    Form1.mmo1.Lines.Add(Sind+' Done');
    ParentApi.TimerMovs[Self.index]:=0;
end;


procedure TPostThread.Execute;
begin
    inherited;
    Stream:=TMemoryStream.Create;
    //Strings:=TStrings.Create;  ///////////////////
    (Stream as TMemoryStream).LoadFromFile(Form1.lbledt18.Text);
    form1.IdHTTP1.Request.ContentType:='application/octet-stream';
    strings:=form1.IdHTTP1.Post('http://127.0.0.1:8000',Stream);
    ShowMessage(Strings);
    Stream.Free;
end;


procedure TForm1.btn23Click(Sender: TObject); // !!!
var Thread:TPostThread;
begin
  Thread:=TPostThread.Create(false);
  pgc1.TabIndex:=0;
end;


{ TImageCompareManager }

procedure TImageCompareManager.CheckThemAll;
var
  HashL,HashR:TFrameArr;
  SomeAlg:TPCAColorSqareDif;
begin
    SomeAlg:=TPCAColorSqareDif.Create();
    SomeAlg.Sqare:=16;
    HashL:=Api.Hash(ULPicArr,Api.Sett);
    //Self.PrintDots(HashL,ULbuf);
    HashR:=Api.Hash(URPicArr,Api.Sett);
    Form1.mmo6.Lines.Add('ULDotAm ='+inttostr(Length(HashL)));
    Form1.mmo6.Lines.Add('URDotAm ='+inttostr(Length(HashR)));
    //Self.PrintDots(HashR,URbuf);
    Form1.lbl4.Caption:=FloatToStr(Api.CheckSomeHashs(HashL,HashR));
    Form1.lbl7.Caption:=FloatToStr(SomeAlg.Check(ULPicArr,URPicArr));


    HashL:=Api.Hash(URPicArr,Api.Sett);
    HashR:=Api.Hash(DRPicArr,Api.Sett);
    Form1.lbl3.Caption:=FloatToStr(Api.CheckSomeHashs(HashL,HashR));
    Form1.lbl8.Caption:=FloatToStr(SomeAlg.Check(URPicArr,DRPicArr));

    HashL:=Api.Hash(DRPicArr,Api.Sett);
    //Self.PrintDots(HashL,DRbuf);
    HashR:=Api.Hash(DLPicArr,Api.Sett);
    Form1.mmo6.Lines.Add('DRDotAm ='+inttostr(Length(HashL)));
    Form1.mmo6.Lines.Add('DLDotAm ='+inttostr(Length(HashR)));
    //Self.PrintDots(HashR,DLbuf);
    Form1.lbl5.Caption:=FloatToStr(Api.CheckSomeHashs(HashL,HashR));
    Form1.lbl9.Caption:=FloatToStr(SomeAlg.Check(DLPicArr,DRPicArr));

    HashL:=Api.Hash(ULPicArr,Api.Sett);
    HashR:=Api.Hash(DLPicArr,Api.Sett);
    Form1.lbl2.Caption:=FloatToStr(Api.CheckSomeHashs(HashL,HashR));
    Form1.lbl6.Caption:=FloatToStr(SomeAlg.Check(ULPicArr,DLPicArr));
    CompareManag.Flip(0);
    CompareManag.Flip(1);
    CompareManag.Flip(2);
    CompareManag.Flip(3);
end;

constructor TImageCompareManager.Create;
begin
    self.ULbuf:=TBitmap.Create;
    self.ULbuf.Width:=640;
    self.ULbuf.Height:=480;

    self.URbuf:=TBitmap.Create;
    self.URbuf.Width:=640;
    self.URbuf.Height:=480;

    self.DLbuf:=TBitmap.Create;
    self.DLbuf.Width:=640;
    self.DLbuf.Height:=480;

    self.DRbuf:=TBitmap.Create;
    self.DRbuf.Width:=640;
    self.DRbuf.Height:=480;
end;

procedure TImageCompareManager.Flip(What: Integer);
begin
    case What of
       0:
       begin
          Form1.img2.Canvas.StretchDraw(Rect(0,0,313,177),ULbuf);
       end;
       1:
       begin
          Form1.img3.Canvas.StretchDraw(Rect(0,0,313,177),URbuf);
       end;
       2: begin
          Form1.img5.Canvas.StretchDraw(Rect(0,0,313,177),DLbuf);
       end;
       3: begin
          Form1.img4.Canvas.StretchDraw(Rect(0,0,313,177),DRbuf);
       end;
    end

end;

procedure TImageCompareManager.FreeAll;
begin

end;

procedure TImageCompareManager.LoadPictureFromFile(Filename: string;
  where: Integer);
var
  Buf:TBitmap;
begin
    Buf:=TBitmap.Create;

    LoadJpegToBitmap(Filename,buf);
    //Buf.SaveToFile('C:\Test.bmp');
    case Where of
       0:
       begin
          ULbuf.Width:=640;
          ULbuf.Height:=480;
          ULbuf.Canvas.StretchDraw(rect(0,0,640,480),buf);
          ULbuf.SaveToFile('C:\Test.bmp');
         //LoadJpegToBitmap(Filename,ULbuf);
       end;
       1:
       begin
         //LoadJpegToBitmap(Filename,URbuf);
         URbuf.Width:=640;
         URbuf.Height:=480;
         URbuf.Canvas.StretchDraw(rect(0,0,640,480),buf);
       end;
       2:
       begin
        // LoadJpegToBitmap(Filename,DLbuf);
        DLbuf.Width:=640;
        DLbuf.Height:=480;
        DLbuf.Canvas.StretchDraw(rect(0,0,640,480),buf);
       end;
       3:
       begin
         //LoadJpegToBitmap(Filename,DRbuf);
         DRbuf.Width:=640;
         DRbuf.Height:=480;
         DRbuf.Canvas.StretchDraw(rect(0,0,640,480),buf);
       end;
    end;
    Buf.Free;
end;

procedure TImageCompareManager.ReinitImages(what: Integer);
begin

end;

procedure TImageCompareManager.MadeSomething(What, From: TBitmap);
begin

end;

procedure TImageCompareManager.PrintDots(Dots: TFrameArr; OnWhat: TBitmap);
var I:Integer;
begin
    for I:=0 to Length(Dots)-1 do
      OnWhat.Canvas.Ellipse(Dots[I][0]-4,Dots[I][1]-4,Dots[I][0]+4,Dots[I][1]+4);
end;

procedure TImageCompareManager.ClearThemAll;
begin

end;


procedure TImageCompareManager.CheckStats;
var
  Br1,Br2,Br3,Br4:double;
  Br21,Br22,Br23,Br24:double;
  Brs1,Brs2,Brs3,Brs4:double;
  Bra1,Bra2,Bra3,Bra4:double;
  I,J:integer;
begin
    br1:=0;
    br2:=0;
    br3:=0;
    br4:=0;

    br21:=0;
    br22:=0;
    br23:=0;
    br24:=0;

    brs1:=0;
    brs2:=0;
    brs3:=0;
    brs4:=0;

   for I:=0 to length(CompareManag.ULPicArr)-1 do
     for J:=0 to length(CompareManag.ULPicArr[0])-1 do
     begin
        Br1:=Br1+CompareManag.ULPicArr[i,j,0]+CompareManag.ULPicArr[i,j,1]+CompareManag.ULPicArr[i,j,2];
        Br21:=Br21+0.2126*CompareManag.ULPicArr[i,j,2]+0.7152*CompareManag.ULPicArr[i,j,2]+0.0722*CompareManag.ULPicArr[i,j,2];
        Brs1:=Brs1+sqrt(0.299*sqr(CompareManag.ULPicArr[i,j,0])+0.587*sqr(CompareManag.ULPicArr[i,j,1])+0.114*sqr(CompareManag.ULPicArr[i,j,2]));
     end;

   for I:=0 to length(CompareManag.URPicArr)-1 do
     for J:=0 to length(CompareManag.URPicArr[0])-1 do
     begin
        Br2:=Br2+CompareManag.URPicArr[i,j,0]+CompareManag.URPicArr[i,j,1]+CompareManag.URPicArr[i,j,2];
        Br22:=Br22+0.2126*CompareManag.URPicArr[i,j,2]+0.7152*CompareManag.URPicArr[i,j,2]+0.0722*CompareManag.URPicArr[i,j,2];
        Brs2:=Brs2+sqrt(0.299*sqr(CompareManag.URPicArr[i,j,0])+0.587*sqr(CompareManag.URPicArr[i,j,1])+0.114*sqr(CompareManag.URPicArr[i,j,2]));
     end;

   for I:=0 to length(CompareManag.DRPicArr)-1 do
     for J:=0 to length(CompareManag.DRPicArr[0])-1 do
     begin
        Br3:=Br3+CompareManag.DRPicArr[i,j,0]+CompareManag.DRPicArr[i,j,1]+CompareManag.DRPicArr[i,j,2];
        Br23:=Br23+0.2126*CompareManag.DRPicArr[i,j,2]+0.7152*CompareManag.DRPicArr[i,j,2]+0.0722*CompareManag.DRPicArr[i,j,2];
        Brs3:=Brs3+sqrt(0.299*sqr(CompareManag.DRPicArr[i,j,0])+0.587*sqr(CompareManag.DRPicArr[i,j,1])+0.114*sqr(CompareManag.DRPicArr[i,j,2]));
     end;

   for I:=0 to length(CompareManag.DLPicArr)-1 do
     for J:=0 to length(CompareManag.DLPicArr[0])-1 do
     begin
        Br4:=Br4+CompareManag.DLPicArr[i,j,0]+CompareManag.DLPicArr[i,j,1]+CompareManag.DLPicArr[i,j,2];
        Br24:=Br24+0.2126*CompareManag.DLPicArr[i,j,2]+0.7152*CompareManag.DLPicArr[i,j,2]+0.0722*CompareManag.DLPicArr[i,j,2];
        Brs4:=Brs4+sqrt(0.299*sqr(CompareManag.DLPicArr[i,j,0])+0.587*sqr(CompareManag.DLPicArr[i,j,1])+0.114*sqr(CompareManag.DLPicArr[i,j,2]));
     end;
   Br1 := Trunc(Br1/(length(CompareManag.ULPicArr)*length(CompareManag.ULPicArr[0]))/3);
   Br2 := Trunc(Br2/(length(CompareManag.URPicArr)*length(CompareManag.URPicArr[0]))/3);
   Br3 := Trunc(Br3/(length(CompareManag.DRPicArr)*length(CompareManag.DRPicArr[0]))/3);
   Br4 := Trunc(Br4/(length(CompareManag.DLPicArr)*length(CompareManag.DLPicArr[0]))/3);

   Br21 := Trunc(Br21/(length(CompareManag.ULPicArr)*length(CompareManag.ULPicArr[0])));
   Br22 := Trunc(Br22/(length(CompareManag.URPicArr)*length(CompareManag.URPicArr[0])));
   Br23 := Trunc(Br23/(length(CompareManag.DRPicArr)*length(CompareManag.DRPicArr[0])));
   Br24 := Trunc(Br24/(length(CompareManag.DLPicArr)*length(CompareManag.DLPicArr[0])));

   Brs1 := Trunc(Brs1/(length(CompareManag.ULPicArr)*length(CompareManag.ULPicArr[0])));
   Brs2 := Trunc(Brs2/(length(CompareManag.URPicArr)*length(CompareManag.URPicArr[0])));
   Brs3 := Trunc(Brs3/(length(CompareManag.DRPicArr)*length(CompareManag.DRPicArr[0])));
   Brs4 := Trunc(Brs4/(length(CompareManag.DLPicArr)*length(CompareManag.DLPicArr[0])));

   BRa1:=Trunc((Br1+Br21+Brs1) / 3);
   BRa2:=Trunc((Br2+Br22+Brs2) / 3);
   BRa3:=Trunc((Br3+Br23+Brs3) / 3);
   BRa4:=Trunc((Br4+Br24+Brs4) / 3);


   Form1.mmo6.Lines.Add('LU Bright: R:'+floattostr(Br1)+' 2:'+floattostr(Br21)+' s:'+floattostr(brs1)+' A'+floattostr(Bra1));
   Form1.mmo6.Lines.Add('RU Bright: R:'+floattostr(Br2)+' 2:'+floattostr(Br22)+' s:'+floattostr(brs2)+' A'+floattostr(Bra2));
   Form1.mmo6.Lines.Add('LD Bright: R:'+floattostr(Br3)+' 2:'+floattostr(Br23)+' s:'+floattostr(brs3)+' A'+floattostr(Bra3));
   Form1.mmo6.Lines.Add('RD Bright: R:'+floattostr(Br4)+' 2:'+floattostr(Br24)+' s:'+floattostr(brs4)+' A'+floattostr(Bra4));

end;



  { Tform }

procedure TForm1.btn26Click(Sender: TObject);
begin
    CompareManag.ULbuf.Free;
    CompareManag.ULbuf:=TBitmap.Create;
    CompareManag.LoadPictureFromFile(Edit4.Text,0);
    SetLength(CompareManag.ULPicArr,0);
    CompareManag.ULPicArr:=Api.FromPicToArr(CompareManag.ULbuf,Api.Sett);
    CompareManag.Flip(0);
end;

procedure TForm1.btn28Click(Sender: TObject);
begin
    CompareManag.DLbuf.Free;
    CompareManag.DLbuf:=TBitmap.Create;
    CompareManag.LoadPictureFromFile(Edit5.Text,2);
    CompareManag.DLPicArr:=Api.FromPicToArr(CompareManag.DLbuf,Api.Sett);
    //CompareManag.DRPicArr:=Api.FromPicToArr(CompareManag.DLbuf,Api.Sett);
    CompareManag.Flip(2);
    //CompareManag.Flip(3);
end;

procedure TForm1.btn34Click(Sender: TObject);
begin
      CompareManag.CheckThemAll;
      CompareManag.CheckStats;
end;

procedure TForm1.btn24Click(Sender: TObject);
var
  Meth:TIIAlg;
Num:integer;
begin
  Num:=StrToInt(Copy(cbb3.Text,1,2));
  SetLength(CompareManag.URPicArr,0);
  SetLength(CompareManag.URPicArr,0);
  CompareManag.URPicArr:=CopyPicArr(CompareManag.ULPicArr);
  CompareManag.DRPicArr:=CopyPicArr(CompareManag.DLPicArr);
  meth:=nil;
  case Num of
  91:begin
     Meth:=TIIAlgSteper.Create;
     (Meth as TIIAlgSteper).Range:=StrToInt(lbledt19.Text);

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
    (Meth as TIIAlgSqr).AlgType:=StrToInt(lbledt19.Text);
  end;

  31:begin
    meth:=TIIAlgMatrix.Create(AlgCont);
    (Meth as TIIAlgMatrix).LoadMatrix(StrToInt(lbledt19.Text));
  end;
  41:begin
    meth:=TIIAlgRED.Create;
    (Meth as TIIAlgRED).treshold:=StrTofloat(lbledt19.Text);
    (Meth as TIIAlgRED).Sqare:=StrToInt(lbledt20.Text);
  end;
  42:begin
    meth:=TIIGreyScale.Create;
    (Meth as TIIGreyScale).AlgType:=strtoint(lbledt19.Text);
  end;

  43:begin
    meth:=TIIAlgREDclear.Create;
    (Meth as TIIAlgREDclear).treshold:=StrTofloat(lbledt19.Text);
    (Meth as TIIAlgREDclear).Sqare:=StrToInt(lbledt20.Text);
  end;

  44:begin
    meth:=TIIAlgRGB.Create;
    (Meth as TIIAlgRGB).treshold:=StrToFloat(lbledt19.Text);
    (Meth as TIIAlgRGB).Sqare:=StrToInt(lbledt20.Text);
  end;

  45:begin
    meth:=TIIAlgRGBclear.Create;
    (Meth as TIIAlgRGBclear).treshold:=StrToFloat(lbledt19.Text);
    (Meth as TIIAlgRGBclear).Sqare:=StrToInt(lbledt20.Text);
  end;
  end;

  if chk2.Checked then
  begin
    Meth.Made(CompareManag.ULPicArr,CompareManag.URPicArr);
    Api.FromArrToPic(CompareManag.URbuf,CompareManag.URPicArr);
  end else
  CompareManag.URbuf.Canvas.Draw(0,0,CompareManag.ULbuf);
  compareManag.URPicArr:=Api.FromPicToArr(CompareManag.URbuf,Api.Sett);

  CompareManag.Flip(1);

  compareManag.DRPicArr:=Api.FromPicToArr(CompareManag.DRbuf,Api.Sett);
  if chk3.Checked then
  begin
    Meth.Made(CompareManag.DLPicArr,CompareManag.DRPicArr);
    Api.FromArrToPic(CompareManag.DRbuf,CompareManag.DRPicArr);
  end else
  CompareManag.DRbuf.Canvas.Draw(0,0,CompareManag.DLbuf);
  compareManag.DRPicArr:=Api.FromPicToArr(CompareManag.DRbuf,Api.Sett);

  CompareManag.Flip(3);


end;



procedure TForm1.cbb3Change(Sender: TObject);
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




procedure TForm1.btn30Click(Sender: TObject);
var bmp:TbitMap;
  Jpegg:TJPEGImage;
Begin
  randomize;
  Jpegg:=TJPEGImage.Create;
  bmp:=tbitmap.Create;
  bmp.Width:=form1.Width-15;
  bmp.Height:=form1.Height-30;
  BitBlt(bmp.Canvas.Handle,0,0,form1.Width,form1.Height,getdc(form1.handle),0,0,SRCCOPY);
  Jpegg.Assign(bmp);
  Jpegg.SaveToFile(IntToStr(Random(99999999))+'.jpg');
  //bmp.SaveToFile(IntToStr(Random(99999999))+'.bmp');
  bmp.Free;
  Jpegg.Free;
end;


procedure TForm1.btn32Click(Sender: TObject);
begin
      ImageMenu.Form2:=TForm2.Create(self);
      ImageMenu.Form2.Show();
      ImageMenu.ImgComp:=CompareManag;
end;


procedure TForm1.btn33Click(Sender: TObject);
begin
      Unit3.Form3:=TForm3.Create(self);
      Unit3.Form3.Show();
      //Unit3.ImgComp:=CompareManag;
end;


procedure TForm1.btn18Click(Sender: TObject);
var
  Params:string;
begin
    form1.mmo4.Lines.Add('I start to uncode video');
    Params:=' -i '+form1.lbledt15.Text+'.mov'+' -r 2 -s 640x360 '+ form1.lbledt15.Text+'T.mov';
    ExecSomeThing(Api.LibPth+'ffmpeg.exe',Params,SW_SHOWNORMAL);
    Params:=form1.Edit7.Text;
    CreateDir(Params);
    Params:=' -i '+form1.lbledt15.Text+'T.mov'+' '+form1.Edit7.Text+'Some%d.jpg';
    form1.mmo1.Lines.Add('I start to exec pics from video');
    ExecSomeThing(Api.LibPth+'ffmpeg.exe',Params, SW_SHOWNORMAL);
end;

procedure TForm1.btn3Click(Sender: TObject);
begin
    Api.FramesL:=TFrames.Create();
    Api.FramesL.LoadFromFile(lbledt7.Text);
    Api.PrintDots(Api.FramesL.Arr[0],0);
end;

procedure TForm1.btn5Click(Sender: TObject);
var
  Res:TsomeRes;
  I:integer;
begin
    mmo2.Lines.Clear;
    Res:=Api.Check2Hashs(Api.FramesL.Arr[strtoint(Edit3.Text)],Api.FramesR);
    for I:=0 to Length(Res)-1 do
      mmo2.Lines.Add(floatToStr(Res[I,0])+' '+floatToStr(Res[I,1]))
end;

procedure TForm1.btn11Click(Sender: TObject);
begin
  if Assigned(offlineThread) then
     OfflineThread.Free;
  OfflineThread:=TSomeApiThread.Create(True);
  OfflineThread.SomeApi:=TmainApi.Create;
  OfflineThread.SomeApi.LibPth:=Api.LibPth;
  OfflineThread.SomeApi.FFmpegPath:=Api.FFmpegPath;
  OfflineThread.SomeApi.TempFilesPath:=Api.TempFilesPath;
  OfflineThread.SomeApi.FFmpegRelTempPath:=Api.FFmpegRelTempPath;
  OfflineThread.SomeApi.IsUseII:=chk4.Checked;
  OfflineThread.Path:=lbledt6.Text;
  OfflineThread.resume;
end;

procedure TForm1.btn20Click(Sender: TObject);
var I:integer;
begin
    SetLength(Api.MovLibrary, LibM.MovAm);
    for I:=0 to LibM.MovAm-1 do
    begin
      Api.MovLibrary[I]:=TFrames.Create;
      Api.MovLibrary[I].LoadFromFile(LibM.LibPath+LibM.MovNames[I]+'\'+'Hash.txt');
      if chk5.Checked then
        Api.MovLibrary[I].Bitiarize();
    end;
   // Api.PrintDots(Api.MovLibrary[0].arr[0],0);
   // Api.PrintDots(Api.MovLibrary[1].arr[0],1);
end;

procedure TForm1.btn21Click(Sender: TObject);
begin
    Api.Sett.H:=StrToInt(lbledt11.Text);
    Api.Sett.S:=StrToInt(lbledt12.Text);
    Api.Sett.P:=StrToFloat(lbledt13.Text);
    Api.HashPicFolder(Edit7.Text);
    Api.FramesL.SaveToFile(Edit6.Text);
end;

procedure TForm1.btn15Click(Sender: TObject);
var
  I:Integer;
  F:TextFile;
  S:string;
begin
  LibM.LibPath:=lbledt14.Text;
  AssignFile(F, lbledt14.Text+'LibraryIndex.txt');
  Reset(F);
  readln(F,LibM.MovAm);
  SetLength(LibM.Edits, LibM.MovAm);
  SetLength(LibM.Checks,LibM.MovAm);
  SetLength(LibM.MovNames,LibM.MovAm);
  SetLength(LibM.MovChecks,LibM.MovAm);
  for I:=0 to LibM.MovAm-1 do
  begin
      LibM.Edits[I]:=TEdit.Create(Form1);
      readln(F,S);
      LibM.MovNames[I]:=S;
      LibM.Edits[I].text:=S;
      LibM.Edits[I].Width:=ScrollBox1.Width-60;
      LibM.Edits[I].Parent:=ScrollBox1;
      LibM.Edits[I].Visible:=True;
      LibM.Edits[I].Left:=10;
      LibM.Edits[I].Top:=10+I*22;
      LibM.Edits[I].Anchors:=[akRight, akLeft];
      LibM.Checks[I]:=TCheckBox.Create(Form1);
      LibM.Checks[I].Checked:=True;
      LibM.Checks[I].Parent:=ScrollBox1;
      LibM.Checks[I].Left:=ScrollBox1.Width-45;
      LibM.Checks[I].Anchors:=[akRight];
      LibM.Checks[I].Top:=10+I*21;
  end;
  CloseFile(F);

  AssignFile(F, lbledt14.Text+'Jsons.txt');
  Reset(F);
  setlength(LibM.MovJsons,LibM.MovAm);
  for I:=0 to LibM.MovAm-1 do
  begin
    readln(F,S);
    LibM.MovJsons[I]:=S;
  end;
  CloseFile(F);


  for I:=0 to LibM.MovAm-1 do
    begin
      LibM.Checks[I].checked:=chk1.checked;
      LibM.MovChecks[I]:=chk1.checked;
    end;
end;

procedure TForm1.chk1Click(Sender: TObject);
var
  I:integer;
begin
    for I:=0 to LibM.MovAm-1 do
    begin
      LibM.Checks[I].checked:=chk1.checked;
      LibM.MovChecks[I]:=chk1.checked;
    end;
end;

procedure RecheckLib(Sender: TObject);
var I:integer;
begin
    for I:=0 to LibM.MovAm-1 do
    begin
      LibM.MovChecks[I]:=LibM.Checks[I].Checked;
      LibM.MovNames[I]:=LibM.Edits[i].text;
    end;
end;


{procedure TForm1.IdHTTPServer1CommandGet(AContext: TIdContext;
  ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
var
  S:string;
begin
    mmo1.Lines.Add('Connect');
    //AContext.Connection.ReadTimeout:=1;
    S:=AContext.Connection.ReadLn(#$A,10);
    while Length(S)>0 do
    begin
     mmo1.Lines.Add(AContext.Connection.ReadLn(#$A,1));
     S:=AContext.Connection.ReadLn(#10,10)
    end;
    mmo1.Lines.Add(AThread.Connection.ReadLn(#$A,1));
    AContext.Connection.Write(LibM.MovJsons[1]);
    AContext.Connection.Disconnect()

end;   }


procedure TForm1.btn19Click(Sender: TObject);
begin
    TextDB.Form4.Show;
end;

{ TSomeApiThread }

procedure TSomeApiThread.Execute;
begin
  self.SomeApi.StartOfflineMovTask(Path)
end;

end.
