/*
 * Copyright (c) 2011 - SEQOY.org and Paulo Oliveira ( http://www.seqoy.org )
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
#import <Foundation/Foundation.h>

/**
 * \nosubgrouping 
 * A collection of math helper methods to perform different operations.
 */
@interface JPMath : NSObject {}


/////////// /////////// /////////// /////////// 
#pragma mark -
#pragma mark Random Numbers Methods.
/////////// /////////// /////////// /////////// 
/** @name Random Numbers Methods
 */
///@{ 

/**
 Generate an random Int number. 
 
 This method use the <b>arc4random()</b> function. The generator employed by the arc4 cipher, which uses 8*8 8
 bit S-Boxes.  The S-Boxes can be in about (2**1700) states.  The arc4random() function returns pseudo-
 random numbers in the range of 0 to (2**32)-1, and therefore has twice the range of rand(3) and
 random(3).
 
 The arc4random_stir() function reads data from /dev/urandom and uses it to permute the S-Boxes via
 arc4random_addrandom().
 
 That's not guarantee that generated numbers doesn't repeat itself on a short period 
 of time between calls.
 @return An <b>int</b> genereated number.
 */
+(int)generateRandomNumber;

/**
 * Generate an random Int number.
 * @param anNumber Max number starting at 0.
 * @param anExcludeNumber Doesn't return this number on this particular generation.
 * @return An <b>int</b> genereated number.
 */
+(int)generateAnRandomMaxNumber:(int)anNumber excluding:(int)anExcludeNumber;

///@}
/////////// /////////// /////////// /////////// 
#pragma mark -
#pragma mark Angles and Diameter Methods.
/////////// /////////// /////////// /////////// 
/** @name Angles and Diameter Methods
 */
///@{ 

/**
 * Convert an degree angle to an radian angle.
 * @param degrees Degrees value to convert. 
 */
+(float)degreesToRadians:(float)degrees;

/**
 * Convert an radian angle to an degree angle.
 * @param radians Radians value to convert.
 */
+(float)radiansToDegrees:(float)radians;

/**
 * Convert diameter value to radius value.
 * @param diameter Diameter value to convert.
 */
+(float)diameterToRadius:(float)diameter;

///@}
/////////// /////////// /////////// /////////// 
@end
