/*
 * Protocols.hpp
 *
 *  Created on: Mar 9, 2017
 *      Author: victor
 */

#ifndef PROTOCOLS_HPP_
#define PROTOCOLS_HPP_

#include "PocoImport.hpp"

#include "mainPipeline.hpp"
#include "taskManager.hpp"
#include "../pathManager.hpp"

#include "lib/base/ffmpegUtil.hpp"
#include "lib/base/baseClasses.hpp"
#include "lib/base/baseAlg.hpp"
#include "lib/macroses.hpp"
#include <string>
#include <sstream>
#include <iostream>

using namespace Poco::Net;
using namespace std;

static Pipeline mainPipeline;
static TTaskManager taskManager;

//some semi-consts
static std::string TempPicPath = "/home/victor/git/MOVSEA2/src/Data/Temp/tempPic";
static std::string TempMovInPath = "/home/victor/git/MOVSEA2/src/Data/Temp/test2.mov";
static std::string TempMovOutPath = "/home/victor/git/MOVSEA2/src/Data/Temp/123.mov";

typedef std::string (*ccfunc)(std::string) ;

class UniProtocol
{
	int ID;
	std::string name;
	std::string subUrl;
};

class ConsoleResourseManager
{

};

class ConsoleCommandsLibrary
{
	std::vector<ccfunc> commands;
	std::vector<std::string> funcNames;
	std::vector<std::string> Descs;

	ccfunc returnFunc(std::string name);

	void AddFunc(ccfunc func, std::string name, std::string Desc = "");
};

class mainPipelineProtocol
{
public:

	std::string TempRelPath;
	std::string TempAbsPath;
	std::string TVidPath;
	std::string ExePath;
	std::string DataRelPath;
	std::string DataAbsPath;

	std::string resolve(HTTPServerRequest &req)
	{
		long long ID;
		std::string answer;
		ofstream fileOut;
		std::string vidSavePath = "";
		ID = taskManager.GetNewID();
		vidSavePath = TempAbsPath + TVidPath+ std::to_string(ID) +".MOV";
		fileOut.open(vidSavePath.c_str());
		std::istream &i = req.stream();
		Poco::StreamCopier::copyStream(i, fileOut, req.getContentLength());
		fileOut.close();

		//Main Pipeline
		ID = taskManager.GetNewID();
		mainPipeline.InitNewTask(ID);
		mainPipeline.FillMovFramesFromFile(ID,vidSavePath.c_str(), "std");// todo rename
		answer = mainPipeline.FindMovTask(ID);
		return answer;
	}

	mainPipelineProtocol()
	{
		DataRelPath = stPathManager.GetPath("DataRelPath");//toto do it
	}
};


class ConsoleProtocol
{
public:

	ConsoleResourseManager ResManager;
	ConsoleCommandsLibrary CommLib;
	std::vector<std::string> History;
	std::string resolve(Poco::Net::HTTPServerRequest &req, Poco::URI &uri);
	std::string ccShowHistory();

	void DumpHistory();
	void LoadHistory();

};



#endif /* PROTOCOLS_HPP_ */
