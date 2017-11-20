unit ImageImproveMeth;

interface

uses BaseTypes;

type
  TIIAlgContainer = class
      Matrixes:array[0..10] of array[0..50] of Real;
      MatrixAm:integer;
  end;

  TIIAlg = class
      Name:string;
      Id:Integer;
      procedure Made(var From,ToWhat:TPicArr);virtual;abstract;
  end;

  TIIAlgEqalise = class(TiiAlg)
      procedure Made(var From,ToWhat:TPicArr);override;
  end;

  TIIAlgNormalize = class(TiiAlg)  //sohranatsa li soonoshenia
      Range:Byte;
      procedure Made(var From,ToWhat:TPicArr);override;
  end;

  TIIAlgSteper = class(TiiAlg)
      Range:Byte;
      procedure Made(var From,ToWhat:TPicArr);override;
  end;

  TIIAlgMatrix = class(TiiAlg)  //test Round, test offst on pixel
      Matrix: array[0..24] of Real;
      Size:Byte;
      CurrentMatrix:integer;
      AlgCont:TIIAlgContainer;
      procedure Made(var From,ToWhat:TPicArr);override;
      procedure LoadMatrix(Index:Integer);
      constructor Create(AlgCon:TIIAlgContainer);
  end;

  TIIAlgRED = class(TIIAlg)
     treshold:Real;
     Sqare:integer;
     procedure Made(var From,ToWhat:TPicArr);override;
  end;

  TIIGreyScale = class(TIIAlg)
      AlgType:integer;
     procedure Made(var From,ToWhat:TPicArr);override;
  end;

  TIIAlgSQR = class(TIIAlg)
     AlgType:integer;
     procedure Made(var From,ToWhat:TPicArr);override;
  end;

  TIIAlgBrightTo = class(TiiAlg)
      procedure Made(var From,ToWhat:TPicArr);override;
  end;

  TIIAlgRedClear = class(TIIAlg)
     treshold:Real;
     Sqare:integer;
     procedure Made(var From,ToWhat:TPicArr);override;
  end;

  TIIAlgRGB = class(TIIAlg)
     treshold:Real;
     Sqare:integer;
     procedure Made(var From,ToWhat:TPicArr);override;
  end;

  TIIAlgRGBClear = class(TIIAlg)
     treshold:Real;
     Sqare:integer;
     procedure Made(var From,ToWhat:TPicArr);override;
  end;

  TIIAlgBrightChange = class(TIIAlg)
     Amount:Real;
     Sqare:integer;
     procedure Made(var From,ToWhat:TPicArr);override;
  end;

  TIIAlgBrightChangeTo = class(TIIAlg)
     //Amount:Real;
     //Sqare:integer;
     targetbright:integer;
     procedure Made(var From,ToWhat:TPicArr);override;
  end;

  TIIAlgBrightChangeAdaptive = class(TIIAlg)
     Amount:Real;
     Sqare:integer;
     procedure Made(var From,ToWhat:TPicArr);override;
  end;

  TIIAlgSimpleBinary = class(TIIAlg)
     Treshold:real;
     procedure Made(var From,ToWhat:TPicArr);override;
  end;

  TIIAlgSimpleResize = class(TIIAlg)
     SizeEq:real;
     procedure Made(var From,ToWhat:TPicArr);override;
  end;

  TPictureCheckAlg = class
      name:string;
      Id:integer;
      function Check(PicL,PicR:TPicArr):real; virtual;abstract;
  end;

  TPCAColorSqareDif = class(TPictureCheckAlg)
      Sqare:integer;
      function Check(PicL,PicR:TPicArr):real; override;
  end;

implementation

{ TIIAlgeqalise }

procedure TIIAlgeqalise.Made(var From, ToWhat: TPicArr);
var
  hR: array [0 .. 255] of double;
  hG: array [0 .. 255] of double;
  hB: array [0 .. 255] of double;
  i, j: word;
  K:Integer;
begin
  K:=255;
  inherited;
  for i := 0 to k do
  begin
    hR[i] := 0;
     hG[i] := 0;
      hb[i] := 0;
  end;
  for i := 0 to Length(From) - 1 do
    for j := 0 to Length(From[0]) - 1 do
    begin
      hR[From[i, j, 0]] := hr[From[i, j, 0]] + 1;
       hG[From[i, j, 1]] := hg[From[i, j, 1]] + 1;
        hB[From[i, j, 2]] := hb[From[i, j, 2]] + 1;
    end;
  for i := 0 to k do
  begin
    hR[i] := hR[i] / (Length(From) * Length(From[0]));
    hG[i] := hG[i] / (Length(From) * Length(From[0]));
    hB[i] := hB[i] / (Length(From) * Length(From[0]));
  end;

  for i := 1 to k do
  begin
    hR[i] := hR[i - 1] + hR[i];
    hG[i] := hg[i - 1] + hg[i];
    hB[i] := hb[i - 1] + hb[i];
  end;
  for i := 0 to Length(From) - 1 do
    for j := 0 to Length(From[0]) - 1 do
    begin
      ToWhat[i, j,0] := Trunc(K*hr[From[i, j, 0]]);
      ToWhat[i, j,1] := Trunc(K*hg[From[i, j, 1]]);
      ToWhat[i, j,2] := Trunc(K*hb[From[i, j, 2]]);
      //ToWhat[i, j, col] := Trunc(h[From[i, j, col]]);
    end;
end;

{ TIIAlgMatrix }

constructor TIIAlgMatrix.Create(AlgCon:TIIAlgContainer);
begin
    self.CurrentMatrix:=-1;
    self.AlgCont:=AlgCon;
end;

procedure TIIAlgMatrix.LoadMatrix(Index: Integer);
const
  Matrix1 : array[0..8] of real = (1/16,2/16,1/16,2/16,  4/16,  2/16,1/16,2/16,1/16); //3x3
  Matrix2 : array[0..8] of real = (-0.1,-0.1,-0.1,-0.1,  2,  -0.1,-0.1,-0.1,-0.1);
  Matrix3 : array[0..8] of real = (-1,-1,-1,-1,  9,  -1,-1,-1,-1);
  Matrix3n : array[0..8] of real = (-1,-1,-1,-1, 9 ,-1,-1,-1,-1); //? \9

  Matrix51 : array[0..24] of real = (1,0,2,0,1, 0,0,0,0,0,2,0,4,0,2,0,0,0,0,0,1,0,2,0,1); //5x5
  Matrix51n : array[0..24] of real = (1/16,0,2/16,0,1/16, 0,0,0,0,0,2/16,0,4/16,0,2/16,0,0,0,0,0,1/16,0,2/16,0,1/16); //5x5
  Matrix52 : array[0..24] of real = (-0.1,0,-0.1,0,-0.1,0,0,0,0,0,-0.1,0,2,0,-0.1,0,0,0,0,0,-0.1,0,-0.1,0,-0.1);
  Matrix53 : array[0..24] of real = (-0.1,0,-0.1,0,-0.1,0.1,0.1,0.1,0.1,0.1,-0.1,0.1, 1.3 ,0.1,-0.1,0.1,0.1,0.1,0.1,0.1,-0.1,0,-0.1,0,-0.1);
var I:Integer;
begin
  CASE Index of
    0: begin
      for I:=0 to 8 do
        SELF.Matrix[i]:=Matrix1[i];
      Self.Size:=1;
    end;
    1: begin
      for I:=0 to 8 do
        SELF.Matrix[i]:=Matrix2[i];
      Self.Size:=1;
    end;
    2: begin
      for I:=0 to 8 do
        SELF.Matrix[i]:=Matrix3[i];
      Self.Size:=1;
    end;
    3: begin
      for I:=0 to 8 do
        SELF.Matrix[i]:=Matrix3n[i];
      Self.Size:=1;
    end;
    4: begin
      for I:=0 to 24 do
        SELF.Matrix[i]:=Matrix51[i];
      Self.Size:=2;
    end;
    5: begin
      for I:=0 to 24 do
        SELF.Matrix[i]:=Matrix51n[i];
      Self.Size:=2;
    end;
    6: begin
      for I:=0 to 24 do
        SELF.Matrix[i]:=Matrix52[i];
      Self.Size:=2;
    end;
    7: begin
      for I:=0 to 24 do
        SELF.Matrix[i]:=Matrix53[i];
      Self.Size:=2;
    end;
  end;
end;

procedure TIIAlgMatrix.Made(var From, ToWhat: TPicArr);
var
  i, j: Integer;
  R,G,B:Integer;
begin
  inherited;
  if Size = 1 then
  for I:=Size to Length(From)-size-1 do
    for J:=Size to Length(From[0])-Size-1 do
    begin
        R:=0;
        G:=0;
        B:=0;

        R:=Trunc(R+From[I-1,J-1,0]*self.matrix[0]);
        G:=Trunc(G+From[I-1,J-1,1]*self.matrix[0]);
        B:=Trunc(B+From[I-1,J-1,2]*self.matrix[0]);

        R:=Trunc(R+From[I-1,J,0]*self.matrix[1]);
        G:=Trunc(G+From[I-1,J,1]*self.matrix[1]);
        B:=Trunc(B+From[I-1,J,2]*self.matrix[1]);

        R:=Trunc(R+From[I-1,J+1,0]*self.matrix[2]);
        G:=Trunc(G+From[I-1,J+1,1]*self.matrix[2]);
        B:=Trunc(B+From[I-1,J+1,2]*self.matrix[2]);

        R:=Trunc(R+From[I,J-1,0]*self.matrix[3]);
        G:=Trunc(G+From[I,J-1,1]*self.matrix[3]);
        B:=Trunc(B+From[I,J-1,2]*self.matrix[3]);

        R:=Trunc(R+From[I,J,0]*self.matrix[4]);
        G:=Trunc(G+From[I,J,1]*self.matrix[4]);
        B:=Trunc(B+From[I,J,2]*self.matrix[4]);

        R:=Trunc(R+From[I,J+1,0]*self.matrix[5]);
        G:=Trunc(G+From[I,J+1,1]*self.matrix[5]);
        B:=Trunc(B+From[I,J+1,2]*self.matrix[5]);

        R:=Trunc(R+From[I+1,J-1,0]*self.matrix[6]);
        G:=Trunc(G+From[I+1,J-1,1]*self.matrix[6]);
        B:=Trunc(B+From[I+1,J-1,2]*self.matrix[6]);

        R:=Trunc(R+From[I+1,J,0]*self.matrix[7]);
        G:=Trunc(G+From[I+1,J,1]*self.matrix[7]);
        B:=Trunc(B+From[I-1,J,2]*self.matrix[7]);

        R:=Trunc(R+From[I+1,J+1,0]*self.matrix[8]);
        G:=Trunc(G+From[I+1,J+1,1]*self.matrix[8]);
        B:=Trunc(B+From[I+1,J+1,2]*self.matrix[8]);

        if R>255 then R:=255;
        if G>255 then G:=255;
        if B>255 then B:=255;

        if R<0 then R:=0;
        if G<0 then G:=0;
        if B<0 then B:=0;


        ToWhat[I+1,J+1,0]:=R;
        ToWhat[I+1,J+1,1]:=G;
        ToWhat[I+1,J+1,2]:=B;
    end;
    if Size = 2 then
    for I:=Size to Length(From)-size-1 do
    for J:=Size to Length(From[0])-Size-1 do
    begin               ///SOME CHINEEESE CODE MF !
        R:=0;
        G:=0;
        B:=0;

        R:=Trunc(R+From[I-2,J-2,0]*self.matrix[0]);  // 1 row
        G:=Trunc(G+From[I-2,J-2,1]*self.matrix[0]);
        B:=Trunc(B+From[I-2,J-2,2]*self.matrix[0]);

        R:=Trunc(R+From[I-2,J-1,0]*self.matrix[1]);
        G:=Trunc(G+From[I-2,J-1,1]*self.matrix[1]);
        B:=Trunc(B+From[I-2,J-1,2]*self.matrix[1]);

        R:=Trunc(R+From[I-2,J,0]*self.matrix[2]);
        G:=Trunc(G+From[I-2,J,1]*self.matrix[2]);
        B:=Trunc(B+From[I-2,J,2]*self.matrix[2]);

        R:=Trunc(R+From[I-2,J+1,0]*self.matrix[3]);
        G:=Trunc(G+From[I-2,J+1,1]*self.matrix[3]);
        B:=Trunc(B+From[I-2,J+1,2]*self.matrix[3]);

        R:=Trunc(R+From[I-2,J+2,0]*self.matrix[4]);
        G:=Trunc(G+From[I-2,J+2,1]*self.matrix[4]);
        B:=Trunc(B+From[I-2,J+2,2]*self.matrix[4]);

        R:=Trunc(R+From[I-1,J-2,0]*self.matrix[5]);  // 1 row
        G:=Trunc(G+From[I-1,J-2,1]*self.matrix[5]);
        B:=Trunc(B+From[I-1,J-2,2]*self.matrix[5]);

        R:=Trunc(R+From[I-1,J-1,0]*self.matrix[6]);
        G:=Trunc(G+From[I-1,J-1,1]*self.matrix[6]);
        B:=Trunc(B+From[I-1,J-1,2]*self.matrix[6]);

        R:=Trunc(R+From[I-1,J,0]*self.matrix[7]);
        G:=Trunc(G+From[I-1,J,1]*self.matrix[7]);
        B:=Trunc(B+From[I-1,J,2]*self.matrix[7]);

        R:=Trunc(R+From[I-1,J+1,0]*self.matrix[8]);
        G:=Trunc(G+From[I-1,J+1,1]*self.matrix[8]);
        B:=Trunc(B+From[I-1,J+1,2]*self.matrix[8]);

        R:=Trunc(R+From[I-1,J+2,0]*self.matrix[9]);
        G:=Trunc(G+From[I-1,J+2,1]*self.matrix[9]);
        B:=Trunc(B+From[I-1,J+2,2]*self.matrix[9]);

        R:=Trunc(R+From[I,J-2,0]*self.matrix[10]);  // 3 row
        G:=Trunc(G+From[I,J-2,1]*self.matrix[10]);
        B:=Trunc(B+From[I,J-2,2]*self.matrix[10]);

        R:=Trunc(R+From[I,J-1,0]*self.matrix[11]);
        G:=Trunc(G+From[I,J-1,1]*self.matrix[11]);
        B:=Trunc(B+From[I,J-1,2]*self.matrix[11]);

        R:=Trunc(R+From[I,J,0]*self.matrix[12]);
        G:=Trunc(G+From[I,J,1]*self.matrix[12]);
        B:=Trunc(B+From[I,J,2]*self.matrix[12]);

        R:=Trunc(R+From[I,J+1,0]*self.matrix[13]);
        G:=Trunc(G+From[I,J+1,1]*self.matrix[13]);
        B:=Trunc(B+From[I,J+1,2]*self.matrix[13]);

        R:=Trunc(R+From[I,J+2,0]*self.matrix[14]);
        G:=Trunc(G+From[I,J+2,1]*self.matrix[14]);
        B:=Trunc(B+From[I,J+2,2]*self.matrix[14]);

        R:=Trunc(R+From[I+1,J-2,0]*self.matrix[15]);  // 4 row
        G:=Trunc(G+From[I+1,J-2,1]*self.matrix[15]);
        B:=Trunc(B+From[I+1,J-2,2]*self.matrix[15]);

        R:=Trunc(R+From[I+1,J-1,0]*self.matrix[16]);
        G:=Trunc(G+From[I+1,J-1,1]*self.matrix[16]);
        B:=Trunc(B+From[I+1,J-1,2]*self.matrix[16]);

        R:=Trunc(R+From[I+1,J,0]*self.matrix[17]);
        G:=Trunc(G+From[I+1,J,1]*self.matrix[17]);
        B:=Trunc(B+From[I+1,J,2]*self.matrix[17]);

        R:=Trunc(R+From[I+1,J+1,0]*self.matrix[18]);
        G:=Trunc(G+From[I+1,J+1,1]*self.matrix[18]);
        B:=Trunc(B+From[I+1,J+1,2]*self.matrix[18]);

        R:=Trunc(R+From[I+1,J+2,0]*self.matrix[19]);
        G:=Trunc(G+From[I+1,J+2,1]*self.matrix[19]);
        B:=Trunc(B+From[I+1,J+2,2]*self.matrix[19]);

        R:=Trunc(R+From[I+2,J-2,0]*self.matrix[20]);  // 5 row
        G:=Trunc(G+From[I+2,J-2,1]*self.matrix[20]);
        B:=Trunc(B+From[I+2,J-2,2]*self.matrix[20]);

        R:=Trunc(R+From[I+2,J-1,0]*self.matrix[21]);
        G:=Trunc(G+From[I+2,J-1,1]*self.matrix[21]);
        B:=Trunc(B+From[I+2,J-1,2]*self.matrix[21]);

        R:=Trunc(R+From[I+2,J,0]*self.matrix[22]);
        G:=Trunc(G+From[I+2,J,1]*self.matrix[22]);
        B:=Trunc(B+From[I+2,J,2]*self.matrix[22]);

        R:=Trunc(R+From[I+2,J+1,0]*self.matrix[23]);
        G:=Trunc(G+From[I+2,J+1,1]*self.matrix[23]);
        B:=Trunc(B+From[I+2,J+1,2]*self.matrix[23]);

        R:=Trunc(R+From[I+2,J+2,0]*self.matrix[24]);
        G:=Trunc(G+From[I+2,J+2,1]*self.matrix[24]);
        B:=Trunc(B+From[I+2,J+2,2]*self.matrix[24]);

        if R>255 then R:=255;
        if G>255 then G:=255;
        if B>255 then B:=255;

        if R<0 then R:=0;
        if G<0 then G:=0;
        if B<0 then B:=0;

        ToWhat[I+1,J+1,0]:=R;
        ToWhat[I+1,J+1,1]:=G;
        ToWhat[I+1,J+1,2]:=B;
    end;

end;

{ TIIAlgSteper }

procedure TIIAlgSteper.Made(var From, ToWhat: TPicArr);
var
  i,j: Integer;
  R,G,B:Integer;
begin
  inherited;

  for I:=0 to Length(From)-1 do
    for J:=0 to Length(From[0])-1 do
    begin
      R:=(From[i,j,0] div range)*range;
      G:=(From[i,j,1] div range)*range;
      B:=(From[i,j,2] div range)*range;
      ToWhat[i,j,0]:=R;
      ToWhat[i,j,1]:=G;
      ToWhat[i,j,2]:=B;
    end;
end;

{ TIIAlgNormalize }

procedure TIIAlgNormalize.Made(var From, ToWhat: TPicArr);
var
  MaxR,MaxG,MaxB:Integer;
  Max:integer;
  i,j:Integer;
begin
  Max:=250;
  MaxR:=0;
  MaxG:=0;
  MaxB:=0;
  for I:=0 to Length(From)-1 do
    for J:=0 to Length(From[0])-1 do
    begin
      if From[i,j,0] > MaxR then MaxR:=From[i,j,0];
      if From[i,j,1] > MaxG then MaxG:=From[i,j,1];
      if From[i,j,2] > MaxB then MaxB:=From[i,j,2];
    end;
  for I:=0 to Length(From)-1 do
    for J:=0 to Length(From[0])-1 do
    begin
       ToWhat[i,j,0] := trunc((From[i,j,0] / MaxR) * Max);
       ToWhat[i,j,1] := trunc((From[i,j,1] / MaxR) * Max);
       ToWhat[i,j,2] := trunc((From[i,j,2] / MaxR) * Max);
    end;
end;

{ TIIAlgRED }
procedure TIIAlgRED.Made(var From, ToWhat: TPicArr);
var
I,J, K,L:integer;
RedAm:int64;
GreenAm:int64;
RG:Real;
LX,LY:Integer;
begin
  inherited;
  LX:=(Length(From)-1) div Sqare;
  LY:=(Length(From[0])-1) div Sqare;
  for I:=0 to LX-1 do
      for J:=0 to LY-1 do
      begin
          RedAm:=0;
          GreenAm:=0;
          for K:=0 to Sqare-1 do
            for L:=0 to Sqare-1 do
            begin

                 RedAm:=RedAm+from[i*sqare+k,j*sqare+L][0];
                 GreenAm:=GreenAm+from[i*sqare+k,j*sqare+L][1];
            end;

          if GreenAm > 5 then
          begin
          RG:=RedAm/GreenAm;
          if RG > treshold then
            for K:=0 to Sqare-1 do
            for L:=0 to Sqare-1 do
            begin
                 ToWhat[i*sqare+k,j*sqare+L][0]:=250;
                 ToWhat[i*sqare+k,j*sqare+L][1]:=0;
                 ToWhat[i*sqare+k,j*sqare+L][2]:=0;
            end;
          end;
      end;

end;

{ TIIGreyScale }

procedure TIIGreyScale.Made(var From, ToWhat: TPicArr);
var I,J,NCol:integer;
begin
  inherited;
  for I:=0 to Length(From)-1 do
    for J:=0 to Length(From[0])-1 do
    begin
      case self.AlgType of
      0:Ncol:=trunc((FROM[i,j][0]+From[I,J][1]+From[I,J][2])/3);
      1:Ncol:=trunc(0.2126*FROM[i,j][0]+0.7152*From[I,J][1]+0.0722*From[I,J][2]);
      2:Ncol:=trunc(0.299*FROM[i,j][0]+0.587*From[I,J][1]+0.114*From[I,J][2]);
      3:Ncol:=trunc(sqrt(0.299*sqr(FROM[i,j][0])+0.587*sqr(From[I,J][1])+0.114*sqr(From[I,J][2])));
      else Ncol:=0;
      end;

      ToWhat[i,j][0]:=0;
      ToWhat[i,j][1]:=Ncol;
      ToWhat[i,j][2]:=0;
    end;
end;

{ TIIAlgSQR }

procedure TIIAlgSQR.Made(var From, ToWhat: TPicArr);
var I,J, Col:integer;
begin
  inherited;
  for I:=0 to Length(From)-1 do
    for J:=0 to Length(From[0])-1 do
    begin
      case self.AlgType of
      1:
      begin
        ToWhat[i,j,0]:=trunc(sqr(FROM[i,j,0]/255)*255);
        ToWhat[i,j,1]:=trunc(sqr(FROM[i,j,1]/255)*255);
        ToWhat[i,j,2]:=trunc(sqr(FROM[i,j,2]/255)*255);
      end;
      2:
      begin
        ToWhat[i,j,0]:=trunc(sqrt(FROM[i,j,0]/255)*255);
        ToWhat[i,j,1]:=trunc(sqrt(FROM[i,j,1]/255)*255);
        ToWhat[i,j,2]:=trunc(sqrt(FROM[i,j,2]/255)*255);
      end;
      3:
      begin
        Col:=(FROM[i,j,0]+FROM[i,j,1]+FROM[i,j,2]) div 3;
        ToWhat[i,j,0]:=trunc(FROM[i,j,0] * sqr(Col/255));
        ToWhat[i,j,1]:=trunc(FROM[i,j,1] * sqr(Col/255));
        ToWhat[i,j,2]:=trunc(FROM[i,j,2] * sqr(Col/255));
      end;
      4:
      begin
        Col:=(FROM[i,j,0]+FROM[i,j,1]+FROM[i,j,2]) div 3;
        ToWhat[i,j,0]:=trunc(FROM[i,j,0] * sqrt(Col/255));
        ToWhat[i,j,1]:=trunc(FROM[i,j,1] * sqrt(Col/255));
        ToWhat[i,j,2]:=trunc(FROM[i,j,2] * sqrt(Col/255));
      end;
    end;
end;

end;

{ TIIAlgRedClear }

procedure TIIAlgRedClear.Made(var From, ToWhat: TPicArr);
var
I,J, K,L:integer;
RedAm:int64;
GreenAm:int64;
RG:Real;
LX,LY:Integer;
begin
  inherited;
  LX:=(Length(From)-1) div Sqare;
  LY:=(Length(From[0])-1) div Sqare;
  for I:=0 to LX-1 do
      for J:=0 to LY-1 do
      begin
          for K:=0 to Sqare-1 do
            for L:=0 to Sqare-1 do
            begin
                 ToWhat[i*sqare+k,j*sqare+L][0]:=0;
                 ToWhat[i*sqare+k,j*sqare+L][1]:=0;
                 ToWhat[i*sqare+k,j*sqare+L][2]:=0;
            end;
          RedAm:=0;
          GreenAm:=0;
          for K:=0 to Sqare-1 do
            for L:=0 to Sqare-1 do
            begin

                 RedAm:=RedAm+from[i*sqare+k,j*sqare+L][0];
                 GreenAm:=GreenAm+from[i*sqare+k,j*sqare+L][1];
            end;

          if GreenAm > 5 then
          begin
          RG:=RedAm/GreenAm;
          if RG > treshold then
            for K:=0 to Sqare-1 do
            for L:=0 to Sqare-1 do
            begin
                 ToWhat[i*sqare+k,j*sqare+L][0]:=250;
                 ToWhat[i*sqare+k,j*sqare+L][1]:=0;
                 ToWhat[i*sqare+k,j*sqare+L][2]:=0;
            end;
          end;
      end;

end;

{ TIIAlgRGB }

procedure TIIAlgRGB.Made(var From, ToWhat: TPicArr);
var
I,J, K,L:integer;
RedAm:int64;
GreenAm:int64;
BlueAm:int64;
RG,GB,BR:Real;
RGCur:real;
LX,LY:Integer;
begin
  inherited;
  LX:=(Length(From)-1) div Sqare;
  LY:=(Length(From[0])-1) div Sqare;
  for I:=0 to LX-1 do
      for J:=0 to LY-1 do
      begin
          RedAm:=0;
          GreenAm:=0;
          BlueAm:=0;
          for K:=0 to Sqare-1 do
            for L:=0 to Sqare-1 do
            begin
                 RedAm:=RedAm+from[i*sqare+k,j*sqare+L][0];
                 GreenAm:=GreenAm+from[i*sqare+k,j*sqare+L][1];
                 BlueAm:=BlueAm+from[i*sqare+k,j*sqare+L][2];
            end;

          if (GreenAm+blueAm) > 5 then
            RG:=2*RedAm/(GreenAm+blueAm) else RG:=2;
          if (BlueAm+RedAm) > 5 then
            GB:=2*GreenAm/(BlueAm+RedAm) else GB:=2;
          if (RedAm+GreenAm) > 5 then
            BR:=1.4*BlueAm/(RedAm+GreenAm) else BR:=2;

          if RG > treshold then
            for K:=0 to Sqare-1 do
            for L:=0 to Sqare-1 do
            begin
                 ToWhat[i*sqare+k,j*sqare+L][0]:=250;
                 ToWhat[i*sqare+k,j*sqare+L][1]:=0;
                 ToWhat[i*sqare+k,j*sqare+L][2]:=0;
            end else

          if GB > treshold then
            for K:=0 to Sqare-1 do
            for L:=0 to Sqare-1 do
            begin
                 ToWhat[i*sqare+k,j*sqare+L][0]:=0;
                 ToWhat[i*sqare+k,j*sqare+L][1]:=250;
                 ToWhat[i*sqare+k,j*sqare+L][2]:=0;
            end else

          if BR > treshold then
            for K:=0 to Sqare-1 do
            for L:=0 to Sqare-1 do
            begin
                 ToWhat[i*sqare+k,j*sqare+L][0]:=0;
                 ToWhat[i*sqare+k,j*sqare+L][1]:=0;
                 ToWhat[i*sqare+k,j*sqare+L][2]:=250;
            end else

            for K:=0 to Sqare-1 do
            for L:=0 to Sqare-1 do
            begin
                 ToWhat[i*sqare+k,j*sqare+L][0]:=From[i*sqare+k,j*sqare+L][0];
                 ToWhat[i*sqare+k,j*sqare+L][1]:=From[i*sqare+k,j*sqare+L][1];
                 ToWhat[i*sqare+k,j*sqare+L][2]:=From[i*sqare+k,j*sqare+L][2];
            end;

      end;

end;

{ TIIAlgRGBClear }

procedure TIIAlgRGBClear.Made(var From, ToWhat: TPicArr);
begin
  inherited;

end;

{ TIIAlgBrightChange }

procedure TIIAlgBrightChange.Made(var From, ToWhat: TPicArr);
begin
  inherited;

end;

{ TIIAlgBrightChangeTo }

function CheckBright(var image:TPicArr):tvec6;
var
Br1:double;
  Br21:double;
  Brs1:double;
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

procedure TIIAlgBrightChangeTo.Made(var From, ToWhat: TPicArr);
var
  Lres:tvec6;
  ratio:Double;
  i,j:Integer;
begin
  Lres:=CheckBright(From);
  ratio:= self.targetbright / Lres[0];
  for I:=0 to Length(From)-1 do
    for J:=0 to Length(From[0])-1 do
    begin
         ToWhat[i,j,0]:=Trunc(From[i,j,0]*ratio);
         ToWhat[i,j,1]:=Trunc(From[i,j,1]*ratio);
         ToWhat[i,j,2]:=Trunc(From[i,j,2]*ratio);
    end;
end;

{ TIIAlgBrightChangeAdaptive }

procedure TIIAlgBrightChangeAdaptive.Made(var From, ToWhat: TPicArr);
begin
  inherited;

end;

{ TIIAlgSimpleBinary }

procedure TIIAlgSimpleBinary.Made(var From, ToWhat: TPicArr);
begin
  inherited;

end;

{ TIIAlgSimpleResize }

procedure TIIAlgSimpleResize.Made(var From, ToWhat: TPicArr);
begin
  inherited;

end;

{ TIIAlgBrightTo }

procedure TIIAlgBrightTo.Made(var From, ToWhat: TPicArr);
begin
  inherited;

end;


{ TPCAColorSqareDif }

function TPCAColorSqareDif.Check(PicL, PicR: TPicArr): real;
begin
    result:=0;
end;

end.
