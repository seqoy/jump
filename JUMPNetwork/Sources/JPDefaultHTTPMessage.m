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
#import "JPDefaultHTTPMessage.h"

/// /// /// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ///
@implementation JPDefaultHTTPMessage
@synthesize dataToSend, userAgent, requestMethod, transportURL, timeOutSeconds;
@synthesize contentType, future;

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Init Methods.
-(id)init {
    self = [super init];
    if ( self != nil ) {
        // Default Data.
        self.userAgent     = @"JUMP Network Transport Layer 1.0";

        //// //// //// //// //// //// //// //// //// //// //// ///// //// //// //// //// //// //// //// //// //// //// /
        // Default Settings.
        self.timeOutSeconds	 = 60 * 5;
        self.contentType     = @"text/plain";

        self.requestMethod = @"POST";
    }
    return self;
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// /
+(id)initWithMethod:(NSString*)anMethod {
	return [[self alloc] initWithData:nil withMethod:anMethod];
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// /
+(id)initWithData:(NSData*)anData {
	return [[self alloc] initWithData:anData withMethod:nil];
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// /
+(id)initWithData:(NSData*)anData withMethod:(NSString*)anMethod {
	return [[self alloc] initWithData:anData withMethod:anMethod];
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// /
-(id)initWithData:(NSData*)anData withMethod:(NSString*)anMethod {
	self = [self init];
	if (self != nil) {
		
		// If Method defined, retain.
		if ( anMethod ) 
			self.requestMethod = anMethod;

		// Retain Parameters.
		self.dataToSend = anData;
	}
	return self;
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Getters & Setters.
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
-(id<JPPipelineFuture>)getFuture {
    return future;
}

@end
