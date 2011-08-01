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
#import "JPPipelineExceptionEvent.h"
#import "JPPipelineUpstreamMessageEvent.h"
#import "JPPipelineFuture.h"
#import "JPPipelineFailedFuture.h"

/**
 * @ingroup events_group
 *
 * The default Pipeline Exception Event implementation.
 */
@interface JPDefaultPipelineExceptionEvent : JPPipelineUpstreamMessageEvent <JPPipelineExceptionEvent> {
	NSException *cause;
	NSError *error;
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Init Methods. 
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
/** @name Init Methods
 */
///@{ 

/**
 * Init the event with an cause.
 * @param anCause An exception object that represent the cause of this Exception.
 */
+(id)initWithCause:(NSException*)anCause;

/**
 * Init the event with an cause.
 * @param anCause An exception object that represent the cause of this Exception.
 * @param anError An error object that represent the cause of this Exception.
 */
+(id)initWithCause:(NSException*)anCause andError:(NSError*)anError;
-(id)initWithCause:(NSException*)anCause andError:(NSError*)anError;

///@}
@end
