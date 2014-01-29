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
@synthesize cause, progress;

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Init Methods. 
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
- (id) init {
    self = [super init];
    if (self != nil) {
        progress = @(0);
    }
    return self;
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
+ (id)init {
	return [[self alloc] init];
}

+(id)initWithListener:(id<JPPipelineFutureListener>)anListener {
	JPPipelineDefaultFuture *instance = [self init];
	
	// Set Listener.
	[instance addListener:anListener];
	
	// Return instance.
	return instance;
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Notification Methods. 

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
-(void)eraseListeners {
    for ( id listener in listeners )
        [[NSNotificationCenter defaultCenter] removeObserver:listener];
    [listeners removeAllObjects];
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
-(void)notifyListenersAndErase:(BOOL)erase withEvent:(id<JPPipelineEvent>)anEvent {
    
    // Create one notification.
    JPPipelineNotification* notification = [JPPipelineNotification initWithName:JPNofityPipelineFutureListener];
	
	// Attach this future on the notification.
	[notification setObject:self];
    
    // Attach the event on the User Dictionary, if needed.
    if ( anEvent )
        [notification setUserInfo:@{JPPipelineNotificationEvent: anEvent}];
    
	// Post Notification.
	[[NSNotificationCenter defaultCenter] postNotification:notification];
    
    // Erase if asked.
    if ( erase )
        [self eraseListeners];
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
-(void)notifyListenersWithEvent:(id<JPPipelineEvent>)anEvent {
	[self notifyListenersAndErase:YES withEvent:anEvent];
}
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
-(void)notifyListeners {
	[self notifyListenersAndErase:YES withEvent:nil];
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
-(void)addListener:(id<JPPipelineFutureListener>)anListener {
	// Check Parameters.
	if (anListener == nil) {
		[NSException raise:NSInvalidArgumentException format:@"An Listener is null."];
	}
    
    //// //// //// //// //// //// //// ///// //// //// //// //// //// //// /
    // Init array of listeners if needed.
    if (!listeners) listeners = [NSMutableArray new];

    // Add to array of listeners.
    [listeners addObject:anListener];
    
    //// //// //// //// //// //// //// ///// //// //// //// //// //// //// /
    // The notification only will be sent for listeners of this object.
    [[NSNotificationCenter defaultCenter]  addObserver:anListener 
                                              selector:@selector(someActionOcurr:) 
                                                  name:JPNofityPipelineFutureListener
                                                object:self];
    
	//// //// //// //// //// //// //// //// //// //// //// //// /
	// Should Notify now !
	if ( [self isDone] ) {
		 [self notifyListeners];
	}
}

/////////// /////////// /////////// /////////// /////////// /////////// /////////// /////////// /////////// 
// Removes the specified listener
-(void)removeListener:(id<JPPipelineFutureListener>)anListener {
	// Check Parameters.
	if (anListener == nil) {
		[NSException raise:NSInvalidArgumentException format:@"An Listener is null."];
	}

    // Remove the listener, if is already done that is nothing to remove.
	if ( ![self isDone] ) {
        [[NSNotificationCenter defaultCenter] removeObserver:anListener];
        [listeners removeObject:anListener];
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
	[self notifyListenersAndErase:NO withEvent:nil];
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// ////
-(void)setProgress:(NSNumber *)anValue {
	// If done, can't set progress.
	if ( [self isDone] )
        Warn( @"Can't set progress! This action is Done." );

    // If no changes, do nothing.
    if ( anValue == progress )
        return;
    
    // Set, copying.
    progress = anValue;
    
	// Notify.
	[self notifyListenersAndErase:NO withEvent:nil];
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// ////
-(void)setFailure:(NSError*)anCause {
	// Allow only once.
	// If done, can't set error.
	if ( [self isDone] )
		Warn(@"Can't set Failure! This action is Done.");
	
	// Retain new cause.
	cause = anCause;

	// Notify.
	[self notifyListeners];
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// ////
-(void)setSuccessWithEvent:(id<JPPipelineEvent>)anEvent {
	// If done, can't set sucess.
	if ( [self isDone] )
		Warn(@"Can't set success! This action is Done.");
    
	// Success.
	success = YES;
    
	// Notify.
	[self notifyListenersWithEvent:anEvent];
    
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// ////
-(void)setSuccess {
    [self setSuccessWithEvent:nil];
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Memory Management Methods. 
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
- (void) dealloc {
    [self eraseListeners];
}

@end
