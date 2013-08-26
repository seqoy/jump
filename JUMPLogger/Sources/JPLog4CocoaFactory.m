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
#import "JPLog4CocoaFactory.h"

////////// ////////// ////////// ////////// 
@implementation JPLog4CocoaFactory 

// Static Logger Class.
static BOOL configured;

////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// 
// Default configuration for the logger.
+(BOOL)configureLogger {
	// If no Class defined, assume default.
	if ( [self loggerClass] == nil ) 
		 [self setLoggerClass:[JPLog4CocoaLogger class]];

	// If already configured, doesn't configure again.
	if ( configured )
		return YES;
	
	// Try to configure from file first.
    BOOL success = [self configureWithFile:@"JPLogger.properties"];
    
	////////// ////////// ////////// ////////// /////////////// ////////// ////////// ////////// /////////////// ////////// ///////
    // If can't, configure locally, using Default values.
    if ( !success) {
		// Custom Layout.
		L4Layout *anLayout = [[L4PatternLayout alloc] initWithConversionPattern:@"[%-5p]: %m%n"];
		
		// Get global level.
		L4Level *globalLevel = [JPLog4CocoaFactory convertJPLevel:[JPLog4CocoaFactory globalLevel]];
								
		// Default level is global level.
		[[L4Logger rootLogger] setLevel:globalLevel];
		
        // Create Appender.
        L4ConsoleAppender *appender = [[L4ConsoleAppender alloc] initTarget:YES withLayout:anLayout];
        
		// Add Console Appender.
        [[L4Logger rootLogger] addAppender:appender];
        
        // Release appender.
	}
    
	// Set as configured.
	configured = YES;
	
    // Everything ok.
    return YES;
}

////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// 
// If the Logging Framework that you're using support load configuration from a file.
+(BOOL)configureWithFile:(NSString*)anFileName {
	// Format file path.
	NSString *filename = [NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] bundlePath], anFileName];

	// If doesn't exist the file, return false.
	if ( ! [[NSFileManager defaultManager] fileExistsAtPath:filename] ) {
		return NO;
    }
	
	// If exist, configure with this file.
	L4PropertyConfigurator *configurator = [[L4PropertyConfigurator alloc] initWithFileName:filename];
	[configurator configure];
	
	// Everything ok.
    return YES;
}

////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// 
#pragma mark -
#pragma mark Level Methods
////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// 
//
+(void)setGlobalLevel:(JPLoggerLevels)desiredLevel {
	// Level.
	L4Level *anLevel = [JPLog4CocoaFactory convertJPLevel:desiredLevel];;
	
	// Set the log level on root logger.
	[[L4Logger rootLogger] setLevel:anLevel];
}

///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// 
+(JPLoggerLevels)globalLevel {
	// Compiler condition to disable all logs.
	#ifndef JPLOGGER_DISABLE_ALL
		
		// Current level for root logger.
		L4Level *anLevel = [[L4Logger rootLogger] level];
		
		// Convert and return.
		return [JPLog4CocoaFactory convertL4Level:anLevel];
		
		///////////// ///////////// /////////
	#else
		return JPLoggerOffLevel;
	#endif

}

///@}
///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// 
#pragma mark -
#pragma mark Level Translation Methods.
///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// 
+(JPLoggerLevels)convertL4Level:(L4Level*)anLevel {
	// Convert.
	if      ( anLevel == [L4Level all] )   return JPLoggerAllLevel;
	else if ( anLevel == [L4Level info] )  return JPLoggerInfoLevel;
	else if ( anLevel == [L4Level debug] ) return JPLoggerDebugLevel;
	else if ( anLevel == [L4Level warn] )  return JPLoggerWarnLevel;
	else if ( anLevel == [L4Level error] ) return JPLoggerErrorLevel;
	else if ( anLevel == [L4Level fatal] ) return JPLoggerFatalLevel;
	else								   return JPLoggerOffLevel;
}

///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////
+(L4Level*)convertJPLevel:(JPLoggerLevels)desiredLevel {
	// Level.
	L4Level *anLevel;
	
	switch (desiredLevel) {
		case JPLoggerAllLevel:
			anLevel = [L4Level all];
			break;
		case JPLoggerInfoLevel:
			anLevel = [L4Level info];
			break;
		case JPLoggerDebugLevel:
			anLevel = [L4Level debug];
			break;
		case JPLoggerWarnLevel:
			anLevel = [L4Level warn];
			break;
		case JPLoggerErrorLevel:
			anLevel = [L4Level error];
			break;
		case JPLoggerFatalLevel:
			anLevel = [L4Level fatal];
			break;
		default:
			anLevel = [L4Level off];
			break;
	}
	
	// Return the level.
	return anLevel;
}
///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// 
@end

