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
#import "JPPipelineEvent.h"

/**
 * @ingroup events_group
 *
 * A JPPipelineEvent which represents the transmission or reception of a
 * \link messages_page message\endlink. It can mean the notification of a \link messages_page received message\endlink or the request
 * for sending a \link messages_page message\endlink, depending on whether it is an upstream event or a
 * downstream event respectively. Refer to the JPPipelineEvent Protocol
 * documentation to find out what an upstream event and a downstream event are
 * and what fundamental differences they have.
 */
@protocol JPPipelineMessageEvent <JPPipelineEvent> 
@required

/**
 * Returns the message.
 */
-(id)getMessage;

/**
 * Set the message.
 * @param An \ref messages_page to be transported by this event.
 */
-(void)setMessage:(id)anMessage;

@end
