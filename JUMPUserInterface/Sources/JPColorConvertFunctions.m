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
#include "JPColorConvertFunctions.h"
#include "JPColorFunctions.h"

///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// 

///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// 
///	
// Math color formulas from http:///www.easyrgb.com and http://www.cs.rit.edu/~ncs/color/t_convert.html

///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// 
#pragma mark -
#pragma mark Convert Color Functions.

///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ////
// Convert RGB color to CMYK.
JPcmyk	JPConvertRGBtoCMYK( JPrgb RGB ) {
	
	float C, M, Y, K = 0.00f;
	
	///// ///// ///// ///// /////
	// First convert RGB to CMY.
	C = 1 - JPPSToQuartz( RGB.R );
	M = 1 - JPPSToQuartz( RGB.G );
	Y = 1 - JPPSToQuartz( RGB.B );
	
	///// ///// ///// ///// /////
	// Convert CMY to CMYK
	float var_K = 1;
	
	if ( C < var_K )   var_K = C;
	if ( M < var_K )   var_K = M;
	if ( Y < var_K )   var_K = Y;
	if ( var_K == 1 ) { //Black
		C = 0;
		M = 0;
		Y = 0;
	}
	else {
		C = ( C - var_K ) / ( 1 - var_K );
		M = ( M - var_K ) / ( 1 - var_K );
		Y = ( Y - var_K ) / ( 1 - var_K );
	}
	K = var_K;
	
	// Normalize to 0-100.
	JPcmyk cmyk;
	cmyk.C = JPNormalizeUp( C );
	cmyk.M = JPNormalizeUp( M );
	cmyk.Y = JPNormalizeUp( Y );
	cmyk.K = JPNormalizeUp( K );
	
	// Return calculated value.
	return cmyk;
};

///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ////
// Convert CMYK color to RGB.
JPrgb	JPConvertCMYKtoRGB( JPcmyk CMYK ) {
	
	JPrgb rgb;
	
	// Normalize CMYK Colors.
	float C, M, Y, K = 0.00;
	C = JPNormalizeDown( CMYK.C );
	M = JPNormalizeDown( CMYK.M );
	Y = JPNormalizeDown( CMYK.Y );
	K = JPNormalizeDown( CMYK.K );
	
	// Convert to CMY Color. (Eliminate Black).
	C = ( C * ( 1 - K ) + K );
	M = ( M * ( 1 - K ) + K );
	Y = ( Y * ( 1 - K ) + K );
	
	// Calculate RGB Colors.
	rgb.R = JPQuartzToPS( ( 1 - C ) );
	rgb.G = JPQuartzToPS( ( 1 - M ) );
	rgb.B = JPQuartzToPS( ( 1 - Y ) );
	
	// Return calculated value.
	return rgb;
}

///// ///// ///// ///// ///// // ///// ///// ///// ///// ///// // ///// ///// ///// ///// ///// // ///// ///// ///// ///// ///// // 
#pragma mark -
#define MAX3(a,b,c) (a > b ? (a > c ? a : c) : (b > c ? b : c))
#define MIN3(a,b,c) (a < b ? (a < c ? a : c) : (b < c ? b : c))

///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ////
// Convert RGB color to HSV.
JPhsv	JPConvertRGBtoHSV( JPrgb RGB ) {
	
	float H, S, V = 0.00f;
	float R, G, B = 0.00f;
	float min, max, delta;
	min = JPPSToQuartz( MIN3(RGB.R, RGB.G, RGB.B) );
	max = JPPSToQuartz( MAX3(RGB.R, RGB.G, RGB.B) );
	
	R = JPPSToQuartz( RGB.R );
	G = JPPSToQuartz( RGB.G );
	B = JPPSToQuartz( RGB.B );
	
	V = max;   
	delta = max - min;
	if( max != 0 )
		S = delta / max;    // s
	else {
		// r = g = b = 0    // s = 0, v is undefined
		S = 0;
		H = 0;
		return (JPhsv){(int)H,
			JPNormalizeUp( S ),
			JPNormalizeUp( V )};
	}
	if ( delta != 0 ) {
		if( R == max )
			H = ( G - B ) / delta;    // between yellow & magenta
		else if( G == max )
			H = 2 + ( B - R ) / delta;  // between cyan & yellow
		else
			H = 4 + ( R - G ) / delta;  // between magenta & cyan
	} else {
		H = 0;
	}
	H *= 60;        // degrees
	if( H < 0 )
		H += 360;
	
	return (JPhsv){(int)roundf( H ),
		JPNormalizeUp( S ),
		JPNormalizeUp( V )};
}

///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ////
// Convert HSB color to RGB.
JPrgb	JPConvertHSVtoRGB( JPhsv HSV ) {
	float H, S, V = 0.00f;
	float R, G, B = 0.00f;
	
	// Normalize HSB Values.
	H = HSV.H;			
	S = JPNormalizeDown( HSV.S );		// % Correct Values.
	V = JPNormalizeDown( HSV.V );		// % Correct Values.
	
	int i;
	float f, p, q, t;
	if( S == 0 ) {
		// achromatic (grey)
		int SV = JPQuartzToPS( V );
		return (JPrgb){SV,SV,SV};
	}
	
	H /= 60;			// sector 0 to 5
	i = floor( H );
	f = H - i;			// factorial part of h
	p = V * ( 1 - S );
	q = V * ( 1 - S * f );
	t = V * ( 1 - S * ( 1 - f ) );
	switch( i ) {
		case 0:
			R = V;
			G = t;
			B = p;
			break;
		case 1:
			R = q;
			G = V;
			B = p;
			break;
		case 2:
			R = p;
			G = V;
			B = t;
			break;
		case 3:
			R = p;
			G = q;
			B = V;
			break;
		case 4:
			R = t;
			G = p;
			B = V;
			break;
		default:		// case 5:
			R = V;
			G = p;
			B = q;
			break;
	}			
	
	// Correct RGB Values. 0 - 255
	JPrgb RGB;
	RGB.R = JPQuartzToPS( R );
	RGB.G = JPQuartzToPS( G );
	RGB.B = JPQuartzToPS( B );
	
	// Return calculated value.
	return RGB;
}

///// ///// ///// ///// ///// // ///// ///// ///// ///// ///// // ///// ///// ///// ///// ///// // ///// ///// ///// ///// ///// // 
#pragma mark -
///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ////


// Convert XYZ color to RGB.
JPrgb	JPConvertXYZtoRGB( JPxyz XYZ ) {
	
	JPrgb RGB;
	
	////////////////
	
	// Normalize.
	XYZ.X = XYZ.X / 100;        //X from 0 to  95.047      (Observer = 2°, Illuminant = D65)
	XYZ.Y = XYZ.Y / 100;        //Y from 0 to 100.000
	XYZ.Z = XYZ.Z / 100;        //Z from 0 to 108.883
	
	////////////////
	
	RGB.R = XYZ.X *  3.2406 + XYZ.Y * -1.5372 + XYZ.Z * -0.4986;
	RGB.G = XYZ.X * -0.9689 + XYZ.Y *  1.8758 + XYZ.Z *  0.0415;
	RGB.B = XYZ.X *  0.0557 + XYZ.Y * -0.2040 + XYZ.Z *  1.0570;
	
	////////////////
	
	if ( RGB.R > 0.0031308 ) RGB.R = 1.055 * ( (int)RGB.R ^ (int)( 1 / 2.4 ) ) - 0.055;
	else                     RGB.R = 12.92 * RGB.R;
	
	////////////////
	
	if ( RGB.G > 0.0031308 ) RGB.G = 1.055 * ( (int)RGB.G ^ (int)( 1 / 2.4 ) ) - 0.055;
	else                     RGB.G = 12.92 * RGB.G;
	
	////////////////
	
	if ( RGB.B > 0.0031308 ) RGB.B = 1.055 * ( (int)RGB.B ^ (int)( 1 / 2.4 ) ) - 0.055;
	else                     RGB.B = 12.92 * RGB.B;
	
	////////////////
	RGB.R = RGB.R * 255;
	RGB.G = RGB.G * 255;
	RGB.B = RGB.B * 255;
	
	return RGB;
}


///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ////
// Convert RGB color to XYZ.
JPxyz	JPConvertRGBtoXYZ( JPrgb RGB ) {
	
	JPxyz XYZ;
	
	////////////////
	
	// Normalize RGB Values.
	RGB.R = ( RGB.R / 255 ); RGB.G = ( RGB.G / 255 ); RGB.B = ( RGB.B / 255 );
	
	
	// Calculate
	if ( RGB.R > 0.04045 ) RGB.R = (int)( ( RGB.R + 0.055 ) / 1.055 ) ^ (int)2.4;
	else                   RGB.R = RGB.R / 12.92;
	
	///////// ///////// ///////// 
	
	if ( RGB.G > 0.04045 ) RGB.G = (int)( ( RGB.G + 0.055 ) / 1.055 ) ^ (int)2.4;
	else                   RGB.G = RGB.G / 12.92;
	
	///////// ///////// ///////// 
	
	if ( RGB.B > 0.04045 ) RGB.B = (int)( ( RGB.B + 0.055 ) / 1.055 ) ^ (int)2.4;
	else                   RGB.B = RGB.B / 12.92;
	
	///////// ///////// ///////// 
	
	RGB.R = RGB.R * 100; RGB.G = RGB.G * 100; RGB.B = RGB.B * 100;
	
	///Observer. = 2°, Illuminant = D65
	XYZ.X = RGB.R * 0.4124 + RGB.G * 0.3576 + RGB.B * 0.1805;
	XYZ.Y = RGB.R * 0.2126 + RGB.G * 0.7152 + RGB.B * 0.0722;
	XYZ.Z = RGB.R * 0.0193 + RGB.G * 0.1192 + RGB.B * 0.9505;
	
	// Return calculated value.
	return XYZ;
	
}

///// ///// ///// ///// ///// // ///// ///// ///// ///// ///// // ///// ///// ///// ///// ///// // ///// ///// ///// ///// ///// // 
#pragma mark -
///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ////-

JPlab	JPConvertXYZtoLAB( JPxyz XYZ ) {
	
	JPlab LAB;
	
	// Normalize XYZ Values.
	XYZ.X = (XYZ.X / 95.047 );
	XYZ.Y = (XYZ.Y / 100.0 );
	XYZ.Z = (XYZ.Z / 108.883 );					//  Observer= 2°, Illuminant= D65.
	
	
	if ( XYZ.X > 0.008856 ) XYZ.X = (int)XYZ.X ^ (int)( 1.0/3.0 );
	else					XYZ.X = ( 7.787 * XYZ.X ) + ( 16.0 / 116.0 );
	
	///////// ///////// ///////// 
	
	if ( XYZ.Y > 0.008856 ) XYZ.Y = (int)XYZ.Y ^ (int)( 1.0/3.0 );
	else                    XYZ.Y = ( 7.787 * XYZ.Y ) + ( 16.0 / 116.0 );
	
	///////// ///////// ///////// 
	
	if ( XYZ.Z > 0.008856 ) XYZ.Z = (int)XYZ.Z ^ (int)( 1.0/3.0 );
	else                    XYZ.Z = ( 7.787 * XYZ.Z ) + ( 16.0 / 116.0 );
	
	///////// ///////// ///////// 
	
	LAB.L = ( 116 * XYZ.Y ) - 16;			
	LAB.A = 500 * ( XYZ.X - XYZ.Y );
	LAB.B = 200 * ( XYZ.Y - XYZ.Z );
	
	// Return calculated value.
	return LAB;
	
}
///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ////
JPxyz	JPConvertLABtoXYZ( JPlab LAB ) {
	
	JPxyz XYZ;
	
	// Normalize LAB Values.
	XYZ.Y = ( LAB.L+ 16 ) / 116;
	XYZ.X = LAB.A / 500 + XYZ.Y;
	XYZ.Z = XYZ.Y - LAB.B / 200;
	
	if ((int)XYZ.Y ^ ((int)3 > 0.008856) ) XYZ.Y = (int)XYZ.Y ^ (int)3.0;
	else								 XYZ.Y = ( XYZ.Y - 16.0 / 116.0 ) / 7.787;
	
	///////// ///////// ///////// 
	
	
	if ( (int)XYZ.X ^ (int) 3 > 0.008856 ) XYZ.X = (int) XYZ.X ^ (int)3;
	else								   XYZ.X = ( XYZ.X - 16 / 116 ) / 7.787;
	
	///////// ///////// ///////// 
	
	
	if ( (int)XYZ.Z ^ (int)3 > 0.008856 ) XYZ.Z = (int)XYZ.Z ^ (int)3;
	else								XYZ.Z = ( XYZ.Z - 16 / 116 ) / 7.787;
	
	///////// ///////// ///////// 
	
	XYZ.X = 95.047 * XYZ.X; 
	XYZ.Y = 100.000 * XYZ.Y;   
	XYZ.Z = 108.883 * XYZ.Z; 
	
	// Return calculated value.
	return XYZ;
}
///// ///// ///// ///// ///// // ///// ///// ///// ///// ///// // ///// ///// ///// ///// ///// // ///// ///// ///// ///// ///// // 
#pragma mark -
///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ////

JPlab	JPConvertRGBtoLAB( JPrgb RGB ) {
	// Trans-Conversions.
	return JPConvertXYZtoLAB( JPConvertRGBtoXYZ( RGB ) );
}

JPrgb	JPConvertLABtoRGB( JPlab LAB ) {
	// Trans-Conversions.
	return  JPConvertXYZtoRGB( JPConvertLABtoXYZ( LAB) );
}
///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ////
