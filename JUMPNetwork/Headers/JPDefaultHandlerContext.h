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
#import "JPPipelineHandler.h"
#import "JPPipelineHandlerContext.h"

@class JPPipeline;

/**
 * @copydoc JPPipelineHandlerContext
 */
@interface JPDefaultHandlerContext : NSObject <JPPipelineHandlerContext> {
	JPDefaultHandlerContext* next;
	JPDefaultHandlerContext* prev;
	NSString* name;
	
	// Handler.
	<JPPipelineHandler> handler;
	
	// Handlers logic.
	BOOL canHandleUpstream;
	BOOL canHandleDownstream;
	
	// Pipeline pointer.
	JPPipeline* pipeline;
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark Properties.
@property (assign) JPDefaultHandlerContext* next;
@property (assign) JPDefaultHandlerContext* prev;

/// The pipeline this context belong to.
@property (assign) JPPipeline* pipeline;

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Init Methods. 
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
/** @name Init Methods
 */
///@{ 

+(id)initWithPreviousContext:(JPDefaultHandlerContext*)previousCtx andNextContext:(JPDefaultHandlerContext*)nextCtx 
					 andName:(NSString*)anName andHandler:(<JPPipelineHandler>)anHandler withPipeline:(JPPipeline*)anPipeline;;
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
-(id)initWithPreviousContext:(JPDefaultHandlerContext*)previousCtx andNextContext:(JPDefaultHandlerContext*)nextCtx 
					 andName:(NSString*)anName andHandler:(<JPPipelineHandler>)anHandler withPipeline:(JPPipeline*)anPipeline;
	
///@}
@end
