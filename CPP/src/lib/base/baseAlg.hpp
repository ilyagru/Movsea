/*
 * baseAlg.hpp
 *
 *  Created on: Feb 10, 2017
 *      Author: victor
 */

#ifndef LIB_BASEALG_HPP_
#define LIB_BASEALG_HPP_

#include "baseClasses.hpp"
#include <math.h>

void HashFrame(Frame &Fr, Dots &DotsR);

float Check2Hash(Dots DotsL,Dots DotsR);
float CheckDotsOnBit(Dots DotsL,FrameBits BitR);

void CheckHashWithMov(Dots &HashL, Mov  &HashR, int *Arr);
void FillBitsFromDots(Dots &Fr, FrameBits &Bits);

void CutDotsTo(std::array<int,10000*3> &result, Dots &dots,int sizeIn, int sizeOut);


void HashAndSaveDotsFromMov(std::string filepath, Mov &mov);

#endif /* LIB_BASEALG_HPP_ */
