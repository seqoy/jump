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

#import "JPHTTPTransporter.h"

@implementation JPHTTPTransporter
@synthesize requester, validatesSecureCertificate, currentProgress, future;

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Init Methods. 
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
+(id)init {
	return [[self alloc] init];
}
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
- (id) init {
	self = [super init];
	if (self != nil) {
		
		// Settings.
		self.validatesSecureCertificate = YES;
	}
	return self;
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Private Methods. 

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
-(void)cancelRequest {
    if ( requester ) {
        [requester cancel];
    }
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
// Handle HTTP Event.
-(void)handleHTTPMessage:(id<JPTransporterHTTPMessage>)e {
    
    // Get the URL.
    NSURL *anURL = [e transportURL];
    
    // URL can't be null.
	if ( anURL == nil ) {
		[NSException raise:@"JPHTTPTransporterException" format:@"Can't build an HTTP Requester, URL is not defined!"];
		return;
	}
    
    //// //// //// //// //// //// //// //// //// //// ////
    // Create NSURLRequester
    NSMutableURLRequest *urlRequester = [[NSMutableURLRequest alloc] initWithURL:anURL];
	
	// Assign HTTP Method.
    [urlRequester setHTTPMethod:[e requestMethod]];
    
	// Time out for connection.
    [urlRequester setTimeoutInterval:[e timeOutSeconds]];

	// Add Data to HTTP Request.
    [urlRequester setValue:[e userAgent] forKey:@"User-Agent"];
    [urlRequester setValue:[e contentType] forKey:@"Content-Type"];
    
	// Has data to send?
	if ( e.dataToSend != nil )
        [urlRequester setHTTPBody:[e dataToSend]];
    
    // Log.
    Debug(@"Requesting HTTP Call : [Method: %@, URL: %@]", e.requestMethod, [[e transportURL] absoluteString] );

    

    //// //// //// //// //// //// //// //// //// //// ////
	// Init AF Networking HTTP requester.
	self.requester = [[AFHTTPRequestOperation alloc] initWithRequest:urlRequester];

    //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// /// //// //// ////
	// Validate Secure Certificate?
//	requester.validatesSecureCertificate = self.validatesSecureCertificate;

    [self.requester setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {

        [self requestFinished:operation];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    
        [self requestFailed:operation];
        
    }];
    
	// Start to Load.
	[[NSOperationQueue mainQueue] addOperation:self.requester];
    
    [self cancelRequest];
    
    // Warn the started.
    //[self requestStarted:self.requester];
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Methods. 

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// ////
// Invoked by Pipeline when a downstream Event has reached its terminal (the head of the pipeline).
-(void)eventSunk:(JPPipeline*)anPipeline withEvent:(id<JPPipelineMessageEvent>)event {
	
	// Store the pipeline.
	pipeline = anPipeline;

	///////// /////// /////// /////// /////// /////// /////// /////// 
	// Handle An Cancel Event.
	if ( [(id)event isKindOfClass:[JPDefaultCancelEvent class]] ) {
		
		// Log.
		Info(@"Cancel Event Handled. Cancelling...");
		
		// Cancel.
        [self cancelRequest];
		
		// No more process pal.
		return;
	}
	
	///////// /////// /////// /////// /////// /////// /////// /////// 
	// Handle HTTP Message.
	if ([[event getMessage] conformsToProtocol:@protocol( JPTransporterHTTPMessage )]) {
		
		// Cast the Message.
		id<JPTransporterHTTPMessage> anMessage = (id<JPTransporterHTTPMessage>)[event getMessage];
		
		// Log.
		Info(@"HTTP Event Handled. Processing...");

		// Handle as HTTP.
		[self handleHTTPMessage:anMessage];
	}
	
    ///////// /////// /////// /////// /////// /////// /////// /////// 
	// If can't handle, warning.
    else 
		Warn( @"[%@] . Message received but can't be handled: %@", NSStringFromClass([self class]), event);
	
	///////// /////// /////// /////// /////// /////// /////// /////// 
	// This event has some future?
	if ( [event getFuture] ) {

		// If some future is defined.
        if ( future ) future = nil;
        
		// Add as Future Object.
        future = (id)[event getFuture];
	}
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
// Invoked by Pipeline when an exception was raised while one of its Handlers process a Event.
-(void)exceptionCaught:(JPPipelineException*)anException withPipeline:(JPPipeline*)pipeline withEvent:(id<JPPipelineEvent>)e {
	// Raise the exception.
	[anException raise];
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark ASIProgressDelegate Methods. 

- (void)setProgress:(float)newProgress {
    // Set self progress.
    self.currentProgress = [NSNumber numberWithFloat:newProgress * 100.0];
    
    // Send overal progress to future.
    if (future)
        [future setProgress:[pipeline progress]];
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark ASIHTTPRequest Methods. 

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// /
- (void)requestStarted:(AFHTTPRequestOperation *)request {
    [future setStarted];
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// /
- (void)requestFinished:(AFHTTPRequestOperation *)request {
	
    // Create Upstream Message.
    JPPipelineUpstreamMessageEvent *message = [JPPipelineUpstreamMessageEvent initWithMessage:[request responseString]];
    
    // Future is finished.
    [future setSuccess];

    // Attach the future to go opposite direction.
    message.future = future;
    
	// Send Request Returned Data Upstream.
	[pipeline sendUpstream:message];
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// /
- (void)requestCancelled:(AFHTTPRequestOperation *)request {
    
    // Release after cancel.
    self.requester = nil;

	///////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// 
	// Cancelled.
	[future cancel];
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// /
- (void)requestFailed:(AFHTTPRequestOperation *)request {
	
	// Failed Error Reason.
	NSError *error = [request error];

	// Log.
	Info(@"HTTP Request Failed (%@)! Sending Error Upstream...", [error localizedDescription] );
	
	// If error is because the request was cancelled. 
//	if ( [error.domain isEqual:NetworkRequestErrorDomain] && error.code == ASIRequestCancelledErrorType ) {
//		[self requestCancelled:request];
//		return;
//	}
    
    // /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// // /////// /////// /////// /////// /////// 
    // Fail the future.
    [future setFailure:error];
	
    // /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// // /////// /////// /////// /////// /////// 
    // Create Exception.
    JPDefaultPipelineExceptionEvent* failedEvent = [JPDefaultPipelineExceptionEvent initWithCause:[JPPipelineException initWithReason:[error localizedDescription]]																
                                                                            andError:error];
    
	///////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// 
	// Send Request Error Data Upstream.
	[pipeline sendUpstream:failedEvent];
}

@end
