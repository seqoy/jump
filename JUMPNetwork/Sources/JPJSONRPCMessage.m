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
#import "JPJSONRPCMessage.h"
/// /// /// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ///
@implementation JPJSONRPCMessage
@synthesize method, parameters, rpcID;

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Set Methods. 
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
-(void)setMethod:(NSString*)anMethod andParameters:(NSArray*)params andId:(NSNumber*)anID {
	// Check Parameters.
	if ( anMethod == nil ) {
		[NSException raise:NSInvalidArgumentException format:@"Method is null."];
	}
	if ( params == nil ) {
		[NSException raise:NSInvalidArgumentException format:@"Parameters is null."];
	}
	
	// Retain values.
	method     = [anMethod copy];
	parameters = params;
	rpcID	   = [anID copy];
	
	// Content Type Setting.
	self.contentType = @"application/json";
}


@end
