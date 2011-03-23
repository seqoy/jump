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
#import "JPLogNSLogLogger.h"

@implementation JPLogNSLogLogger

///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// 
#pragma mark -
#pragma mark Getters and Setters.
///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// 
-(id)getKeyForLog {
	return nil;
}
////////// ////////// ////////// //////////
-(void)setKeyForLog:(id)anKey {
	// Do nothing.
}
///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// 
-(void)setLevel:(JPLoggerLevels)desiredLevel {
	SetGlobalLogLevel( desiredLevel );
}
///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// 
-(JPLoggerLevels)currentLevel {
	// Compiler condition to disable all logs.
	#ifndef JPLOGGER_DISABLE_ALL
		return [[JUMPLoggerConfig loggerFactoryClass] globalLevel];
	#else
		return JPLoggerOffLevel;
	#endif
}
///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// 
#pragma mark -
#pragma mark Private Methods.
///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// 
-(void)logWithLevel:(JPLoggerLevels)anLevel logKeyword:(NSString*)anKeyword message:(NSString*)anMessage {
	// Compiler condition to disable all logs.
	#ifndef JPLOGGER_DISABLE_ALL
		// Only log authorized level.
		if ( anLevel <= [self currentLevel] )
			NSLog( @"%@: %@", anKeyword, anMessage);
	#endif
}

///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// 
-(NSString*)formatExceptionMessage:(NSException*)anException  {
	// If no exception return empty.
	if ( !anException ) 
		return @"";
	
	return [NSString stringWithFormat:@"Exception: %@\nCause: %@\nMore Info:%@", [anException name], [anException reason], [anException userInfo]];
}
///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ////////////
-(NSString*)formatFullLogMessage:(JPLoggerMetadata*)metadata {
	return [NSString stringWithFormat:@"%@\n%@", metadata.message, [self formatExceptionMessage:metadata.exception]];
}

///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// 
#pragma mark -
#pragma mark Log Methods.
///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// 
-(void)debugWithMetadata:(JPLoggerMetadata*)logData  { 
	[self logWithLevel:JPLoggerDebugLevel logKeyword:@"DEBUG" message:[self formatFullLogMessage:logData]];
};

///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// 
-(void)infoWithMetadata:(JPLoggerMetadata*)logData  { 
	[self logWithLevel:JPLoggerInfoLevel logKeyword:@"INFO" message:[self formatFullLogMessage:logData]];
};

///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// 
-(void)warnWithMetadata:(JPLoggerMetadata*)logData  {  
	[self logWithLevel:JPLoggerWarnLevel logKeyword:@"WARN" message:[self formatFullLogMessage:logData]];
};

///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// 
-(void)errorWithMetadata:(JPLoggerMetadata*)logData  {  
	[self logWithLevel:JPLoggerErrorLevel logKeyword:@"ERROR" message:[self formatFullLogMessage:logData]];
};

///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// 
-(void)fatalWithMetadata:(JPLoggerMetadata*)logData  {  
	[self logWithLevel:JPLoggerFatalLevel logKeyword:@"FATAL" message:[self formatFullLogMessage:logData]];
};

@end
