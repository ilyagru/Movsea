/*
 * taskManager.hpp
 *
 *  Created on: Feb 22, 2017
 *      Author: victor
 */

#ifndef TASKMANAGER_HPP_
#define TASKMANAGER_HPP_

#include <string>

class Result
{
	int resType;
	long long ID;
	int resId;
	int time;
	std::string resStr;
	std::string toString();
};

class TTaskManager
{
public:
	std::vector<long long> idList;
	std::vector<Result> results;
	long long lastId;

	long long GetNewID()
	{
		return 1;     //todo make it
	}
};



#endif /* TASKMANAGER_HPP_ */
