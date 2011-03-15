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
 * \nosubgrouping 
 * JPLoggerInterface defines an common interface to logger tasks. The nature of JPLogger Modules is
 * to allow you to use any Logger library or framework that you want. So you can implement
 * your own class with this protocol as a wrapper around your favorite logger.
 */
@protocol JPLoggerInterface 
@required

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
+(void)debug:(id)variableList, ... ;

/**
 * Log an message with <b>Info</b> level priority.
 * @param variableList An format string, and his paramteres. Similar to <tt>[NSString stringWithFormat:]</tt> method.
 */
+(void)info:(id)variableList, ... ; 

/**
 * Log an message with <b>Warn</b> level priority.
 * @param variableList An format string, and his paramteres. Similar to <tt>[NSString stringWithFormat:]</tt> method.
 */
+(void)warn:(id)variableList, ... ; 

/**
 * Log an message with <b>Error</b> level priority.
 * @param variableList An format string, and his paramteres. Similar to <tt>[NSString stringWithFormat:]</tt> method.
 */
+(void)error:(id)variableList, ... ; 

/**
 * Log an message with <b>Fatal</b> level priority.
 * @param variableList An format string, and his paramteres. Similar to <tt>[NSString stringWithFormat:]</tt> method.
 */
+(void)fatal:(id)variableList, ... ;

////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// 
/**
 * Log an message with <b>Debug</b> level priority, also accept an Exception.
 * @param variableList An format string, and his paramteres. Similar to <tt>[NSString stringWithFormat:]</tt> method.
 * @param anException An NSException object with more information about hits log.
 */
+(void)debugWithException:(NSException*)anException andMessage:(id)variableList, ...  ;

/**
 * Log an message with <b>Info</b> level priority, also accept an Exception.
 * @param variableList An format string, and his paramteres. Similar to <tt>[NSString stringWithFormat:]</tt> method.
 * @param anException An NSException object with more information about hits log.
 */
+(void)infoWithException:(NSException*)anException andMessage:(id)variableList, ...  ;

/**
 * Log an message with <b>Warn</b> level priority, also accept an Exception.
 * @param variableList An format string, and his paramteres. Similar to <tt>[NSString stringWithFormat:]</tt> method.
 * @param anException An NSException object with more information about hits log.
 */
+(void)warnWithException:(NSException*)anException andMessage:(id)variableList, ...  ;

/**
 * Log an message with <b>Error</b> level priority, also accept an Exception.
 * @param variableList An format string, and his paramteres. Similar to <tt>[NSString stringWithFormat:]</tt> method.
 * @param anException An NSException object with more information about hits log.
 */
+(void)errorWithException:(NSException*)anException andMessage:(id)variableList, ...  ;

/**
 * Log an message with <b>Fatal</b> level priority, also accept an Exception.
 * @param variableList An format string, and his paramteres. Similar to <tt>[NSString stringWithFormat:]</tt> method.
 * @param anException An NSException object with more information about hits log.
 */
+(void)fatalWithException:(NSException*)anException andMessage:(id)variableList, ...  ;


///@}
@end