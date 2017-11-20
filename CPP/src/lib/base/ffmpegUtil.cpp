/*
 * ffmpegUtil.cpp
 *
 *  Created on: Mar 11, 2017
 *      Author: victor
 */

/*
 * ffmpegUtil.hpp
 *
 *  Created on: Feb 22, 2017
 *      Author: victor
 */

#ifndef LIB_FFMPEGUTIL_HPP_
#define LIB_FFMPEGUTIL_HPP_

#include <iostream>
#include <fstream>
#include <stdio.h>
#include <string.h>
#include <array>
#include "lib/thirdparty/pstream.h"

#include "Constants.hpp"
#include "ffmpegUtil.hpp"
#include "baseAlg.hpp"
#include "baseClasses.hpp"

//start ffmpeg to decode given by filename video to frames
//and creates a pipe to read raw rgb24 image data
//assiciates given FILE *PIPE with it.
//!Does not create/declare a new FILE*;
void ffOpenImagePipe(FILE **PIPE, const char *filename)
{
	char CMD[240]="";   /////// I HOPE 60 Doesnt kill program someday... ok 120
	strcat(CMD,"ffmpeg -i ");  //todo: change to std::string...carefully
	strcat(CMD ,filename);
	strcat(CMD," -r 2 -f image2pipe -pix_fmt rgb24 -vcodec rawvideo -");
	*PIPE = popen(CMD, "r");
}

void ffOpenImageWritePipe(FILE **PIPE, const char *filename)
{
	char CMD[240]="";   /////// I HOPE 60 Doesnt kill program someday... ok 120 ... ok here 240
	strcat(CMD,"ffmpeg -y -f rawvideo -vcodec rawvideo -s 640x360 -pix_fmt rgb24 -r 2 -i - -an -vcodec libx264 ");
	strcat(CMD ,filename);	//todo: change to std::string...carefully
	std::cout << CMD << "\n";
	*PIPE = popen(CMD, "w");
}

//Fills a frame arr[FullLen*3] from given Pipe.
//reads only 1 !NEXT frame from prev opened video(for ex: ffOpenImagePipe).
//doesn't open or close pipe, or create an array.
// something as  "PIPE >> arr"
void ffReadFrameFromPipe(FILE ** PIPE, Frame &arr)
{
	for(int i=0; i<FullLen*3; i++)
	{
		arr[i] = fgetc(*PIPE);
	}
}

void ffWriteFrameToPipe(FILE ** PIPE, Frame &arr)
{
	for(int i=0; i<FullLen*3; i++)
	{
		 fputc(arr[i],*PIPE);
	}
}

void ffSaveMovToFile(Mov &mov, const char *filename)
{
	FILE * PIPE;
	ffOpenImageWritePipe(&PIPE,filename);
	for (int i=0; i < mov.fram; i++)
	{
		ffWriteFrameToPipe(&PIPE, mov.Frames[i]);
	}
	pclose(PIPE);
}


//Starts the ffmpeg without any options
//return 0 if linux was able to run something named ffmpeg
//opens it own Pipe and closes it (not as read and open);
int CheckFFmpeg(int checkType)
{
	FILE * PIPE;

	PIPE = popen("ffmpeg", "r");
	if (PIPE !=NULL)
	{
		return 0;
		pclose(PIPE);
	}
	else
	{
		return 1;
		pclose(PIPE);
	}
}

float ffGetVideoDuration(std::string filepath)
{

	redi::ipstream proc("ffmpeg -i " + filepath, redi::pstreams::pstdout | redi::pstreams::pstderr);
	std::string str;
	std::string time;
	float Dmin,Dsec;
	while (std::getline(proc.err(), str))
	{
	    if (str.find("Duration")!= std::string::npos)
	    {
	    	time = str.substr(str.find("Duration")+10,str.find(',')-str.find("Duration")-10);
	    	Dmin = atoi(time.substr(3,2).c_str());
	    	Dsec = atoi(time.substr(6,2).c_str());
	    	proc.close();
	    	return Dmin*60+Dsec;
	    }
	}
	return -1;
}

#endif /* LIB_FFMPEGUTIL_HPP_ */



