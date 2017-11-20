/*
 * macroses.cpp
 *
 *  Created on: Apr 2, 2017
 *      Author: victor
 */
#include "macroses.hpp"
#include "lib/base/Constants.hpp"

void mOpen(Mov  & mov, bool isDumpPicars, std::string path)
{
	path = "/home/victor/git/MOVSEA2/src/Data/Temp/tempPic";
	FILE * PIPE;
	ffOpenImagePipe(&PIPE,"/home/victor/git/MOVSEA2/src/Data/Temp/test2.mov");
	mov.Frames.resize(14);
	for (int i=0;i<14;i++)
	{
		ffReadFrameFromPipe(&PIPE,mov.Frames[i]);
		if (isDumpPicars)
			{ SaveFrameArrToFile(mov.Frames[i], path+std::to_string(i)); }
	}
	pclose(PIPE);
}


void mGenerateTestDots(Dots &dots, int method)
{
	if (method == 1) //DIAGONAL
	{
		for (int i=0; i< 100 ; i++)
		{
			dots[0+i*3+0]   =  i; //RD
			dots[0+i*3+1]   =  i;
			dots[(100+i)*3+0] = -i; //LD
			dots[(100+i)*3+1] =  i;
			dots[(200+i)*3+0] = -i; //LU
			dots[(200+i)*3+1] = -i;
			dots[(300+i)*3+0] =  i; //RU
			dots[(300+i)*3+1] = -i;
		}
	}

}

void SafeExit(int code)
{

}


void mHashNPaintSave(std::string RelTemppath, std::string RelLibpath)
{
	Mov mov;
	FILE * PIPE;
	RelTemppath = absTempPath + RelTemppath;  //todo: repath
	RelLibpath = absTempPath + RelLibpath;
	ffOpenImagePipe(&PIPE,RelTemppath.c_str());
	mov.Frames.resize(14);
	for (int i=0;i<14;i++)
	{
		ffReadFrameFromPipe(&PIPE,mov.Frames[i]);
	}
	pclose(PIPE);
	cout << "ReadEnd\n" << endl;

	mov.Hashs.resize(14);
	for (int i=0;i<14;i++)
	{
		HashFrame(mov.Frames[i],mov.Hashs[i]);
		PaintDotsOnFrame(mov.Hashs[i],mov.Frames[i],0);
	}

	ffOpenImageWritePipe(&PIPE,RelLibpath.c_str());
	for (int i=0;i<14;i++)
	{
		ffWriteFrameToPipe(&PIPE,mov.Frames[i]);
	}
	pclose(PIPE);

}

void mHashNSaveHash(std::string RelTemppath, std::string RelLibpath)
{
	Mov mov;
	FILE * PIPE;
	RelTemppath = absTempPath + RelTemppath;
	RelLibpath = absTempPath + RelLibpath;
	ffOpenImagePipe(&PIPE,RelTemppath.c_str());
	mov.Frames.resize(11);
	for (int i=0;i<11;i++)
	{
		ffReadFrameFromPipe(&PIPE,mov.Frames[i]);
	}
	pclose(PIPE);
	cout << "ReadEnd\n" << endl;

	mov.Hashs.resize(11);
	mov.fram = 11;
	for (int i=0; i<11; i++)
	{
		HashFrame(mov.Frames[i],mov.Hashs[i]);
		cout << '\n' << i << "-----" << endl;
		cout <<  mov.Hashs[i].size() << endl;
		for (unsigned int j=0; j<mov.Hashs[i].size()/3; j++)
		{
			//cout << j << endl;
			//cout << mov.Hashs[i][j*3]     << ' ' ;
			//cout << mov.Hashs[i][j*3 + 1] << ' ' ;
			//cout << mov.Hashs[i][j*3 + 2] << '\n';
		}
	}
	SaveMovDotsToFile(RelLibpath, mov);
	mov.Frames.clear();
	mov.Frames.shrink_to_fit();
	mov.Hashs.clear();
	mov.Hashs.shrink_to_fit();


	cout << "OK" << endl;

}

