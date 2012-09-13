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
#import "JPPipelineHandler.h"
#import "JPDefaultHandlerContext.h"

/**
 * @ingroup handlers_group

 Handles or intercepts an upstream JPPipelineEvent, and sends a JPPipelineEvent to the next handler in a JPPipeline.
 The most common use case of this interface is to intercept an event to transform the received messages or execute the relevant business logic.
 
 <h2>Using the Upstream Handler Class</h2>
 
 In most cases, you will get to use a JPSimplePipelineUpstreamHandler to implement an upstream handler because it provides an individual
 handler method for each event type. You might want to implement this interface directly though if you want to handle various types of events 
 in more generic way.
 
 <h3>Firing an event to the next handler</h3>
 
 You can forward the received event upstream or downstream. In most cases, JPPipelineUpstreamHandler will send the event upstream (i.e. inbound)
 although it is legal to send the event downstream (i.e. outbound):
 
 \code
 // Sending the event upstream (inbound)
 // Override...
 -(void)handleContextUpstream:(JPDefaultHandlerContext*)ctx withEvent:(id<JPPipelineEvent>)e {
	 ...
	 [ctx sendUpstream:e];
	 ...
 }
 
 // Sending the event downstream (outbound)
  -(void)handleContextDownstream:(JPDefaultHandlerContext*)ctx withEvent:(id<JPPipelineEvent>)e {
	 ...
	 [ctx sendDownstream:[DownstreamMessageEvent init(...)]];
	 ...
 }
 \endcode
 
*/ 
@protocol JPPipelineUpstreamHandler <JPPipelineHandler>

/**
 * Handles the specified specified event.
 * @param ctx  The context object for this handler.
 * @param e    The downstream event to process or intercept.
 */
-(void)handleContextUpstream:(JPDefaultHandlerContext*)ctx withEvent:(id<JPPipelineEvent>)e;
@end
