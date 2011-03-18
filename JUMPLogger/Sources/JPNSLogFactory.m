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
#import "JPNSLogFactory.h"

////////// ////////// ////////// ////////// 
@implementation JPNSLogFactory 

// Static Logger Class.
static BOOL configured;
static JPLoggerLevels globalLevel;

////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// 
// Default configuration for the logger.
+(BOOL)configureLogger {
	// If already configured, do nothing.
	if ( configured )
		return YES;
	
	// Default class.
	[self setLoggerClass:[JPLogNSLogLogger class]];
	
	// Default level is INFO.
	[self setGlobalLevel:JPLoggerInfoLevel];
	
	// Configured.
	configured = YES;
	
	// No more configurations.. Is NSLog right? That's why Log Frameworks exist!
	return YES;
}

////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// 
// If the Logging Framework that you're using support load configuration from a file. You should
+(BOOL)configureWithFile:(NSString*)anFileName {
	// Doesn't configure from file.
    return NO;
}

////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// 
#pragma mark -
#pragma mark Level Methods
////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// 
//
+(void)setGlobalLevel:(JPLoggerLevels)desiredLevel {
	globalLevel = desiredLevel;
}

///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// 
+(JPLoggerLevels)globalLevel {
	return globalLevel;
}
@end

