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
#import "JPJSONRPCDecoderHandler.h"

/// /// /// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ///
@implementation JPJSONRPCDecoderHandler


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
		Warn( @"JPJSONRPCDecoderHandler :: %@. The response is: %@", errorReason, stringResponse );
		
		///////// /////// /////// /////// /////// /////// /////// /////// /////// 
		// Send Error Upstream.
		[ctx sendUpstream:[JPDefaultPipelineExceptionEvent initWithCause:[JPPipelineException initWithReason:errorReason]
																andError:[NSError errorWithDomain:NSStringFromClass([self class])
																							 code:kJSONRPCCantDecode 
																						 userInfo:[NSDictionary dictionaryWithObject:errorReason forKey:NSLocalizedDescriptionKey]
																		  ]
						   ]
		 ];
		
		///////// ///////// ///////// ///////// ///////// ///////// /// ///////// ///////// 
		// Send the Message Upstream too, maybe somebody knows what to do with that.
		[ctx sendUpstream:event];
		return;
	}
	
	/////////////////////////////////////////////////
	// Log JSON String.
	Info( @"Received JSON :: %@", [JSONProcesser convertToJSON:[JSONDecoded mutableCopy] humanReadable:YES] );
	
	//////// ////// ////// ////// ////// ////// ////// 
	// Check if result some server Error.
	if( [JSONDecoded objectForKey:@"error"] ) {
		
		// If server error isn't NULL (REAL ERROR), process it.
		if ( [JSONDecoded objectForKey:@"error"] != [NSNull null] ) {
			
			// JSON Error Data.
			NSDictionary *anError = [JSONDecoded objectForKey:@"error"];
			
			// NSError User Info Dictionary.
			NSDictionary *userInfo = [NSDictionary dictionaryWithObject:[anError objectForKey:@"message"] 
																 forKey: NSLocalizedDescriptionKey];

			///////// /////// /////// /////// /////// /////// /////// /////// /////// 
			// Create an NSError.
			NSError *JSONError = [NSError errorWithDomain:@"JPJSONRPCDecoderHandler"
													 code:[[anError objectForKey:@"code"] intValue]
												 userInfo:userInfo];

			//////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// 
			// Log.
			Info( @"JSON Error Handled (%@) | Sending Error Upstream...", [JSONError localizedDescription] );
			
			///////// /////// /////// /////// /////// /////// /////// /////// /////// 
			// Send Error Upstream.
			[ctx sendUpstream:[JPDefaultPipelineExceptionEvent initWithCause:[JPPipelineException initWithReason:[JSONError localizedDescription]]
																	andError:JSONError]];
			
			// Break.
			return;
		}
	}
	
	// ////// ////// ////// ////// ////// //////  ////// 
	// JSON doesn't Contains RPC Results. It is invalid.
	if ( ! [JSONDecoded objectForKey:@"result"] ) {
		NSString *errorReason = @"Invalid JSON-RPC data. JSON Object doesn't contain an 'result' entry.";
		Warn( @"%@", errorReason );

		///////// /////// /////// /////// /////// /////// /////// /////// /////// 
		// Send Error Upstream.
		[ctx sendUpstream:[JPDefaultPipelineExceptionEvent initWithCause:[JPPipelineException initWithReason:errorReason]
																andError:[NSError errorWithDomain:NSStringFromClass([self class])
																							 code:kJSONRPCInvalid 
																						 userInfo:[NSDictionary dictionaryWithObject:errorReason forKey:NSLocalizedDescriptionKey]
																		  ]
						   ]
		 ];
		return;
	}
	
	///////// /////// /////// /////// /////// /////// /////// /////// /////// 
	// Result Key.
	NSDictionary *result = [JSONDecoded objectForKey:@"result"];
	
	
	///////// /////// /////// /////// /////// /////// /////// /////// /////// 
	// Set decoded Message on the event.
	[event setMessage:result];
	
	// Send upstream.
	[ctx sendUpstream:event];
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Memory Management Methods. 
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
- (void) dealloc {
	[super dealloc];
}


@end
