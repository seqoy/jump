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
#import "JPPipeline.h"
@implementation JPPipeline
@synthesize sink;

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Private Methods. 
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
-(void)checkDuplicateName:(NSString*)name {
	if ( [contextObjectsMap objectForKey:name] ) {
		[NSException raise:@"IllegalArgumentException" format:@"Duplicate handler name: %@.", name];
	}
}

/// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
// Check if object could be replaced or removed.
-(void)checkIfIsFinalObject:(JPDefaultHandlerContext*)ctx {
	if ( [finalObjects containsObject:ctx] ) 
		[NSException raise:@"UnauthorizedAccessException" format:@"The handler '%@' can't be removed or replaced!", [ctx name]];
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
// Get Context By Name.
-(JPDefaultHandlerContext*)getContextByName:(NSString*)name {
	if (name == nil) {
		[NSException raise:NSInvalidArgumentException format:@"Name is nil"];
	}
	return [contextObjectsMap objectForKey:name];
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
// Get Context By Handler.
-(JPDefaultHandlerContext*)getContextByHandler:(<JPPipelineHandler>)handler {
	if (handler == nil) {
		[NSException raise:NSInvalidArgumentException format:@"Handler is nil"];
	}
	if ([contextObjectsMap count] == 0) {
		return nil;
	}
	JPDefaultHandlerContext *ctx = head;
	for (;;) {
		if ([ctx handler] == handler) {
			return ctx;
		}
		
		ctx = ctx.next;
		if (ctx == nil) {
			break;
		}
	}
	return nil;
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
// Get Context By Name, throw exception if doesn't found.
-(JPDefaultHandlerContext*)getContextByNameOrDie:(NSString*)name {
	JPDefaultHandlerContext* ctx = [self getContextByName:name];
	if (ctx == nil)
		[NSException raise:@"NoSuchElementException" format:@"%@", name];

	return ctx;
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
// Get Context By Handler, throw exception if doesn't found.
-(JPDefaultHandlerContext*)getContextByHandlerOrDie:(<JPPipelineHandler>)handler {
	JPDefaultHandlerContext* ctx = [self getContextByHandler:handler];
	if (ctx == nil) 
		[NSException raise:@"NoSuchElementException" format:@"%@", NSStringFromClass( [(id)handler class] )];

	return ctx;
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
// Remove By Context.
-(JPDefaultHandlerContext*)removeByContext:(JPDefaultHandlerContext*)ctx {
	// If context is final. Raise exception.
	[self checkIfIsFinalObject:ctx];
	
	/////////// /////////// /////////// /////////// /////////// /////////// /////////// /////////// /////////// /////////// 
	if (head == tail) {
		// Release Head and Tail.
		[head release], head = nil;
		[tail release], tail = nil;
		[contextObjectsMap removeAllObjects];
	} else if (ctx == head) {
		[self removeFirst];
	} else if (ctx == tail) {
		[self removeLast];
	} else {
		JPDefaultHandlerContext* prev = ctx.prev;
		JPDefaultHandlerContext* next = ctx.next;
		prev.next = next;
		next.prev = prev;
		[contextObjectsMap removeObjectForKey:[ctx name]];
	}
	return ctx;
}

/////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// 
// Replace By Context.
-(<JPPipelineHandler>)replaceByContext:(JPDefaultHandlerContext*)ctx withName:(NSString*)newName andHandler:(<JPPipelineHandler>)newHandler {
	// If context is final. Raise exception.
	[self checkIfIsFinalObject:ctx];
	
	/////////// /////////// /////////// /////////// /////////// /////////// /////////// /////////// /////////// /////////// 
	if (ctx == head) {
		[self removeFirst];
		[self addFirst:newName withHandler:newHandler];
	} else if (ctx == tail) {
		[self removeLast];
		[self addLast:newName withHandler:newHandler];
	} else {
		BOOL sameName = [[ctx name] isEqualToString:newName];
		if (!sameName) {
			[self checkDuplicateName:newName];
		}
		
		JPDefaultHandlerContext* prev = ctx.prev;
		JPDefaultHandlerContext* next = ctx.next;
		JPDefaultHandlerContext* newCtx = [JPDefaultHandlerContext initWithPreviousContext:prev
																			andNextContext:next
																				   andName:newName
																				andHandler:newHandler
																			   withPipeline:self];
		prev.next = newCtx;
		next.prev = newCtx;
		
		if (!sameName) {
			[contextObjectsMap removeObjectForKey:[ctx name]];
			[contextObjectsMap setObject:newCtx forKey:newName];
		}
	}
	
	return [ctx handler];
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Init Methods. 
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
- (id) init
{
	self = [super init];
	if (self != nil) {
		// Init.
		contextObjectsMap = [[NSMutableDictionary alloc] init];
		notificationCenter = [NSNotificationCenter defaultCenter];
	}
	return self;
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
+(id)init {
	return [[[self alloc] init] autorelease];
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
-(void)buildContextMapWithName:(NSString*)anName andHandler:(<JPPipelineHandler>)anHandler  {
	JPDefaultHandlerContext* ctx = [JPDefaultHandlerContext initWithPreviousContext:nil
																	 andNextContext:nil
																			andName:anName
																		 andHandler:anHandler
																	   withPipeline:self];
	// Head and Tails.
	head = ctx;
	tail = ctx;
	
	// Add to Context Map.
	[contextObjectsMap removeAllObjects];
	[contextObjectsMap setObject:ctx forKey:anName];
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Methods. 

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
// Inserts a Handler at the first position of this pipeline.
-(void)addFirst:(NSString*)name withHandler:(<JPPipelineHandler>)handler {
	if ( [contextObjectsMap count] == 0 ) {
		[self buildContextMapWithName:name andHandler:handler];
	}
	
	else {
		// Check if already exists.
		[self checkDuplicateName:name];

		// Change Heads.
		JPDefaultHandlerContext *oldHead = head;
		JPDefaultHandlerContext *newHead = [JPDefaultHandlerContext initWithPreviousContext:nil
																			 andNextContext:oldHead
																					andName:name
																				 andHandler:handler
																				withPipeline:self];
		oldHead.prev = newHead;
		head = newHead;

		// Add to the Dictionary.
		[contextObjectsMap setObject:newHead forKey:name];
	}
}
/////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// 
// Appends a Handler at the last position of this pipeline.
-(void)addLast:(NSString*)name withHandler:(<JPPipelineHandler>)handler {
	if ( [contextObjectsMap count] == 0 ) {
		[self buildContextMapWithName:name andHandler:handler];
	}
	
	else {
		// Check if already exists.
		[self checkDuplicateName:name];
		
		// Change Tail.
		JPDefaultHandlerContext *oldTail = tail;
		JPDefaultHandlerContext *newTail = [JPDefaultHandlerContext initWithPreviousContext:oldTail
																			 andNextContext:nil
																					andName:name
																				 andHandler:handler 
																				withPipeline:self];
		oldTail.next = newTail;
		tail = newTail;
		
		// Add to the Dictionary.
		[contextObjectsMap setObject:newTail forKey:name];
	}
}

/////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// 
// Inserts a Handler before an existing handler of this.
-(void)addBefore:(NSString*)baseName withName:(NSString*)name withHandler:(<JPPipelineHandler>)handler {
	
	// Get Context.
	JPDefaultHandlerContext *ctx = [self getContextByNameOrDie:baseName];
	
	///////// ///////// ///////// ///////// ///////// ///////// ///////// ///////// ///////// 
	// If on the head, insert first.
	if (ctx == head) 
		[self addFirst:baseName withHandler:handler];
	
	////////// ///////// ///////// ///////// ///////// ///////// ///////// ///////// ///////// 
	// If don't...
	else {
		
		// Check if already exists.
		[self checkDuplicateName:name];
		
		// Create New Context.
		JPDefaultHandlerContext *newCtx=  [JPDefaultHandlerContext initWithPreviousContext:ctx.prev
																			andNextContext:ctx
																				   andName:name
																				andHandler:handler 
																			   withPipeline:self];
		// Set contexts chain.
		ctx.prev.next = newCtx;
		ctx.prev = newCtx;
		
		// Add to the Dictionary.
		[contextObjectsMap setObject:newCtx forKey:name ];
	}
}

/////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// 
// Inserts a Handler after an existing handler of this.
-(void)addAfter:(NSString*)baseName withName:(NSString*)name withHandler:(<JPPipelineHandler>)handler  {
	
	// Get Context.
	JPDefaultHandlerContext *ctx = [self getContextByNameOrDie:baseName];
	
	///////// ///////// ///////// ///////// ///////// ///////// ///////// ///////// ///////// 
	// If on the tail, insert last.
	if (ctx == tail) 
		[self addLast:baseName withHandler:handler];
	
	////////// ///////// ///////// ///////// ///////// ///////// ///////// ///////// ///////// 
	// If don't...
	else {
		
		// Check if already exists.
		[self checkDuplicateName:name];
		
		// Create New Context.
		JPDefaultHandlerContext *newCtx = [JPDefaultHandlerContext initWithPreviousContext:ctx
																			andNextContext:ctx.next
																				   andName:name
																				andHandler:handler 
																			   withPipeline:self];
		// Set contexts chain.
		ctx.next.prev = newCtx;
		ctx.next = newCtx;
		
		// Add to the Dictionary.
		[contextObjectsMap setObject:newCtx forKey:name];
	}
}

/////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// 
// Removes the specified {@link ChannelHandler} from this pipeline.
-(void)removeByHandler:(<JPPipelineHandler>)handler {
	[self removeByContext:[self getContextByHandlerOrDie:handler]];
}

/////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// 
// Removes the {@link ChannelHandler} with the specified name from this pipeline.
-(<JPPipelineHandler>)removeByName:(NSString*)name {
	return [[self removeByContext:[self getContextByNameOrDie:name]] handler];
}

/////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// 
// Removes the first {@link ChannelHandler} in this pipeline.
-(<JPPipelineHandler>)removeFirst {
	if ([contextObjectsMap count] == 0) {
		[NSException raise:@"NoSuchElementException" format:@"Trying to remove the first element."];
	}
	
	JPDefaultHandlerContext *oldHead = head;
	if (oldHead == nil) {
		[NSException raise:@"NoSuchElementException" format:@"Trying to remove the first element."];
	}
	
	// If context is final. Raise exception.
	[self checkIfIsFinalObject:oldHead];
	
	if (oldHead.next == nil) {
		head = nil;
		tail = nil;
		[contextObjectsMap removeAllObjects];
	} else {
		oldHead.next.prev = nil;
		head = oldHead.next;
		[contextObjectsMap removeObjectForKey:[oldHead name]];
	}
	return [oldHead handler];
}


/////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// 
// Removes the last {@link ChannelHandler} in this pipeline.
-(<JPPipelineHandler>)removeLast {
	if ([contextObjectsMap count] == 0) {
		[NSException raise:@"NoSuchElementException" format:@"Trying to remove the last element."];
	}
	
	JPDefaultHandlerContext *oldTail = [[tail retain] autorelease];
	if (oldTail == nil) {
		[NSException raise:@"NoSuchElementException" format:@"Trying to remove the last element."];
	}
	
	// If context is final. Raise exception.
	[self checkIfIsFinalObject:oldTail];

	if (oldTail.prev == nil) {
		head = nil;
		tail = nil;
		[contextObjectsMap removeAllObjects];
	} else {
		oldTail.prev.next = nil;
		tail = oldTail.prev;
		[contextObjectsMap removeObjectForKey:[oldTail name]];
	}
	return [oldTail handler];
}

/////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// 
// Replaces the specified {@link ChannelHandler} with a new handler in this pipeline.
-(void)replaceByHandler:(<JPPipelineHandler>)oldHandler withName:(NSString*)name andHandler:(<JPPipelineHandler>)handler {
	[self replaceByContext:[self getContextByHandlerOrDie:oldHandler]
				  withName:name
				andHandler:handler];
}

/////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// 
// Replaces the {@link ChannelHandler} of the specified name with a new handler in this pipeline.
-(<JPPipelineHandler>)replaceByName:(NSString*)oldName withName:(NSString*)newName andHandler:(<JPPipelineHandler>)newHandler {
	return [self replaceByContext:[self getContextByNameOrDie:oldName]
				  withName:newName
				andHandler:newHandler];
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
// Set handler as final, so he can't be removed or replaced.
-(void)setAsFinal:(NSString*)name {
	// Get Context by Name.
	JPDefaultHandlerContext *ctx = [self getContextByNameOrDie:name];

	/////////// ////////// ////////// ////////// ////////// ////////// ////////// 
	// Init Set if needed.
	if ( !finalObjects ) 
		  finalObjects = [[NSMutableSet alloc] init];
	
	// Add to final Set.
	[finalObjects addObject:ctx];
}

/////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// 
// Returns the first {@link ChannelHandler} in this pipeline.
-(<JPPipelineHandler>)first {
	JPDefaultHandlerContext* anHead = head;
	if (anHead == nil) {
		return nil;
	}
	return [anHead handler];
}

/////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// 
// Returns the last {@link ChannelHandler} in this pipeline.
-(<JPPipelineHandler>)last {
	JPDefaultHandlerContext* anTail = tail;
	if (anTail == nil) {
		return nil;
	}
	return [anTail handler];
}

/////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// 
// Returns the {@link ChannelHandler} with the specified name in this
-(<JPPipelineHandler>)get:(NSString*)name {
	JPDefaultHandlerContext* ctx = [contextObjectsMap objectForKey:name];
	if (ctx == nil) {
		return nil;
	} else {
		return [ctx handler];
	}
}

/////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// 
// Sends the specified {@link ChannelEvent} to the first {@link ChannelDownstreamHandler} in this pipeline.
-(void)sendUpstream:(<JPPipelineEvent>)e {
	JPDefaultHandlerContext* anHead = [self getActualUpstreamContext:head];
	if (anHead == nil) {
		Warn( @"The pipeline contains no upstream handlers; discarding: %@", e);
		return;
	}
	[self sendContextUpstream:anHead withEvent:e];
}

/////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// 
-(void)sendContextUpstream:(JPDefaultHandlerContext*)ctx withEvent:(<JPPipelineEvent>)e {
	@try {
		[(<JPPipelineUpstreamHandler>)[ctx handler] handleContextUpstream:ctx withEvent:e]; 
	} 
	
	@catch (NSException *exception) {
		[self notifyHandlerException:exception withEvent:e];
	}
}

/////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// 
// Sends the specified {@link ChannelEvent} to the last {@link ChannelDownstreamHandler} in this pipeline.
-(void)sendDownstream:(<JPPipelineEvent>)e {
	JPDefaultHandlerContext* anTail = [self getActualDownstreamContext:tail];
	if (anTail == nil) {
		@try {
			[[self sink] eventSunk:self withEvent:e];
			return;
		} 
		
		@catch (NSException *exception) {
			[self notifyHandlerException:exception withEvent:e];
			return;
		}
	}

	[self sendContextDownstream:anTail withEvent:e];
}	

/////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// 
-(void)sendContextDownstream:(JPDefaultHandlerContext*)ctx withEvent:(<JPPipelineEvent>)e {
	@try {
		[(<JPPipelineDownstreamHandler>)[ctx handler] handleContextDownstream:ctx withEvent:e]; 
	} 
	
	@catch (NSException *exception) {
		[self notifyHandlerException:exception withEvent:e];
	}
}

/////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// 
-(JPDefaultHandlerContext*)getActualUpstreamContext:(JPDefaultHandlerContext*)ctx {
	if (ctx == nil) {
		return nil;
	}
	
	JPDefaultHandlerContext *realCtx = ctx;
	while (![realCtx canHandleUpstream]) {
		realCtx = realCtx.next;
		if (realCtx == nil) {
			return nil;
		}
	}
	return realCtx;
}

/////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// 
-(JPDefaultHandlerContext*)getActualDownstreamContext:(JPDefaultHandlerContext*)ctx {
	if (ctx == nil) {
		return nil;
	}
	
	JPDefaultHandlerContext* realCtx = ctx;
	while (![realCtx canHandleDownstream]) {
		realCtx = realCtx.prev;
		if (realCtx == nil) {
			return nil;
		}
	}
	return realCtx;
}

/////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// 
-(void)notifyHandlerException:(NSException*)anException withEvent:(<JPPipelineEvent>)e {
	if ([(id)e conformsToProtocol:@protocol( JPPipelineExceptionEvent )]) { 
		Warn(@"An exception was thrown by a user handler while handling an exception event (%@). %@", anException );
	}

	// New Exception Instance.
	JPPipelineException *newException;

	///////// ////// ////// ////// ////// 
	// If already are one Pipeline Exception, assume it.
	if ([anException isKindOfClass:[JPPipelineException class]]) {
		newException = (JPPipelineException*) anException;
	} 
	
	///////// ////// ////// ////// ////// 
	// If doesn't assume the reason.
	else {
		newException = [JPPipelineException initWithReason:[anException reason]];
	}
	
	///////// ////// ////// ////// ////// 
	// Pass Exception to Sink End Processing.
	@try {
		[[self sink] exceptionCaught:newException 
						withPipeline:self 
						   withEvent:e];
	} 
	
	// If sink can't handle. Throw again.
	@catch (NSException *e1) {
		Warn(@"An exception was thrown by an exception handler. Exception: %@", e1);
		[e1 raise];
	}
	
}


/////////// /////////// /////////// /////////// /////////// /////////// /////////// /////////// /////////// 
#pragma mark -
/////////// /////////// /////////// /////////// /////////// /////////// /////////// /////////// /////////// 
// Adds one listener.
-(void)addListener:(<JPPipelineListener>)listener {
	[notificationCenter addObserver:listener selector:@selector(pipelineActionOcurr:) name:JPPipelineNotify object:self];
}

/////////// /////////// /////////// /////////// /////////// /////////// /////////// /////////// /////////// 
// Removes the specified listener
-(void)removeListener:(<JPPipelineListener>)listener {
	[notificationCenter removeObserver:listener];
}

/////////// /////////// /////////// /////////// /////////// /////////// /////////// /////////// /////////// 
// Notify Some Action.
-(void)notifyListeners:(<JPPipelineListenerNotification>)notification {
	
	// If notification is null, do nothing.
	if ( notification == nil ) 
		return;
	
	// Assign ourselves to this notification.
	[notification setObject:self];
	
	// Post Notification.
	[notificationCenter postNotification:notification];
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Memory Management Methods. 
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
- (void) dealloc {
	[contextObjectsMap release], contextObjectsMap = nil;
	[finalObjects release], finalObjects = nil;
	[(id)sink release], sink = nil;
	[super dealloc];
}

@end
