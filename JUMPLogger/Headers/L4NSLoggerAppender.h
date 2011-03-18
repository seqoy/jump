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
#import "JPLog4CocoaFactory.h"
#import "LoggerClient.h"
#import "L4WriterAppender.h"
#import "L4Layout.h"

/**
 * An extension of L4WriterAppender that as a bridge between
 * Log4CocoaTouch and <a href="p://github.com/fpillet/NSLogger">NSLogger</a>.
 */
@interface L4NSLoggerAppender : L4AppenderSkeleton {
	// NSLogger Instance.
	Logger *logger;
	
	// Log Exceptions?
	BOOL shouldLogExceptions;
	 
	 // Log Exceptions Trace?
	BOOL shouldLogTrace;
}
//////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// 
#pragma mark Properties.
@property (assign) BOOL shouldLogExceptions; 
@property (assign) BOOL shouldLogTrace;

//////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// 
#pragma mark -
#pragma mark Init Methods.
//////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// 
- (id) initWithLayout:(L4Layout *)aLayout;

//////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// 
#pragma mark -
#pragma mark Config Methods.
//////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// 
-(void)setOptions:(uint32_t)options;

@end
