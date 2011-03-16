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

+(void)setLoggerClass:(Class<JPLoggerInterface>)loggerClass;

+(Class)loggerClass;

/**
 * Get an configured instance of the logger. 
 * @return An autorelesable instance of the logger.
 */
+(id<JPLoggerInterface>)getLogger;

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
@end