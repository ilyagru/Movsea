/*
 * Protocols.cpp
 *
 *  Created on: Apr 2, 2017
 *      Author: victor
 */


#include "lib/protocols/Protocols.hpp"
#include "lib/base/ffmpegUtil.hpp"
#include "lib/base/baseClasses.hpp"
#include "lib/base/baseAlg.hpp"
#include "lib/macroses.hpp"
#include <string>
#include <sstream>
#include <iostream>
#include "lib/LibraryManager.hpp"


using namespace Poco::Net;
using namespace Poco;

class Command
{
public:
	std::string comm;
	std::string funcname;
	std::vector<std::string> params;
	void fromString(std::string);
	std::string toString();
	Command();
	Command(std::string);
};

std::string Decode(std::string str)
{
	while(str.find("%20") != string::npos)
		str.replace(str.find("%20"),3," ");
	while(str.find("%7C") != string::npos)
		str.replace(str.find("%7C"),3,"|");
	return str;
}


std::string ConsoleProtocol::ccShowHistory()
{
	std::string his;
	for (unsigned int i=0;i<History.size();i++)
	{
		his+=History[i]+"/n";
	}
	return his;
}

std::string ccOpenIndexFile(std::string comm)
{
	std::string filepath;
	filepath = comm.substr(comm.find(":")+1);
	stLibraryCreator.LoadIndex(filepath);
	stLibraryCreator.LoadDesc(stLibraryCreator.index.descRelPath+filepath);
	return "loaded from "+ filepath + " index File and Descriptions";
}

std::string ccAddDotFileToIndex(std::string comm)
{
	std::string filepath;
	std::string name;
	filepath = comm.substr(comm.find(":")+1,comm.find("||") - comm.find(":")-1);
	name = comm.substr(comm.find("||") + 2);
	stLibraryCreator.AddMovDotsFileToIndex(filepath,name);
	return "file "+ filepath + " added to index as "+ name;
}

std::string ccSaveIndexFile(std::string comm)
{
	std::string filepath;
	filepath = comm.substr(comm.find(":")+1);
	stLibraryCreator.SaveIndex(filepath);
	stLibraryCreator.SaveDesc(stLibraryCreator.index.descRelPath+filepath);
	return "Saved to "+ filepath + " index File and Descriptions";
}


std::string ccffmpegDiagonalDots()
{
	std::string path = TempPicPath;
	Mov mov;
	FILE * PIPE;
	ffOpenImagePipe(&PIPE,TempMovInPath.c_str());
	mov.Frames.resize(14);
	Dots dots{0};
	for (int i=0;i<14;i++)
	{
		ffReadFrameFromPipe(&PIPE,mov.Frames[i]);
	}
	pclose(PIPE);
	cout << "\n==ReadEnd==\n";

	mGenerateTestDots(dots,1);
	cout << std::endl;

	ffOpenImageWritePipe(&PIPE,TempMovOutPath.c_str());
	for (int i=0;i<14;i++)
	{
		PaintDotsOnFrame(dots,mov.Frames[i],0);
		ffWriteFrameToPipe(&PIPE,mov.Frames[i]);
	}
	pclose(PIPE);
	exit(0);
}

std::string ccffmpegSaveTest()
{
	std::string path = "/home/victor/git/MOVSEA2/src/Data/Temp/tempPic";
	Mov mov;
	FILE * PIPE;
	ffOpenImagePipe(&PIPE,"/home/victor/git/MOVSEA2/src/Data/Temp/test2.mov");
	mov.Frames.resize(14);
	for (int i=0;i<14;i++)
	{
		ffReadFrameFromPipe(&PIPE,mov.Frames[i]);
		//SaveFrameArrToFile(mov.Frames[i], path+std::to_string(i));
	}
	pclose(PIPE);
	cout << "ReadEnd\n";


	ffOpenImageWritePipe(&PIPE,"/home/victor/git/MOVSEA2/src/Data/Temp/123.mov");
	for (int i=0;i<14;i++)
	{
		ffWriteFrameToPipe(&PIPE,mov.Frames[i]);
	}
	pclose(PIPE);
	return "mov saved to /home/victor/git/MOVSEA2/src/Data/Temp/123.mov";
}


std::string ccCheckCutDots(std::string comm)
{
	stringstream ss,sout;
	int am;
	cout << comm << endl;
	comm = Decode(comm);
	cout << comm << endl;
	ss << comm.substr(comm.find(":")+1);
	ss >> am;
	std::array<int,10000*3> res;
	for (int i=0; i<am; i++)
	{
		ss >> res[i*3+2];
		res[i*3+0] = i;
		cout << res[i*3+0] << '-' << res[i*3+2] << endl;
	}
	Dots dots{0};
	CutDotsTo(res, dots, am, am);
	for (int i=0; i<am; i++)
	{
		sout << res[i*3+0] << '-' << res[i*3+2] << " = " << dots[i*3+0] << '-' << dots[i*3+2] << std::endl;
	}

	return sout.str();
}


std::string ConsoleProtocol::resolve(Poco::Net::HTTPServerRequest &req, URI &uri)
{
	std::string Command;
	std::string funcname;

	Command = uri.toString().substr(uri.toString().find("--")+2);
	Command = Decode(Command);
	History.emplace_back(Command);
	funcname = Command.substr(0,Command.find(":"));
	cout << "i do " << funcname << " from " << Command <<std::endl;
	std::string answer;
	answer = "OK";
	if (funcname == "help")
	{
		answer = "ffmpegSaveTest \n";
		answer += "ffmpegDiagonalDots \n";
		answer += "HashingTextSaveTest \n";
	}


	if (funcname == "CheckCutDots")       {   answer = ccCheckCutDots(Command); }
	if (funcname == "ffmpegSaveTest")     {   answer = ccffmpegSaveTest();      }
	if (funcname == "ffmpegDiagonalDots") {   answer = ccffmpegDiagonalDots();  }
	if (funcname == "History")      	  {   answer = ccShowHistory(); 		}
	if (funcname == "HashNPaintMov")
	{
		answer = Command.substr(Command.find(":")+1,Command.find("||")-Command.find(":")-1) +"///"
				+  Command.substr(Command.find("||")+2);
		mHashNPaintSave(Command.substr(Command.find(":")+1,Command.find("||")-Command.find(":")-1),
				Command.substr(Command.find("||")+2));

	}
	if (funcname == "HashNSaveHash")
	{
		answer = Command.substr(Command.find(":")+1,Command.find("||")-Command.find(":")-1) +"///"
				+  Command.substr(Command.find("||")+2);
		mHashNSaveHash(Command.substr(Command.find(":")+1,Command.find("||")-Command.find(":")-1), Command.substr(Command.find("||")+2));

	}

	if (funcname == "OpenIndexFile")       {   answer = ccOpenIndexFile(Command); }
	if (funcname == "SaveIndexFile")     {   answer = ccSaveIndexFile(Command);     }
	if (funcname == "AddFileToIndex")     {   answer = ccAddDotFileToIndex(Command);     }

	if (funcname == "ShutDown")
	{
		cout << "GoodBye" << std::endl;
		exit(0);
	}

	return answer;
}

void ConsoleProtocol::DumpHistory()
{
	std::ofstream f;
	std::string str;
	f.open("History.txt", std::fstream::out);
    for (unsigned int i=0; i<History.size(); i++)
    {
        f << History[i].c_str() << '\n';
    }
	f.close();

}

void ConsoleProtocol::LoadHistory()
{
	std::ifstream f;
	std::string str;
	f.open("History.txt", std::fstream::in);
    while( !f.eof() )
    {
    	getline(f,str);
        History.emplace_back(str);
    }
	f.close();

}
