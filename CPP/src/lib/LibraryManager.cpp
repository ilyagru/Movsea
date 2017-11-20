/* * LibraryManager.cpp
 *
 *  Created on: Mar 6, 2017
 *      Author: victor
 */

#include "LibraryManager.hpp"
#include "lib/base/baseClasses.hpp"
#include <fstream>
#include "pathManager.hpp"

void LibraryManager::loadIndex(std::string filename)
{
	std::fstream fileout;
	fileout.open(LibraryAbsPath + filename, std::fstream::in);
	fileout >> movAm;

	IndexFileName = filename;
	fileout >> MovsPath;
	fileout >> DescFileName;
	//todo fill abs paths;
	Movies.resize(movAm);

	for (int i=0; i< movAm; i++)
	{
		fileout >> Movies[i].name;  //todo check how read may be scanline
		fileout >> Movies[i].FileName;
	}

	fileout.close();
}

void LibraryManager::loadMovDescs(std::string filename)
{
	std::fstream fileout;
	fileout.open(LibraryAbsPath + DescFileName, std::fstream::in);

	for (int i=0; i< movAm; i++)
	{
		//fileout >> Descs[i];
	}

	fileout.close();
}

void LibraryManager::loadMovDots()
{
	std::fstream filestream;
	for (int i = 0; i < movAm; i++)
	{
		filestream.open(LibraryAbsPath+MovsPath+Movies[i].FileName, std::fstream::in);
		LoadMovDotsFromStream(filestream, Movies[i]);
		Movies[i].isDot = true;
		Movies[i].isFrame = false;  //todo move to constructor
		filestream.close();
	}
}


	void LibraryCreator::LoadIndex(std::string filepath)
	{
		index.Load(filepath);
	}
	void LibraryCreator::SaveIndex(std::string filepath)
	{
		index.Save(filepath);//todo change to pathfolder
	}
	void LibraryCreator::LoadDesc(std::string filepath)
	{
		desc.Load(filepath);
	}
	void LibraryCreator::SaveDesc(std::string filepath)
	{
		desc.Save(filepath);
	}

	void LibraryCreator::AddMovDotsFileToIndex(std::string name, std::string filename)
	{
		index.names.push_back(name);
		index.files.push_back(filename);
		index.size++;
		//index.size=index.names.size;
		LastIndex++;
	}
	void LibraryCreator::DelMovDotsFileFrIndex(std::string name)
	{
		for (int i=0;i<index.size; i++)
		{
			if (index.names[i] == name)
			{
				index.names.erase(index.names.begin()+i); //todo chech it or remade to simple index
				index.files.erase(index.files.begin()+i);
				LastIndex--;
				break;
			}
		}
	}
	void LibraryCreator::AddMovDescToIndex(std::string name, std::string description)
	{
		desc.names.push_back(name);
		desc.strings.push_back(description);
		//desc.size=desc.names.size;
		LastDesc++;
	}
	void LibraryCreator::DelMovDescFrIndex(std::string name) //todo bind together desc and index
	{
		for (int i=0;i<desc.size; i++)
		{
			if (desc.names[i] == name)
			{
				desc.strings.erase(desc.strings.begin()+i); //todo chech it or remade to simple index;
				desc.names.erase(desc.names.begin()+i);
				LastDesc--;
				break;
			}
		}
	}

	void LibraryCreator::HashAddMovToIndex(std::string filepath,std::string name, std::string description)
	{


	}

void IndexFile::Load(std::string filepath)
{
	std::ifstream f;
	f.open(filepath, std::fstream::in);
	std::string str;
	getline(f,descRelPath);
	getline(f,str);
	this->size = atoi(str.c_str());
	for (int i=0;i<size; i++)
	{
		getline(f,str);
		names.emplace_back(str.substr(0,str.find("||")));
		files.emplace_back(str.substr(str.find("||")+2));
	}
	f.close();
}

void IndexFile::Save(std::string filepath)
{
	std::ofstream f;
	f.open(filepath, std::fstream::out);
	f << descRelPath << '\n';
	f << size << '\n';
	for (int i=0;i<size; i++)
	{
		f<< names[i] <<"||" << files[i] << '\n';
	}

	f.close();
}

void DescriptionFile::Load(std::string filepath)
{
	std::ifstream f;
	f.open(filepath, std::fstream::in);
	std::string str;
	getline(f,str);
	this->size = atoi(str.c_str());
	for (int i=0;i<size; i++)
	{
		getline(f,str);
		names.emplace_back(str.substr(0,str.find("||")));
		strings.emplace_back(str.substr(str.find("||")+2));
	}
	f.close();
}

void DescriptionFile::Save(std::string filepath)
{
	std::ofstream f;
	f.open(filepath, std::fstream::out);
	for (int i=0;i<size; i++)
	{
		f<< names[i] <<"||" << strings[i] << '\n';
	}
	f.close();
}

LibraryCreator::LibraryCreator()
{
	this->LibraryRelPath = stPathManager.GetPath("LibraryRelPath");
	this->LibraryAbsPath = stPathManager.GetPath("ExePath")+
						   stPathManager.GetPath("DataPath")+
						   LibraryRelPath;
}

void LibraryManager::LoadLibrary(std::string IndexFileName)
{
	this->loadIndex(IndexFileName);
	this->loadMovDescs(index.descRelPath);
	this->loadMovDots();
}
