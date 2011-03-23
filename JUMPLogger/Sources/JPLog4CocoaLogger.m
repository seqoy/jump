
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

@implementation JPLog4CocoaLogger

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

///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// 
#pragma mark -
#pragma mark Getters and Setters.
///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// 
-(id)getKeyForLog {
	return keyForLog;
}

////////// ////////// ////////// //////////
-(void)setKeyForLog:(id)anKey {
	keyForLog = (Class)anKey;
}

///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// 
-(void)setLevel:(JPLoggerLevels)desiredLevel {
	
	// Level.
	L4Level *anLevel = [JPLog4CocoaFactory convertJPLevel:desiredLevel];;
	
	// Set the log level for this specific class.
	[[L4Logger loggerForClass:(Class)[self getKeyForLog]] setLevel:anLevel];
}

///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// 
-(JPLoggerLevels)currentLevel {
	// Compiler condition to disable all logs.
	#ifndef JPLOGGER_DISABLE_ALL
		
		// Current level for specific class.
		L4Level *anLevel = [[L4Logger loggerForClass:(Class)[self getKeyForLog]] level];
		
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
	if([[L4Logger loggerForClass:(Class)[self getKeyForLog]] isDebugEnabled])
		[self logWithMetadata:logData forType:[L4Level debug]];
};

///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// 
-(void)infoWithMetadata:(JPLoggerMetadata*)logData { 
	if([[L4Logger loggerForClass:(Class)[self getKeyForLog]] isInfoEnabled]) 
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

	-(void)debugWithMetadata:(JPLoggerMetadata*)logData { /// Disabled };
	-(void)infoWithMetadata:(JPLoggerMetadata*)logData { /// Disabled };
	-(void)warnWithMetadata:(JPLoggerMetadata*)logData { /// Disabled };
	-(void)errorWithMetadata:(JPLoggerMetadata*)logData { /// Disabled };
	-(void)fatalWithMetadata:(JPLoggerMetadata*)logData { /// Disabled };

#endif

@end
