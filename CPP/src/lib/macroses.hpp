/*
 * macroses.hpp
 *
 *  Created on: Mar 18, 2017
 *      Author: victor
 */

#ifndef LIB_MACROSES_HPP_
#define LIB_MACROSES_HPP_

#include <string>
#include <lib/base/baseClasses.hpp>
#include <lib/base/baseAlg.hpp>
#include <lib/base/ffmpegUtil.hpp>

using namespace std;

void mOpenPipeAndReadMovFromFFmpeg(Mov  &mov, bool isDumpPicars, string path);

void mGenerateTestDots(Dots & dots, int method);

void SafeExit(int code);
void SafeStart(int code);

void mHashNPaintSave(std::string RelTemppath, std::string RelLibpath);
void mHashNSaveHash(std::string RelTemppath, std::string RelLibpath);

#endif /* LIB_MACROSES_HPP_ */
