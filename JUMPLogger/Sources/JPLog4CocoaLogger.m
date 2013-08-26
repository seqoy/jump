
/*
 * Copyright (c) 2011 - SEQOY.org and Paulo Oliveira ( http://www.seqoy.org )
 *
 * Licensed under the Apache License, Version 2.0 (the "License") {  };
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
#import "JPLog4CocoaLogger.h"
#import "JPLog4CocoaFactory.h"
#import <objc/message.h>

@implementation JPLog4CocoaLogger
@synthesize keyForLog;

///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// 
#pragma mark -
#pragma mark Private Methods.
///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// 
-(void)logWithMetadata:(JPLoggerMetadata*)logData forType:(L4Level*)anLevel {
	// Validate Metadata.
	[logData validate];
	
	/////////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// 
	// Log.
	log4Log(logData.caller,																	// Caller.
			[logData.lineNumber intValue],													// Line Number.
			[logData.fileName UTF8String],													// File Name.
			[[logData prettyMethod] UTF8String],											// Pretty Formatted Method Name.
			@selector(lineNumber:fileName:methodName:message:level:exception:),				// Selector.
			anLevel,																		// Log Level.
			logData.isAssertion,															// Is Assertion.
			YES,																			// Assertion.
			logData.exception,																// Exception.
			logData.message);																// Message.
}

///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////
-(L4Logger*)loggerForKey:(id)loggerKey {

	// Set log for an Name (category or domain).
	if ( [loggerKey isKindOfClass:[NSString class]] ) 
		return [L4Logger loggerForName:loggerKey];
	
	///////////// ///////////// ///////////// ///	
	// Set the log level for this specific class.
	else if ( ! class_isMetaClass( loggerKey ) )
		return [L4Logger loggerForClass:(Class)loggerKey];
	
	///////////// ///////////// ///////////// ///	
	// Can't recognize, throw exception.
	else 
		[NSException raise:@"JPLoggerException" 
					format:@"'keyForLog' property defined type '%@' isn't not allowed. You should use an 'NSString' or 'Class' type.", NSStringFromClass([self class])];

	////////// ///////////// ///////////// ///	
	// Must return something.
	return nil;
}

///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// 
#pragma mark -
#pragma mark Memory Methods.
///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// 
-(void)dealloc {
	// ARC is implemented.
}

///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// 
#pragma mark -
#pragma mark JPLoggerInterface Methods.
///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// 
-(void)setLevel:(JPLoggerLevels)desiredLevel {
	
	// Level.
	L4Level *anLevel = [JPLog4CocoaFactory convertJPLevel:desiredLevel];;
	
	///////////// ///////////// ///////////// ///	
	// Logger Key.
	id loggerKey = [self getKeyForLog];
	
	// Set the log level.
	[[self loggerForKey:loggerKey] setLevel:anLevel];
}

///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// 
-(JPLoggerLevels)currentLevel {
	// Compiler condition to disable all logs.
	#ifndef JPLOGGER_DISABLE_ALL
		
		///////////// ///////////// ///////////// ///	
		// Logger Key.
		id loggerKey = [self getKeyForLog];

		// Current level for specific class.
		L4Level *anLevel = [[self loggerForKey:loggerKey] level];
		
		// Convert and return.
		return [JPLog4CocoaFactory convertL4Level:anLevel];
	
	///////////// ///////////// /////////
	#else
		return JPLoggerOffLevel;
	#endif
}

///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// 
// Compiler condition to disable all logs.
#ifndef JPLOGGER_DISABLE_ALL

///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// 
-(void)debugWithMetadata:(JPLoggerMetadata*)logData { 
	if([[self loggerForKey:[self getKeyForLog]] isDebugEnabled])
		[self logWithMetadata:logData forType:[L4Level debug]];
};

///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// 
-(void)infoWithMetadata:(JPLoggerMetadata*)logData { 
	if([[self loggerForKey:[self getKeyForLog]] isInfoEnabled]) 
		[self logWithMetadata:logData forType:[L4Level info]];
}
///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// 
-(void)warnWithMetadata:(JPLoggerMetadata*)logData {  
    // Simply redirect parameters.
	[self logWithMetadata:logData forType:[L4Level warn]];
};

///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// 
-(void)errorWithMetadata:(JPLoggerMetadata*)logData {  
    // Simply redirect parameters.
	[self logWithMetadata:logData forType:[L4Level error]];
};

///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// 
-(void)fatalWithMetadata:(JPLoggerMetadata*)logData {  
    // Simply redirect parameters.
	[self logWithMetadata:logData forType:[L4Level fatal]];
};

///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// 
// Compiler condition to disable all logs.
#else

	// Disable all.
	-(void)debugWithMetadata:(JPLoggerMetadata*)logData {};
	-(void)infoWithMetadata:(JPLoggerMetadata*)logData {};
	-(void)warnWithMetadata:(JPLoggerMetadata*)logData {};
	-(void)errorWithMetadata:(JPLoggerMetadata*)logData {};
	-(void)fatalWithMetadata:(JPLoggerMetadata*)logData {};

#endif
		
@end
