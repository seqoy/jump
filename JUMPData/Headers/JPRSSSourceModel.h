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

@interface JPRSSSourceModel : NSObject {
	NSString* value;
	NSString* url;
}

/// An item's source element indicates the fact that the item has been republished from another RSS feed.
@property (copy) NSString* value;

/**
 * The element MUST have a url attribute that identifies the URL of the source feed.
 */
@property (copy) NSString* url;

@end

