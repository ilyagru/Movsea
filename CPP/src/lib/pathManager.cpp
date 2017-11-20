/*
 * pathManager.cpp
 *
 *  Created on: Apr 29, 2017
 *      Author: victor
 */

#include "pathManager.hpp"
#include <iostream>
#include <fstream>

void PathManager::LoadPathFile(std::string abspath)
{
	std::ifstream f;
	f.open(abspath);
	std::string str;
	f >> ProgramAbsPath; //flush/stdnull
	f >> ProgramAbsPath;
	while (!f.eof())
	{
		f>>str;
		this->pathnames.emplace_back(ProgramAbsPath+str);
		f>>str;
		this->paths.emplace_back(ProgramAbsPath+str);
	}
	f.close();
}

std::string PathManager::GetPath(std::string name)
{
	for (unsigned int i=0; i<pathnames.size(); i++)
	{
		if (pathnames[i] == name)
		{
			return paths[i];
		}
	}
	std::cout << "SGW 1111111" << std::endl;
	return "something gose wrong";
}
