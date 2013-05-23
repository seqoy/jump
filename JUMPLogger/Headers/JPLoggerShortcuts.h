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

/**
 * Shortcut to set the Global Log Level.
 */
#define SetGlobalLogLevel( _anlevel_ ) [[JUMPLoggerConfig loggerFactoryClass] setGlobalLevel:_anlevel_]

/**
 * Shortcut to set the Log Level for the current class.
 */
#define SetClassLogLevel( _anlevel_ ) [[[JUMPLoggerConfig loggerFactoryClass] getLoggerForClass:[self class]] setLevel:_anlevel_]

/**
 * Shortcut to set the Log Level for some specific category.
 */
#define SetCategoryLogLevel( _category, _anlevel_ ) [[[JUMPLoggerConfig loggerFactoryClass] getLoggerForCategory:_category] setLevel:_anlevel_]

///@}
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// ///// //// //// //// 
#pragma mark -
#pragma mark Macros that log from objects.
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// ///// //// //// //// 
/** @name Macros that log from objects
 */
///@{ 

//// //// //// //// //// //// //// ////
// Udenfine if needed.
#ifdef Debug
	#undef Debug()
#endif
#ifdef Info
	#undef Info()
#endif
#ifdef Warn
	#undef Warn()
#endif
#ifdef Error
	#undef Error()
#endif
#ifdef Fatal
	#undef Fatal()
#endif

// Define.
#define Debug(message, ...) DebugExceptionTo( nil, nil, message, ##__VA_ARGS__)
#define Info(message, ...) InfoExceptionTo( nil, nil, message, ##__VA_ARGS__)
#define Warn(message, ...) WarnExceptionTo( nil, nil, message, ##__VA_ARGS__)
#define Error(message, ...) ErrorExceptionTo( nil, nil, message, ##__VA_ARGS__)
#define Fatal(message, ...) FatalExceptionTo( nil, nil, message, ##__VA_ARGS__)

///@}
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// ///// //// //// //// 
#pragma mark -
#pragma mark Macros that log from objects for a specific category.
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// ///// //// //// //// 
/** @name Macros that log from objects
 */
///@{ 

//// //// //// //// //// //// //// ////
// Udenfine if needed.
#ifdef DebugTo
	#undef DebugTo
#endif
#ifdef InfoTo
	#undef InfoTo
#endif
#ifdef WarnTo
	#undef WarnTo
#endif
#ifdef ErrorTo
	#undef ErrorTo
#endif
#ifdef FatalTo
	#undef Fatal
#endif

// Define.
#define DebugTo(category, message, ...) DebugExceptionTo( category, nil, message, ##__VA_ARGS__)
#define InfoTo(category, message, ...) InfoExceptionTo( category, nil, message, ##__VA_ARGS__)
#define WarnTo(category, message, ...) WarnExceptionTo( category, nil, message, ##__VA_ARGS__)
#define ErrorTo(category, message, ...) ErrorExceptionTo( category, nil, message, ##__VA_ARGS__)
#define FatalTo(category, message, ...) FatalExceptionTo( category, nil, message, ##__VA_ARGS__)

///@}
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// ///// //// //// //// 
#pragma mark -
#pragma mark Macros that log with an exception from objects.
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// ///// //// //// //// 
/** @name Macros that log with an exception from objects
 */
///@{ 

//// //// //// //// //// //// //// ////
// Udenfine if needed.
#ifdef DebugException
	#undef DebugException()
#endif
#ifdef InfoException
	#undef InfoException()
#endif
#ifdef WarnException
	#undef WarnException()
#endif
#ifdef ErrorException
	#undef ErrorException()
#endif
#ifdef FatalException
	#undef FatalException()
#endif

// Define.
#define DebugException(exception, message, ...) DebugExceptionTo( nil, exception, message, ##__VA_ARGS__)
#define InfoException(exception, message, ...) InfoExceptionTo( nil, exception, message, ##__VA_ARGS__)
#define WarnException(exception, message, ...) WarnExceptionTo( nil, exception, message, ##__VA_ARGS__)
#define ErrorException(exception, message, ...) ErrorExceptionTo( nil, exception, message, ##__VA_ARGS__)
#define FatalException(exception, message, ...) FatalExceptionTo( nil, exception, message, ##__VA_ARGS__)

///@}
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// ///// //// //// //// 
#pragma mark -
#pragma mark Macros that log with an exception from objects to a specific category.
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// ///// //// //// //// 
/** @name Macros that log with an exception from objects
 */
///@{ 

//// //// //// //// //// //// //// ////
// Udenfine if needed.
#ifdef DebugExceptionTo
	#undef DebugExceptionTo()
#endif
#ifdef InfoExceptionTo
	#undef InfoExceptionTo()
#endif
#ifdef WarnExceptionTo
	#undef WarnExceptionTo()
#endif
#ifdef ErrorExceptionTo
	#undef ErrorExceptionTo()
#endif
#ifdef FatalExceptionTo
	#undef FatalExceptionTo()
#endif

// Define.
#define DebugExceptionTo(category, exception, message, ...) JPLogIfYouCan( @selector(debugWithMetadata:), __FILE__, category, [self class], self, NSStringFromSelector( _cmd ),  __LINE__, [NSString stringWithFormat:message, ##__VA_ARGS__], exception)
#define InfoExceptionTo(category, exception, message, ...) JPLogIfYouCan( @selector(infoWithMetadata:), __FILE__, category, [self class], self, NSStringFromSelector( _cmd ),  __LINE__, [NSString stringWithFormat:message, ##__VA_ARGS__], exception)
#define WarnExceptionTo(category, exception, message, ...) JPLogIfYouCan( @selector(warnWithMetadata:), __FILE__, category, [self class], self, NSStringFromSelector( _cmd ),  __LINE__, [NSString stringWithFormat:message, ##__VA_ARGS__], exception)
#define ErrorExceptionTo(category, exception, message, ...) JPLogIfYouCan( @selector(errorWithMetadata:), __FILE__, category, [self class], self, NSStringFromSelector( _cmd ),  __LINE__, [NSString stringWithFormat:message, ##__VA_ARGS__], exception)
#define FatalExceptionTo(category, exception, message, ...) JPLogIfYouCan( @selector(fatalWithMetadata:), __FILE__, category, [self class], self, NSStringFromSelector( _cmd ),  __LINE__, [NSString stringWithFormat:message, ##__VA_ARGS__], exception)

///@}
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// ///// //// //// //// 
#pragma mark -
#pragma mark Macros that Debug specific Objective-C types.
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// ///// //// //// //// 
/** @name Macros that Debug specific Objective-C types
 */
///@{ 

//// //// //// //// //// //// //// ////
// Udenfine if needed.
#ifdef LogObject
	#undef LogObject()
#endif
#ifdef LogObjectTo
	#undef LogObjectTo()
#endif
#ifdef LogInt
	#undef LogInt()
#endif
#ifdef LogIntTo
	#undef LogIntTo()
#endif
#ifdef LogFloat
	#undef LogFloatTo()
#endif
#ifdef LogRect
	#undef LogRectTo()
#endif
#ifdef LogFloat
	#undef LogFloatTo()
#endif
#ifdef LogPoint
	#undef LogPointTo()
#endif
#ifdef LogSize
	#undef LogSizeTo()
#endif
#ifdef LogSize
	#undef LogSizeTo()
#endif
#ifdef LogSize
	#undef LogSizeTo()
#endif
#ifdef LogBool
	#undef LogBoolTo()
#endif
#ifdef LogIndexPath
	#undef LogIndexPathTo()
#endif

// Define.
#define LogObject( arg ) Debug( @"Object: %@", arg )
#define LogObjectTo( category, arg ) DebugTo( category, @"Object: %@", arg )
/// /// /// ////// ///// /// /// /// ////// ///// /// /// /// ////// ///// 
#define LogInt( arg ) Debug( @"integer: %i", arg )
#define LogIntTo( category, arg ) DebugTo( category, @"integer: %i", arg )
/// /// /// ////// ///// /// /// /// ////// ///// /// /// /// ////// ///// 
#define LogFloat( arg ) Debug( @"float: %f", arg )
#define LogFloatTo( category,arg ) DebugTo( category,@"float: %f", arg )
/// /// /// ////// ///// /// /// /// ////// ///// /// /// /// ////// ///// 
#define LogRect( arg ) Debug( @"CGRectMake( %f, %f, %f, %f)", arg.origin.x, arg.origin.y, arg.size.width, arg.size.height )
#define LogRectTo( category,arg ) DebugTo( category,@"CGRectMake( %f, %f, %f, %f)", arg.origin.x, arg.origin.y, arg.size.width, arg.size.height )
/// /// /// ////// ///// /// /// /// ////// ///// /// /// /// ////// ///// /// /// /// ////// ///// /// /// /// ////// ///// /// /// /// ////// ///// 
#define LogPoint( arg ) Debug( @"CGPoint ( %f, %f )", arg.x, arg.y )
#define LogPointTo( category,arg ) DebugTo( category,@"CGPoint ( %f, %f )", arg.x, arg.y )
/// /// /// ////// ///// /// /// /// ////// ///// /// /// /// ////// ///// /// /// /// ////// ///// 
#define LogSize( arg ) Debug( @"CGSize ( %f, %f )", arg.width, arg.height )
#define LogSizeTo( category,arg ) DebugTo( category,@"CGSize ( %f, %f )", arg.width, arg.height )
/// /// /// ////// ///// /// /// /// ////// ///// /// /// /// ////// ///// /// /// /// ////// ///// 
#define LogBool( arg ) 	Debug( @"Boolean: %@", ( arg == YES ? @"YES" : @"NO" ) )
#define LogBoolTo( category,arg ) DebugTo( category,@"Boolean: %@", ( arg == YES ? @"YES" : @"NO" ) )
/// /// /// ////// ///// /// /// /// ////// ///// /// /// /// ////// ///// /// /// /// ////// ///// /// /// /// ////// ///// 
#define LogIndexPath( arg ) Debug( @"Section: %i, Row: %i", arg.section, arg.row )
#define LogIndexPathTo( category,arg ) DebugTo( category,@"Section: %i, Row: %i", arg.section, arg.row )
/// /// /// ////// ///// /// /// /// ////// ///// /// /// /// ////// ///// /// /// /// ////// ///// /// /// /// ////// /////
#define LogWhere() Debug( @"[%@ %@]", NSStringFromClass( [self class] ), NSStringFromSelector( _cmd ) )
#define LogWhereTo( category ) DebugTo( category,@"[%@ %@]", NSStringFromClass( [self class] ), NSStringFromSelector( _cmd ) )


///@}
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// ///// //// //// //// 
#pragma mark -
#pragma mark Private Contidional Function.
void JPLogIfYouCan( SEL method, const char *file, NSString* category, Class logToClass, id caller, NSString *anMethodName, int lineNumber, NSString* message, NSException* anException );
