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
#import "JPFeedPipelineHandler.h"
#import "JPXMLParserXPath.h"

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
@implementation JPFeedPipelineHandler


//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Private Methods. 
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
-(BOOL)isAtomFeed:(NSDictionary*)data {
	BOOL isAtom;
	
	// Does it have an 'feed' element?
	isAtom = (nil != [data objectOnPath:@"feed"]);
	// Does it have an 'feed/xmlns' element?
	isAtom = (nil != [data objectOnPath:@"feed/xmlns"]);
	// Return test result.
	return isAtom;
}

-(BOOL)isRSSFeed:(NSDictionary*)data version:(NSString*)anVersion {
	BOOL isRSS = NO;
	
	// Does it have an RSS element?
	isRSS = (nil != [data objectOnPath:@"rss"]);
	
	// Does it? Let's check the version.
	if ( isRSS ) {
		NSString* version = [data objectOnPath:@"rss/version"];
		isRSS = (version != nil && [version isEqualToString:anVersion] );
	}
	
	// Return test result.
	return isRSS;
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Methods. 
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
// Invoked when a message object was received.
-(void)messageReceived:(id<JPPipelineHandlerContext>)ctx withMessageEvent:(id<JPPipelineMessageEvent>)event {
	
	// Make sure we can handle the message.
	if ([[event getMessage] isKindOfClass:[NSDictionary class]]) {

		// Data.
		NSDictionary *data = [event getMessage];
		
		//// //// //// //// //// //// //// /// //// //// //// //// //// / //// //// //// //// //// //// / /
		// We'll check what kind of feed we're talking about: RSS 2.0 or Atom feed..
		BOOL isAtom			= [self isAtomFeed:data];
		BOOL isRSSFeed		= [self isRSSFeed:data version:@"2.0"];
		NSString *decoding  = ( isRSSFeed ? @"RSS 2.0" : @"Atom" );
		
		/// //// //// //// //// //// / /
		// Somebody that we known?
		if ( isAtom || isRSSFeed ) {
			
			/// //// //// //// //// //// / //// //// //// / //// //// //// / //// //// //// / //// //// //// / //// //// //// / //// //// //// / //// //// //// / //// //// //// 
			// Try to process.
			@try {
				Debug( @"%@ :: %@ feed handled. Will start to parse...", NSStringFromClass([self class]), decoding );
				
				// Feed processer class.
				Class feedProcesser = ( isAtom ? [JPAtomFeedModel class] : [JPRSSFeedModel class] );
				
				// Process.
				id processed = [feedProcesser initWithDictionary:data];
				Debug( @"%@ :: %@ feed parsed Ok. Sending upstream...", NSStringFromClass([self class]), decoding );
				
				// Load Feed Data into Event as Message.
				[event setMessage:processed];
			}
			
			/// //// //// //// //// //// / //// //// //// / //// //// //// / //// //// //// / //// //// //// / //// //// //// / //// //// //// / //// //// //// / //// //// //// 
			// Some error???
			@catch (NSException *exception) {
				NSString *errorReason = [NSString stringWithFormat:@"Can't decode the %@ Feed. Reason: %@.", decoding, exception.reason];
				Error( @"%@ :: %@", NSStringFromClass([self class]), errorReason );
				
				///////// /////// /////// /////// /////// /////// /////// /////// /////// 
				// Send Error Upstream.
				[ctx sendUpstream:[JPDefaultPipelineExceptionEvent initWithCause:[JPPipelineException initWithReason:errorReason]
																		andError:[NSError errorWithDomain:@"JPFeedPipelineHandler"
																									 code:0
																								 userInfo:[NSDictionary dictionaryWithObjectsAndKeys:errorReason, NSLocalizedDescriptionKey, nil]
																				  ]
								   ]
				 ];
				// Will send the original envent upstream too...
			}
		}
		
		 //// //// //// //// //// //// //// //// ////  //// //// //// //// //// //// //// //// ////  //// //// //// //// //// //// //// //// //// 
		// If we can't identify. We just send the event upstream.
		else {
			Warn( @"%@ :: Doesn't found an RSS 2.0 or Atom feed. Just sending event upstream...", NSStringFromClass([self class]) );
		}
	}
	
	///// //// //// //// //// //// //// //// //// //// //// //// 
	// After processing the message, follow the chain.
	[ctx sendUpstream:event];
}

@end
