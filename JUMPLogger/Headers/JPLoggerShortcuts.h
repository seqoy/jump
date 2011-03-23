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
#import <Foundation/Foundation.h>
#import "JUMPLoggerConfig.h"
#import "JPLoggerMetadata.h"

/**
 * \file JPLoggerShortcuts.h
 * \nosubgrouping 
 * Collection of Macro-Functions to facilitate logger tasks.
 */

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// ///// //// //// //// 
#pragma mark -
#pragma mark Macros that define log levels.
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// ///// //// //// //// 
/** @name Macros that define log levels
 */
///@{ 
#define SetGlobalLogLevel( _anlevel_ ) [[JUMPLoggerConfig loggerFactoryClass] setGlobalLevel:_anlevel_]
#define SetClassLogLevel( _anlevel_ ) [[[JUMPLoggerConfig loggerFactoryClass] getLoggerForClass:[self class]] setLevel:_anlevel_]

///@}
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// ///// //// //// //// 
#pragma mark -
#pragma mark Macros that log from objects.
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// ///// //// //// //// 
/** @name Macros that log from objects
 */
///@{ 

#define Debug(message, ...) DebugException( nil, message, ##__VA_ARGS__)
#define Info(message, ...) InfoException( nil, message, ##__VA_ARGS__)
#define Warn(message, ...) WarnException( nil, message, ##__VA_ARGS__)
#define Error(message, ...) ErrorException( nil, message, ##__VA_ARGS__)
#define Fatal(message, ...) FatalException( nil, message, ##__VA_ARGS__)

///@}
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// ///// //// //// //// 
#pragma mark -
#pragma mark Macros that log with an exception from objects.
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// ///// //// //// //// 
/** @name Macros that log with an exception from objects
 */
///@{ 

#define DebugException(exception, message, ...) JPLogIfYouCan( @selector(debugWithMetadata:), __FILE__,  [self class], self, NSStringFromSelector( _cmd ),  __LINE__, [NSString stringWithFormat:message, ##__VA_ARGS__], exception)
#define InfoException(exception, message, ...) JPLogIfYouCan( @selector(infoWithMetadata:), __FILE__,  [self class], self, NSStringFromSelector( _cmd ),  __LINE__, [NSString stringWithFormat:message, ##__VA_ARGS__], exception)
#define WarnException(exception, message, ...) JPLogIfYouCan( @selector(warnWithMetadata:), __FILE__,  [self class], self, NSStringFromSelector( _cmd ),  __LINE__, [NSString stringWithFormat:message, ##__VA_ARGS__], exception)
#define ErrorException(exception, message, ...) JPLogIfYouCan( @selector(errorWithMetadata:), __FILE__,  [self class], self, NSStringFromSelector( _cmd ),  __LINE__, [NSString stringWithFormat:message, ##__VA_ARGS__], exception)
#define FatalException(exception, message, ...) JPLogIfYouCan( @selector(fatalWithMetadata:), __FILE__,  [self class], self, NSStringFromSelector( _cmd ),  __LINE__, [NSString stringWithFormat:message, ##__VA_ARGS__], exception)

///@}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// ///// //// //// //// 
// Private Contidional Function.
void JPLogIfYouCan( SEL method, const char *file, Class logToClass, id caller, NSString *anMethodName, int lineNumber, NSString* message, NSException* anException );
