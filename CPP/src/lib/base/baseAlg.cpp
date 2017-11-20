/*
 * baseAlg.hpp
 *
 *  Created on: Feb 10, 2017
 *      Author: victor
 */

#ifndef LIB_BASEALG_CPP_
#define LIB_BASEALG_CPP_


#include "baseAlg.hpp"


void CutDotsTo(std::array<int,10000*3> &result, Dots &dots,int sizeIn, int sizeOut)
{
	int max;
	for (int i=0; i<sizeOut; i++ )
	{
		max = result[0*3+2];   //[0,2] X,Y,DIFF
		int Jmax = 0;
		for (int j=0; j<sizeIn; j++)
		{
			if (result[j*3 + 2] > max)
			{
				Jmax = j;
				max = result[j*3 + 2];
			}
		}
		dots[i*3+0] = result[Jmax*3 + 0];
		dots[i*3+1] = result[Jmax*3 + 1];
		dots[i*3+2] = result[Jmax*3 + 2];
		result[Jmax*3 + 2] = 0;
	}

}


float Check2Hash(Dots DotsL,Dots DotsR)
{
	int Am=0;

	return Am/400;
}

float CheckDotsOnBit(Dots DotsL,FrameBits BitR)
{
	int Am=0;
	for (int i=0; i<400; i++) //try iterator or for .. in
	{
		//if (BitR[DotsL[i][0]][DotsL[i][1]])
		{Am++;};
	}
	return Am/400;

}

float CheckSqare(Frame &Arr,int X, int Y)
{
	//int lLU;
	//int lCe;

	/////////
   float Sum1[3],Sum2[3],Sum3[3],Sum4[3];
   float diff[6];
   int LI,LJ;


   ////////SORRY I NEED THIS FOR TIME... todo [
   LI=X;
   X=Y;
   Y=LI;
   ////////

    Sum1[0]=0.01; //todo change to if
    Sum1[1]=0.01;
    Sum1[2]=0.01;
    Sum2[0]=0.01;
    Sum2[1]=0.01;
    Sum2[2]=0.01;
    Sum3[0]=0.01;
    Sum3[1]=0.01;
    Sum3[2]=0.01;
    Sum4[0]=0.01;
    Sum4[1]=0.01;
    Sum4[2]=0.01;
    diff[0]=0;
    diff[1]=0;
    diff[2]=0;
    diff[3]=0;
    diff[4]=0;
    diff[5]=0;;

    //lCe = Y*shY*3 + X*shX*3;  //Line num * line len + bumber in line [x,y]
    //lLU = lCe - H*shY*3 - H*shX*3;

    for (LI =X - H; LI <= X; LI++)
     for (LJ=Y - H; LJ <= Y; LJ++)
     {
          Sum1[0] = Sum1[0]+Arr[(LI*shY+LJ)*3+shR];
          Sum1[1] = Sum1[1]+Arr[(LI*shY+LJ)*3+shG];
          Sum1[2] = Sum1[2]+Arr[(LI*shY+LJ)*3+shB];
     }

    //TODO check what is faster v or ^
    /*
    for (LI =(Y - H)*shY*3; LI <= Y*shY*3; LI+=shY*3) //todo LI step shY nor ++ and *shY
     for (LJ=(X - H)*shX*3; LJ <= X*shX*3; LJ+=shX*3) //todo Add LI to LJ
     {
          Sum1[0] = Sum1[0]+Arr[LI+LJ+shR];
          Sum1[1] = Sum1[1]+Arr[LI+LJ+shG];
          Sum1[2] = Sum1[2]+Arr[LI+LJ+shB];
     }

    */

    for (LI =X; LI <= X+H; LI++)
      for (LJ=Y - H; LJ <= Y; LJ++)
      {
    	  Sum2[0] = Sum2[0]+Arr[(LI*shY+LJ)*3+shR];
    	  Sum2[1] = Sum2[1]+Arr[(LI*shY+LJ)*3+shG];
    	  Sum2[2] = Sum2[2]+Arr[(LI*shY+LJ)*3+shB];
      }

   //for LI:=X to X+H do
   //  for LJ:=Y - H to Y do
    for (LI =X - H; LI <= X; LI++)
     for (LJ=Y; LJ <= Y+H; LJ++)
     {
    	 Sum3[0] = Sum3[0]+Arr[(LI*shY+LJ)*3+shR];
    	 Sum3[1] = Sum3[1]+Arr[(LI*shY+LJ)*3+shG];
    	 Sum3[2] = Sum3[2]+Arr[(LI*shY+LJ)*3+shB];
     }

    for (LI =X; LI <= X+H; LI++)
     for (LJ=Y; LJ <= Y+H; LJ++)
     {
          Sum4[0] = Sum4[0]+Arr[(LI*shY+LJ)*3+shR];
          Sum4[1] = Sum4[1]+Arr[(LI*shY+LJ)*3+shG];
          Sum4[2] = Sum4[2]+Arr[(LI*shY+LJ)*3+shB];
     }

    diff[0] =           abs(Sum1[0] - Sum2[0]) / (Sum1[0] + Sum2[0]);
    diff[0] = diff[0] + abs(Sum1[1] - Sum2[1]) / (Sum1[1] + Sum2[1]);
    diff[0] = diff[0] + abs(Sum1[2] - Sum2[2]) / (Sum1[2] + Sum2[2]);

    diff[1] =           abs(Sum2[0] - Sum3[0]) / (Sum2[0] + Sum3[0]);
    diff[1] = diff[1] + abs(Sum2[1] - Sum3[1]) / (Sum2[1] + Sum3[1]);
    diff[1] = diff[1] + abs(Sum2[2] - Sum3[2]) / (Sum2[2] + Sum3[2]);


    diff[2] =           abs(Sum3[0] - Sum4[0]) / (Sum3[0] + Sum4[0]);
    diff[2] = diff[2] + abs(Sum3[1] - Sum4[1]) / (Sum3[1] + Sum4[1]);
    diff[2] = diff[2] + abs(Sum3[2] - Sum4[2]) / (Sum3[2] + Sum4[2]);

    diff[3] =           abs(Sum4[0] - Sum1[0]) / (Sum4[0] + Sum1[0]);
    diff[3] = diff[3] + abs(Sum4[1] - Sum1[1]) / (Sum4[1] + Sum1[1]);
    diff[3] = diff[3] + abs(Sum4[2] - Sum1[2]) / (Sum4[2] + Sum1[2]);

    diff[4] =           abs(Sum2[0] - Sum4[0]) / (Sum2[0] + Sum4[0]);
    diff[4] = diff[4] + abs(Sum2[1] - Sum4[1]) / (Sum2[1] + Sum4[1]);
    diff[4] = diff[4] + abs(Sum2[2] - Sum4[2]) / (Sum2[2] + Sum4[2]);

    diff[5] =           abs(Sum1[0] - Sum3[0]) / (Sum1[0] + Sum3[0]);
    diff[5] = diff[5] + abs(Sum1[1] - Sum3[1]) / (Sum1[1] + Sum3[1]);
    diff[5] = diff[5] + abs(Sum1[2] - Sum3[2]) / (Sum1[2] + Sum3[2]);

    return (diff[0]+diff[1]+diff[2]+diff[3]+diff[4]+diff[5]);
}

void HashFrame(Frame &Fr, Dots &DotsR)
{
	std::array<int,10000*3> TempRes; //todo not create in func, rewrite in memory alocation basis

	int    MaxDot;
    float res;
    float MaxRes;
    int SizeX   = FrameSizeX;
    int SizeY   = FrameSizeY;
    int centerX =SizeX / 2;
    int centerY =SizeY / 2;
    float porog = P;
    MaxDot=0;
    MaxRes=0;

    for (int I = 30 / S; I<= ((SizeX-30) / S); I++)
      for (int J =30 / S; J<= ((SizeY-30) / S); J++)
      {
        res = CheckSqare(Fr,I*S,J*S);
        if (res>MaxRes)
          MaxRes=res;
        if (res > porog)
        {
        	TempRes[MaxDot*3+0] = I*S - centerX;//
        	TempRes[MaxDot*3+1] = J*S - centerY;//
        	TempRes[MaxDot*3+2] = trunc(res*1000);
        	MaxDot=MaxDot+1;
        }
	}
    std::cout << MaxDot;
    CutDotsTo(TempRes,DotsR,400,MaxDot);
}

void CheckHashWithMov(Dots &HashL,Mov  &HashR, int *Arr)
{
  int LLen = 400;
  int am1,am2;
  for (int I = 0; I < HashR.fram;I++)
  if (HashR.DotsAm[I] < 10)
  {
     Arr[I,0]=I;
     Arr[I,1]=0;
  }
  else
  {
    am1=0;
    for (int J = 0; J< LLen; J++)
      for (int K=0; K<HashR.DotsAm[I];K++)
        if (abs(HashL[J,0] - HashR.Frames[I][K,0]) + abs(HashL[J,1] - HashR.Frames[I][K,1]) < CheckRad)
		{
          am1++;
          break;
  	  	}
    am2=0;
    for (int K=0; K < HashR.DotsAm[I]; K++)
      for (int J=0; J < LLen; J++)
        if (abs(HashL[J,0] - HashR.Frames[I][K,0]) + abs(HashL[J,1] - HashR.Frames[I][K,1]) < CheckRad)
		{
          am2++;
          break;
		}

    Arr[I,0]=I;
    Arr[I,1]= (am1+am2)/(LLen+HashR.DotsAm[I]);
  }
}


void FillBitsFromDots(Dots &Fr, FrameBits &Bits)
{
  int M,I,J;
  int CX,CY;
  int SizeX = 640;
  int SizeY = 360;
  for ( M = 0; M<400; M++)
  {
      for (I =-12; I <= 12; I++)
        for (J =-(12-abs(I)); J<= (12-abs(I));J++)   //todo: check <= <
        {
           CX=Fr[M,0] + I + 320;
           CY=Fr[M,1] + J + 180;
           Bits[CX,CY]=true;
		}
  }
}

#endif /* LIB_BASEALG_CPP_ */
