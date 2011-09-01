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
#if !TARGET_OS_IPHONE 
    #import <ApplicationServices/ApplicationServices.h>
#else
    #import <CoreGraphics/CoreGraphics.h>
#endif
#import "JPColorTypes.h"

/**
 * \file JPColorConvertFunctions.h
 * JPColor functions to convert between color spaces.
 */

////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// 
#pragma mark -
#pragma mark Convert Color Functions.
/// Convert from RGB to CMYK.
JPcmyk	JPConvertRGBtoCMYK( JPrgb RGB );

/// Convert from CMYK to RGB.
JPrgb	JPConvertCMYKtoRGB( JPcmyk CMYK );

#pragma mark -

/// Convert from RGB to HSV.
JPhsv	JPConvertRGBtoHSV( JPrgb RGB );
/// Convert from HSV to RGB.
JPrgb	JPConvertHSVtoRGB( JPhsv HSB );

#pragma mark -

/// Convert from RGB to XYZ.
JPxyz	JPConvertRGBtoXYZ( JPrgb RGB );
/// Convert from HSV to RGB.
JPrgb	JPConvertHSBtoXYZ( JPxyz XYZ );

#pragma mark -

/// Convert from RGB to LAB.
JPlab	JPConvertRGBtoLAB( JPrgb RGB );
/// Convert from LAB to RGB.
JPrgb	JPConvertLABtoRGB( JPlab LAB );

#pragma mark -

/// Convert from XYZ to LAB.
JPlab	JPConvertXYZtoLAB( JPxyz XYZ );
/// Convert from LAB to XYZ.
JPxyz	JPConvertLABtoXYZ( JPlab LAB );

#pragma mark -

/// Convert from XYZ to RGB.
JPrgb	JPConvertXYZtoRGB( JPxyz XYZ );
/// Convert from RGB to XYZ.
JPxyz	JPConvertRGBtoXYZ( JPrgb RGB );

////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// 
