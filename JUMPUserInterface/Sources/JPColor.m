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
#import "JPColor.h"

@implementation JPColor

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Properties.
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@synthesize R = __r, G = __g, B = __b;
@synthesize blendMode = __blendMode;
@synthesize opacity;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Private Methods.
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-(NSDictionary*)dictionary {
	return [NSDictionary dictionaryWithObjectsAndKeys:
				  [NSNumber numberWithInt:__r], @"R",
				  [NSNumber numberWithInt:__g], @"G",
				  [NSNumber numberWithInt:__b], @"B",
				  [NSNumber numberWithFloat:opacity], @"opacity",
				  [__blendModes objectAtIndex:__blendMode], @"blendMode",
			nil];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////
-(CGBlendMode)convertBlendModeFromString:(NSString*)anBlendModeName {
	return [__blendModes indexOfObject:anBlendModeName];
}

///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// 
#pragma mark -
#pragma mark Init Methods.
///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// 
- (id) init {
	self = [super init];
	if (self != nil) {
		// Blend Modes String.
		__blendModes = [[NSArray alloc] initWithObjects:   
					  @"kCGBlendModeNormal",
					  @"kCGBlendModeMultiply",
					  @"kCGBlendModeScreen",
					  @"kCGBlendModeOverlay",
					  @"kCGBlendModeDarken",
					  @"kCGBlendModeLighten",
					  @"kCGBlendModeColorDodge",
					  @"kCGBlendModeColorBurn",
					  @"kCGBlendModeSoftLight",
					  @"kCGBlendModeHardLight",
					  @"kCGBlendModeDifference",
					  @"kCGBlendModeExclusion",
					  @"kCGBlendModeHue",
					  @"kCGBlendModeSaturation",
					  @"kCGBlendModeColor",
					  @"kCGBlendModeLuminosity",
					  @"kCGBlendModeClear",
					  @"kCGBlendModeCopy",
					  @"kCGBlendModeSourceIn",
					  @"kCGBlendModeSourceOut",
					  @"kCGBlendModeSourceAtop",
					  @"kCGBlendModeDestinationOver",
					  @"kCGBlendModeDestinationIn",
					  @"kCGBlendModeDestinationOut",
					  @"kCGBlendModeDestinationAtop",
					  @"kCGBlendModeXOR",
					  @"kCGBlendModePlusDarker",
					  @"kCGBlendModePlusLighter", nil];
	}
	return self;
}

///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// //////
// Initializes and returns an JPColor from a UIColor object.
+(JPColor*)initWithUIColor:(UIColor*)anUIColorObject {

	// Get the Color Reference.
	CGColorRef colorref = [anUIColorObject CGColor];
	
	// Get the Color Components.
	const CGFloat *components = CGColorGetComponents(colorref);

	// Init and return.
	return [JPColor initWithRed:JPQuartzToPS( components[0] )
							  G:JPQuartzToPS( components[1] )
							  B:JPQuartzToPS( components[2] )
						opacity:JPQuartzAlphaToPS( components[3] )];
}

///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// //////
// Init object from one Dictionary.
+(JPColor*)initWithDictionary:(NSDictionary*)anDictionary {
	// Create new instance.
	JPColor *anInstance = [[[JPColor alloc] init] autorelease];

	// Set Color and return.
	[anInstance setColorWithDictionary:anDictionary];	 
	return anInstance;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Initializes and returns a JPColor using the specified opacity and grayscale values.
+(JPColor*)initWithGrayScale:(int)grayscale opacity:(float)anAlpha {
	return [JPColor initWithRed:grayscale G:grayscale B:grayscale opacity:anAlpha];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Init object with HSB color.
+(JPColor*)initWithHue:(int)hue S:(int)saturation V:(int)brightness opacity:(float)anAlpha {
	return [JPColor iniWithJPrgb:JPConvertHSVtoRGB(JPCreateHSVType((float)hue, (float)saturation, (float)brightness)) opacity:anAlpha ];
}

/////////////////////////////////////////////////////////////////////////////////////
// Init object with JPrgb type.
+(id)initWithJPrgb:(JPrgb)values {
	return [JPColor initWithRed:values.R G:values.G B:values.B opacity:100];
}

/////////////////////////////////////////////////////////////////////////////////////
+(JPColor*)initWithCyan:(int)cyan M:(int)magenta Y:(int)yellow K:(int)black opacity:(float)anAlpha {
	// Convert CMYK color.
	JPrgb converted = JPConvertCMYKtoRGB( JPCreateCMYKType(cyan, magenta, yellow, black));
	// Init and return.
	return [JPColor iniWithJPrgb:converted opacity:anAlpha];
}

////////////////////////////////////////////////
// Init object with JPrgb type and opacity.
+(id)iniWithJPrgb:(JPrgb)values opacity:(float)anAlpha{
	return [JPColor initWithRed:values.R G:values.G B:values.B opacity:anAlpha];   
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
+(JPColor*)initWithRed:(int)Red G:(int)Green B:(int)Blue opacity:(float)anAlpha {
	return [JPColor initWithRed:Red G:Green B:Blue opacity:anAlpha blendMode:0];   
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
+(JPColor*)initWithCSS:(NSString*)anCSSString {
	// Create new instance.
	JPColor *anInstance = [[[JPColor alloc] init] autorelease];
	
	// Set Color and return.
	[anInstance setColorWithCSS:anCSSString];
	return anInstance;
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
+(JPColor*)initWithRed:(int)Red G:(int)Green B:(int)Blue opacity:(float)anAlpha blendMode:(CGBlendMode)anBlendMode {
	// Create new instance.
	JPColor *anInstance = [[[JPColor alloc] init] autorelease];

	// Set Color and return.
	[anInstance setColorRed:Red G:Green B:Blue opacity:anAlpha blendMode:anBlendMode  ];
	return anInstance;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Set Methods.
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

-(void)setColorRed:(int)Red G:(int)Green B:(int)Blue opacity:(float)anAlpha {
	// Set internal properties. Call the full properties, Assume Blend Effect as Normal.
	[self setColorRed:Red G:Green B:Blue opacity:anAlpha blendMode:0 ];   
}

////////////// /////////////////////// ////////////////////////
// Set color with Dictionary.
- (void)setColorWithDictionary:(NSDictionary*)anDictionary {
	
	////////////////////////////////////////////////////////////
	// Parse the Dictionary Value with Blend.
	if ( [anDictionary objectForKey:@"blendMode" ] )
		  [self setColorRed:[ [anDictionary objectForKey:@"R" ] intValue ]
						  G:[ [anDictionary objectForKey:@"G" ] intValue ] 
						  B:[ [anDictionary objectForKey:@"B" ] intValue ]
					opacity:[ [anDictionary objectForKey:@"opacity" ] floatValue ]
				blendMode:[ self convertBlendModeFromString:[ anDictionary objectForKey:@"blendMode"] ] ];
	
	////////////////////////////////////////////////////////////
	// Parse the dictionary withoug blend.
	else {
		[self setColorRed:[ [anDictionary objectForKey:@"R" ] intValue ]
						G:[ [anDictionary objectForKey:@"G" ] intValue ] 
						B:[ [anDictionary objectForKey:@"B" ] intValue ]
				  opacity:[ [anDictionary objectForKey:@"opacity" ] floatValue ]];
	}
}

///////////// //////////////// //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-(void)setColorWithCSS:(NSString*)anCSSString {
	// Convert String on a array of characters divided by ",", "(" and ")".
	NSArray* cssValues = [anCSSString componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"(,)"]];
	
	///////////// //////////////// 
	// RGB color and Default opacity.
	JPrgb anRGB;
	float anopacity = 100.0;
	
	///////////// ////////////////  ///////////// //////////////// ///////////// //////////////// 
	// Anything more or less is unsupported, and therefore this property is ignored
	// according to the W3C guidelines.
	if ( ! ([cssValues count] == 1
		 || [cssValues count] == 5    // rgb( x x x )
		 || [cssValues count] == 6) )  // rgba( x x x x )
	{
		[NSException raise:@"JPColorException" format:@"CSS String '%@' unsupported.", anCSSString];
		return;
	}
	
	////////////////  ///////////// //////////////// ///////////// //////////////// 
	// Decode.
	if ([cssValues count] == 1) {
		NSString* cssString = [cssValues objectAtIndex:0];
		
		if ([cssString characterAtIndex:0] == '#') {
			unsigned long colorValue = 0;
			
			////////////////  ///////////// //////////////// ///////////// //////////////// 
			// #FFF
			if ([cssString length] == 4) {
				colorValue = strtol([cssString UTF8String] + 1, nil, 16);
				colorValue = ((colorValue & 0xF00) << 12) | ((colorValue & 0xF00) << 8)
				| ((colorValue & 0xF0) << 8) | ((colorValue & 0xF0) << 4)
				| ((colorValue & 0xF) << 4) | (colorValue & 0xF);
			} 
			
			////////////////  ///////////// //////////////// ///////////// //////////////// 
			// #FFFFFF
			else if ([cssString length] == 7) {
				colorValue = strtol([cssString UTF8String] + 1, nil, 16);
			}

			// Assign to RGB structure.
			anRGB = JPCreateRGBType(((colorValue & 0xFF0000) >> 16),
									((colorValue & 0xFF00) >> 8),
									 (colorValue & 0xFF));
			
		} 
		
		///  ///////////// //////////////// ///////////// //////////////// 
		// No color to assign.
		else if ([cssString isEqualToString:@"none"]) {
			return;
			
		///  ///////////// //////////////// ///////////// //////////////// 
		// Some color name.
		} else {
			if ( [JPColor respondsToSelector:NSSelectorFromString(cssString)] ) {
				JPColor *instance = [[JPColor performSelector:NSSelectorFromString(cssString)] retain];
				// Retrieve values.
				anRGB = [instance RGB];
				anopacity = [instance opacity];
				// Release instance.
				[instance release];
			} 
			// Unknown color name.
			else {
				[NSException raise:@"JPColorException" format:@"Unkown CSS color name '%@', can't be created.", cssString];
				return;
			}
		}
	}
	///  ///////////// //////////////// ///////////// //////////////// 
	// Setted as rgb() on CSS.
	else if ([cssValues count] == 5 && [[cssValues objectAtIndex:0] isEqualToString:@"rgb"]) {
		// rgb( x x x )
		anRGB = JPCreateRGBType([[cssValues objectAtIndex:1] intValue],
								[[cssValues objectAtIndex:2] intValue],
								[[cssValues objectAtIndex:3] intValue]);
	} 
	
	///  ///////////// //////////////// ///////////// //////////////// 
	// Setted as rgba() on CSS.
	else if ([cssValues count] == 6 && [[cssValues objectAtIndex:0] isEqualToString:@"rgba"]) {
		// rgba( x x x x )
		anRGB = JPCreateRGBType([[cssValues objectAtIndex:1] intValue],
								[[cssValues objectAtIndex:2] intValue],
								[[cssValues objectAtIndex:3] intValue]);
		// opacity.
		anopacity = [[cssValues objectAtIndex:4] intValue];
	}

	///////////// //////////////// ///////////// //////////////// 
	// If can't decode nothing. Throw an error.
	else {
		[NSException raise:@"JPColorException" format:@"No decode condition was reached for '%@' CSS String.", anCSSString];
		return;
	}
	
	// Apply the color.
	[self setColorRed:anRGB.R G:anRGB.G B:anRGB.B opacity:anopacity];
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setColorWithHue:(int)hue S:(int)saturation V:(int)brightness opacity:(float)anAlpha {
	// Convert to RGB.
	JPrgb converted = JPConvertHSVtoRGB( JPCreateHSVType((float)hue, (float)saturation, (float)brightness));
	// Set RGB Color.
	[self setColorRed:converted.R G:converted.G B:converted.B opacity:anAlpha];
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setColorRed:(int)Red G:(int)Green B:(int)Blue opacity:(float)anAlpha blendMode:(CGBlendMode)anBlendMode {
	
	// Set internal properties.
	__r = Red;
	__g = Green;
	__b = Blue;
	opacity = anAlpha;
		
	// Set Blend Effect.
	__blendMode = anBlendMode;
}

///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// 
#pragma mark -
#pragma mark Getters.
///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// 
-(JPrgb)RGB {
	return JPCreateRGBType(__r, __g, __b);
}
///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// /
-(JPcmyk)CMYK {
	return JPConvertRGBtoCMYK( self.RGB );
}
///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// /
-(JPhsv)HSV {
	return JPConvertRGBtoHSV( self.RGB );
}
///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// /
-(CGColorRef)CGColor {
	return JPCreateColorWithJPrgb(self.RGB, opacity);
}
///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// /
-(UIColor*)UIColor { 
	return [UIColor colorWithCGColor:self.CGColor];
}

///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// 
#pragma mark -
#pragma mark Color Processing Methods.
///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// 
- (JPColor*)multiplyHue:(float)hd saturation:(float)sd value:(float)vd {
	JPhsv HSV = self.HSV;
	JPrgb rgbValues = JPConvertHSVtoRGB( JPCreateHSVType( (float)HSV.H * hd , (float)HSV.S * sd, (float)HSV.V * vd) );
	// Set values.
	[self setColorRed:rgbValues.R G:rgbValues.G B:rgbValues.B opacity:self.opacity blendMode:self.blendMode];
	// Return itself.
	return self;
}

///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// //////
- (JPColor*)addHue:(float)hd saturation:(float)sd value:(float)vd {
	JPhsv HSV = self.HSV;
	JPrgb rgbValues = JPConvertHSVtoRGB( JPCreateHSVType( (float)HSV.H + hd , (float)HSV.S + sd, (float)HSV.V  + vd) );
	// Set values.
	[self setColorRed:rgbValues.R G:rgbValues.G B:rgbValues.B opacity:self.opacity blendMode:self.blendMode];
	// Return itself.
	return self;
}

///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// //////
// Create a lighter version of the color.
- (JPColor*)lighter {
	return [self multiplyHue:1 saturation:0.5 value:1.1];
}

///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// //////
// Create a darker version of the color.
- (JPColor*)darker {
	return [self multiplyHue:1 saturation:1.6 value:0.6];
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Object Copy.
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
- (JPColor*)copyWithAlpha:(float)newAlpha {
	return [JPColor initWithRed:__r G:__g B:__b opacity:newAlpha blendMode:self.blendMode];
}

///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// //////
- (id)copyWithZone:(NSZone *)zone {
	
	// Alloc a new object, pass all the data to the new object. This method is on PhotoshopImage.
	JPColor *copy = [[[self class] allocWithZone: zone] initWithRed:__r
																  G:__g
																  B:__b
															opacity:opacity 
														blendMode:__blendMode];
	return copy;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Free Memory - Release. 
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
	[__blendModes release], __blendModes = nil;
	[super dealloc];
}


@end
