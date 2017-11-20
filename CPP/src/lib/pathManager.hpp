/*
 * pathLibrary.hpp
 *
 *  Created on: Apr 29, 2017
 *      Author: victor
 */

#ifndef LIB_PATHMANAGER_HPP_
#define LIB_PATHMANAGER_HPP_

#include <string>
#include <vector>

class PathManager
{
public:
	std::string pathFile;
	std::string ProgramAbsPath;
	std::vector<std::string> paths;
	std::vector<std::string> pathnames;
	void LoadPathFile(std::string abspath);
	std::string GetPath(std::string name);
	std::string GetSummPath(std::string name); //todo fill
};

static PathManager stPathManager;


#endif /* LIB_PATHLIBRARY_HPP_ */
