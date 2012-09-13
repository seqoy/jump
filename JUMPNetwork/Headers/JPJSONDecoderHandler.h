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
 * \ingroup json_group
 * \nosubgrouping 

 An simple JSON Decoder Handler.
 
 JPJSONDecoderHandler intercepts any <b>upstream</b> \ref messages_page and try to decode as a <b>JSON Object</b>.
 <p>
 If JPJSONDecoderHandler can't decode to JSON Object will send an JPDefaultPipelineExceptionEvent upstream as a warning error, you can catch this
 exception and process it as an decode error. Refer to #JPJSONDecoderErrors to known the proper <b>error code</b>.
 <p>
 You also can ignore this exception and let the next handler (if exist) continue the processing, because the unmodified
 \ref messages_page are sent upstream to the next handler even when an error ocurrs. This is useful if you have an 
 \link the_pipeline pipeline\endlink that decode differents types of \ref messages_page (<i>e.g. XML and JSON</i>) at the same time.
 <p>
 Here an example that how you assign the JPJSONDecoderHandler to the pipeline:
 \code
 [pipeline addLast:@"JSONDecoder" withHandler:[JPJSONDecoderHandler initWithJSONDecoderClass:[JSONEncoder class]]];
 \endcode
 The JPJSONDecoderHandler doesn't have an embedded JSON Decoder. You have to inform one JSON Processer Class that conform with
 the JPDataProcessserJSON protocol. See the <b>JUMP Data Module</b> to find an default implementation of this protocol that you can use
 or you can implement your own.
 
 */
@interface JPJSONDecoderHandler : JPSimplePipelineUpstreamHandler {
	Class<JPDataProcessserJSON> JSONProcesser;
}

/*! Default JSON Decoder Errors. You can use this errors codes when you are retrieving some exception from the pipeline.
 Look for the <tt>'JPJSONDecoderHandler'</tt> domain an some of this errors constants. */
typedef enum {
	/*! Can't decode the Response String as JSON Object. Probably isn't an JSON String or is invalid. */
    kJSONCantDecode,  
	/*! Invalid JSON data. Is an correct JSON String, but invalid RPC format. */
    kJSONRPCInvalid
} JPJSONDecoderErrors;

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

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Process Methods. 
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
/** @name Process Methods
 */
///@{

/*
 * When a JSON data is succesfully decoded this method will be called with the data. 
 * You can override this method on a subclass to do some custom processing. 
 * Make sure to call <tt>super</tt> if you want to preserve the original functionality.
 */
-(void)jsonDataDecoded:(id)JSONDecoded withEvent:(id<JPPipelineMessageEvent>)event andContext:(id<JPPipelineHandlerContext>)ctx;

///@}
@end
