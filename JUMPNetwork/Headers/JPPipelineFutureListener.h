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
#import "JPPipelineFuture.h"


//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Notifications.
#define JPNofityPipelineFutureListener @"JPNofityPipelineFutureListener"
#pragma mark -
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
@protocol JPPipelineListenerNotification;

/**
 * @ingroup events_group
 *
 * Listens to the result of a EventFuture.  The result of the
 * asynchronous I/O operation is notified once this listener
 * is added by calling addListener:.
 */
@protocol JPPipelineFutureListener
@required

/**
 * Invoked when some action ocurr.
 */
-(void)someActionOcurr:(id<JPPipelineListenerNotification>)notification;

@end
