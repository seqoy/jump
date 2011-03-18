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
#import "JPLoggerAbstractFactory.h"
#import "JPLoggerShortcuts.h"
#import "JPLog4CocoaLogger.h"
#import "Log4Cocoa.h"

#import "L4NSLoggerAppender.h"

/**
 * JPLog4CocoaFactory missing documentation.
 */
@interface JPLog4CocoaFactory : JPLoggerAbstractFactory {}

///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// 
#pragma mark -
#pragma mark Level Translation Methods.
///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// 
+(JPLoggerLevels)convertL4Level:(L4Level*)anLevel;
+(L4Level*)convertJPLevel:(JPLoggerLevels)anLevel;
@end
