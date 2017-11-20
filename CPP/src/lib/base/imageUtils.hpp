/*
 * imageUtils.hpp
 *
 *  Created on: Mar 5, 2017
 *      Author: victor
 */

#ifndef LIB_IMAGEUTILS_HPP_
#define LIB_IMAGEUTILS_HPP_

class ImageBuffer
{
public:
	std::vector<int*> Images;
};


void ResizeImage(int * Original, int * Resized, int NewW,int NewH);




#endif /* LIB_IMAGEUTILS_HPP_ */
