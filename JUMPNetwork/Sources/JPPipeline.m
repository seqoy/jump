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
@synthesize sink, progress;

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Private Methods. 
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
-(void)checkDuplicateName:(NSString*)name {
	if ( contextObjectsMap[name] ) {
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
	return contextObjectsMap[name];
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
// Get Context By Handler.
-(JPDefaultHandlerContext*)getContextByHandler:(id<JPPipelineHandler>)handler {
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
-(JPDefaultHandlerContext*)getContextByHandlerOrDie:(id<JPPipelineHandler>)handler {
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
        head = nil;
        tail = nil;
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
-(id<JPPipelineHandler>)replaceByContext:(JPDefaultHandlerContext*)ctx withName:(NSString*)newName andHandler:(id<JPPipelineHandler>)newHandler {
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
			contextObjectsMap[newName] = newCtx;
		}
	}
	
	return [ctx handler];
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Init Methods. 
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
- (id) init {
	self = [super init];
	if (self != nil) {
		// Init.
		contextObjectsMap = [[NSMutableDictionary alloc] init];
	}
	return self;
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
+(id)init {
	return [[self alloc] init];
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
-(JPDefaultHandlerContext*)buildContextMapWithName:(NSString*)anName andHandler:(id<JPPipelineHandler>)anHandler  {
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
	contextObjectsMap[anName] = ctx;
    
    return ctx;
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Progress Methods.
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
-(NSNumber*)progress {
    
    // Retrieve the Array with All Contexts.
    NSArray* allContexts = [contextObjectsMap allValues];
    
    // Total Progress will be calculated here.
    float calcProgress = 0.0;
    
    // Loop processing...
    for (int i=0; i < [sectionedProgress count]; i++) {
        // Sectioned Percent.
        float sectionedPercent = [sectionedProgress[i] floatValue];
        
        // First element is the Sink Object. 
        if ( i==0 )
            calcProgress += sectionedPercent * ( [[sink currentProgress] floatValue] / 100 );
        
        // The rest is Contexts.
        else {
            JPDefaultHandlerContext *context = allContexts[i-1];     // Index of Contexts is minus one, we're skipping the Sink.
            calcProgress += sectionedPercent * ( [[context progress] floatValue] / 100 );
        }
    }
    
    // Return.
    return @(calcProgress);
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
-(void)calculateSectionedProgress {
    if ( !sectionedProgress ) sectionedProgress = [NSMutableArray new];
    [sectionedProgress removeAllObjects];

    // Array with All Contexts.
    NSArray* allContexts = [contextObjectsMap allValues];

    // Control numbers.
    float   maxPuntuaction              = 10;                           // Max puntuaction - Should be 0-10.
    int     numberOfSections            = [allContexts count] + 1;      // How many sections we have (contexts) + one Sink.
    float   planePercentage             = 100.0 / numberOfSections;     // Plane Percentage.
    float   totalNormalizedPuntuaction  = 0.0;                          
    float   normalizedPontuaction[numberOfSections];
    
    // The math algorithm behind Sectioned Progress involves:

    //// //// //// //// //// //// //// //// //// 
    //
    //  A) Normalize the points (0-10) to a Plane Percentage manner (Product of 100 / <numberOfSections>).
    //     If we have 4 elements we will have a base of 25. So we'll normalize 10 to 25, 5 to 12.5 and so on.
    //     We're using the current formula:
    //              = <planePercentage> / <maxPuntuaction> * Progress Priority
    //
    for (int i=0; i < numberOfSections; i++) {
        
        // Priority value.
        NSInteger priority;
        
        // First object is the Sink.
        if (i==0) {
            priority = 5;       // TODO: Get sink priority.
        }
        
        // Contexts..
        else {
            // Cast context...
            JPDefaultHandlerContext *ctx = allContexts[i-1];     // Index of Contexts is minus one, we're skipping the Sink.
            // Priority.
            priority = ctx.progressPriority;
        }

        // Calc...
        normalizedPontuaction[i]= planePercentage / maxPuntuaction * priority;
        totalNormalizedPuntuaction+= normalizedPontuaction[i];
    }
    //// //// //// //// //// //// //// //// //// 
    //
    //  B) The normalization never will finish fill the 100% of our progress percentage.
    //     What we do in this case is distribute the rest based on his importance (priority), not equally.
    //     We're using the current formula to guess what we should increment to reach 100%:
    //        a = ( 100 - <totalNormalizedPuntuaction> ) * <normalizedValue> / <totalNormalizedPuntuaction>
    //
    //        And finally apply no the normalized values.
    //        b = a + <normalizedValue>;
    //
    for (int i=0; i < numberOfSections; i++) {    
        // Calc..
        float sectionValue = normalizedPontuaction[i] + ( (100 - totalNormalizedPuntuaction ) * normalizedPontuaction[i] / totalNormalizedPuntuaction );
        // Store..
        [sectionedProgress addObject:@(sectionValue)];
    }
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Methods. 

/////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// 
-(void)notifyHandlerException:(NSException*)anException withEvent:(id<JPPipelineEvent>)e {
	if ([(id)e conformsToProtocol:@protocol( JPPipelineExceptionEvent )]) { 
		Warn(@"An exception was thrown by a user handler while handling an exception event (%@).", anException );
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

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
// Inserts a Handler at the first position of this pipeline.
-(void)addFirst:(NSString*)name withHandler:(id<JPPipelineHandler>)handler {
    [self addFirst:name withHandler:handler withProgressPriority:handler.progressPriority];
}

/////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// 
-(void)addFirst:(NSString*)name withHandler:(id<JPPipelineHandler>)handler withProgressPriority:(NSInteger)priority {
	if ( [contextObjectsMap count] == 0 ) {
		JPDefaultHandlerContext *ctx = [self buildContextMapWithName:name andHandler:handler];
        [ctx setProgressPriority:priority];
        [self calculateSectionedProgress];

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
		contextObjectsMap[name] = newHead;
        
        // Set the priority.
        [newHead setProgressPriority:priority];
        
        // Calc Sectioned Progress.
        [self calculateSectionedProgress];
	}
}

/////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// 
// Appends a Handler at the last position of this pipeline.
-(void)addLast:(NSString*)name withHandler:(id<JPPipelineHandler>)handler {
    [self addLast:name withHandler:handler withProgressPriority:handler.progressPriority];
}

/////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// 
-(void)addLast:(NSString*)name withHandler:(id<JPPipelineHandler>)handler withProgressPriority:(NSInteger)priority {
	if ( [contextObjectsMap count] == 0 ) {
		JPDefaultHandlerContext *ctx = [self buildContextMapWithName:name andHandler:handler];
        [ctx setProgressPriority:priority];
        [self calculateSectionedProgress];
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
		contextObjectsMap[name] = newTail;
        
        // Set the priority.
        [newTail setProgressPriority:priority];
        
        // Calc Sectioned Progress.
        [self calculateSectionedProgress];

	}
}

/////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// 
// Inserts a Handler before an existing handler of this.
-(void)addBefore:(NSString*)baseName withName:(NSString*)name withHandler:(id<JPPipelineHandler>)handler {
    [self addBefore:baseName withName:name withHandler:handler withProgressPriority:handler.progressPriority];
}

/////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// 
-(void)addBefore:(NSString*)baseName withName:(NSString*)name withHandler:(id<JPPipelineHandler>)handler withProgressPriority:(NSInteger)priority {
	
	// Get Context.
	JPDefaultHandlerContext *ctx = [self getContextByNameOrDie:baseName];
	
	///////// ///////// ///////// ///////// ///////// ///////// ///////// ///////// ///////// 
	// If on the head, insert first.
	if (ctx == head) 
		[self addFirst:baseName withHandler:handler withProgressPriority:priority];
	
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
		contextObjectsMap[name] = newCtx;
        
        // Set the priority.
        [newCtx setProgressPriority:priority];
        
        // Calc Sectioned Progress.
        [self calculateSectionedProgress];

	}
}

/////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// 
// Inserts a Handler after an existing handler of this.
-(void)addAfter:(NSString*)baseName withName:(NSString*)name withHandler:(id<JPPipelineHandler>)handler  {
    [self addAfter:baseName withName:name withHandler:handler withProgressPriority:handler.progressPriority];
}

/////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// 
-(void)addAfter:(NSString*)baseName withName:(NSString*)name withHandler:(id<JPPipelineHandler>)handler withProgressPriority:(NSInteger)priority {
	
	// Get Context.
	JPDefaultHandlerContext *ctx = [self getContextByNameOrDie:baseName];
	
	///////// ///////// ///////// ///////// ///////// ///////// ///////// ///////// ///////// 
	// If on the tail, insert last.
	if (ctx == tail) 
		[self addLast:baseName withHandler:handler withProgressPriority:priority];
	
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
		contextObjectsMap[name] = newCtx;
        
        // Set the priority.
        [newCtx setProgressPriority:priority];
        
        // Calc Sectioned Progress.
        [self calculateSectionedProgress];

	}
}
/////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// 
// Removes the specified {@link ChannelHandler} from this pipeline.
-(void)removeByHandler:(id<JPPipelineHandler>)handler {
	[self removeByContext:[self getContextByHandlerOrDie:handler]];
}

/////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// 
// Removes the {@link ChannelHandler} with the specified name from this pipeline.
-(id<JPPipelineHandler>)removeByName:(NSString*)name {
	return [[self removeByContext:[self getContextByNameOrDie:name]] handler];
}

/////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// 
// Removes the first {@link ChannelHandler} in this pipeline.
-(id<JPPipelineHandler>)removeFirst {
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
-(id<JPPipelineHandler>)removeLast {
	if ([contextObjectsMap count] == 0) {
		[NSException raise:@"NoSuchElementException" format:@"Trying to remove the last element."];
	}
	
	JPDefaultHandlerContext *oldTail = tail;
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
-(void)replaceByHandler:(id<JPPipelineHandler>)oldHandler withName:(NSString*)name andHandler:(id<JPPipelineHandler>)handler {
	[self replaceByContext:[self getContextByHandlerOrDie:oldHandler]
				  withName:name
				andHandler:handler];
}

/////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// 
// Replaces the {@link ChannelHandler} of the specified name with a new handler in this pipeline.
-(id<JPPipelineHandler>)replaceByName:(NSString*)oldName withName:(NSString*)newName andHandler:(id<JPPipelineHandler>)newHandler {
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
-(id<JPPipelineHandler>)first {
	JPDefaultHandlerContext* anHead = head;
	if (anHead == nil) {
		return nil;
	}
	return [anHead handler];
}

/////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// 
// Returns the last {@link ChannelHandler} in this pipeline.
-(id<JPPipelineHandler>)last {
	JPDefaultHandlerContext* anTail = tail;
	if (anTail == nil) {
		return nil;
	}
	return [anTail handler];
}

/////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// 
// Returns the {@link ChannelHandler} with the specified name in this
-(id<JPPipelineHandler>)get:(NSString*)name {
	JPDefaultHandlerContext* ctx = contextObjectsMap[name];
	if (ctx == nil) {
		return nil;
	} else {
		return [ctx handler];
	}
}

/////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// 
// Sends the specified {@link ChannelEvent} to the first {@link ChannelDownstreamHandler} in this pipeline.
-(void)sendUpstream:(id<JPPipelineEvent>)e {
	JPDefaultHandlerContext* anHead = [self getActualUpstreamContext:head];
	if (anHead == nil) {
		Warn( @"The pipeline contains no upstream handlers; discarding: %@", e);
		return;
	}
	[self sendContextUpstream:anHead withEvent:e];
}

/////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// 
-(void)sendContextUpstream:(JPDefaultHandlerContext*)ctx withEvent:(id<JPPipelineEvent>)e {
	@try {
		[(id<JPPipelineUpstreamHandler>)[ctx handler] handleContextUpstream:ctx withEvent:e];
	} 
	
	@catch (NSException *exception) {
		[self notifyHandlerException:exception withEvent:e];
	}
}

/////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// 
// Sends the specified {@link ChannelEvent} to the last {@link ChannelDownstreamHandler} in this pipeline.
-(void)sendDownstream:(id<JPPipelineEvent>)e {
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
-(void)sendContextDownstream:(JPDefaultHandlerContext*)ctx withEvent:(id<JPPipelineEvent>)e {
	@try {
		[(id<JPPipelineDownstreamHandler>)[ctx handler] handleContextDownstream:ctx withEvent:e];
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

@end
