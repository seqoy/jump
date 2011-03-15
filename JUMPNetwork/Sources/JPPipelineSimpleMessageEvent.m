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
#import "JPPipelineSimpleMessageEvent.h"

/// /// /// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ///
@implementation JPPipelineSimpleMessageEvent
@synthesize message;


//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
// Pevent the initialization of the abstract class via the default initializer.
// You should subclass as an Concrete class or use JPPipelineUpstreamMessageEvent or JPPipelineDownstreamMessageEvent.
// When you subclass, make sure to doesn't call [super init].
- (id)init {
	[self doesNotRecognizeSelector:_cmd];
	[self release];
	return nil;
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Init Methods. 
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
+(id)initWithMessage:(id)anMessage {
	return [[[self alloc] initWithMessage:anMessage] autorelease];
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
-(id)initWithMessage:(id)anMessage {
	self = [super init];
	if (self != nil) {
		
		// Check Parameters.
        if (anMessage == nil) {
			[NSException raise:@"NullPointerException" format:@"Message Object is null."];
        }

		// Retain parameters.
        self.message  = anMessage;
	}
	return self;
}

// /// /// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ///
// Returns the Future Object which is associated with this event. 
// This method should be overrided before use.
-(<JPPipelineFuture>)getFuture {
	[NSException raise:NSInternalInconsistencyException 
				format:@"You must override [%@ %@] before use it.", NSStringFromClass([self class]), NSStringFromSelector(_cmd)];
	return nil;
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Memory Management Methods. 
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
- (void) dealloc {
	[message release], message = nil;
	[super dealloc];
}


@end
