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

#define Debug(message, ...) JPLogIfYouCan( @selector(debug:), [NSString stringWithFormat:message, ##__VA_ARGS__], nil, [self class])
#define Info(message, ...) JPLogIfYouCan( @selector(info:), [NSString stringWithFormat:message, ##__VA_ARGS__], nil, [self class])
#define Warn(message, ...) JPLogIfYouCan( @selector(warn:), [NSString stringWithFormat:message, ##__VA_ARGS__], nil, [self class])
#define Error(message, ...) JPLogIfYouCan( @selector(error:), [NSString stringWithFormat:message, ##__VA_ARGS__], nil, [self class])
#define Fatal(message, ...) JPLogIfYouCan( @selector(fatal:), [NSString stringWithFormat:message, ##__VA_ARGS__], nil, [self class])

///@}
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// ///// //// //// //// 
#pragma mark -
#pragma mark Macros that log with an exception from objects.
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// ///// //// //// //// 
/** @name Macros that log with an exception from objects
 */
///@{ 

#define DebugException(exception, message, ...) JPLogIfYouCan( @selector(debugWithException:andMessage:), [NSString stringWithFormat:message, ##__VA_ARGS__], exception, [self class])
#define InfoException(exception, message, ...) JPLogIfYouCan( @selector(infoWithException:andMessage:), [NSString stringWithFormat:message, ##__VA_ARGS__], exception, [self class])
#define WarnException(exception, message, ...) JPLogIfYouCan( @selector(warnWithException:andMessage:), [NSString stringWithFormat:message, ##__VA_ARGS__], exception, [self class])
#define ErrorException(exception, message, ...) JPLogIfYouCan( @selector(errorWithException:andMessage:), [NSString stringWithFormat:message, ##__VA_ARGS__], exception, [self class])
#define FatalException(exception, message, ...) JPLogIfYouCan( @selector(fatalWithException:andMessage:), [NSString stringWithFormat:message, ##__VA_ARGS__], exception, [self class])

///@}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// ///// //// //// //// 
// Private Contidional Function.
void JPLogIfYouCan( SEL method, NSString* message, NSException* anException, Class logToClass );
