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
#import "JPPipelineHandlerContext.h"



/**
 * @ingroup handlers_group
 *
 * Handles or intercepts a Event, and sends a
 * Event to the next handler in a Pipeline.
 *
 * Pipeline Handler Protocol itself does not provide any method.  To handle a
 * Event you need to implement its sub-interfaces.  There are
 * two sub-interfaces which handles a received event, one for upstream events
 * and the other for downstream events:
 * 
 *	- JPPipelineUpstreamHandler handles and intercepts an upstream Event.
 *	- JPPipelineDownstreamHandler handles and intercepts a downstream Event.
 *
 * You will also find more detailed explanation from the documentation of
 * each sub-interface on how an event is interpreted when it goes upstream and
 * downstream respectively.
 *
 * <h3>The context object</h3>
 * <p>
 * A JPPipelineHandler is provided with a JPPipelineHandlerContext
 * object.  A JPPipelineHandler is supposed to interact with the
 * JPPipeline it belongs to via a context object.  Using the
 * context object, the JPPipelineHandler can pass events upstream or
 * downstream, modify the pipeline dynamically, or store the information
 * (attachment) which is specific to the handler.
 *
 */ 
@protocol JPPipelineHandler 

	// No methods, maybe someday!

@end
