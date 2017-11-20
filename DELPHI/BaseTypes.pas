unit BaseTypes;

interface
uses dialogs,Windows,StdCtrls,Forms,jpeg,ShellApi,SysUtils,Graphics, Controls,Classes,ExtCtrls, ComCtrls, textDb, math;

type
  TPicArr = array of array of array[0..3] of Integer;

  TsomeRes = array of array[0..2] of Real;
  tvec6 = array[0..5] of Double;
  TFrameArr =  array of array[0..2] of integer;
  Tpixel = array[0..2] of Integer;


  TFramesBits = class
      SizeX,SizeY:integer;
      TestBitOfBit: array[0..639] of TBits;
      function Check(FrameR:TframeArr):Real;
      procedure FillBits(FrameL:TFrameArr);
      function Check2Frames(FrameL,FrameR:TFrameArr): Real;
      constructor create();
      destructor Destroy();
  end;


  Tsettings = record  { TODO : set 1 full class for all settingth }
      H  : Integer;
      S  : Integer;
      P  : Real;
      Cut: Integer;
  end;

    TFrames = class
      Arr : array of TFrameArr ;
      FrAm:Integer;
      Bited:boolean;
      BitArr:array of TFramesBits;
      DotsAm : array of integer;
      procedure LoadFromFile(Filename : string);
      procedure SaveToFile(Filename : string);
      procedure Resize(Fr:Integer);
      procedure Assign(Frame:TFrameArr; Ind:integer);
      function ToString():string;
      procedure FromString(str:string);
      procedure Bitiarize();
  end;

  procedure CaptureConsoleOutput(const ACommand, AParameters: String; AMemo: TMemo);
  function ExecSomeThing(const FileName,Params: ShortString; const WinState: Word): boolean; export;
  function SomeOnesRemoveDir(sDir : string) : Boolean;

  procedure ZeroArray(var Arr:array of Real); overload;
  procedure ZeroArray(var Arr:array of integer); overload;
  procedure SetArray(var Arr:array of real; Val:real); overload;
  procedure SetArray(var Arr:array of integer; Val:integer); overload;

  function CopyPicArr(var Sourse:TPicArr):TPicArr;
  procedure LoadJpegToBitmap(Filename:string; var Bit:TBitmap);
  procedure FromArrToPic(Img: Tbitmap; var PicArr: TPicArr);
  function CutDotsTo(var Dots: TFrameArr; Amount: Integer): TFrameArr;
  procedure DumpPicArr(var Pic:Tpicarr; filename:string);


  function Hash(var Arr:TPicArr; Sett:Tsettings):TFrameArr;
  function Chech2Bits(var FRl,FRR:TFrameArr; BitL,BitR:TFramesBits):real;

implementation

procedure DumpPicArr(var Pic:Tpicarr; filename:string);
var
  SL:TStringList;
  i,j:Integer;
begin
  SL:=TStringList.Create;
  for I:=0 to Length(Pic)-1 do
    for J:=0 to Length(Pic[0])-1 do
    Sl.Add(IntToStr(Pic[i,j,0])+'-'+IntToStr(Pic[i,j,1])+'-'+IntToStr(Pic[i,j,2]));
  Sl.SaveToFile(filename);
  sl.Free;
end;

function ExecSomeThing(const FileName,
                     Params: ShortString;
                     const WinState: Word): boolean; export;
var
  StartInfo: TStartupInfo;
  ProcInfo: TProcessInformation;
  CmdLine: ShortString;
begin
  CmdLine := '"' + Filename + '" ' + Params;
  //CmdLine := Filename;
  FillChar(StartInfo, SizeOf(StartInfo), #0);
  with StartInfo do
  begin
    //cb := SizeOf(StartInfo.SUInfo);
    dwFlags := STARTF_USESHOWWINDOW;
    wShowWindow := WinState;
  end;
  Result := CreateProcess(nil, PChar( String( CmdLine ) ), nil, nil, false,
                          CREATE_NEW_CONSOLE or NORMAL_PRIORITY_CLASS, nil,
                          PChar(ExtractFilePath(Filename)),StartInfo,ProcInfo);
  if Result then
  begin
    WaitForSingleObject(ProcInfo.hProcess, INFINITE);
    { Free the Handles }
    CloseHandle(ProcInfo.hProcess);
    CloseHandle(ProcInfo.hThread);
  end;
end;

function SomeOnesRemoveDir(sDir : string) : Boolean;    //http://www.programmersforum.ru/showthread.php?t=1344
var
  iIndex: Integer;
  SearchRec: TSearchRec;
  sFileName: string;
begin
 // Result := False;
  sDir := sDir + '\*.*';
  iIndex := FindFirst(sDir, faAnyFile, SearchRec);

  while iIndex = 0 do
  begin
    sFileName := ExtractFileDir(sDir)+'\'+SearchRec.name;
    if SearchRec.Attr = faDirectory then
    begin
      if (SearchRec.name <> '' ) and (SearchRec.name <> '.') and
      (SearchRec.name <> '..') then
        SomeOnesRemoveDir(sFileName);
    end
    else
    begin
      if SearchRec.Attr <> faArchive then
        FileSetAttr(sFileName, faArchive);
      if not DeleteFile(sFileName) then
        ShowMessage('Could NOT delete ' + sFileName);
    end;
    iIndex := FindNext(SearchRec);
  end;

  FindClose(SearchRec);
  RemoveDir(ExtractFileDir(sDir));
  Result := True;
end;

procedure CaptureConsoleOutput(const ACommand, AParameters: String; AMemo: TMemo);
 const
   CReadBuffer = 2400;
 var
   saSecurity: TSecurityAttributes;
   hRead: THandle;
   hWrite: THandle;
   suiStartup: TStartupInfo;
   piProcess: TProcessInformation;
   pBuffer: array[0..CReadBuffer] of AnsiChar;
   dRead: DWord;
   dRunning: DWord;
 begin
   saSecurity.nLength := SizeOf(TSecurityAttributes);
   saSecurity.bInheritHandle := True;
   saSecurity.lpSecurityDescriptor := nil;

   if CreatePipe(hRead, hWrite, @saSecurity, 0) then
   begin
     FillChar(suiStartup, SizeOf(TStartupInfo), #0);
     suiStartup.cb := SizeOf(TStartupInfo);
     suiStartup.hStdInput := hRead;
     suiStartup.hStdOutput := hWrite;
     suiStartup.hStdError := hWrite;
     suiStartup.dwFlags := STARTF_USESTDHANDLES or STARTF_USESHOWWINDOW;
     suiStartup.wShowWindow := SW_SHOWNORMAL;

     if CreateProcess(nil, PChar(ACommand + ' ' + AParameters), @saSecurity,
       @saSecurity, True, NORMAL_PRIORITY_CLASS, nil, nil, suiStartup, piProcess)
       then
     begin
       repeat
         dRunning  := WaitForSingleObject(piProcess.hProcess, 100);
         Application.ProcessMessages();
         repeat
           dRead := 0;
           ReadFile(hRead, pBuffer[0], CReadBuffer, dRead, nil);
           pBuffer[dRead] := #0;

           OemToAnsi(pBuffer, pBuffer);
           AMemo.Lines.Add(String(pBuffer));
         until (dRead < CReadBuffer);
       until (dRunning <> WAIT_TIMEOUT);
       CloseHandle(piProcess.hProcess);
       CloseHandle(piProcess.hThread);
     end;

     CloseHandle(hRead);
     CloseHandle(hWrite);
   end;
end;


{ TFrames }

procedure TFrames.Assign(Frame: TFrameArr; Ind: integer);
begin
    if FrAm>Ind then
    begin
     self.Arr[Ind]:=Frame;
     self.DotsAm[Ind]:=Length(Frame);
    end
    else
      ShowMessage('out of bounds '+inttostr(Ind)+' of '+inttostr(FrAm));
end;

procedure TFrames.Bitiarize;
var
  I: Integer;
begin
    SetLength(BitArr,FrAm);
    for I := 0 to FrAm-1 do
    begin
      BitArr[i]:=TFramesBits.Create;
      BitArr[i].FillBits(Self.Arr[i]);
    end;
    Self.Bited:=True;

end;

procedure TFrames.FromString(str: string);
begin

end;

procedure TFrames.LoadFromFile(Filename: string);
var F:TextFile;
    I,J:Integer;
    DotAm : Integer;
begin
    AssignFile(F, Filename);
    Reset(F);
    read(F,FrAm);
    Self.Resize(FrAm);
    for I:=0 to FrAm-1 do
    begin
        read(F,DotAm);
        SetLength(self.Arr[i],DotAm);
        self.DotsAm[I] :=DotAm;
        for J:=0 to DotAm-1 do
        begin
          read(F,self.Arr[I,J,0]);
          read(F,self.Arr[I,J,1]);
        end;
    end;


    CloseFile(F);
end;

procedure TFrames.Resize(Fr: Integer);
var I:Integer;
begin
    SetLength(Self.Arr, Fr);
    SetLength(Self.DotsAm, Fr);
    self.FrAm:=Fr;
    for  I:=0 to Fr-1 do
      Self.DotsAm[I] := 0;
end;

procedure TFrames.SaveToFile(Filename: string);
var F:TextFile;
    I,J:Integer;
begin
    AssignFile(F, Filename);
    ReWrite(F);
    writeln(F,FrAm);
    for I:=0 to FrAm-1 do
    begin
        writeln(F,DotsAm[I]);
        for J:=0 to self.DotsAm[I]-1 do
        begin
          writeln(F,self.Arr[I,J,0],' ',self.Arr[I,J,1]) ;
          //writeln(F,self.Arr[I,J,1]);
        end;
    end;


    CloseFile(F);
end;

function TFrames.ToString: string;
begin

end;

{ Array }

procedure ZeroArray(var Arr:array of Real); overload;
var I:integer;
begin
    for I:=0 to Length(Arr)-1 do
    begin
      Arr[I]:=0;
    end;
end;

procedure ZeroArray(var Arr:array of integer); overload;
var I:integer;
begin
    for I:=0 to Length(Arr)-1 do
    begin
      Arr[I]:=0;
    end;
end;

procedure SetArray(var Arr:array of real; Val:real); overload;
var I:integer;
begin
    for I:=0 to Length(Arr)-1 do
    begin
      Arr[I]:=Val;
    end;
end;

procedure SetArray(var Arr:array of integer; Val:integer); overload;
var I:integer;
begin
    for I:=0 to Length(Arr)-1 do
    begin
      Arr[I]:=Val;
    end;
end;

function CopyPicArr(var Sourse:TPicArr):TPicArr;
var I,J:integer;
begin
  SetLength(Result,Length(Sourse));
  for I:=0 to Length(Sourse)-1 do
  begin
    SetLength(Result[I],Length(Sourse[I]));
    for J:=0 to Length(Sourse[I])-1 do
    begin
      Result[i,j,0]:=Sourse[i,j,0];
      Result[i,j,1]:=Sourse[i,j,1];
      Result[i,j,2]:=Sourse[i,j,2];
    end;
  end;

end;


procedure LoadJpegToBitmap(Filename:string; var Bit:TBitmap);
var
  JPEG: TJPEGImage;
begin
    JPEG := TJPEGImage.Create;
    JPEG.LoadFromFile(Filename);
    Bit.Assign(JPEG);
    JPEG.Free;
end;

procedure FromArrToPic(Img: Tbitmap; var PicArr: TPicArr);
var
  I,J:Integer;
  SX,SY:Integer;
  R,G,B:Integer;
begin
  SX := length(PicArr);
  SY := Length(PicArr[0]);
  Img.Width:=SX;
  Img.Height:=SY;
  //SetLength(Result,SX);
  for I:=0 to SX-1 do
    for J:=0 to SY-1 do
    begin
         //Color := ColorToRGB(Img.Canvas.Pixels[I,J]);  //////////////////////
         R:=PicArr[I,J][0];
         G:=PicArr[I,J][1];
         B:=PicArr[I,J][2];
         if R > 254 then R:=254;
         if G > 254 then G:=254;
         if B > 254 then B:=254;
         if R < 0 then R:=0;
         if B < 0 then B:=0;
         if G < 0 then G:=0;
         Img.Canvas.Pixels[I,J] := R or (G shl 8) or (B shl 16);
    end;
end;

function CheckSqare(var Arr:TPicArr; X,Y : integer; Sett:Tsettings):real;
var
   Sum1,Sum2,Sum3,Sum4 : array[0..2] of Real;
   diff : array[0..5] of Real;
   LI,LJ:Integer;
   H:integer;

begin
    H:=Sett.H;
    Sum1[0]:=0.01; //change to if
    Sum1[1]:=0.01;
    Sum1[2]:=0.01;
    Sum2[0]:=0.01;
    Sum2[1]:=0.01;
    Sum2[2]:=0.01;
    Sum3[0]:=0.01;
    Sum3[1]:=0.01;
    Sum3[2]:=0.01;
    Sum4[0]:=0.01;
    Sum4[1]:=0.01;
    Sum4[2]:=0.01;
    diff[0]:=0;
    diff[1]:=0;
    diff[2]:=0;
    diff[3]:=0;
    diff[4]:=0;
    diff[5]:=0;
//    result:=0;

    for LI:=X - H to X do
     for LJ:=Y - H to Y do
      begin
          Sum1[0] := Sum1[0]+Arr[LI,LJ,0];
          Sum1[1] := Sum1[1]+Arr[LI,LJ,1];
          Sum1[2] := Sum1[2]+Arr[LI,LJ,2];
      end;

    for LI:=X to X+H do
     for LJ:=Y - H to Y do
      begin
          Sum2[0] := Sum2[0]+Arr[LI,LJ,0];
          Sum2[1] := Sum2[1]+Arr[LI,LJ,1];
          Sum2[2] := Sum2[2]+Arr[LI,LJ,2];
      end;

    for LI:=X to X+H do
     for LJ:=Y - H to Y do
     begin
          Sum3[0] := Sum3[0]+Arr[LI,LJ,0];
          Sum3[1] := Sum3[1]+Arr[LI,LJ,1];
          Sum3[2] := Sum3[2]+Arr[LI,LJ,2];
      end;

    for LI:=X to X+H do
     for LJ:=Y to Y+H do
      begin
          Sum4[0] := Sum4[0]+Arr[LI,LJ,0];
          Sum4[1] := Sum4[1]+Arr[LI,LJ,1];
          Sum4[2] := Sum4[2]+Arr[LI,LJ,2];
      end;

    diff[0] :=           abs(sum1[0] - sum2[0]) / (sum1[0] + sum2[0]);
    diff[0] := diff[0] + abs(sum1[1] - sum2[1]) / (sum1[1] + sum2[1]);
    diff[0] := diff[0] + abs(sum1[2] - sum2[2]) / (sum1[2] + sum2[2]);

    diff[1] :=           abs(sum2[0] - sum3[0]) / (sum2[0] + sum3[0]);
    diff[1] := diff[1] + abs(sum2[1] - sum3[1]) / (sum2[1] + sum3[1]);
    diff[1] := diff[1] + abs(sum2[2] - sum3[2]) / (sum2[2] + sum3[2]);


    diff[2] :=           abs(sum3[0] - sum4[0]) / (sum3[0] + sum4[0]);
    diff[2] := diff[2] + abs(sum3[1] - sum4[1]) / (sum3[1] + sum4[1]);
    diff[2] := diff[2] + abs(sum3[2] - sum4[2]) / (sum3[2] + sum4[2]);

    diff[3] :=           abs(sum4[0] - sum1[0]) / (sum4[0] + sum1[0]);
    diff[3] := diff[3] + abs(sum4[1] - sum1[1]) / (sum4[1] + sum1[1]);
    diff[3] := diff[3] + abs(sum4[2] - sum1[2]) / (sum4[2] + sum1[2]);

    diff[4] :=           abs(sum2[0] - sum4[0]) / (sum2[0] + sum4[0]);
    diff[4] := diff[4] + abs(sum2[1] - sum4[1]) / (sum2[1] + sum4[1]);
    diff[4] := diff[4] + abs(sum2[2] - sum4[2]) / (sum2[2] + sum4[2]);

    diff[5] :=           abs(sum1[0] - sum3[0]) / (sum1[0] + sum3[0]);
    diff[5] := diff[5] + abs(sum1[1] - sum3[1]) / (sum1[1] + sum3[1]);
    diff[5] := diff[5] + abs(sum1[2] - sum3[2]) / (sum1[2] + sum3[2]);

    Result:= (diff[0]+diff[1]+diff[2]+diff[3]+diff[4]+diff[5]);
end;

function CutDotsTo(var Dots: TFrameArr; Amount: Integer): TFrameArr;
var
  I,J:Integer;
  Dot:array[0..2] of Integer;
begin
    Dot[2]:=0;
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
    SetLength(Dots,Amount); ///////////////////////////////////////
end;

function Hash(var Arr:TPicArr; Sett:Tsettings):TFrameArr;
var
    I,J:Integer;
    MaxDot : Integer;
    center: TPoint;
    porog : Real;
    res : real;
    Size:TPoint;
    S:Integer;
    MaxRes:Real;
    //SomeI:Integer;
begin
    //TextDBMan.TempLog[0]:=TStringList.Create;
    SetLength(Result,6000);
    Size.x := Length(arr);
    Size.Y := Length(Arr[0]);
    center.X:=Size.X div 2;
    center.Y :=Size.Y div 2;
    S:=Sett.S;
    porog :=Sett.P;
    MaxDot:=0;
    MaxRes:=0;

    for I:=(30 div S) to ((Size.X-30) div S) do
    begin
      for J:=(30 div S) to ((Size.Y-30) div S) do
      begin
        Res := CheckSqare(Arr,I*S,J*S,Sett);
        if res<0.0001 then
        begin
          //
         // TextDBMan.LogTo(IntToStr(S)+'+'+IntToStr(I)+'|'+IntToStr(J)+'='+IntToStr(iter)+'-'+FloatToStr(res));
        end;
        if res>MaxRes then
          MaxRes:=res;
        if res > porog then
        begin
          Result[MaxDot][0]:=I*S - center.X;
          Result[MaxDot][1]:=J*S - center.Y;
          try
          Result[MaxDot][2]:=Trunc(res*1000);
          except
              showmessage(inttostr(MaxDot));
          end;
          MaxDot:=MaxDot+1;

        end;
      end;
    end;
    SetLength(Result,MaxDot);
    CutDotsTo(Result,400);

end;


{ TFramesBits }

function TFramesBits.Check(FrameR: TframeArr): Real;
var
  I:integer;
  Sum:Integer;
  Len:Integer;
begin
  sum:=0;
  for I:=0 to length(FrameR)-1 do
  begin
      if TestBitOfBit[FrameR[I,0]+320][FrameR[I,1]+180] then inc(Sum);
  end;
  Len:=length(FrameR);
  result:=Sum/len;
end;

function TFramesBits.Check2Frames(FrameL, FrameR: TFrameArr): Real;
var
  BitL,BitR:TFramesBits;
  ResL,ResR:Real;
begin
  BitL.FillBits(FrameL);
  BitR.FillBits(FrameR);
  ResL:=BitL.Check(FrameR);
  ResR:=BitR.Check(FrameL);
  result:=(ResL+ResR) / 2;
end;


function Chech2Bits(var FRl,FRR:TFrameArr; BitL,BitR:TFramesBits):real;
var
  ResL,ResR:Real;
begin
  ResL:=BitL.Check(FRR);
  ResR:=BitR.Check(FRL);
  result:=(ResL+ResR) / 2;
end;


constructor TFramesBits.Create;
var
  I:integer;
begin
  for I:=0 to 639 do
  begin
     Self.TestBitOfBit[i]:=TBits.Create;
     Self.TestBitOfBit[i].Size:=360;
  end;

end;



destructor TFramesBits.Destroy;
var
  I: Integer;
begin
  for I := 0 to 639 do
    self.TestBitOfBit[i].Free;
end;

procedure TFramesBits.FillBits(FrameL: TFrameArr);
var
  M,I,J:integer;
  Cx,Cy:Integer;
begin
   SizeX:=640;
   SizeY:=360;
   for M:=0 to length(FrameL)-1 do
   begin
        for I:=-12 to +12 do
         for J:=-(12-abs(i)) to (12-abs(i)) do
         begin
           CX:=FrameL[M,0] + I + 320;
           CY:=FrameL[M,1] + J + 180;
           TestBitOfBit[CX][CY]:=True;
         end;
   end;
end;




end.
