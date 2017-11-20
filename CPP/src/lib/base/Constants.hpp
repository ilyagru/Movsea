/*
 * Constants.hpp
 *
 *  Created on: Feb 20, 2017
 *      Author: victor
 */

#ifndef LIB_CONSTANTS_HPP_
#define LIB_CONSTANTS_HPP_

#include <array>

const int FrameSizeX = 640;
const int FrameSizeY = 360;
const int FullLen = FrameSizeX*FrameSizeY;
const int InputFrameSizeX = 940;
const int InputFrameSizeY = 560;
const int InputFullLen = InputFrameSizeX*InputFrameSizeY;

const int SFrAm = 14;
const int InputSFrAm = 14;
//Settings
const int H = 8;
const int S = 4;
const float P = 5.5;
const int CheckRad = 13;


const int shY  = 640;
const int shX = 1;
const int shLU = -shX-shY;
const int shRU = +shX-shY;
const int shRD = +shX+shY;
const int shLD = -shX+shY;

const int shCLU = shCLU*3;
const int shCRU = shCRU*3;
const int shCRD = shCRD*3;
const int shCLD = shCLD*3;

const int shR = 0;
const int shG = 1;
const int shB = 2;

const std::string absExePath =  "/home/victor/git/MOVSEA2/src/";
const std::string absTempPath =  "/home/victor/git/MOVSEA2/src/Data/Temp/";

#endif /* LIB_CONSTANTS_HPP_ */
