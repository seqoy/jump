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
#import "JPPipelineEvent.h"

// Weak references.
@class JPPipeline;
@protocol JPPipelineHandler;

/**
 \protocol JPPipelineHandlerContext
 
 Enables a JPPipelineHandler to interact with its JPPipeline and other handlers.
 A handler can send a JPPipelineEvent upstream or downstream, modify the JPPipeline it belongs to dynamically.<br>
 
 <h3>Sending an event</h3>
 
 You can send or forward a JPPipelineEvent to the closest handler in the same JPPipeline by calling 
 sendUpstream(ChannelEvent) or sendDownstream(ChannelEvent). Please refer to JPPipeline to understand how an event flows.
 
 <h3>Modifying a pipeline</h3>
 
 You can get the JPPipeline your handler belongs to by calling #getPipeline.
 A non-trivial application could insert, remove, or replace handlers in the pipeline dynamically in runtime.
 
 <h3>Retrieving for later use</h3>
 
 You can keep the JPPipelineHandlerContext for later use, such as
 triggering an event outside the handler methods, even from a different thread.

 \code
 @interface MyHandler : JPSimplePipelineHandler {
	id<JPPipelineHandlerContext> savedCtx;
 }
 @end
 
 @implementation MyHandler
 
 -(void)beforeAdd:(id<JPPipelineHandlerContextct>)ctx {
	savedCtx = ctx;
 }
 
 -(void)login:(NSString*)username andPassword:(NSString*)password {
	... 
	[self login:username andPassword:password withSavedContext:savedCtx]; 
	...
 }
 @end
 \endcode
 
 <h3>Additional resources worth reading</h3>
 
 Please refer to the JPPipelineHandler, JPPipelineEvent and JPPipeline to find out what a 
 upstream event and a downstream event are, what fundamental differences they have, how they 
 flow in a pipeline, and how to handle the event in your application. 
 */ 
@protocol JPPipelineHandlerContext
@required

/**
 * Returns the name of the JPPipelineHandler.
 */
-(NSString*)name;

/**
 * Returns the JPPipelineHandler that this context object is
 * serving.
 */
-(id<JPPipelineHandler>)handler;

/**
 * Returns the Pipeline that this context belongs to.
 */
-(JPPipeline*)getPipeline;

/**
 * Returns YES if and only if the JPPipelineHandler is an
 * instance of JPPipelineUpstreamHandler.
 */
-(BOOL)canHandleUpstream;

/**
 * Returns YES if and only if the JPPipelineHandler is an
 * instance of JPPipelineDownstreamHandler.
 */
-(BOOL)canHandleDownstream;

/**
 * Sends the specified JPPipelineEvent to the
 * JPPipelineUpstreamHandler which is placed in the closest upstream
 * from the handler associated with this context.
 */
-(void)sendUpstream:(id<JPPipelineEvent>)e;

/**
 * Sends the specified JPPipelineEvent to the
 * JPPipelineDownstreamHandler which is placed in the closest
 * downstream from the handler associated with this context. 
 */
-(void)sendDownstream:(id<JPPipelineEvent>)e;

/**
 * The current progress that the JPPipelineHandler that this context is handling.
 * This property should contain values from 0 to 100. If this value is <tt>nil</t>
 * 100 will be assumed.
 */
-(NSNumber*)progress;

/**
 * Used by the JPPipelineHandler that this context is handling
 * to set his current progress. This progress is used by the
 * JPPipeline to calculate an overall progress of all operations
 * on a pipeline call. This property should contain values from 0 to 100.
 * You must pass the actual event been processing in order to send
 * progress notification to his future (if defined).
 */
-(void)setProgress:(NSNumber*)anValue withEvent:(id<JPPipelineEvent>)anEvent;

/**
 * Retrieve the progress priority that the Handler attached to this Context
 * has on the overall progress calcuation. Return a number from 0 to 10.
 */
-(NSInteger)progressPriority;

/**
 * Set the progress priority that the Handler attached to this Context
 * has on the overall progress calcuation. Should be a number from 0 to 10.
 */
-(void)setProgressPriority:(NSInteger)priority;

@end
