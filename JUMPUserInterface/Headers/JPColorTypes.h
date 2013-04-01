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
//#if !TARGET_OS_IPHONE 
//    #import <ApplicationServices/ApplicationServices.h>
//#else
    #import <CoreGraphics/CoreGraphics.h>
//#endif
/**
 * \file JPColorTypes.h
 * JPColor Data Type Structure for different color spaces.
 */

/**
 * JPColor RGB Structure Type. Use #JPCreateRGBType to conveniently create this structure.
 * @see JPConvertRGBtoCMYK, JPConvertCMYKtoRGB, JPConvertRGBtoHSV, JPConvertHSVtoRGB functions.
 */
struct JPrgb {
	/*! Red (0-255) value */
	int R;
	/*! Green (0-255) value */
	int G;
	/*! Blue (0-255) value */
	int B;
};
typedef struct JPrgb JPrgb;

/// JPColor CMY Structure Type.
struct JPcmy {
	/*! Cyan (0-100) value */
	int C;
	/*! Magenta (0-100) value */
	int M;
	/*! Yellow (0-100) value */
	int Y;
};
typedef struct JPcmy JPcmy;

/**
 * JPColor CMYK Structure Type. Use #JPCreateCMYKType to conveniently create this structure.
 * @see JPConvertRGBtoCMYK, JPConvertCMYKtoRGB functions.
 */
struct JPcmyk {
	/*! Cyan (0-100) value */
	int C;
	/*! Magenta (0-100) value */
	int M;
	/*! Yellow (0-100) value */
	int Y;
	/*! Black (0-100) value */
	int K;
};
typedef struct JPcmyk JPcmyk;

/**
 * JPColor HSB Structure Type. Use #JPCreateHSVType to conveniently create this structure.
 * @see JPConvertRGBtoHSV, JPConvertHSVtoRGB functions.
 */
struct JPhsv {
	/*! Hue value */
	int H;
	/*! Saturation value */
	int S;
	/*! Brighntess value */
	int V;
};
typedef struct JPhsv JPhsv;

/// JPColor LAB Structure Type. Use #JPCreateLABType to conveniently create this structure.
struct JPlab {
	int L;
	int A;
	int B;
};
typedef struct JPlab JPlab;

/// JPColor XYZ Structure Type.
struct JPxyz {
	int X;
	int Y;
	int Z;
};
typedef struct JPxyz JPxyz;