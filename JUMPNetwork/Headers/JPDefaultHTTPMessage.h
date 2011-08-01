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
#import "JPTransporterHTTPMessage.h"
#import "JPPipelineDowstreamMessageEvent.h"
#import "JPPipelineFuture.h"
#import "JPPipelineEvent.h"

/**
 * \ingroup transporter_group
 * \nosubgrouping 
 * \brief JPDefaultHTTPMessage is an type of \ref messages_page that encapsulate the HTTP data to be transported.
 JPDefaultHTTPMessage is an implementaton of the JPTransporterHTTPMessage protocol.
 It is an type of \ref messages_page that encapsulate the HTTP data to 
 be transported by the JPHTTPTransporter \link transporter_page I|O implementation\endlink.
 You can use this class directly, create your own subclass of this event or 
 create your own implementation of the JPTransporterHTTPMessage protocol.
 <p>
 An simply code to illustrate how to send an JPDefaultHTTPMessage downstream:
 \code
 JPDefaultHTTPMessage *eventMessage = [JPDefaultHTTPMessage initWithData:dataToTransport withMethod:@"POST"]
 eventMessage.transportURL = [NSURL URLWithString:@"http://seqoy.org/httpgateway"];
 
 [pipeline sendDownstream:[JPPipelineMessageEvent initWithMessage:eventMessage]];
 \endcode
 Of course this example require a big boilerplate for a simple operation. See \ref factories_page for more information to 
 how configure and automate boilerplates using <a href="http://en.wikipedia.org/wiki/Factory_method_pattern">Factory Patterns</a>.

 <h2>Additional resources worth reading</h2>
 
 See \ref jsonrpc_messages_page to learn about \ref messages_page that use HTTP components as basis.  
 
 <br>
 <br>
 */
@interface JPDefaultHTTPMessage : NSObject <JPTransporterHTTPMessage, JPPipelineEvent> {
	NSData *dataToSend;
	NSString *userAgent;
	NSString *requestMethod;
	NSURL *transportURL;
	
	// Settings.
	NSTimeInterval timeOutSeconds;
	NSString* contentType;
    
    // Future.
    id<JPPipelineFuture> future;
}
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark Properties.
/**
 * Some Future Action associated with this event.
 */
@property (retain) id<JPPipelineFuture> future;

/**
 * Data that this event transport.
 */
@property (retain) NSData *dataToSend;

/**
 * HTTP User-Agent of this message.
 */
@property (copy)   NSString *userAgent;

/**
 * HTTP Method of this message.
 * Default value is <b>"POST"</b>.
 */
@property (copy)   NSString *requestMethod;

/**
 * HTTP URL to process this message.
 */
@property (copy)   NSURL *transportURL;

/**
 * HTML Content-Type of this message.
 * Default value is <b>"text/plain"</b>.
 */
@property (copy)     NSString* contentType;

/// 
/**
 * Seconds before timeout this HTTP event.
 * Default value is <b>300 seconds (5 minutes)</b>.
 */
@property (assign)   NSTimeInterval timeOutSeconds;

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Init Methods. 
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
/** @name Init Methods
 */
///@{ 

/**
 * Init this event with specified Method.
 * @param anMethod HTTP Method of this message.
 */
+(id)initWithMethod:(NSString*)anMethod;

/**
 * Init this event with specified data.
 * @param anData Data that this event transport.
 */
+(id)initWithData:(NSData*)anData;

/**
 * Init this event with specified data and an HTTP Method.
 * @param anData Data that this event transport.
 * @param anMethod HTTP Method of this message.
 */
+(id)initWithData:(NSData*)anData withMethod:(NSString*)anMethod;

-(id)initWithData:(NSData*)anData withMethod:(NSString*)anMethod;

///@}
@end