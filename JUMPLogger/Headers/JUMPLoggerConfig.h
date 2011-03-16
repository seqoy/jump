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
#import "JPLoggerFactoryInterface.h"

@interface JUMPLoggerConfig : NSObject {}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// ///// //// //// //// 
#pragma mark -
#pragma mark Config Methods
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// ///// //// //// //// 
/** @name Config Methods
 */
///@{ 

/**
 * Configure the JUMP Logger Module to retrieve loggers using this factory class.
 * @param anClass The class of the Logger Factory. Must conform with the JPLoggerFactoryInterface protocol.
 */
+(void)setLoggerFactoryClass:(Class<JPLoggerFactoryInterface>)anClass;

/**
 * Return the current configured Logger Factory Class. 
 * Default value is <tt>nil</tt>
 */
+(Class<JPLoggerFactoryInterface>)loggerFactoryClass;

///@}
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// ///// //// //// //// 


@end
