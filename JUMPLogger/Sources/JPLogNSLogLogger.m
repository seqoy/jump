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

// Static Variables.
static JPLoggerLevels loggerLevel = JPLoggerOffLevel;

///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// 
+(void)setLevel:(JPLoggerLevels)desiredLevel {
	loggerLevel = desiredLevel;
}
-(void)setLevel:(JPLoggerLevels)anLevel {
	[JPLogNSLogLogger setLevel:anLevel];
}

///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// 
+(JPLoggerLevels)currentLevel {
	return loggerLevel;
}
-(JPLoggerLevels)currentLevel {
	return [JPLogNSLogLogger currentLevel];
}

///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// 
#pragma mark -
#pragma mark Private Methods.
///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// 
+(void)logWithLevel:(JPLoggerLevels)anLevel logKeyword:(NSString*)anKeyword message:(NSString*)anMessage {
	// Only log authorized level.
	if ( anLevel <= loggerLevel )
		NSLog( @"%@: %@", anKeyword, anMessage);
}

///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// 
+(NSString*)formatExceptionMessage:(NSException*)anException {
	return [NSString stringWithFormat:@"Exception: %@\nCause: %@\nMore Info:%@", [anException name], [anException reason], [anException userInfo]];
}

///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// 
#pragma mark -
#pragma mark Log Methods.
///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// 
+(void)debug:(id)variableList, ... { 
	va_list args;
	[self logWithLevel:JPLoggerDebugLevel logKeyword:@"DEBUG" message:[NSString stringWithFormat:@"%@", variableList, args]];
};

///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// 
+(void)info:(id)variableList, ...  { 
	va_list args;
	[self logWithLevel:JPLoggerInfoLevel logKeyword:@"INFO" message:[NSString stringWithFormat:@"%@", variableList, args]];
}; 

///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// 
+(void)warn:(id)variableList, ...  { 
	va_list args;
	[self logWithLevel:JPLoggerWarnLevel logKeyword:@"WARN" message:[NSString stringWithFormat:@"%@", variableList, args]];
}; 

///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// 
+(void)error:(id)variableList, ...  { 
	va_list args;
	[self logWithLevel:JPLoggerErrorLevel logKeyword:@"ERROR" message:[NSString stringWithFormat:@"%@", variableList, args]];
}; 

///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// 
+(void)fatal:(id)variableList, ...  {  
	va_list args;
	[self logWithLevel:JPLoggerFatalLevel logKeyword:@"DEBUG" message:[NSString stringWithFormat:@"%@", variableList, args]];
};

#pragma mark -
///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// 
+(void)debugWithException:(NSException*)anException andMessage:(id)variableList, ...   { 
	va_list args;
	NSString *message = [NSString stringWithFormat:@"%@\n%@", [NSString stringWithFormat:variableList, args], [self formatExceptionMessage:anException]];
	[self logWithLevel:JPLoggerDebugLevel logKeyword:@"DEBUG" message:message];
};

///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// 
+(void)infoWithException:(NSException*)anException andMessage:(id)variableList, ...   { 
	va_list args;
	NSString *message = [NSString stringWithFormat:@"%@\n%@", [NSString stringWithFormat:variableList, args], [self formatExceptionMessage:anException]];
	[self logWithLevel:JPLoggerInfoLevel logKeyword:@"INFO" message:message];
};

///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// 
+(void)warnWithException:(NSException*)anException andMessage:(id)variableList, ...   {  
	va_list args;
	NSString *message = [NSString stringWithFormat:@"%@\n%@", [NSString stringWithFormat:variableList, args], [self formatExceptionMessage:anException]];
	[self logWithLevel:JPLoggerWarnLevel logKeyword:@"WARN" message:message];
};

///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// 
+(void)errorWithException:(NSException*)anException andMessage:(id)variableList, ...   {  
	va_list args;
	NSString *message = [NSString stringWithFormat:@"%@\n%@", [NSString stringWithFormat:variableList, args], [self formatExceptionMessage:anException]];
	[self logWithLevel:JPLoggerErrorLevel logKeyword:@"ERROR" message:message];
};

///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// 
+(void)fatalWithException:(NSException*)anException andMessage:(id)variableList, ...   {  
	va_list args;
	NSString *message = [NSString stringWithFormat:@"%@\n%@", [NSString stringWithFormat:variableList, args], [self formatExceptionMessage:anException]];
	[self logWithLevel:JPLoggerFatalLevel logKeyword:@"FATAL" message:message];
};

@end
