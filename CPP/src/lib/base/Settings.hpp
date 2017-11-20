/*
 * Settings.hpp
 *
 *  Created on: Feb 25, 2017
 *      Author: victor
 */

#ifndef LIB_SETTINGS_HPP_
#define LIB_SETTINGS_HPP_

#include <string>
#include <map>


class Settings
{
public:
	std::string settPath;
	std::string rootPath;
	std::map <std::string,std::string> CustomParams;
	std::string ffmmpegPath;
	std::string dataPath;
	std::string tepmRelPath;
	std::string vidFolderName,dumpFolderName;

	int algStep,algSize,algPor;

	void LoadSettingsFromFile(std::string filepath);
	void SaveSettingsToFile(std::string filepath);
	void SetCustomParam(std::string paramName, std::string newValue);
	std::string GetParam(std::string paramName);
	std::string GetParam(int paraID);

	int AddParam(std::string paramName, std::string newValue);

private:
	std::map<std::string,std::string>::iterator parIt;  //v nebesah
};



#endif /* LIB_SETTINGS_HPP_ */
