/*
 * loggingManager.hpp
 *
 *  Created on: Apr 3, 2017
 *      Author: victor
 */

#ifndef LIB_EXTENSIONS_LOGGINGMANAGER_HPP_
#define LIB_EXTENSIONS_LOGGINGMANAGER_HPP_
#include <iostream>
#include <sstream>
#include <fstream>
#include <vector>


class LoggingManager
{
public:
	std::vector<std::stringstream> logs;
	std::vector<std::stringstream> Closedlogs;
	std::vector<std::string> ClosedlogNames;
	std::vector<std::string> logNames;

	std::stringstream errlog;  //logs[0] or [<0]
	std::stringstream mainlog; //logs[1]
	std::stringstream subProclog; //logs [2]

	std::string LogFolder;

	void log(int logID,std::string text);
	void log(std::string logName,std::string text);
	void log(std::string text);

	int OpenLog(std::string name);
	int CloseLog(int logId);
	int CloseLog(std::string logName);

	void DumpLog(int logId);
	void DumpLog(std::string logName);

	void DumpClosedLogs(std::string relfilepath = "");
	void DumpOpendLogs(std::string relfilepath= "");

	void ShowMeLog(std::ostream &out, std::string logName);

	int GetLogId(std::string logName);

};


#endif /* LIB_EXTENSIONS_LOGGINGMANAGER_HPP_ */
