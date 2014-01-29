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
#import "AFHTTPRequestOperation.h"

// Transport Interfaces.
#import "JPTransporterHTTPMessage.h"

// Logger.
#import "JPLogger.h"

// Pipeline.
#import "JPPipelineSink.h"
#import "JPPipelineUpstreamMessageEvent.h"
#import "JPDefaultPipelineExceptionEvent.h"
#import "JPPipelineNotification.h"
#import "JPPipeline.h"
#import "JPDefaultCancelEvent.h"
#import "JPPipelineFuture.h"

/**
 * \ingroup transporter_group
 * \nosubgrouping 
 * \brief An default <b>HTTP</b> implementation of the \ref transporter_page that conforms with the JPPipelineSink protocol.
 
 This default implementation use the <a href="http://es.wikipedia.org/wiki/Hypertext_Transfer_Protocol">HTTP protocol</a> 
 to transport data between an external server and your application, performing basic HTTP requests and interacting
 with REST-based services (GET / POST / PUT / DELETE). 
 <p>
 Internally it uses the wonderful <a href="http://allseeing-i.com/ASIHTTPRequest/">ASIHTTPRequest</a> library. 
 <b>ASIHTTPRequest</b> is builded on top of the <a href="http://developer.apple.com/library/mac/#documentation/Networking/Conceptual/CFNetwork/Introduction/Introduction.html">Apple CFNetwork API</a>
 and works in both Mac OS X and iPhone applications.
 <p>
 Once created your JPPipeline you should attach the transporter.
 \code
 // Create new Pipeline.
 JPPipeline *pipeline = [JPPipeline init];
 
 // HTTP Transporter associated with the pipeline.
 pipeline.sink = [JPHTTPTransporter init];
 \endcode 
 <h2>HTTP Transporter Events Messages</h2>
 @copydetails JPDefaultHTTPMessage

 */
@interface JPHTTPTransporter : NSObject <JPPipelineSink> {
	
	// Pipeline Pointer.
	JPPipeline *pipeline;
	
	// Should Validate Secure Certificate?
	BOOL validatesSecureCertificate;
    
    // Progress.
    NSNumber *currentProgress;
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark Properties.
/// Future being processed.
@property (readonly) id<JPPipelineFuture> future;

/// The HTTP Requester.
@property (retain) AFHTTPRequestOperation *requester;

/// Should validate any Security Certificate.
@property (assign) BOOL validatesSecureCertificate;

/// The current progress of the transporter provider task.
@property (copy) NSNumber *currentProgress;

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Init Methods. 
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
/*
 * Init the transporter class.
 */
+(id)init;

@end
