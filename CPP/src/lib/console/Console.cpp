/*
 * Console.cpp
 *
 *  Created on: Feb 8, 2017
 *      Author: victor
 */
#include "Console.hpp"



std::string CutWordFromString(std::string Str)
{
	std::string::size_type pos = Str.find(' '); // Позиция первого символа строки-разделителя.
	Str = Str.substr(0, pos); // Строка до разделителя.
	return Str.substr(pos+1); // Строка после разделителя.
}

void DecodeVid(std::string Comm)
{

}

void ApplicationQuit()
{

}


void Console::Execute(std::string Comm)
{
	std::string Head;
	Head = CutWordFromString(Comm);
	if (Head == "DecodeVid")
		{DecodeVid(Comm);}

	if (Head == "Quit")
		{ApplicationQuit();}


}

