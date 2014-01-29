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

NSString * const JPJSONRPCErrorName     = @"JPJSONRPCErrorName";
NSString * const JPJSONRPCErrorMoreInfo = @"JPJSONRPCErrorMoreInfo";
NSString * const JPJSONRPCErrorData     = @"JPJSONRPCErrorData";

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
-(void)jsonDataDecoded:(id)JSONDecoded withEvent:(id<JPPipelineMessageEvent>)event andContext:(id<JPPipelineHandlerContext>)ctx {

    ///////// /////// /////// /////// /////// /////// /////// /////// /////// 
    // If decoded is NIL. Probably we're handling some error, nothing to do here.
    if ( JSONDecoded == nil ) {
        [super jsonDataDecoded:JSONDecoded withEvent:event andContext:ctx];
        return;
    }
    
    ///////// /////// /////// /////// /////// /////// /////// /////// /////// 
	// Create an JSON-PRC Model Object.
    JPJSONRPCModel *model = [JPJSONRPCModel init];
    
    // If some error, we store here.
    NSError *JSONError;
    
	//////// ////// ////// ////// ////// ////// ////// 
	// Check if result some server Error. 
	if( JSONDecoded[@"error"] ) {
		
		// If server error isn't NULL (REAL ERROR), process it.
		if ( JSONDecoded[@"error"] != [NSNull null] ) {
			
			// JSON Error Data.
			NSDictionary *anError = JSONDecoded[@"error"];
            
            ///////// /////// /////// /////// /////// /////// /////// /////// /////// //// /////// 
            // Grab error Message.
            id errorMessage = anError[@"message"];

            // Error MUST be an String. 
            if ( ![errorMessage isKindOfClass:[NSString class]] ) {
                NSString *errorReason = @"Invalid JSON-RPC. Error 'message' key must be of STRING type.";
                JSONError = [NSError errorWithDomain:@"JPJSONRPCDecoderHandler"
                                                code:kJSONRPCInvalid
                                            userInfo:@{NSLocalizedDescriptionKey: errorReason}];
            }
            
            // /////// /////// /////// /////// /////// /////// /////// //// /////// // /////// /////// /////// /////// /////// /////// ////
            // If error object is valid, process.
            else {
                
                // NSError User Info Dictionary.
                NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithObject:errorMessage
                                                                                   forKey:NSLocalizedDescriptionKey];
                
                ///////// /////// /////// /////// /////// /////// /////// /////// /////// //// /////// 
                // Assign extra JSON-RPC Metadata about this error to the userInfo dictionary.
                
                // Error Name, JSON-RPC 1.1 Compliant.
                if (anError[@"name"]) 
                    userInfo[JPJSONRPCErrorName] = anError[@"name"];    
                
                // Object value that carries custom and application-specific error information. JSON-RPC 1.1 Compliant.
                if (anError[@"error"]) 
                    userInfo[JPJSONRPCErrorMoreInfo] = anError[@"error"];
                
                // A Primitive or Structured value that contains additional information about the error. JSON-RPC 2.0 Compliant.
                if (anError[@"data"]) 
                    userInfo[JPJSONRPCErrorData] = anError[@"data"];
                
                ///////// /////// /////// /////// /////// /////// /////// /////// /////// 
                // Create an NSError.
                JSONError = [NSError errorWithDomain:@"JPJSONRPCDecoderHandler"
                                                code:[anError[@"code"] intValue]
                                            userInfo:userInfo];
            }

			//////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// 
			// Log.
			Info( @"JSON Error Handled (%@) | Sending Error Upstream...", [JSONError localizedDescription] );
			
		}
	}
	
	// ////// ////// ////// ////// ////// //////  ////// 
	// JSON doesn't Contains RPC Results. It is invalid.
	else if ( ! JSONDecoded[@"result"] ) {
		NSString *errorReason = @"Invalid JSON-RPC data. JSON Object doesn't contain an 'result' entry.";
		Warn( @"%@", errorReason );
        
        ///////// /////// /////// /////// /////// /////// /////// /////// /////// 
        // Create an NSError.
        JSONError = [NSError errorWithDomain:NSStringFromClass([self class])
                                        code:kJSONRPCInvalid
                                    userInfo:@{NSLocalizedDescriptionKey: errorReason}];
	}
	
    // ////// ////// ////// ////// ////// //////  ////// 
    // Some error formatted?
    if ( JSONError ) {

        // Fail the future.
        [[event getFuture] setFailure:JSONError];

        // Send Error Upstream.
        [ctx sendUpstream:[JPDefaultPipelineExceptionEvent initWithCause:[JPPipelineException initWithReason:[JSONError localizedDescription]]
                                                                andError:JSONError]];
        
        // We're sending a formatted error trough the pipeline. But also sending the full JSON-RPC Model with error and 
        // other data below, maybe some another handler wants to known what to do with that.
        
    }
        
	///////// /////// /////// /////// /////// /////// /////// /////// /////// 
    // Assign data.
    model.theId   = JSONDecoded[@"id"];
    model.result  = JSONDecoded[@"result"];
    model.error   = JSONDecoded[@"error"];
    model.version = JSONDecoded[@"version"]; 
    
	///////// /////// /////// /////// /////// /////// /////// /////// /////// 
	// Super Processing. (Send upstream).
	[super jsonDataDecoded:model withEvent:event andContext:ctx];
}

@end
