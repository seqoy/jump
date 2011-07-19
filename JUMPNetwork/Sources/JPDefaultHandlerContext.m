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
#import "JPDefaultHandlerContext.h"
#import "JPPipeline.h"

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
@implementation JPDefaultHandlerContext
@synthesize next, prev, pipeline;

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Init Methods. 
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
+(id)initWithPreviousContext:(JPDefaultHandlerContext*)previousCtx andNextContext:(JPDefaultHandlerContext*)nextCtx 
					 andName:(NSString*)anName andHandler:(<JPPipelineHandler>)anHandler
				withPipeline:(JPPipeline*)anPipeline {
	return [[[JPDefaultHandlerContext alloc] initWithPreviousContext:previousCtx
													 andNextContext:nextCtx
															andName:anName
														 andHandler:anHandler
														withPipeline:anPipeline] 
			autorelease];
}
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
-(id)initWithPreviousContext:(JPDefaultHandlerContext*)previousCtx andNextContext:(JPDefaultHandlerContext*)nextCtx 
					 andName:(NSString*)anName andHandler:(<JPPipelineHandler>)anHandler
				withPipeline:(JPPipeline*)anPipeline {
	//////////////////////
	self = [super init];
	if (self != nil) {

		////////////////////////// ///////////////////// 
		// Correct values?
		if (anName == nil) {
			[NSException raise:NSInvalidArgumentException format:@"Name is null."];
		}
		if (anHandler == nil) {
			[NSException raise:NSInvalidArgumentException format:@"Handler is null."];
		}
		if (anPipeline == nil) {
			[NSException raise:NSInvalidArgumentException format:@"Pipeline is null."];
		}
		
		////////////////////////// ///////////////////// 
		// Correct instances?
		canHandleUpstream = [(id)anHandler conformsToProtocol:@protocol( JPPipelineUpstreamHandler )];
		canHandleDownstream = [(id)anHandler conformsToProtocol:@protocol( JPPipelineDownstreamHandler )]; 
		
		if (!canHandleUpstream && !canHandleDownstream) {
			[NSException raise:@"IllegalArgumentException" format:@"Handler is must be conform to %@ or %@ protocols.", @"a", @"b" ];
		}

		////////////////////////// ///////////////////// 
		// Assign values.
		self.pipeline	= anPipeline;
		self.prev		= previousCtx;
		self.next		= nextCtx;

		////////////////////////// ///////////////////// 
		// Handle the Handler (daaah!), release first if needed.
        if ( handler ) [(id)handler release];
		handler	= [(id)anHandler retain];
		
		// Copy values.
		name = [anName copy];
	}
	return self;
}

//// //// //// //// //// //// //// //// //// //// //// //
// Object Description.
-(NSString*)description {
	return [NSString stringWithFormat:@"[JPDefaultHandlerContext: %@]", [self name]];
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Methods. 
-(NSString*)name {
	return name;
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //
-(JPPipeline*)getPipeline {
	return self.pipeline;
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //
-(<JPPipelineHandler>)handler {
	return handler;
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //
-(BOOL)canHandleUpstream {
	return canHandleUpstream;
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //
-(BOOL)canHandleDownstream {
	return canHandleDownstream;
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //
-(void)sendUpstream:(<JPPipelineEvent>)e {
	JPDefaultHandlerContext* anNext = [pipeline getActualUpstreamContext:self.next];
	if (anNext != nil) {
		[pipeline sendContextUpstream:anNext withEvent:e];
	}
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //
-(void)sendDownstream:(<JPPipelineEvent>)e {
	JPDefaultHandlerContext* previous = [pipeline getActualDownstreamContext:self.prev];
	if (previous == nil) {
		@try {
			[[pipeline sink] eventSunk:pipeline withEvent:e];
		} 
		
		@catch (NSException *exception) {
			[pipeline notifyHandlerException:exception withEvent:e];
		}
	} else {
		[pipeline sendContextDownstream:previous withEvent:e];
	}
}


//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Memory Management Methods. 
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
- (void) dealloc {
	[(id)handler release];
	[name release];
	[super dealloc];
}



@end
