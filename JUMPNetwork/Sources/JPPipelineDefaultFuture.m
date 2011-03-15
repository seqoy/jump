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
#import "JPPipelineDefaultFuture.h"

/// /// /// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ///
@implementation JPPipelineDefaultFuture
@synthesize cause;

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Init Methods. 
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
+ (id)init {
	return [[[self alloc] init] autorelease];
}

+(id)initWithListener:(<JPPipelineFutureListener>)anListener {
	JPPipelineDefaultFuture *instance = [self init];
	
	// Set Listener.
	[instance addListener:anListener];
	
	// Return instance.
	return instance;
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Private Methods. 
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
-(void)notifyListener:(<JPPipelineFutureListener>)anListener {
	@try {
		[anListener someActionOcurr:self];
	} 
	
	@catch (NSException* anException) {
		Warn( @"An exception was thrown by %@: %@", [(id)anListener class], anException );
 	}
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
-(void)notifyListenersAndErase:(BOOL)erase {
	if (firstListener != nil) {
		[self notifyListener:firstListener];
		
		// Erase if asked.
		if ( erase ) 
			[(id)firstListener release], firstListener = nil;
		
		if (otherListeners != nil) {
			for ( <JPPipelineFutureListener> anListener in otherListeners ) {
				[self notifyListener:anListener];
			}
			// Erase if asked.
			if ( erase )
				[otherListeners release], otherListeners = nil;
		}
	}
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
-(void)notifyListeners {
	[self notifyListenersAndErase:YES];
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Methods. 
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
-(void)addListener:(<JPPipelineFutureListener>)anListener {
	// Check Parameters.
	if (anListener == nil) {
		[NSException raise:NSInvalidArgumentException format:@"An Listener is null."];
	}

	//// //// //// //// //// //// //// //// //// //// //// //// /
	// Should notify now, start as false.
	BOOL notifyNow = NO;
	
	//// //// //// //// //// //// //// //// //// //// //// //// /
	// If is done, will notify now.
	if ([self isDone]) {
		notifyNow = YES;
	} 
	
	//// //// //// //// //// //// //// //// //// //// //// //// /
	// If isn't done, store the listener.
	else {
		if (firstListener == nil) {
			firstListener = [(id)anListener retain];
		} else {
			if (otherListeners == nil) {
				otherListeners = [[NSMutableArray alloc] init];
			}
			[otherListeners addObject:anListener];
		}
	}
	
	//// //// //// //// //// //// //// //// //// //// //// //// /
	// Notify now !
	if ( notifyNow ) {
		[self notifyListener:anListener];
	}
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// ////
-(void)removeListener:(<JPPipelineFutureListener>)anListener {
	// Check Parameters.
	if (anListener == nil) {
		[NSException raise:NSInvalidArgumentException format:@"An Listener is null."];
	}
	
	if ( ![self isDone] ) {
		if (anListener == firstListener) {
			if (otherListeners != nil && ![otherListeners count] == 0) {
				[(id)firstListener release], firstListener = nil;
				firstListener = [[otherListeners objectAtIndex:0] retain];
				[otherListeners removeObjectAtIndex:0];
			} else {
				[(id)firstListener release], firstListener = nil;
			}
		} else if (otherListeners != nil) {
			[otherListeners removeObject:anListener];
		}
	}
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// ////
#pragma mark -
//// //// //// //// //// //// //// //// //// //// //// //// //// //// ////
-(BOOL)isDone {
	return [self isCancelled] || [self isSuccess] || [self isFailed];													  
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// ////
-(BOOL)isCancelled {
	return cancelled;
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// ////
-(BOOL)isSuccess {
	return success;
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// ////
-(BOOL)isStarted {
	return started && ![self isDone];
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// ////
-(BOOL)isFailed {
	return [self getCause] != nil;
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// ////
-(void)cancel {
	// Allow only once.
	if ( [self isDone] )
		Warn( @"Can't Cancel This action is Done." );
	
	cancelled = YES;
	
	// Notify.
	[self notifyListeners];
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// ////
-(void)setStarted {
	started = YES;
	
	// Notify Listeners.
	[self notifyListenersAndErase:NO];
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// ////
-(void)setFailure:(NSError*)anCause {
	// Allow only once.
	// If done, can't set sucess.
	if ( [self isDone] )
		[NSException raise:@"JPPipelineNotificationException"
					format:@"Can't set Failture! This action is Done."];
	
	// Release older cause.
	[cause release], cause = nil;
	// Retain new cause.
	cause = [anCause retain];

	// Notify.
	[self notifyListeners];
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// ////
-(void)setSuccess {
	// If done, can't set sucess.
	if ( [self isDone] )
		[NSException raise:@"JPPipelineNotificationException"
					format:@"Can't set success! This action is Done."];
	// Success.
	success = YES;

	// Notify.
	[self notifyListeners];
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Memory Management Methods. 
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
- (void) dealloc {
	[otherListeners release], otherListeners = nil;
	[(id)firstListener release], firstListener = nil;
	[super dealloc];
}

@end
