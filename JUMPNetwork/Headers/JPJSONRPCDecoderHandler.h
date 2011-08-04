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
#import "JPPipelineException.h"
#import "JPDefaultPipelineExceptionEvent.h"
#import "JPDataProcessserJSON.h"
#import "JPJSONDecoderHandler.h"
#import "JPJSONRPCModel.h"

#import "JPLogger.h"

/**
 * Keys <tt>NSError.userInfo</tt>, for more data about JSON-RPC Errors decoded.<br>
 * See <a href="http://json-rpc.org/wd/JSON-RPC-1-1-WD-20060807.html#ErrorObject">JSON-RPC 1.1 Error Object</a> definitions.<br>
 * Also see <a href="http://groups.google.com/group/json-rpc/web/json-rpc-2-0">JSON-RPC 2.0 Error Object</a> definitions.
 */
FOUNDATION_EXPORT NSString *const JPJSONRPCErrorName;       // Compliant with JSON-RPC 1.1
FOUNDATION_EXPORT NSString *const JPJSONRPCErrorMoreInfo;   // Compliant with JSON-RPC 1.1
FOUNDATION_EXPORT NSString *const JPJSONRPCErrorData;       // Compliant with JSON-RPC 2.0

/**
 * \ingroup jsonrpc_group
 * \nosubgrouping 

 An simple JSON-RPC Decoder Handler.
 
 JPJSONRPCDecoderHandler intercepts any <b>upstream</b> \ref messages_page and try to decode as a <b>JSON Object</b> first,
 and then to interpret the JSON-RPC properties.
 <p>
 If JPJSONRPCDecoderHandler can't decode to JSON Object or can't found the RPC properties 
 will send an JPDefaultPipelineExceptionEvent upstream as a warning error, you can catch this
 exception and process it as an decode error. Refer to #JPJSONDecoderErrors to known the proper <b>error code</b>.
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
@interface JPJSONRPCDecoderHandler : JPJSONDecoderHandler {}
@end
