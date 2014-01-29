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
#import "JPSimplePipelineUpstreamHandler.h"
#import "JPPipeline.h"

/// /// /// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ///
@implementation JPSimplePipelineUpstreamHandler
@synthesize progressPriority;

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Init Methods. 
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
- (id) init {
    self = [super init];
    if (self != nil) {
        self.progressPriority = 10;
    }
    return self;
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
+(id)init {
	return [[self alloc] init];
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
-(NSString*)description {
	return [NSString stringWithFormat:@"[%@]", NSStringFromClass([self class])];
	 
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Methods. 
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
/**
 * Handles the specified upstream event. Down-casts the received upstream event into more
 * meaningful sub-type event and calls an appropriate handler method with
 * the down-casted event.
 */
-(void)handleContextUpstream:(JPDefaultHandlerContext*)ctx withEvent:(id<JPPipelineEvent>)e {
    
    // Starting, so progress is 0%.
    [ctx setProgress:@0 withEvent:e];
	
    ///////// /////// /////// /////// /////// /////// /////// /////// 
	// Handle if is an Exception Event.
	if ([(id)e conformsToProtocol:@protocol( JPPipelineExceptionEvent )]) 
        [self exceptionCaughtWithContext:ctx withException:(id<JPPipelineExceptionEvent>)e];
    
	///////// /////// /////// /////// /////// /////// /////// /////// 
	// Handle if is an Message Event.
	else if ([(id)e conformsToProtocol:@protocol( JPPipelineMessageEvent )])
		[self messageReceived:ctx withMessageEvent:(id<JPPipelineMessageEvent>)e];
	
	
    ///////// /////// /////// /////// /////// /////// /////// /////// 
	// If can't handle, send Up Stream.
    else 
		[ctx sendUpstream:e];
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
// Invoked when a message object was received.
-(void)messageReceived:(id<JPPipelineHandlerContext>)ctx withMessageEvent:(id<JPPipelineMessageEvent>)e {
    
    // Finishing, so progress is 100%.
    [ctx setProgress:@100 withEvent:e];
	
	// We doesn't do nothing here actually, just send upstream.
	// This method is intended to be subclassed.
	[ctx sendUpstream:e];
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
// Invoked when an exception was raised.
-(void)exceptionCaughtWithContext:(id<JPPipelineHandlerContext>)ctx withException:(id<JPPipelineExceptionEvent>)e {
	if (self == [[ctx getPipeline] performSelector:@selector(last)] ) {
		Info( @"An exception was found and no Pipeline Handler was able to handle it.\n" 
              @"You could implement exceptionCaughtWithContext:withException: on same handler if you want to deal with that.\n"
              @"The unhandled exception are: %@", e);
	}
	
	// Send Error Event Upstream.
	[ctx sendUpstream:e];
}		


@end
