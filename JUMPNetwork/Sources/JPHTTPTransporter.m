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
	return [[[self alloc] init] autorelease];
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
// Init HTTP Requester.
-(void)buildRequesterWithURL:(NSURL*)anURL {
	
	// URL can't be null.
	if ( anURL == nil ) {
		[NSException raise:@"JPHTTPTransporterException" format:@"Can't build an HTTP Requester, URL is not defined!"];
		return;
	}
	
	// If already exist, cancel and release.
	if ( requester ) {
		[requester cancel]; 
		[requester setDelegate:nil];
		[requester release], requester = nil;
	}
	
	//// //// //// //// //// //// //// //// //// //// ////
	// Init HTTP requester.
	self.requester = [ASIHTTPRequest requestWithURL:anURL];
    
    // Receive HTTP call progress.
    [requester setShowAccurateProgress:YES];
    [requester setDownloadProgressDelegate:self];
	
	// Set ourselves as delegate.
	[requester setDelegate:self];
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
// Handle HTTP Event.
-(void)handleHTTPMessage:(<JPTransporterHTTPMessage>)e {
	
	// Assign HTTP Method.
	requester.requestMethod = [e requestMethod];
	
	// Time out for connection.
	requester.timeOutSeconds = [e timeOutSeconds];

	//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// /// //// //// //// 
	// Validate Secure Certificate?
	requester.validatesSecureCertificate = self.validatesSecureCertificate;
	
	// Add Data to HTTP Request.
	[requester addRequestHeader:@"User-Agent" value:[e userAgent]];
	[requester addRequestHeader:@"Content-Type" value:[e contentType]]; 
	
	// Has data to send?
	if ( e.dataToSend != nil )
		[requester appendPostData:[e dataToSend]];
	 
	// Start to Load.
	[requester startAsynchronous];
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Methods. 

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
// Invoked by Pipeline when a downstream Event has reached its terminal (the head of the pipeline).
-(void)eventSunk:(JPPipeline*)anPipeline withEvent:(<JPPipelineMessageEvent>)event {
	
	// Store the pipeline.
	pipeline = anPipeline;

	///////// /////// /////// /////// /////// /////// /////// /////// 
	// Handle An Cancel Event.
	if ( [(id)event isKindOfClass:[JPDefaultCancelEvent class]] ) {
		
		// Log.
		Info(@"Cancel Event Handled. Cancelling...");
		
		// If have one active requester.
		if ( requester && [requester isExecuting] ) {
			[requester cancel]; 
			[requester setDelegate:nil];
			[requester release], requester = nil;
		}
		
		// No more process pal.
		return;
	}
	
	///////// /////// /////// /////// /////// /////// /////// /////// 
	// Handle HTTP Message.
	if ([[event getMessage] conformsToProtocol:@protocol( JPTransporterHTTPMessage )]) {
		
		// Cast the Message.
		id<JPTransporterHTTPMessage> anMessage = (<JPTransporterHTTPMessage>)[event getMessage];
		
		// Log.
		Info(@"HTTP Event Handled. Processing...");

		// Configure Requester.
		[self buildRequesterWithURL:[anMessage transportURL]];
		
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
        if ( future ) [(id)future release];
        
		// Add as Future Object.
        future = [(id)[event getFuture] retain];
	}
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
// Invoked by Pipeline when an exception was raised while one of its Handlers process a Event.
-(void)exceptionCaught:(JPPipelineException*)anException withPipeline:(JPPipeline*)pipeline withEvent:(<JPPipelineEvent>)e {
	// Raise the exception.
	[anException raise];
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark ASIProgressDelegate Methods. 

- (void)setProgress:(float)newProgress {
    self.currentProgress = [NSNumber numberWithFloat:newProgress * 100.0];
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark ASIHTTPRequest Methods. 

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// /
- (void)requestStarted:(ASIHTTPRequest *)request {
    [future setStarted];
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// /
- (void)requestFinished:(ASIHTTPRequest *)request {
	
    // Create Upstream Message.
    JPPipelineUpstreamMessageEvent *message = [JPPipelineUpstreamMessageEvent initWithMessage:[request responseString]];
    
    // Attach the future to go opposite direction.
    message.future = future;
    
	// Send Request Returned Data Upstream.
	[pipeline sendUpstream:message];
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// /
- (void)requestCancelled:(ASIHTTPRequest *)request {

	///////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// 
	// Cancelled.
	[future cancel];
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// /
- (void)requestFailed:(ASIHTTPRequest *)request {
	
	// Failed Error Reason.
	NSError *error = [request error];

	// Log.
	Info(@"HTTP Request Failed (%@)! Sending Error Upstream...", [error localizedDescription] );
	
	// If error is because the request was cancelled. 
	if ( [error.domain isEqual:NetworkRequestErrorDomain] && error.code == ASIRequestCancelledErrorType ) {
		[self requestCancelled:request];
		return;
	}
    
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

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Memory Management Methods. 
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
- (void) dealloc {
	if ( requester ) 
		[requester cancel];
	
	// Clean up requester delegate.
	if ( requester ) 
		[requester setDelegate:nil];
	
	// Release.
	[requester release], requester = nil;
    [currentProgress release], currentProgress = nil;

	[(id)future release], future = nil;
	[super dealloc];
}


@end
