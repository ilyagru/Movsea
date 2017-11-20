/*
 * loggingManager.cpp
 *
 *  Created on: Apr 3, 2017
 *      Author: victor
 */

#include "loggingManager.hpp"

int LoggingManager::GetLogId(std::string logName)
{
	for (unsigned int i; i< logs.size(); i++)
	{
		if (logName == logNames[i])
		{
			return i;
		}
	}
	return -1;
}

void LoggingManager::log(int logId, std::string text)
{
	logs[logId] << text;
}

void LoggingManager::log(std::string logName, std::string text)
{
	logs[GetLogId(logName)] << text;
}

void LoggingManager::log(std::string text)
{
	mainlog << text;
}

int LoggingManager::OpenLog(std::string name)
{
	int tint = GetLogId(name);
	if (tint < 0)
	{
		logs.emplace_back();
		logNames.emplace_back(name);
		return logs.size()-1;
	}
	return tint;
}

int LoggingManager::CloseLog(int logId)
{
	//Closedlogs.emplace_back(logs[logId]);
	ClosedlogNames.emplace_back(logNames[logId]);
	return Closedlogs.size()-1;
}

int LoggingManager::CloseLog(std::string logName)
{
	int tint = GetLogId(logName);
	//Closedlogs.emplace_back(logs[tint]);
	ClosedlogNames.emplace_back(logNames[tint]);
	return Closedlogs.size()-1;
}

void LoggingManager::DumpLog(int logId)
{
	std::ofstream f;
	f.open(LogFolder+ClosedlogNames[logId], std::fstream::out);
	f << Closedlogs[logId].str();
	f.close();

}

void LoggingManager::DumpLog(std::string logName)
{
	std::ofstream f;
	int logId = GetLogId(logName);
	f.open(LogFolder+ClosedlogNames[logId], std::fstream::out);
	f << Closedlogs[logId].str();
	f.close();

}

void LoggingManager::DumpClosedLogs(std::string relfilepath)
{
	bool useDefPath = (relfilepath == "");
	for (unsigned int i=0; i< Closedlogs.size(); i++)
	{
		std::ofstream f;
		if (useDefPath)
		{
			f.open(LogFolder+ClosedlogNames[i], std::fstream::out);
		}
		else
		{
			f.open(relfilepath+ClosedlogNames[i], std::fstream::out);
		}
		f << Closedlogs[i].str();
		f.close();
	}
}

void LoggingManager::DumpOpendLogs(std::string relfilepath)
{
	bool useDefPath = (relfilepath == "");
	for (unsigned int i=0; i< logs.size(); i++)
	{
		std::ofstream f;
		if (useDefPath)
		{
			f.open(LogFolder+logNames[i], std::fstream::out);
		}
		else
		{
			f.open(relfilepath+logNames[i], std::fstream::out);
		}
		f << logs[i].str();
		f.close();
	}

}

void LoggingManager::ShowMeLog(std::ostream &out, std::string logName)
{
	for (unsigned int i=0; i < logs.size();i++)
	{
		if (logNames[i] == logName)
		{
			out << logs[i].str();
			break;
		}
	}
}
