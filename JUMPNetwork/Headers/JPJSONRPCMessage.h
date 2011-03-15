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
#import <Foundation/Foundation.h>
#import "JPTransporterJSONRPCMessage.h"
#import "JPDefaultHTTPMessage.h"

/**
 * \ingroup jsonrpc_group
 * \nosubgrouping 
 * \brief JPJSONRPCMessage is an type of \ref messages_page 
 that encapsulate an <a href="http://en.wikipedia.org/wiki/JSON-RPC">JSON-RPC</a>
 data to be transported.
 JPJSONRPCMessage is an subclass of JPDefaultHTTPMessage and
 implements the JPTransporterJSONRPCMessage protocol, it is designed to transport
 \ref jsonrpc_messages_page on top of the HTTP protocol.
 <p> 
 You can use this class directly, create your own subclass of this event or 
 create your own implementation of the JPTransporterJSONRPCMessage protocol.
 <p>
 An simply code to illustrate how to send an JPTransporterJSONRPCMessage downstream:
 \code
 JPJSONRPCMessage *eventMessage = [JPJSONRPCMessage initWithMethod:@"POST"]
 eventMessage.transportURL = [NSURL URLWithString:@"http://seqoy.org/httpgateway"];
 [eventMessage setMethod:@"someCall" 
           andParameters:[NSArray arrayWithObjects:@"parameter1", @"parameter2", nil]
                   andId:[NSNumber numberWithInt:2]];
 
 [pipeline sendDownstream:[JPPipelineMessageEvent initWithMessage:eventMessage]];
 \endcode
 Of course this example require a big boilerplate for a simple operation. See \ref factories_page for more information to 
 how configure and automate boilerplates using <a href="http://en.wikipedia.org/wiki/Factory_method_pattern">Factory Patterns</a>.
 <br>
 <br>
 */
@interface JPJSONRPCMessage : JPDefaultHTTPMessage <JPTransporterJSONRPCMessage> {
	NSString  *method;
	NSArray   *parameters;
	NSNumber  *rpcID;
}
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark Properties.
/// JSON-RPC Method. 
@property(copy) NSString  *method;

/// JSON-RPC parameters. 
@property(copy) NSArray   *parameters;

/// JSON-RPC id.
@property(copy) NSNumber  *rpcID;


//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Methods. 
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 

/**
 * Configure the data of this event.
 * @param anMethod An RPC method.
 * @param params An array with parameters.
 * @param anID ID of this RPC call.
 */
-(void)setMethod:(NSString*)anMethod andParameters:(NSArray*)params andId:(NSNumber*)anID;
@end
