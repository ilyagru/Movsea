#pragma once

#include <Poco/Mutex.h>
#include <Poco/Util/ServerApplication.h>
#include "lib/pathManager.hpp"

using namespace Poco;
using namespace Poco::Util;
using namespace std;

class MyServerApp : public ServerApplication
{
public:
	static string getText();
	static void setText(string newText);
	int main(const vector<string> &);
	static string text;
	static Mutex textLock;
	void DoSomePreInit(int type)
	{
		stPathManager.LoadPathFile("pathFile.txt");
	}
};
