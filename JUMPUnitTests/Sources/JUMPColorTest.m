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
#import <GHUnitIOS/GHUnit.h> 
#import "JPColor.h"
#import "JPCore.h"
/**
 * JUMP Database Module Unit Tests
 */
@interface JUMPColorTests : GHTestCase {
	JPColor *anColor;
}
@end

//////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// 
#pragma mark -
@implementation JUMPColorTests

//////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// 
#pragma mark -
#pragma mark Tests

-(void)testColorInit {
	anColor = [[JPColor alloc] init];
	GHAssertNotNil( anColor, @"JPColor wasn't instantiated.");
}

-(void)testCSSColor {
	anColor = [JPColor initWithCSS:@"#FF0000"];
	GHAssertNotNil( anColor, @"JPColor wasn't instantiated.");
	//////////// //////////// //////
	GHAssertTrue( 255 == anColor.RGB.R, @"Red value wasn't setted correctly");
    GHAssertTrue(0 == anColor.RGB.G, @"Green value wasn't setted correctly");
    GHAssertTrue(0 == anColor.RGB.B, @"Blue value wasn't setted correctly");
	//////////// //////////// //////
	[anColor setColorWithCSS:@"#fff"];
	GHAssertTrue( 255 == anColor.RGB.R, @"Red value wasn't setted correctly");
    GHAssertTrue( 255 == anColor.RGB.G, @"Green value wasn't setted correctly");
    GHAssertTrue( 255 == anColor.RGB.B, @"Blue value wasn't setted correctly");
	//////////// //////////// //////
	[anColor setColorWithCSS:@"#2658e8"];
	GHAssertTrue( 38 == anColor.RGB.R, @"Red value wasn't setted correctly");
    GHAssertTrue( 88 == anColor.RGB.G, @"Green value wasn't setted correctly");
    GHAssertTrue( 232 == anColor.RGB.B, @"Blue value wasn't setted correctly");
	//////////// //////////// //////
	[anColor setColorWithCSS:@"rgb(0,255,0)"];
	GHAssertTrue( 0 == anColor.RGB.R, @"Red value wasn't setted correctly");
    GHAssertTrue( 255 == anColor.RGB.G, @"Green value wasn't setted correctly");
    GHAssertTrue( 0 == anColor.RGB.B, @"Blue value wasn't setted correctly");
	//////////// //////////// //////
	[anColor setColorWithCSS:@"rgba(0,255,0,20)"];
	GHAssertTrue( 0 == anColor.RGB.R, @"Red value wasn't setted correctly");
    GHAssertTrue( 255 == anColor.RGB.G, @"Green value wasn't setted correctly");
    GHAssertTrue( 0 == anColor.RGB.B, @"Blue value wasn't setted correctly");
	float anFloat = anColor.opacity;
    GHAssertTrue( 20.0 == anColor.opacity, @"Opacity value wasn't setted correctly");	
	//////////// //////////// //////
	[anColor setColorWithCSS:@"olive"];
	GHAssertTrue( 128 == anColor.RGB.R, @"Red value wasn't setted correctly");
    GHAssertTrue( 128 == anColor.RGB.G, @"Green value wasn't setted correctly");
    GHAssertTrue( 0 == anColor.RGB.B, @"Blue value wasn't setted correctly");
	//////////// //////////// //////
	[anColor setColorWithCSS:@"deepskyblue"];
	GHAssertTrue( 0 == anColor.RGB.R, @"Red value wasn't setted correctly");
    GHAssertTrue( 191 == anColor.RGB.G, @"Green value wasn't setted correctly");
    GHAssertTrue( 255 == anColor.RGB.B, @"Blue value wasn't setted correctly");
}

-(void)testFailCSSColors {
	GHAssertThrows([JPColor initWithCSS:@"x"], @"JPColor should fail!");
	GHAssertThrows([JPColor initWithCSS:@"rgb(p,"], @"JPColor should fail!"); 
}

-(void)testProperties {
	anColor = [JPColor initWithRed:255 G:245 B:235 opacity:99.90f blendMode:5];
	GHAssertNotNil( anColor, @"JPColor wasn't instantiated.");
	//////////// //////////// //////
	GHAssertTrue( 255 == anColor.RGB.R, @"Red value wasn't setted correctly");
    GHAssertTrue( 245 == anColor.RGB.G, @"Green value wasn't setted correctly");
    GHAssertTrue( 235 == anColor.RGB.B, @"Blue value wasn't setted correctly");
	//////////// //////////// //////
	float anFloat = anColor.opacity;
    GHAssertTrue( anColor.opacity > 90.0f, @"Opacity value wasn't setted correctly");
    GHAssertTrue( 5 == anColor.blendMode, @"Blend Mode value wasn't setted correctly");
	//////////// //////////// //////
	GHAssertTrue( 255 == anColor.R, @"Red value wasn't setted correctly");
    GHAssertTrue( 245 == anColor.G, @"Green value wasn't setted correctly");
    GHAssertTrue( 235 == anColor.B, @"Blue value wasn't setted correctly");
	//////////// //////////// //////
	anColor.blendMode = 3;
    GHAssertTrue( 3 == anColor.blendMode, @"Blend Mode value wasn't setted correctly");
}

-(void)testDictionary {
	anColor = [JPColor initWithRed:255 G:245 B:235 opacity:33 blendMode:5];
	GHAssertNotNil( anColor, @"JPColor wasn't instantiated.");
	//////////// //////////// //////
	float anFloat = anColor.opacity;
	NSDictionary *convertColors = [anColor dictionary];
	//////////// //////////// //////
	JPColor *newColor = [JPColor initWithDictionary:convertColors];
	//////////// //////////// //////
	GHAssertTrue( newColor.R == anColor.R, @"Red value wasn't setted correctly");
    GHAssertTrue( newColor.G == anColor.G, @"Green value wasn't setted correctly");
    GHAssertTrue( newColor.B == anColor.B, @"Blue value wasn't setted correctly");
	anFloat = newColor.opacity;
    GHAssertTrue( newColor.opacity == anColor.opacity, @"Opacity value wasn't setted correctly");
}

-(void)testUIColor {
	anColor = [JPColor initWithRed:136 G:93 B:100 opacity:50];
	GHAssertNotNil( anColor, @"JPColor wasn't instantiated.");
	////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// 
	UIColor *color = anColor.UIColor;
	GHAssertNotNil( color, @"UIColor wasn't instantiated.");
	////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// 
	CGColorRef cgColor = anColor.CGColor;
	const CGFloat *rgba = CGColorGetComponents(cgColor);
	GHAssertTrue( 136 == JPQuartzToPS ( rgba[0] ), @"Red value wasn't setted correctly");
    GHAssertTrue( 93  == JPQuartzToPS ( rgba[1] ), @"Green value wasn't setted correctly");
    GHAssertTrue( 100 == JPQuartzToPS ( rgba[2] ), @"Blue value wasn't setted correctly");
    GHAssertTrue( 50  == JPNormalizeUp( rgba[3] ), @"Opacity value wasn't setted correctly");
}

-(void)testConvertions {
	anColor = [JPColor initWithCyan:70 M:30 Y:10 K:10 opacity:100];
	GHTestLog( @"Check this convertions using the Photoshop or any other trustable color converter.");
	GHTestLog( @"Created ->-- C: %i, M: %i, G: %i, K: %i", anColor.CMYK.C, anColor.CMYK.M, anColor.CMYK.Y, anColor.CMYK.K );
	GHTestLog( @"Converted ->-- R: %i, G: %i, B: %i", anColor.R, anColor.G, anColor.B );
	GHTestLog( @"Converted ->-- H: %i, S: %i, B: %i", anColor.HSV.H, anColor.HSV.S, anColor.HSV.V );
	GHTestLog( @"-----------");
	////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// 
	[anColor setColorRed:0 G:0 B:0 opacity:100];
	GHTestLog( @"Created  ->-- R: %i, G: %i, B: %i", anColor.R, anColor.G, anColor.B );
	GHTestLog( @"Converted ->-- C: %i, M: %i, G: %i, K: %i", anColor.CMYK.C, anColor.CMYK.M, anColor.CMYK.Y, anColor.CMYK.K );
	GHTestLog( @"Converted ->-- H: %i, S: %i, B: %i", anColor.HSV.H, anColor.HSV.S, anColor.HSV.V );
	GHTestLog( @"-----------");
	////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// 
	[anColor setColorRed:0 G:0 B:255 opacity:100];
	GHTestLog( @"Created  ->-- R: %i, G: %i, B: %i", anColor.R, anColor.G, anColor.B );
	GHTestLog( @"Converted ->-- C: %i, M: %i, G: %i, K: %i", anColor.CMYK.C, anColor.CMYK.M, anColor.CMYK.Y, anColor.CMYK.K );
	GHTestLog( @"Converted ->-- H: %i, S: %i, B: %i", anColor.HSV.H, anColor.HSV.S, anColor.HSV.V );
	GHTestLog( @"-----------");
	////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// 
	[anColor setColorRed:155 G:155 B:155 opacity:100];
	GHTestLog( @"Created  ->-- R: %i, G: %i, B: %i", anColor.R, anColor.G, anColor.B );
	GHTestLog( @"Converted ->-- C: %i, M: %i, G: %i, K: %i", anColor.CMYK.C, anColor.CMYK.M, anColor.CMYK.Y, anColor.CMYK.K );
	GHTestLog( @"Converted ->-- H: %i, S: %i, B: %i", anColor.HSV.H, anColor.HSV.S, anColor.HSV.V );
	GHTestLog( @"-----------");
	////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// 
	[anColor setColorWithHue:136 S:93 V:100 opacity:100];
	GHTestLog( @"Created ->-- H: %i, S: %i, B: %i", anColor.HSV.H, anColor.HSV.S, anColor.HSV.V );
	GHTestLog( @"Converted ->-- R: %i, G: %i, B: %i", anColor.R, anColor.G, anColor.B );
	GHTestLog( @"Converted ->-- C: %i, M: %i, G: %i, K: %i", anColor.CMYK.C, anColor.CMYK.M, anColor.CMYK.Y, anColor.CMYK.K );
}

-(void)testLightAndDark {
	anColor = [JPColor initWithRed:38 G:88 B:232 opacity:100];
	GHTestLog( @"Check this convertions using the Photoshop or any other trustable color converter.");
	GHTestLog( @"Created ->-- R: %i, G: %i, B: %i", anColor.R, anColor.G, anColor.B );
	////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// 
	anColor = [anColor lighter];
	GHTestLog( @"Lighter  ->-- R: %i, G: %i, B: %i", anColor.R, anColor.G, anColor.B );
	////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// 
	anColor = [anColor darker];
	GHTestLog( @"Darker  ->-- R: %i, G: %i, B: %i", anColor.R, anColor.G, anColor.B );
}
@end