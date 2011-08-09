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
#import "JPDataProcessserXML.h"
#import "JPLogger.h"


/**
 * Keys in the <tt>NSError.userInfo</tt> for more data about XML Errors when decoding.
 */
FOUNDATION_EXPORT NSString *const JPXMLDecoderParserError;       /// The Parser Error associated, if isn't available or isn't setted return <tt>nil</tt>.

/**
 * \nosubgrouping 

 An simple XML Decoder Handler.
 
 */
@interface JPXMLDecoderHandler : JPSimplePipelineUpstreamHandler {
	Class<JPDataProcessserXML> XMLProcesser;
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Init Methods. 
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
/** @name Init Methods
 */
///@{
/**
 * Init the XML Decoder Handler.
 * @param an <tt>Class</tt> of an custom XML Processer that conforms with the JPDataProcessserXML protocol.
 */
+(id)initWithXMLDecoderClass:(Class<JPDataProcessserXML>)anXMLProcesserClass;

-(id)initWithXMLDecoderClass:(Class<JPDataProcessserXML>)anXMLProcesserClass;

///@}
@end
