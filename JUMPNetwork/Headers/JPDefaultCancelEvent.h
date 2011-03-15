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
#import "JPPipelineDowstreamMessageEvent.h"

/**
 * @ingroup events_group
 *
 * \ref An Pipeline <b>downstream</b> \ref events_page that represent one <b>"cancel"</b> action.
 
 You can <b>cancel</b> an <b>downstream</b> \ref events_page while he is processing 
 sending an JPDefaultCancelEvent downstream as follow:
 \code
 [pipeline sendDownstream:[JPDefaultCancelEvent init]];
 \endcode
 \note Instead that \ref the_pipeline are always an asynchronous I/O operation 
 he process one \ref events_page at a time, that's why you can cancel an event
 while he is processing or waiting for some answer.
 */
@interface JPDefaultCancelEvent : JPPipelineDowstreamMessageEvent {}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Init Methods. 
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
/*
 * Init this event.
 */
+(id)init;
@end
