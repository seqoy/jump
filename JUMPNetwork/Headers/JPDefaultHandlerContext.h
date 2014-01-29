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
	NSString* name;
	
	// Handler.
	id<JPPipelineHandler> handler;
	
	// Handlers logic.
	BOOL canHandleUpstream;
	BOOL canHandleDownstream;
	
    // Progress.
    NSNumber *progress;
    
    // Progress priority.
    NSInteger progressPriority;
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark Properties.
@property (assign) JPDefaultHandlerContext* next;
@property (assign) JPDefaultHandlerContext* prev;

/// The pipeline this context belongs to.
@property (assign) JPPipeline* pipeline;

/// The current progress that the JPPipelineHandler that this context is handling.
@property (readonly) NSNumber* progress;

/**
 * Retrieve the progress priority that the Handler attached to this Context
 * has on the overall progress calcuation. Return a number from 0 to 10.
 */
@property (nonatomic,assign) NSInteger progressPriority;

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Init Methods. 
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
/** @name Init Methods
 */
///@{ 

+(id)initWithPreviousContext:(JPDefaultHandlerContext*)previousCtx andNextContext:(JPDefaultHandlerContext*)nextCtx 
					 andName:(NSString*)anName andHandler:(id<JPPipelineHandler>)anHandler withPipeline:(JPPipeline*)anPipeline;;
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
-(id)initWithPreviousContext:(JPDefaultHandlerContext*)previousCtx andNextContext:(JPDefaultHandlerContext*)nextCtx 
					 andName:(NSString*)anName andHandler:(id<JPPipelineHandler>)anHandler withPipeline:(JPPipeline*)anPipeline;
	
///@}
@end
