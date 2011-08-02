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
- (id) init {
    self = [super init];
    if (self != nil) {
        self.progressPriority = 5;
    }
    return self;
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Process Methods. 
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
// When a JSON data is succesfully decoded this method will be called with the data. 
// You can override this method on a subclass to do some custom processing.
-(void)jsonDataDecoded:(NSDictionary*)JSONDecoded withEvent:(<JPPipelineMessageEvent>)event andContext:(<JPPipelineHandlerContext>)ctx {

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
            
            // Fail the future.
            [[event getFuture] setFailure:JSONError];
			
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
        // Create an NSError.
        NSError *JSONError = [NSError errorWithDomain:NSStringFromClass([self class])
                                                 code:kJSONRPCInvalid
                                             userInfo:[NSDictionary dictionaryWithObject:errorReason forKey:NSLocalizedDescriptionKey]];
        
        // Fail the future.
        [[event getFuture] setFailure:JSONError];
		
		///////// /////// /////// /////// /////// /////// /////// /////// /////// 
		// Send Error Upstream.
		[ctx sendUpstream:[JPDefaultPipelineExceptionEvent initWithCause:[JPPipelineException initWithReason:errorReason]
																andError:JSONError]
		 ];
        
        // Break.
		return;
	}
	
	///////// /////// /////// /////// /////// /////// /////// /////// /////// 
	// Result Key.
	NSDictionary *result = [JSONDecoded objectForKey:@"result"];
	
	///////// /////// /////// /////// /////// /////// /////// /////// /////// 
	// Super Processing.
	[super jsonDataDecoded:result withEvent:event andContext:ctx];
}

@end
