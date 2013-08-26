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
#import "JPLoggerAbstractFactory.h"

////////// ////////// ////////// ////////// 
@implementation JPLoggerAbstractFactory 

// Static Logger Class.
static Class loggerClass;
#define AbstractClassError() [NSException raise:@"AbstractClassException" format:@"You must subclass 'JPLoggerAbstractFactory' and/or implement [%@ %@] !!", NSStringFromClass([self class]), NSStringFromSelector(_cmd)]

////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// 
#pragma mark -
#pragma mark Getters and Setters.
////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// 
+(void)setLoggerClass:(Class<JPLoggerInterface>)anLoggerClass {
    loggerClass = anLoggerClass;
}

////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// 
+(Class)loggerClass {
    return loggerClass;
}

////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// 
// Get an configured instance of the logger. 
+(id<JPLoggerInterface>)getLogger {
	[self configureLogger];
	
	// Return it.
	return [[[self loggerClass] alloc] init];
}

////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// 
+(id<JPLoggerInterface>)getLoggerForClass:(Class)anClass {
	// Init the logger.
	id<JPLoggerInterface> anLogger = [self getLogger];
	
	// Attach the key, an class on this case.
	[anLogger setKeyForLog:anClass];
	
	// Return it.
	return anLogger;
}

+(id<JPLoggerInterface>)getLoggerForCategory:(NSString*)anCategory {
	// Init the logger.
	id<JPLoggerInterface> anLogger = [self getLogger];

	// Attach the key, an category on this case.
	[anLogger setKeyForLog:anCategory];
	
	// Return it.
	return anLogger;
}

////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// 
// Default configuration for the logger. Must be implemented.
+(BOOL)configureLogger {
	AbstractClassError();
    return NO;
}

////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// // ////////// 
// If the Logging Framework that you're using support load configuration from a file implement this method.
+(BOOL)configureWithFile:(NSString*)anFileName {
    return NO;
}

////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// 
#pragma mark -
#pragma mark Level Methods
////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// 
+(void)setGlobalLevel:(JPLoggerLevels)desiredLevel {
	AbstractClassError();
}

///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// 
+(JPLoggerLevels)globalLevel {
	AbstractClassError();
	return JPLoggerOffLevel;
}
@end

