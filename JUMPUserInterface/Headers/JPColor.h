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
#import <UIKit/UIKit.h>
#if !TARGET_OS_IPHONE 
    #import <ApplicationServices/ApplicationServices.h>
#else
    #import <CoreGraphics/CoreGraphics.h>
#endif
#import "JPColorTypes.h"
#import "JPColorFunctions.h"
#import "JPColorConvertFunctions.h"

/**
 * \nosubgrouping 
 * \class JPColor
 
 JPColor is an Color Object that encapsulate information about colors on different color spaces. Is similar
 to the <a href="http://developer.apple.com/library/ios/#documentation/uikit/reference/UIColor_Class/Reference/Reference.html">UIKit/UIColor class</a>, 
 but with a lot of more convenient and powerfull features.
 Contains several convenient methods to easily create colors and convert between spaces.
 
 
 <h2> Creating colors </h2>
 An example to how to create an JPColor with RGB values.
 \code
 JPColor anColor = [JPColor initWithRed:255 G:0 B:0 opacity:100];
 \endcode
 The above code create an <b>red</b> color. Note that JPColor use an Photoshop-like values (0-255) to represent
 RGB colors. So once created an JPColor is easy to convert it to an UIColor like this:
 \code
 UIColor anUIColor = [[JPColor initWithRed:255 G:0 B:0 opacity:100] UIColor];
 \endcode
 You also can create color using different color spaces, like CMYK;
 \code
 JPColor *cmyk = [JPColor initWithCyan:0 M:100 Y:100: K:0 opacity:100];
 \endcode
 Or an CSS string, like this:
 \code
 JPColor *color = [JPColor initWithCSS:@"#2658e8"];
 \endcode

 <h2>Colors Templates</h2>
 JPColor includes an collection of \ref color templates methods 
 that follow the <a href="http://www.w3.org/TR/css3-color/#svg-color">W3C CSS 3 Extended Colors Keywords</a>.  
 You can retrieve this methods simply calling his name, like this:
 \code
 JPColor *seaGreenColor = [JPColor seagreen];
 \endcode
 
 <h2>Colors Type Structures</h2>
 JPColor return different \link JPColorTypes.h structures types\endlink with values for different color spaces.
 See #RGB, #CMYK and #HSV properties to learn more about it.
 Here one exampe retrieving an CMYK structure and displaying it:
 \code
 JPColor *anColor = [JPColor greenColor];
 JPcmyk repr = [anColor CMYK];
 
 // Print values.
 NSLog( @"C:%i, M:%i, Y:%i, K:%i", repr.C, repr.M, repr.Y, repr.K );
 \endcode
 
 */
@interface JPColor : NSObject <NSCopying> {   
	
	// Main Properties.
	int __r;
	int __g;
	int __b;
	float opacity;
	
	// Internal control of adjusment mode.
	CGBlendMode __blendMode;
	
	// Blend Modes String.
	NSArray *__blendModes;
	
}
////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// 
#pragma mark -
#pragma mark Properties.
////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// 
/**
 * Red value (0-255)
 */
@property (readonly) int R;

/**
 * Green value (0-255)
 */
@property (readonly) int G;

/**
 * Blue value (0-255)
 */
@property (readonly) int B;

/**
 * opacity value (0-100)
 */
@property (readonly) float opacity;

/**
 * An JPrgb type with setted Red, Green and Blue representation of this object.
 */
@property (readonly) JPrgb RGB;

/**
 * An JPcmyk type with setted Cyan, Magenta, Yellow and Black representation of this object.
 */
@property (readonly) JPcmyk CMYK;  

/**
 * An JPhsv type with setted Hue, Saturation and Brightness representation of this object.
 */
@property (readonly) JPhsv HSV;

/**
 * An Quartz Blend Mode associated with this color.
 */
@property (assign) CGBlendMode blendMode;

/**
 * The Quartz Color reference that corresponds to the receiver’s color.
 * @return An retained CGColorRef object. Is your responsability to safe release this object.
 */
@property (readonly) CGColorRef CGColor;

/**
 * Generate an UIColor object with stored values os this object.
 */
@property (readonly) UIColor* UIColor;

////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// 
#pragma mark -
#pragma mark Init Methods.
////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// 
/** @name Init Methods
 */
///@{

/**
 * Initializes and returns an JPColor from a UIColor object.
 * @param anUIColorObject An UIColor object.
 */
+(JPColor*)initWithUIColor:(UIColor*)anUIColorObject;

/**
 * Initializes and returns an JPColor from a NSDictionary.
 * The Dictionary must contain the follow structure:
 * \code
 * [<int>, @"R", <int>, @"G", <int>, @"B", <int>, @"opacity", <CGBlendMode>, @"blendMode"]
 * \endcode
 * @param anDictionary An dictionary with values to create the color object.
 */
+(JPColor*)initWithDictionary:(NSDictionary*)anDictionary;

/**
 * Initializes and returns an JPColor using the specified opacity and grayscale values.
 * @param grayscale An gray scale from 0 to 100.
 * @param anAlpha An opacity value from 0 to 100.
 */
+(JPColor*)initWithGrayScale:(int)grayscale opacity:(float)anAlpha;

/**
 * Initializes and returns a JPColor object using the specified opacity and RGB component values.
 * @param Red An Red value from 0 to 255.
 * @param Green An Green value from 0 to 255.
 * @param Blue An Blue value from 0 to 255.
 * @param anAlpha An opacity value from 0 to 100.
 */
+(JPColor*)initWithRed:(int)Red G:(int)Green B:(int)Blue opacity:(float)anAlpha;

/**
 * Initializes and returns a JPColor object using the specified opacity and HSB color space component values.
 * @param hue An Hue value from 0 to 360.
 * @param saturation An Saturation value from 0 to 100.
 * @param brightness An Brightness value from 0 to 100.
 * @param anAlpha An opacity value from 0 to 100.
 */
+(JPColor*)initWithHue:(int)hue S:(int)saturation V:(int)brightness opacity:(float)anAlpha;

/**
 * Initializes and returns a JPColor object using the specified opacity and CMYK color space component values.
 * @param cyan An Cyan value from 0 to 100.
 * @param magenta An Magenta value from 0 to 100.
 * @param yellow An Yellow value from 0 to 100.
 * @param black An Black value from 0 to 100.
 * @param anAlpha An opacity value from 0 to 100.
 */
+(JPColor*)initWithCyan:(int)cyan M:(int)magenta Y:(int)yellow K:(int)black opacity:(float)anAlpha;

/**
 * Initializes and returns a JPColor object using an JPrgb type.
 * @param values An JPrgb variable with with setted Red, Green and Blue values.
 */
+(JPColor*)initWithJPrgb:(JPrgb)values;

/**
 * Initializes and returns a JPColor object using an JPrgb type and opacity.
 * @param values An JPrgb variable with with setted Red, Green and Blue values.
 * @param anAlpha An opacity value from 0 to 100.
 */
+(JPColor*)iniWithJPrgb:(JPrgb)values opacity:(float)anAlpha;

/**
 * Initializes and returns a JPColor object using an String representing an CSS color.
 * This method understand several types of color representations usually encountered on CSS definitions as:
 *    - #fff
 *    - #FFFF
 *    - rgb(255,255,255)
 *    - rgba(100,100,100,50)
 * <p>
 * This value also can be one of the <a href="http://www.w3.org/TR/css3-color/#svg-color">W3C CSS 3 
 * Extended Colors Keywords</a>.
 * @throw An <b>JPColorException</b> if can't decode this string.
 */
+(JPColor*)initWithCSS:(NSString*)anCSSString;

/**
 * Initializes and returns a JPColor object using the specified opacity and RGB component values.
 * @param Red An Red value from 0 to 255.
 * @param Green An Green value from 0 to 255.
 * @param Blue An Blue value from 0 to 255.
 * @param anAlpha An opacity value from 0 to 100.
 * @param anBlendMode An Quartz Blend Mode (CGBlendMode) to associate with this object.
 */
+(JPColor*)initWithRed:(int)Red G:(int)Green B:(int)Blue opacity:(float)anAlpha blendMode:(CGBlendMode)anBlendMode;

///@}
////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// 
#pragma mark -
#pragma mark Convert Methods.
////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// 
/** @name Convert Methods
 */
///@{

/**
 * Parse the stored values of this object to an NSDictionary.
 * @see The initWithDictionary: method for more information.
 */
-(NSDictionary*)dictionary;

///@}
////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// 
#pragma mark -
#pragma mark Set Methods.
////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// 
/** @name Set Methods
 */
///@{

/**
 * Set Red, Green, Blue and opacity values.
 * @param Red An Red value from 0 to 255.
 * @param Green An Green value from 0 to 255.
 * @param Blue An Blue value from 0 to 255.
 * @param anAlpha An opacity value from 0 to 100.
 */
- (void)setColorRed:(int)Red G:(int)Green B:(int)Blue opacity:(float)anAlpha;

/**
 * Set Red, Green, Blue, opacity and Blend Effect values.
 * @param Red An Red value from 0 to 255.
 * @param Green An Green value from 0 to 255.
 * @param Blue An Blue value from 0 to 255.
 * @param anAlpha An opacity value from 0 to 100.
 * @param anBlendMode An Quartz Blend Mode (CGBlendMode) to associate with this object.
 */
 - (void)setColorRed:(int)Red G:(int)Green B:(int)Blue opacity:(float)anAlpha blendMode:(CGBlendMode)anBlendMode;

/**
 * Set Hue, Saturaton, Brigtness and opacity.
 * @copydetails JPColor::initWithHue:S:V:opacity:
 */
- (void)setColorWithHue:(int)hue S:(int)saturation V:(int)brightness opacity:(float)anAlpha;

/**
 * Set color with an String representing an CSS color.
 * @copydetails JPColor::initWithCSS:
 */
-(void)setColorWithCSS:(NSString*)anCSSString;

/** 
 * Set color with an NSDictionary.
 * @copydetails JPColor::initWithDictionary:
 */
- (void)setColorWithDictionary:(NSDictionary*)anDictionary;

///@}
////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// 
#pragma mark -
#pragma mark Color Processing Methods.
////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// 
/** @name Color Processing Methods
 */
///@{

/**
 * Multiply new HSV values to current object.
 * @copydetails #addHue:saturation:value:
 */
- (JPColor*)multiplyHue:(float)hd saturation:(float)sd value:(float)vd;

/**
 * Add new HSV values to current object.
 * @param hd An Hue value from 0 to 255.
 * @param sd An Saturation value from 0 to 255.
 * @param vd An Brightness value from 0 to 255.
 * @return Return itself.
 */ 
- (JPColor*)addHue:(float)hd saturation:(float)sd value:(float)vd;

/**
 * Add more light to current color.
 * @return Return itself.
 */
- (JPColor*)lighter;

/**
 * Remove light from current color (More darker).
 * @return Return itself.
 */
- (JPColor*)darker;

/**
 * Make a new copy of this object assigning one new opacity Value.
 * @return An new autoreleaseable instance.
 */
- (JPColor*)copyWithAlpha:(float)newAlpha;


///@}
@end
