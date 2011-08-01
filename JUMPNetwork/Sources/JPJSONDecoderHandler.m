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
#import "JPJSONDecoderHandler.h"

/// /// /// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ///
@implementation JPJSONDecoderHandler


//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Init Methods. 
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
+(id)initWithJSONDecoderClass:(Class)anJSONProcesserClass {
	return [[[self alloc] initWithJSONDecoderClass:anJSONProcesserClass] autorelease];
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
-(id)initWithJSONDecoderClass:(Class)anJSONProcesserClass {
	// Assert that responds to Protocol (interface).
	if (! [(id)anJSONProcesserClass conformsToProtocol:@protocol(JPDataProcessserJSON)] )
		[NSException raise:NSInvalidArgumentException
					format:@"Processer Class must conform to JPDataProcessserJSON protocol."];

	//// //// //// //// //// / //// //// //// //// //// / //// //// //// //// //// / //// //// //// //// //// /
	if (self != nil) {
		JSONProcesser = anJSONProcesserClass;
	}
	return self;
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// ///
- (id) init {
	[NSException raise:NSInternalInconsistencyException
				format:@"You should use the 'initWithJSONDecoderClass:' method to init."];
	return nil;
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Process Methods. 
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
// When a JSON data is succesfully decoded this method will be called with the data. 
// You can override this method on a subclass to do some custom processing.
-(void)jsonDataDecoded:(NSDictionary*)result withEvent:(<JPPipelineMessageEvent>)event andContext:(<JPPipelineHandlerContext>)ctx {
	
	///////// /////// /////// /////// /////// /////// /////// /////// /////// 
	// Set decoded Message on the event.
	[event setMessage:result];
	
	// Send upstream.
	[ctx sendUpstream:event];
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Methods. 
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
// Invoked when a message object was received.
-(void)messageReceived:(<JPPipelineHandlerContext>)ctx withMessageEvent:(<JPPipelineMessageEvent>)event {

	// Response String.
	NSString *stringResponse = [event getMessage];
	
	// Convert JSON String.
	NSDictionary *JSONDecoded = [JSONProcesser convertFromJSON:stringResponse];
	
	// ////// ////// ////// ////// ////// ////// 
	// If can't decode.
	if ( JSONDecoded == nil ) {
		NSString *errorReason = [NSString stringWithFormat:@"Can't decode the Response String as JSON Object.\nProbably isn't an JSON String or is invalid."];
		Warn( @"JPJSONDecoderHandler :: %@. The response is: %@", errorReason, stringResponse );
        
        ///////// /////// /////// /////// /////// /////// /////// /////// /////// ///////// /////// /////// /////// /////// /////// /////// /////// /////// 
        // Create the error.
        NSError *anError = [NSError errorWithDomain:NSStringFromClass([self class])
                                               code:kJSONCantDecode 
                                           userInfo:[NSDictionary dictionaryWithObject:errorReason forKey:NSLocalizedDescriptionKey]];
        
        // Fail the future.
        [[event getFuture] setFailure:anError];
		
		///////// /////// /////// /////// /////// /////// /////// /////// /////// 
		// Send Error Upstream.
		[ctx sendUpstream:[JPDefaultPipelineExceptionEvent initWithCause:[JPPipelineException initWithReason:errorReason]
																andError:anError]
		 ];
		
		///////// ///////// ///////// ///////// ///////// ///////// /// ///////// ///////// 
		// Send the Message Upstream too, maybe somebody knows what to do with that.
		[ctx sendUpstream:event];
		return;
	}
	
	/////////////////////////////////////////////////
	// Log JSON String.
	Info( @"Received JSON :: %@", [JSONProcesser convertToJSON:[JSONDecoded mutableCopy] humanReadable:YES] );
	
	// Finish to process Ok.
	[self jsonDataDecoded:JSONDecoded withEvent:event andContext:ctx];
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Memory Management Methods.
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
- (void) dealloc {
	[super dealloc];
}

@end
