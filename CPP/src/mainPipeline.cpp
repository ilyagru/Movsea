/*
 * mainPipeline.cpp
 *
 *  Created on: Feb 14, 2017
 *      Author: victor
 */

#include "mainPipeline.hpp"
#include "lib/base/Constants.hpp"
#include "lib/base/ffmpegUtil.hpp"


int Pipeline::InitTaskFromVidFile(std::string, long long ID)
{
	return 1;
}

int InitTaskFromArr(int *arr, int ID)
{

	return 1;
}

//simple add new Mov to tasks and fill its ID
int Pipeline::InitNewTask(long long ID)
{
	Tasks.emplace_back();
	Tasks.back().ID=ID;
	return 1;
}

int Pipeline::EvaluateResults(int ***result, int method)
{
	int res = -1;
	int max = 0;
	int usedMaxs = 1;
	int upperBorder = 0,lowerBorder = 0;
	int cutUpper = 0;
	bool isUseClosenes = false;
	int maxs[10];
	int MovAm;

	int marks[MovAm] = {0};

	if (method == 1)
	{
		usedMaxs = 2;

	}

    max = marks[0];
    for(int i = 0; i < MovAm; i++)
    {
	  if (marks[i] > max)
	  {
		max = marks[i];
		res = i;
	  }
    }
    return res;
}


//start ffmpeg and fills Mov.Frames from images given by
//ffmpeg to pipe raw image decoding
void Pipeline::FillMovFramesFromFile(long long ID, std::string filename, std::string filepath = "std")
{
	Mov  &Movie = Tasks[ID];
	Movie.fram = SFrAm;

	Movie.Frames.resize(Movie.fram);

	FILE * PIPE;
	char fullPath[120];

	ffOpenImagePipe(&PIPE, fullPath);
	if (filepath == "std")
	for (int i=0; i<Movie.fram;i++)
	{
		ffReadFrameFromPipe(&PIPE, Movie.Frames[i]);
	};
	pclose(PIPE);
}

std::string Pipeline::FindMovTask(long long taskID)
{
	int res = -1;
    Mov &Task = Tasks[taskID];

    if (isUseBits)
    {
    	//Here will be version where used slower to hash but very faster comparison alg
    	// that is realised in Delphi version
    }
    else
    {
    	//Preparation
    	int *** results = new int ** [Task.fram];   // [I=Frame,J=Mov,K=MovFr] //todo change to 1d array<>
        for (int i = 0; i < Task.fram; i++)
        {
        	results[i] = new int * [MovLib.Movies.size()];
        	for (unsigned int j = 0; j < MovLib.Movies.size(); j++)
        	{
        		results[i][j] = new int [MovLib.Movies[j].fram];
        	}
        }

        //Hashing
    	Task.Hashs.resize(Task.fram);
    	for (int i=0; i<Task.fram; i++)
    	{
    		HashFrame(Task.Frames[i],Task.Hashs[i]);
    	}

    	//Searching
    	if (isUseThreads)
    	{

    	}
    	else
    	{
			for (int i=0; i<Task.fram; i++)
				for (unsigned int j; j < MovLib.Movies.size() ;j++)
				{
					CheckHashWithMov(Task.Hashs[i], MovLib.Movies[j], results[i][j]);
				}
    	}

    	//evaluation and choosing
    	//todo realize it please
    	res = EvaluateResults(results, 1);

    }

	if (res>-1)
		//return MovLib.Descs[res];
	return "NONE";
}





