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
#import "JPPipelineEventFactory.h"
#import "JPJSONRPCMessage.h"
#import "JPPipelineEvent.h"
#import "JPPipelineFuture.h"

/**
 * An protocol that represent JPJSONRPCMessage factory pattern.
 */
@interface JPJSONRPCEventFactory : NSObject <JPPipelineEventFactory> {}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Init Methods. 
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 

/**
 * Build an JPJSONRPCMessage event with this factory specifications.
 * @param anMethod An RPC Method.
 * @param params RPC Parameters.
 * @param anID RPC Call id number.
 * @param anFuture An JPPipelineFuture object to get information about the progress of this event.
 */
+(JPJSONRPCMessage*)newEventWithMethod:(NSString*)anMethod andParameters:(NSArray*)params
											  andId:(NSNumber*)anID andFuture:(id<JPPipelineFuture>)anFuture;

@end


