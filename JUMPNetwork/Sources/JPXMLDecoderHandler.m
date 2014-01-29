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
#import "JPXMLDecoderHandler.h"

NSString * const JPXMLDecoderParserError     = @"parserError";

/// /// /// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ///
@implementation JPXMLDecoderHandler

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Init Methods. 
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
+(id)initWithXMLDecoderClass:(Class)anXMLProcesserClass {
	return [[self alloc] initWithXMLDecoderClass:anXMLProcesserClass];
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
-(id)initWithXMLDecoderClass:(Class)anXMLProcesserClass {
	// Assert that responds to Protocol (interface).
	if (! [(id)anXMLProcesserClass conformsToProtocol:@protocol(JPDataProcessserXML)] )
		[NSException raise:NSInvalidArgumentException
					format:@"Processer Class must conform to JPDataProcessserXML protocol."];

	//// //// //// //// //// / //// //// //// //// //// / //// //// //// //// //// / //// //// //// //// //// /
	if (self != nil) {
		XMLProcesser = anXMLProcesserClass;
        self.progressPriority = 7;
	}
	return self;
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// ///
- (id) init {
	[NSException raise:NSInternalInconsistencyException
				format:@"You should use the 'initWithXMLDecoderClass:' method to init."];
	return nil;
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Methods. 
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
// Invoked when a message object was received.
-(void)messageReceived:(id<JPPipelineHandlerContext>)ctx withMessageEvent:(id<JPPipelineMessageEvent>)event {

	// Response String.
	NSString *stringResponse = [event getMessage];
	
	// Decode here...
	NSDictionary *XMLDecoded;
	
	// ////// ////// ////// ////// ////// //////
	// Convert XML String.
	@try {
		XMLDecoded = [XMLProcesser convertFromXML:stringResponse];
	}

	// ////// ////// ////// ////// ////// //////
	// If some exception...
	@catch ( NSException *e ) {
		
		NSString *errorReason = [NSString stringWithFormat:@"Can't decode the Response String as XML Object.\nProbably isn't an XML String or is invalid.\nParser reason: %@.", e.reason];
		Warn( @"JPXMLDecoderHandler :: %@\nThe XML that fails is: %@", errorReason, stringResponse );
		
		// Retrieve the Parser Error.
		NSError *parserError = [e userInfo][@"parserError"];
        
        // Get the Error Domain and Code from Parser Error if available, if isn't defined will assume default.
        NSString  *errorDomain = ( parserError ? parserError.domain : @"JPXMLDecoderHandler" );
        NSInteger errorCode    = ( parserError ? parserError.code   : -1 );
        
        // Create the User Info.
        NSMutableDictionary *userInfo = [NSMutableDictionary new];
        
        // Assign the Parser Error in it, if available.
        if ( parserError ) {
            userInfo[JPXMLDecoderParserError] = parserError;
        }
        
        // Assign the Error Reason (Description) in it.
        userInfo[NSLocalizedDescriptionKey] = errorReason;
        
        // Create error.
        NSError *decodeError = [NSError errorWithDomain:errorDomain
                                                   code:errorCode
                                               userInfo:userInfo];
        
        // Fail the future.
        [[event getFuture] setFailure:decodeError];
		
		///////// /////// /////// /////// /////// /////// /////// /////// /////// 
		// Send Error Upstream.
		[ctx sendUpstream:[JPDefaultPipelineExceptionEvent initWithCause:[JPPipelineException initWithReason:errorReason]
																andError:decodeError]
		 ];
		
		///////// ///////// ///////// ///////// ///////// ///////// /// ///////// ///////// 
		// Send the Message Upstream too, maybe somebody knows what to do with that.
		[ctx sendUpstream:event];
		return;
	}
	
	/////////////////////////////////////////////////
	// Log XML.
	Debug( @"XML Received and Parsed :: %i bytes", (int)[stringResponse length] );
	
	///////// /////// /////// /////// /////// /////// /////// /////// /////// 
	// Set decoded Message on the event.
	[event setMessage:XMLDecoded];
	
	// Send upstream.
	[ctx sendUpstream:event];
}

@end
