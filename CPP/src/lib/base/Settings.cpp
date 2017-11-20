/*
 * Settings.cpp
 *
 *  Created on: Feb 25, 2017
 *      Author: victor
 */

#include "Settings.hpp"


void Settings::SetCustomParam(std::string paramName, std::string newValue)
{

}

std::string Settings::GetParam(std::string paramName)
{
	parIt = CustomParams.find(paramName);
	if (parIt != CustomParams.end())
	{
		return CustomParams[paramName];
	}
	else
	{
		return "notfound";
	}
}

std::string Settings::GetParam(int paraID)
{

	return "notfound";
}

int Settings::AddParam(std::string paramName, std::string newValue)
{
	parIt = CustomParams.find(paramName);
		if (parIt != CustomParams.end())
		{
			return 1;
		}
		else
		{
			CustomParams[paramName] = newValue;
			return 0;
		}
}


