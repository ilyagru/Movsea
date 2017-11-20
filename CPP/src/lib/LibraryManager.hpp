/*
 * LibraryManager.hpp
 *
 *  Created on: Feb 10, 2017
 *      Author: victor
 */

#ifndef LIB_LIBRARYMANAGER_HPP_
#define LIB_LIBRARYMANAGER_HPP_

#include "lib/base/baseClasses.hpp"
#include <vector>
#include <string>

/* Index
 * Descfile
 * MovAm
 * Mov1Name Mov1FilePath Mov1Filename
 * ...
 * MovNName MovNFilePath MovNFilename
 *
 */

/* Desc
 * MovAm
 * Mov1Desc
 * ...
 * Mov2Desc
 *
 */


class IndexFile
{
public:
	std::vector<std::string> names;
	std::vector<std::string> files;
	int size;
	int AbsPath;
	int RelPath;
	int Filename;
	std::string descRelPath;
	void Load(std::string filepath);
	void Save(std::string filepath);
};

class DescriptionFile
{
public:
	std::vector<std::string> strings;
	std::vector<std::string> names;
	int size;
	int AbsPath;
	int RelPath;
	int Filename;
	void Load(std::string filepath);
	void Save(std::string filepath);
};


class LibraryCreator
{
public:

	IndexFile index;
	DescriptionFile desc;

	int DescSect = 1;
	int IndexSect = 2;
	int LastDesc = 0;
	int LastIndex = 0;

	std::string LibraryRelPath;
	std::string LibraryAbsPath; //todo load

	void LoadIndex(std::string filepath);
	void SaveIndex(std::string filepath);
	void LoadDesc(std::string filepath);
	void SaveDesc(std::string filepath);

	void AddMovDotsFileToIndex(std::string name, std::string filename);
	void DelMovDotsFileFrIndex(std::string name);

	void AddMovDescToIndex(std::string name, std::string description);
	void DelMovDescFrIndex(std::string name);

	void HashAddMovToIndex(std::string filepath,std::string name, std::string description);

	LibraryCreator();
};


class LibraryManager
{
public:
	IndexFile index;
	DescriptionFile desc;

	std::vector<Mov> Movies;
	int movAm;

	std::string LibraryRelPath;// todo load
	std::string LibraryAbsPath;
	std::string IndexFileName;
	std::string DescFileName;
	std::string MovsPath;


	void SetLibraryPath(std::string Path);

	void resizeLib(int Size);

	//load index file from LibPath+filename
	//create empty Movies, fill relPath, movAm
	//load descs
	void loadIndex(std::string filename);

	//load descs from file mentioned in Index
	void loadMovDescs(std::string filename);
	void loadMovFrames(); //load Mov.Frames by their relPath loaded by LoadIndex;
	void loadMovDots();
	void hashAllMovs();
	void bitAllMovs();
	bool checkAllState(int state); //0-indexed, 1-all loaded,2-hashed,3-bitted;

	int AddMov(std::string name, std::string absPath, std::string filename); //load a new film frame

	void LoadLibrary(std::string IndexFileName);
};


static LibraryCreator stLibraryCreator;

#endif /* LIB_LIBRARYMANAGER_HPP_ */
