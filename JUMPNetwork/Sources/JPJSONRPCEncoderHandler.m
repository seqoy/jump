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
#import "JPJSONRPCEncoderHandler.h"

/// /// /// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ///
@implementation JPJSONRPCEncoderHandler

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Init Methods. 
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
+(id)initWithJSONEncoderClass:(Class)anJSONProcesserClass {
	return [[self alloc] initWithJSONEncoderClass:anJSONProcesserClass];
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
-(id)initWithJSONEncoderClass:(Class)anJSONProcesserClass {
	// Assert that responds to Protocol (interface).
	if (! [(id)anJSONProcesserClass conformsToProtocol:@protocol(JPDataProcessserJSON)] )
		[NSException raise:NSInvalidArgumentException
					format:@"Processer Class must conform to JPDataProcessserJSON protocol."];
	
	//// //// //// //// //// / //// //// //// //// //// / //// //// //// //// //// / //// //// //// //// //// /
	if (self != nil) {
		JSONProcesser = anJSONProcesserClass;
        self.progressPriority = 5;
	}
	return self;
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// ///
- (id) init {
	[NSException raise:NSInternalInconsistencyException
				format:@"You should use the 'initWithJSONEncoderClass:' method to init."];
	return nil;
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
// Invoked when some Send data is requested.
-(void)sendRequestedWithContext:(id<JPPipelineHandlerContext>)ctx withMessageEvent:(id<JPPipelineMessageEvent>)event {
	
	///////// /////// /////// /////// /////// /////// /////// /////// 
	// Handle if is an JSON RPC Message.
	if ([[event getMessage] conformsToProtocol:@protocol( JPTransporterJSONRPCMessage )]) {
		
		// Cast Message.
		id<JPTransporterJSONRPCMessage>rpcMessage = (id<JPTransporterJSONRPCMessage>)[event getMessage];
	
		// ////// ////// ////// ////// ////// ////// ////// ////// ///
		// Create Dictionary with RPC Data.
		NSMutableDictionary *rpcData = (NSMutableDictionary*)@{@"method": [rpcMessage method],
												@"id": [rpcMessage rpcID],
												@"params": [rpcMessage parameters]};
		// Encode as JSON String.
		NSString *JSONString = [JSONProcesser convertToJSON:rpcData];
		
		/////////////////////////////////////////////////
		// Log JSON String.
		Info( @"Sending JSON: %@", [JSONProcesser convertToJSON:rpcData humanReadable:YES]);
	
		// Convert JSON String to Binary Data.
		NSData *postData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
		
		// Set the data on the message.
		[rpcMessage setDataToSend:postData];
		
		// Send Event Downstream.
		[ctx sendDownstream:event];
	}
	
	// ////// ////// ////// ////// ////// ////// ////// ////// ///
	// If can't encode. Send Downstream.
	else 
		[ctx sendDownstream:event];
}

@end
