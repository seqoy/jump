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
#include "JPColorFunctions.h"

///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// 
CGColorRef JPCreateRGBColor( float r, float g, float b, float alpha ) {

	// Create the color converting from Photoshop (0-255).
	CGFloat rgba[ 4 ] = { JPPSToQuartz( r ), 
						  JPPSToQuartz( g ), 
						  JPPSToQuartz( b ),  
						  JPPSAlphaToQuartz( alpha ) };
	
	// Create One Color Space.
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	
	// Create CGColor.
	CGColorRef anCGColor = CGColorCreate( colorSpace, rgba );
	
	// Release Color Space.
	CGColorSpaceRelease(colorSpace);
	
	// Return the color.
	return anCGColor;

}

// Return a Quartz CGColor based on a Photoshop RGB Type.
CGColorRef JPCreateColorWithJPrgb( JPrgb RGB, float alpha ) {
	return JPCreateRGBColor(RGB.R, RGB.G, RGB.B, alpha);
	
}

///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// 
#pragma mark -
#pragma mark Create Photoshop Color Types.
///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// /
// Create one Phtosohop RGB Type.
JPrgb JPCreateRGBType( int r, int g, int b ) {
	
	JPrgb rgb; rgb.R = r; rgb.G = g; rgb.B = b;
	return rgb;
	
}
///// ///// ///// ///// ///// ///// ///// ///// ///// /////////// ///// ///// ///// ///// ///// ///// ///// ///// //////
// Create one Phtosohop CMYK Type.
JPcmyk JPCreateCMYKType( int C, int M, int Y, int K) {
	
	JPcmyk cmyk; cmyk.C = C; cmyk.M = M; cmyk.Y = Y; cmyk.K = K;
	return cmyk;
	
}
///// ///// ///// ///// ///// ///// ///// ///// ///// /////////// ///// ///// ///// ///// ///// ///// ///// ///// //////
// Create one Phtosohop LAB Type.
JPlab JPCreateLABType( int L, int A, int B) {
	
	JPlab lab; lab.L = L; lab.A = A; lab.B = B;
	return lab;
	
	
};
///// ///// ///// ///// ///// ///// ///// ///// ///// /////////// ///// ///// ///// ///// ///// ///// ///// ///// //////
// Create one Phtosohop HSB Type.
JPhsv JPCreateHSVType( int H, int S, int B) {
	
	JPhsv hsb; hsb.H = H; hsb.S = S; hsb.V = B;
	return hsb;
	
}

