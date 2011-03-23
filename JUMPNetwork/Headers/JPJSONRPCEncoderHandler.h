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
#import "JPSimplePipelineDownstreamHandler.h"
#import "JPTransporterJSONRPCMessage.h"
#import "JPDataProcessserJSON.h"
#import "JPDataProcessserJSON.h"
#import "JPLogger.h"

/**
 * \ingroup jsonrpc_group
 * \nosubgrouping 

 An simple JSON-RPC Encoder Handler.
 
 JPJSONRPCEncoderHandler intercepts <b>downstream</b> JPJSONRPCMessage and encode his RPC properties, 
 fisrt on a JSON String and later on <b>NSData</b> to be sent by a \ref transporter_page.
 Other types of messages are ignored and sented downstream to the next handler on the \ref the_pipeline.
 <p>
 Here an example that how you assign the JPJSONRPCEncoderHandler to the pipeline:
 \code
 [pipeline addLast:@"JSONRPCEncoder" withHandler:[JPJSONRPCEncoderHandler initWithJSONEncoderClass:[JSONEncoder class]]];
 \endcode
 The JPJSONRPCEncoderHandler doesn't have an embedded JSON Encoder. You have to inform one JSON Processer Class that conform with
 the JPDataProcessserJSON protocol. See the <b>JUMP Data Module</b> to find an default implementation of this protocol that you can use
 or you can implement your own.
 */
@interface JPJSONRPCEncoderHandler : JPSimplePipelineDownstreamHandler {
	Class<JPDataProcessserJSON> JSONProcesser;
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Init Methods. 
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
/** @name Init Methods
 */
///@{

/**
 * Init the JSON Encoder Handler.
 * @param anJSONProcesserClass A <tt>Class</tt> of an custom JSON Processer that conforms with the JPDataProcessserJSON protocol.
 */
+(id)initWithJSONEncoderClass:(Class<JPDataProcessserJSON>)anJSONProcesserClass;

-(id)initWithJSONEncoderClass:(Class<JPDataProcessserJSON>)anJSONProcesserClass;

///@}
@end

