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
#import "JPLoggerInterface.h"

/**
 * \nosubgrouping 
 * Missing Docs.
 */
@protocol JPLoggerFactoryInterface

////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// 
/** @name Required Methods
 */
///@{ 
@required

/**
 * Set the Logger Class that this factory builds.
 * @param loggerClass The logger class.
 */
+(void)setLoggerClass:(Class<JPLoggerInterface>)loggerClass;

/**
 * Get the logger Class that this factory builds.
 */
+(Class)loggerClass;

/**
 * Get an configured instance of the logger. 
 * @return An autorelesable instance of the logger.
 */
+(id<JPLoggerInterface>)getLogger;

/**
 * Get an configured instance of the logger for specific class.
 * @param anClass An logger for an specific class.
 * @return An autorelesable instance of the logger.
 */
+(id<JPLoggerInterface>)getLoggerForClass:(Class)anClass;

/**
 * Get an configured instance of the logger for specific category.
 * @param anCategory An logger for an specific category.
 * @return An autorelesable instance of the logger.
 */
+(id<JPLoggerInterface>)getLoggerForCategory:(NSString*)anCategory;

/**
 * Implement on this method all configuration for the logger. 
 * This method should be called inside of #getLogger to configure all settings.
 * @return YES if configured succesfully.
 */
+(BOOL)configureLogger;

/**
 * If the Logging Framework that you're using support load configuration from a file. You should
 * implement your logic on this method.
 * @param anFileName The configuration file name that should be included on the Application Bundle.
 * @return YES if configured succesfully.
 */
+(BOOL)configureWithFile:(NSString*)anFileName ;

///@}
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
+(void)setGlobalLevel:(JPLoggerLevels)anLevel;

/**
 * Retrieve current log level.
 * @see #JPLoggerLevels for more information.
 */
+(JPLoggerLevels)globalLevel;

///@}
@end