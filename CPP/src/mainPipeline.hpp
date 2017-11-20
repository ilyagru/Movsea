/*
 * mainPipeline.hpp
 *
 *  Created on: Feb 14, 2017
 *      Author: victor
 */

#ifndef MAINPIPELINE_HPP_
#define MAINPIPELINE_HPP_

#include "lib/LibraryManager.hpp"
#include "lib/base/baseAlg.hpp"
#include "lib/base/baseClasses.hpp"
#include <string>

class Pipeline
{
public:
	LibraryManager MovLib;
	std::vector<Mov> Tasks;

	bool isUseBits;
	bool isUseThreads;

	void LoadLibraryFromFolder(std::string folder);

	int InitTaskFromArr(int *arr, long long ID);
	int InitTaskFromArr(char *arr[], long long ID);
	int InitTaskFromVidFile(std::string, long long ID);
	int InitTaskFromStream();

	//simple add new Mov to tasks and fill its ID
	int InitNewTask(long long ID);

	//start ffmpeg and fills Mov.Frames from images given by
	//ffmpeg to pipe raw image decoding
	void FillMovFramesFromFile(long long ID, std::string filename, std::string filepath);

	std::string FindMovTask(long long taskID);
	int EvaluateResults(int ***result, int method);
};



#endif /* MAINPIPELINE_HPP_ */
