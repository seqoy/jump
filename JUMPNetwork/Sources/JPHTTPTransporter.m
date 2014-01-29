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
@synthesize requester, validatesSecureCertificate, currentProgress;

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark - Init Methods.
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
#pragma mark - Private Methods.

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
    [urlRequester setValue:[e userAgent] forHTTPHeaderField:@"User-Agent"];
    [urlRequester setValue:[e contentType] forHTTPHeaderField:@"Content-Type"];
    
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
    self.requester.securityPolicy.allowInvalidCertificates = !self.validatesSecureCertificate;
 
    //
    //  Avoid capturing self in blocks, more info:
    //      http://stackoverflow.com/questions/7853915/how-do-i-avoid-capturing-self-in-blocks-when-implementing-an-api
    //
    __weak JPHTTPTransporter *weakSelf = self;
    
    //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// /// //// //// ////
    // Completion poiting to correct methods.
    [self.requester
     
         setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            [weakSelf requestFinished:operation];

        }
         
        failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [weakSelf requestFailed:operation];
        }
     
    ];
    
    //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// /// //// //// ////
    // Follow the progress...
    [self.requester
     
         setDownloadProgressBlock:^( NSUInteger bytesRead , long long totalBytesRead , long long totalBytesExpectedToRead ) {
            
            if ( totalBytesExpectedToRead < 0 ) {
                Warn(@"%@", @"Download progress is returning -1. Probably the server does not set the 'Content-Length' HTTP header in the response.");
                totalBytesExpectedToRead = 0;
            }
            
            float progress = (float)totalBytesRead / totalBytesExpectedToRead;
            [weakSelf setProgress:progress];
        
        }
     
    ];
    
    //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// /// //// //// ////
	// Start to Load.
	[[NSOperationQueue mainQueue] addOperation:self.requester];
    
    // Warn that started.
    [self requestStarted:self.requester];
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

		// Add as Future Object.
        _future = (id)[event getFuture];
	}
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
// Invoked by Pipeline when an exception was raised while one of its Handlers process a Event.
-(void)exceptionCaught:(JPPipelineException*)anException withPipeline:(JPPipeline*)pipeline withEvent:(id<JPPipelineEvent>)e {
	// Raise the exception.
	[anException raise];
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark - Progress Methods.

- (void)setProgress:(float)newProgress {
    // Set self progress.
    self.currentProgress = [NSNumber numberWithFloat:newProgress * 100.0];
    
    // Send overal progress to future.
    if (self.future)
       [self.future setProgress:[pipeline progress]];
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark - Result Methods.

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// /
- (void)requestStarted:(AFHTTPRequestOperation *)request {
    [self.future setStarted];
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// /
- (void)requestFinished:(AFHTTPRequestOperation *)request {
	
    // Create Upstream Message.
    JPPipelineUpstreamMessageEvent *message = [JPPipelineUpstreamMessageEvent initWithMessage:[request responseString]];
    
    // Future is finished.
    [self.future setSuccess];

    // Attach the future to go opposite direction.
    message.future = self.future;
    
	// Send Request Returned Data Upstream.
	[pipeline sendUpstream:message];
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// /
- (void)requestCancelled:(AFHTTPRequestOperation *)request {
    
    // Release after cancel.
    self.requester = nil;

	///////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// 
	// Cancelled.
	[self.future cancel];
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// /
- (void)requestFailed:(AFHTTPRequestOperation *)request {
	
	// Failed Error Reason.
	NSError *error = [request error];

	// Log.
	Info(@"HTTP Request Failed (%@)! Sending Error Upstream...", [error localizedDescription] );
	
	// If error is because the request was cancelled. 
	if ( [error.domain isEqual:NSURLErrorDomain] && error.code == NSURLErrorCancelled ) {
		[self requestCancelled:request];
		return;
	}
    
    // /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// // /////// /////// /////// /////// /////// 
    // Fail the future.
    [self.future setFailure:error];
	
    // /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// // /////// /////// /////// /////// /////// 
    // Create Exception.
    JPDefaultPipelineExceptionEvent* failedEvent = [JPDefaultPipelineExceptionEvent initWithCause:[JPPipelineException initWithReason:[error localizedDescription]]																
                                                                            andError:error];
    
	///////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// 
	// Send Request Error Data Upstream.
	[pipeline sendUpstream:failedEvent];
}

@end
