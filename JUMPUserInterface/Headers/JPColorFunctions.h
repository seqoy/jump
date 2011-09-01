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
#import "JPColorTypes.h"
#import <Foundation/Foundation.h>
#if !TARGET_OS_IPHONE 
    #import <ApplicationServices/ApplicationServices.h>
#else
    #import <CoreGraphics/CoreGraphics.h>
#endif
/**
 * \file JPColorFunctions.h
 * JPColor utility and helper functions.
 */

/**
 * Convert a Photoshop-like Alpha Percent (0 - 100) to Quartz Alpha Percent (0.0 - 1.0).
 */
#define JPPSAlphaToQuartz(alpha) ( (float)alpha / 100.0 )

/**
 * Convert a Quartz Alpha Percent (0.0 - 1.0) to Photoshop-like Alpha Percent (0 - 100).
 */
#define JPQuartzAlphaToPS(alpha) ( (float)alpha * 100.0 )

/// Convert a Photoshop Color Percent (0 - 255) to a Quartz Color Percent (0.0 - 1.0).
#define JPPSToQuartz(color) (float)( color / 255.0 )

/// Convert a Quartz Color Percent (0.0 - 1.0) to a Photoshop-like Color Percent (0 - 255).
#define JPQuartzToPS( __color__ ) (int)roundf( __color__  * 255 )


/// Return a UIColor based on a Photoshop Color Percent (0 - 255) for Red, Green and Blue.
#define JPCreateUIColor( r, g, b, alpha ) ( [UIColor colorWithCGColor:JPCreateRGBColor( (float)r, (float)g, (float)b, (float)alpha) ]  )

/// Normalize some value to 0-1;
#define JPNormalizeUp( color ) ((int)roundf( color * 100 ))

/// Normalize some value to 0-100;
#define JPNormalizeDown( __color__ ) ((float)__color__ / 100)
/**
 * Create a Quartz CGColor based on a Photoshop-like Color Percent (0 - 255) for Red, Green and Blue.
 * @param r An Red value from 0 to 255.
 * @param g An Green value from 0 to 255.
 * @param b An Blue value from 0 to 255.
 * @param alpha An opacity value from 0 to 100.
 * @return An retained Quartz CGColorRef object.
 */
CGColorRef JPCreateRGBColor( float r, float g, float b, float alpha ) ;

/**
 * Create a Quartz CGColor based on a JPrgb Type.
 * @param RGB An JPrgb type with values.
 * @param alpha An opacity value from 0 to 100.
 * @return An retained Quartz CGColorRef object.
 */
CGColorRef JPCreateColorWithJPrgb( JPrgb RGB, float alpha ) ;


////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// 
#pragma mark -
#pragma mark Create JPColor Types.

/// Create an JPrgb structure type.
JPrgb	JPCreateRGBType( int r, int g, int b) ;

/// Create an JPcmyk structure type.
JPcmyk	JPCreateCMYKType( int C, int M, int Y, int K) ;

/// Create an JPlab structure type.
JPlab	JPCreateLABType( int L, int A, int B) ;

/// Create an JPhsv structure type.
JPhsv	JPCreateHSVType( int H, int S, int B) ;

////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// 
