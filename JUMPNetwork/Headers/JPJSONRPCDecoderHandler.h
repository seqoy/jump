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
#import "JPSimplePipelineUpstreamHandler.h"
#import "JPPipelineException.h"
#import "JPDefaultPipelineExceptionEvent.h"
#import "JPPipelineUpstreamMessageEvent.h"
#import "JPDataProcessserJSON.h"
#import "JPLogger.h"


/**
 * \ingroup jsonrpc_group
 * \nosubgrouping 

 An simple JSON-RPC Decoder Handler.
 
 JPJSONRPCDecoderHandler intercepts any <b>upstream</b> \ref messages_page and try to decode as a <b>JSON Object</b> first,
 and then to interpret the JSON-RPC properties.
 <p>
 If JPJSONRPCDecoderHandler can't decode to JSON Object or can't found the RPC properties 
 will send an JPDefaultPipelineExceptionEvent upstream as a warning error, you can catch this
 exception and process it as an decode error. Refer to #JPJSONRPCDecoderErrors to known the proper <b>error code</b>.
 <p>
 You also can ignore this exception and let the next handler (if exist) continue the processing, because the unmodified
 \ref messages_page are sent upstream to the next handler even when an error ocurrs. This is useful if you have an 
 \link the_pipeline pipeline\endlink that decode differents types of \ref messages_page (<i>e.g. XML and JSON</i>) at the same time.
 <p>
 Here an example that how you assign the JPJSONRPCDecoderHandler to the pipeline:
 \code
 [pipeline addLast:@"JSONRPCDecoder" withHandler:[JPJSONRPCDecoderHandler initWithJSONDecoderClass:[JSONEncoder class]]];
 \endcode
 The JPJSONRPCDecoderHandler doesn't have an embedded JSON Decoder. You have to inform one JSON Processer Class that conform with
 the JPDataProcessserJSON protocol. See the <b>JUMP Data Module</b> to find an default implementation of this protocol that you can use
 or you can implement your own.
 
 */
@interface JPJSONRPCDecoderHandler : JPSimplePipelineUpstreamHandler {
	Class<JPDataProcessserJSON> JSONProcesser;
}

/*! Default JSON-RPC Decoder Errors. You can use this errors codes when you are retrieving some exception from the pipeline.
 Look for the <tt>'JPJSONRPCDecoderHandler'</tt> domain an some of this errors constants. */
typedef enum {
	/*! Can't decode the Response String as JSON Object. Probably isn't an JSON String or is invalid. */
    kJSONRPCCantDecode,  
	/*! Invalid JSON-RPC data. Is an correct JSON String, but invalid RPC format. */
    kJSONRPCInvalid	 
} JPJSONRPCDecoderErrors;

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Init Methods. 
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
/** @name Init Methods
 */
///@{
/**
 * Init the JSON Decoder Handler.
 * @param anJSONProcesserClass A <tt>Class</tt> of an custom JSON Processer that conforms with the JPDataProcessserJSON protocol.
 */
+(id)initWithJSONDecoderClass:(Class<JPDataProcessserJSON>)anJSONProcesserClass;

-(id)initWithJSONDecoderClass:(Class<JPDataProcessserJSON>)anJSONProcesserClass;

///@}
@end
