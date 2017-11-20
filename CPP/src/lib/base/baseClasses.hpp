/*
 * baseClasses.hpp
 *
 *  Created on: Feb 10, 2017
 *      Author: victor
 */

#ifndef LIB_BASECLASSES_HPP_
#define LIB_BASECLASSES_HPP_

#include <vector>
#include <string>
#include <array>
#include <string>
#include <sstream>
#include <iostream>
#include "Constants.hpp"


typedef std::array<unsigned int,FrameSizeX*FrameSizeY*3> Frame;
typedef std::array<signed int,400*3> Dots;
typedef std::array<bool,FrameSizeX*FrameSizeY> FrameBits;


class Mov
{
public:
	long long ID;
	std::vector<Frame> Frames;
	std::vector<Dots> Hashs;
	std::vector<FrameBits> Bits;
	std::vector<int> DotsAm;
	int fram;
	bool isDot,isFrame;
	std::string name;
	std::string FileName; //from library.MoviePath
};

// obsolete, todo redone using S/LFrameToStream
void SaveFrameArrToFile(Frame &arr, std::string filepath);
void LoadFrameArrToFile(Frame &arr, std::string filepath);


//to stream only 1 frame
void LoadFrameFromStream(std::fstream &stream, Frame &Fr);
void SaveFrameToStream(std::fstream &stream, Frame &Fr);

//to stream with file header
void LoadMovFramesFromStream(std::fstream &stream, Mov &mov);
void SaveMovFramesToStream(std::fstream &stream, Mov &mov);


//stream only 1 dots
void LoadDotsFromStream(std::fstream &stream, Frame &dots);
void SaveDotsToStream(std::fstream &stream, Frame &dots);

//to stream with fileheader
void LoadMovDotsFromStream(std::fstream &stream, Mov &mov);
void SaveMovDotsToStream(std::fstream &stream, Mov &mov);

//to file using S/LMovDotsStream
void SaveMovDotsToFile(std::string filepath, Mov &mov);
void LoadMovDotsToFile(std::string filepath, Mov &mov);




void PaintDotsOnFrame(Dots &dots,Frame &fr, int color);

inline int getFramePixelCol(Frame &fr, int X,int Y, int col);
inline int getShiftFromXY(int X,int Y);


void coutDots(Dots &dots);

#endif /* LIB_BASECLASSES_HPP_ */
