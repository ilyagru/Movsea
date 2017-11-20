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

#include "Constants.hpp"

//start ffmpeg to decode given by filename video to frames
//and creates a pipe to read raw rgb24 image data
//assiciates given FILE *PIPE with it.
//!Does not create/declare a new FILE*;
void ffOpenImagePipe(FILE **PIPE, const char *filename);

void ffOpenImageWritePipe(FILE **PIPE, const char *filename);

//Fills a frame arr[FullLen*3] from given Pipe.
//reads only 1 !NEXT frame from prev opened video(for ex: ffOpenImagePipe).
//doesn't open or close pipe, or create an array.
// something as  "PIPE >> arr"
void ffReadFrameFromPipe(FILE ** PIPE, Frame &arr);

void ffWriteFrameToPipe(FILE ** PIPE, Frame &arr);

void ffSaveMovToFile(Mov &mov, const char *filename);


//Starts the ffmpeg without any options
//return 0 if linux was able to run something named ffmpeg
//opens it own Pipe and closes it (not as read and open);
int CheckFFmpeg(int checkType);


float ffGetVideoDuration(std::string filepath);

#endif /* LIB_FFMPEGUTIL_HPP_ */
