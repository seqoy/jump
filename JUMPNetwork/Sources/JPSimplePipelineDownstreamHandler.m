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
#import "JPSimplePipelineDownstreamHandler.h"

/// /// /// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ///
@implementation JPSimplePipelineDownstreamHandler
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

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
/**
 * Handles the specified downstream event. Down-casts the received downstream event into more
 * meaningful sub-type event and calls an appropriate handler method with
 * the down-casted event.
 */
-(void)handleContextDownstream:(JPDefaultHandlerContext*)ctx withEvent:(id<JPPipelineEvent>)e {

    // Starting, so progress is 0%.
    [ctx setProgress:@0 withEvent:e];

	///////// /////// /////// /////// /////// /////// /////// /////// 
	// Handle if is an Message Event.
	if ([(id)e conformsToProtocol:@protocol( JPPipelineMessageEvent )])
		[self sendRequestedWithContext:ctx withMessageEvent:(id<JPPipelineMessageEvent>)e];
	
    ///////// /////// /////// /////// /////// /////// /////// /////// 
	// If can't handle, send Down Stream.
    else 
		[ctx sendDownstream:e];
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
// Invoked when some Send data is requested.
-(void)sendRequestedWithContext:(id<JPPipelineHandlerContext>)ctx withMessageEvent:(id<JPPipelineMessageEvent>)e {
    
    // Finished, so progress is 100%.
    [ctx setProgress:@100 withEvent:e];
	
	// We don't do nothing here actually, just send upstream.
	// This method is intended to be subclassed.
	[ctx sendDownstream:e];
}

@end
