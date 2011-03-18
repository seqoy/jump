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

/**
 * \file JPLoggerInterface.h
 */

/*! <b>JUMP Logger</b> default logger levels. */
typedef enum JPLoggerLevels {
	/// Set the logger level to OFF.
	JPLoggerOffLevel, 
	/// Set the logger level to INFO.
	JPLoggerInfoLevel,
	/// Set the logger level to DEBUG.
	JPLoggerDebugLevel,
	/// Set the logger level to WARN.
	JPLoggerWarnLevel,
	/// Set the logger level to ERROR.
	JPLoggerErrorLevel,
	/// Set the logger level to FATAL.
	JPLoggerFatalLevel,
	/// Set the logger level to ALL.
	JPLoggerAllLevel
} JPLoggerLevels;

/**
 * \nosubgrouping 
 * JPLoggerInterface defines an common interface to logger tasks. 
 * The nature of <b>JUMP Logger Module</b> is to allow you to use any Logger Library or Logger Framework that you want. 
 * So you can implement this protocol in your own class as an 
 * <a href="http://en.wikipedia.org/wiki/Adapter_pattern">Adapter</a> to your favorite logger. 
 */
@protocol JPLoggerInterface 
@required

////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// 
#pragma mark -
#pragma mark Level Methods
////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// 
/** @name Level Methods
 */
///@{ 

/**
 * Define the log level. You must implement this method even if you Logging Framework support
 * dynamically change the log level or not. If doesn't support, just leave the method empty.
 * @see #JPLoggerLevels for more information.
 */
-(void)setLevel:(JPLoggerLevels)anLevel;

/**
 * Retrieve current log level.
 * @see #JPLoggerLevels for more information.
 */
-(JPLoggerLevels)currentLevel;

///@}
////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// 
#pragma mark -
#pragma mark Log For Some Key Methods
////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// 
/** @name Log For Some Key Methods
 */
///@{ 

-(id)getKeyForLog;

////////// ////////// ////////// //////////
-(void)setKeyForLog:(id)anKey;

///@}
////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// 
#pragma mark -
#pragma mark Log Methods
////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// 
/** @name Log Methods
 */
///@{ 

/**
 * Log an message with <b>Debug</b> level priority.
 * @param variableList An format string, and his paramteres. Similar to <tt>[NSString stringWithFormat:]</tt> method.
 */
-(void)debug:(id)variableList, ... ;

/**
 * Log an message with <b>Info</b> level priority.
 * @param variableList An format string, and his paramteres. Similar to <tt>[NSString stringWithFormat:]</tt> method.
 */
-(void)info:(id)variableList, ... ; 

/**
 * Log an message with <b>Warn</b> level priority.
 * @param variableList An format string, and his paramteres. Similar to <tt>[NSString stringWithFormat:]</tt> method.
 */
-(void)warn:(id)variableList, ... ; 

/**
 * Log an message with <b>Error</b> level priority.
 * @param variableList An format string, and his paramteres. Similar to <tt>[NSString stringWithFormat:]</tt> method.
 */
-(void)error:(id)variableList, ... ; 

/**
 * Log an message with <b>Fatal</b> level priority.
 * @param variableList An format string, and his paramteres. Similar to <tt>[NSString stringWithFormat:]</tt> method.
 */
-(void)fatal:(id)variableList, ... ;

////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// 
/**
 * Log an message with <b>Debug</b> level priority, also accept an Exception.
 * @param variableList An format string, and his paramteres. Similar to <tt>[NSString stringWithFormat:]</tt> method.
 * @param anException An NSException object with more information about hits log.
 */
-(void)debugWithException:(NSException*)anException andMessage:(id)variableList, ...  ;

/**
 * Log an message with <b>Info</b> level priority, also accept an Exception.
 * @param variableList An format string, and his paramteres. Similar to <tt>[NSString stringWithFormat:]</tt> method.
 * @param anException An NSException object with more information about hits log.
 */
-(void)infoWithException:(NSException*)anException andMessage:(id)variableList, ...  ;

/**
 * Log an message with <b>Warn</b> level priority, also accept an Exception.
 * @param variableList An format string, and his paramteres. Similar to <tt>[NSString stringWithFormat:]</tt> method.
 * @param anException An NSException object with more information about hits log.
 */
-(void)warnWithException:(NSException*)anException andMessage:(id)variableList, ...  ;

/**
 * Log an message with <b>Error</b> level priority, also accept an Exception.
 * @param variableList An format string, and his paramteres. Similar to <tt>[NSString stringWithFormat:]</tt> method.
 * @param anException An NSException object with more information about hits log.
 */
-(void)errorWithException:(NSException*)anException andMessage:(id)variableList, ...  ;

/**
 * Log an message with <b>Fatal</b> level priority, also accept an Exception.
 * @param variableList An format string, and his paramteres. Similar to <tt>[NSString stringWithFormat:]</tt> method.
 * @param anException An NSException object with more information about hits log.
 */
-(void)fatalWithException:(NSException*)anException andMessage:(id)variableList, ...  ;


///@}
@end