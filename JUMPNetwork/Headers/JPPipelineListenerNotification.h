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
#import "JPPipelineEvent.h"

@protocol JPPipelineListenerNotification <NSCopying, NSCoding, NSObject>
@required

/**
 * Set Notification Object.
 */
-(void)setObject:(id)anObject;

/**
 * Returns the Future Object which is associated with this notification.
 */
-(id<JPPipelineFuture>)getFuture;

/**
 * Returns the Event which is associated with this notification.
 */
-(id<JPPipelineEvent>)getEvent;

@end
