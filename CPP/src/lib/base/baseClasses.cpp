/*
 * baseClasses.hpp
 *
 *  Created on: Feb 10, 2017
 *      Author: victor
 */

#ifndef LIB_BASECLASSES_CPP_
#define LIB_BASECLASSES_CPP_

#include "baseClasses.hpp"
#include "baseAlg.hpp"
#include <iostream>
#include <fstream>

#include <vector>
#include <string>

void SaveFrameArrToFile(Frame &arr, std::string filepath)
{
	std::fstream fileout;
	fileout.open (filepath, std::fstream::out);
	fileout << "1 " << "1 \n";    //1 1 means FrameArr Text File; 1 2 meand FrameArr binary file...
	for (int i=0;i<FullLen;i++)
	{
		fileout << arr[i*3] << " ";
		fileout << arr[i*3+1] << " ";
		fileout << arr[i*3+2];
		fileout << "\n";
	}
	fileout.close();
}
void LoadFrameArrToFile(Frame &arr, std::string filepath)
{
	std::fstream fileout;
	fileout.open (filepath,std::fstream::in);
	fileout >> arr[0] >> arr[0];    //1 1 means FrameArr Text File; 1 2 meand FrameArr binary file...

	for (int i=0;i<FullLen;i++)
	{
		fileout >> arr[i*3];
		fileout >> arr[i*3+1];
		fileout >> arr[i*3+2];
	}
	fileout.close();
}

void LoadDotsFromStream(std::fstream &stream, Dots &dots)
{
	unsigned int size;
	stream >>  size;
	for (unsigned int i=0; i<size; i++)
	{
		stream >> dots[i*3]     ;
		stream >> dots[i*3 + 1] ;
		stream >> dots[i*3 + 2] ;
	}

}

void SaveDotsToStream(std::fstream &stream, Dots &dots)
{
	stream <<  dots.size()/3 << '\n';
	unsigned int size = dots.size()/3;
	for (unsigned int i=0; i<size; i++)
	{
		stream << dots[i*3]     << ' ' ;
		stream << dots[i*3 + 1] << ' ' ;
		stream << dots[i*3 + 2] << '\n';
	}

}

void LoadMovDotsFromStream(std::fstream &stream, Mov &mov)
{
	int Fram;
	int fileType = 10,fileSubType = 1;
	//12 =Full Dots 1 = Text, mean file contaning all Dots for 1 movie in text file
	bool isText = true;
	bool isMovDotsFile = true;

	stream >> fileType;
	stream >> fileSubType;
	stream >> Fram;

	for (int i=0; i<Fram;i++)
	{
		LoadDotsFromStream(stream,mov.Hashs[i]);
	}

}

void SaveMovDotsToStream(std::fstream &stream, Mov &mov)
{
	int Fram = mov.fram;
	int fileType = 10,fileSubType = 1;
	//12 =Full Dots 1 = Text, mean file contaning all Dots for 1 movie in text file
	//bool isText = true;
	//bool isMovDotsFile = true;

	stream << fileType << ' ' << fileSubType << '\n';
	stream << Fram << '\n';
	for (int i=0; i<Fram;i++)
	{
		SaveDotsToStream(stream,mov.Hashs[i]);
	}
	stream << std::endl;

}

void PaintDotsOnFrame(Dots &dots,Frame &fr, int color)
{
	std::cout << "HELLO" <<std::endl;
	int x;
	int y;
	for (unsigned int i=0; i<400; i++)
	{
		x = dots[i*3] + 320;  //todo calc all in 1 line without temp ints
		y = dots[i*3+1] + 180;
		//std::cout << i << "|" << x << "|" << y << std::endl;
		for (int j = 1; j < 4; j++)
		{
			fr[((y+j)*shY+x)*3+color] = 240;
			fr[(y*shY+(x+j))*3+color] = 240;
			fr[((y-j)*shY+x)*3+color] = 240;
			fr[(y*shY+(x-j))*3+color] = 240;
		}
	}
}

inline int getFramePixelCol(Frame &fr, int X,int Y, int col)
{
	return fr[(Y*shY+X*shX)*3+col];
}

inline int getShiftFromXY(int X,int Y)
{
	return (Y*shY+X*shX)*3;
}

void coutDots(Dots &dots)
{
	for (unsigned int i=0; i<400; i++)
	{
		std::cout << dots[i*3]     << '|' ;
		std::cout << dots[i*3 + 1] << '|' ;
		std::cout << dots[i*3 + 2] << std::endl;
	}
}

void SaveMovDotsToFile(std::string filepath, Mov &mov)
{
	std::fstream stream;
	stream.open(filepath,std::fstream::out);
	SaveMovDotsToStream(stream, mov);
	stream.close();
}

void LoadMovDotsToFile(std::string filepath, Mov &mov)
{
	std::fstream stream;
	stream.open(filepath,std::fstream::in);
	SaveMovDotsToStream(stream, mov);
	stream.close();
}

void HashAndSaveDotsFromMov(std::string filepath, Mov &mov)
{
	mov.Hashs.resize(mov.fram);
	for (int i=0; i<mov.fram;i++)
	{
		HashFrame(mov.Frames[i],mov.Hashs[i]);
	}
	SaveMovDotsToFile(filepath,mov);
}

#endif /* LIB_BASECLASSES_CPP_ */
