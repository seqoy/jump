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
#import "JPMath.h"

/////////// /////////// /////////// /////////// 
@implementation JPMath

/////////// /////////// /////////// /////////// 
#pragma mark -
#pragma mark Random Numbers Methods.
/////////// /////////// /////////// /////////// 

/////////// /////////// /////////// 
// Generate random number. 
+(int)generateRandomNumber {
	return (arc4random() % ((unsigned)RAND_MAX + 1));
}

/////////// /////////// /////////// 
// Generate an random Int number.
+(int)generateAnRandomMaxNumber:(int)anNumber excluding:(int)anExcludeNumber {
	
	// Random Number.
	int randomNumber = anExcludeNumber;
	
	// Generate one random number.
	while ( randomNumber == anExcludeNumber ) {
		randomNumber = [self generateRandomNumber] % anNumber;
	}
	
	// Return it.
	return randomNumber;
}


/////////// /////////// /////////// /////////// 
#pragma mark -
#pragma mark Angles Methods.
/////////// /////////// /////////// /////////// 

/////////// /////////// /////////// 
// Convert an degree angle to an radian angle.
+(float)degreesToRadians:(float)degrees {
	return (M_PI * degrees / 180.0);
}

/////////// /////////// /////////// 
// Convert an radian angle to an degree angle.
+(float)radiansToDegrees:(float)radians {
	return radians * (180.0 / M_PI);
}

/////////// /////////// /////////// 
// Convert diameter value to radius value.
+(float)diameterToRadius:(float)diameter {
	return (diameter * 0.5);
}

@end
