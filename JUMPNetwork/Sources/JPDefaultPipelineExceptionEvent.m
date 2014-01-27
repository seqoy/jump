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
#import "JPDefaultPipelineExceptionEvent.h"

/// /// /// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ///
@implementation JPDefaultPipelineExceptionEvent

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Init Methods. 
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
+(id)initWithCause:(NSException*)anCause {
	return [[self alloc] initWithCause:anCause andError:nil];
}
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
+(id)initWithCause:(NSException*)anCause andError:(NSError*)anError {
	return [[self alloc] initWithCause:anCause andError:anError];
}
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
-(id)initWithCause:(NSException*)anCause andError:(NSError*)anError {
	self = [super init];
	if (self != nil) {
        if (anCause == nil) {
			[NSException raise:NSInvalidArgumentException format:@"Cause is null."];
        }
		
		// Store Cause.
        cause = [anCause copy];
		
		// Store error if defined.
		if ( anError )
			error = [anError copy];
        
        // Future.
        self.future = [JPPipelineFailedFuture initWithCause:[self getError]];

	}
	return self;
}
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
-(NSString*)description {
	return [NSString stringWithFormat:@"[%@, Cause: %@]", [cause name], [cause reason]];
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Methods. 
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
// Returns the raised exception.
-(NSException*)getCause {
	return cause;
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
// Returns the stored error.
-(NSError*)getError {
	return error;
}


@end
