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


@interface JPAtomLinkModel : NSObject {
	NSString* href;
	NSString* rel;
	NSString* type;
	NSString* hreflang;
	NSString* title;
	NSString* length;
}

/// Identifies the category.
@property (copy) NSString* href;

/*
 * Contains a single link relationship type. It can be a full URI (see <a href="http://www.atomenabled.org/developers/syndication/#extensibility">extensibility</a>),
 * or one of the following predefined values:
 *  - <tt>alternate</tt>: an alternate representation of the entry or feed, for example a permalink to the html version of the entry, or the front page of the weblog.
 *  - <tt>enclosure</tt>: a related resource which is potentially large in size and might require special handling, for example an audio or video recording.
 *  - <tt>related</tt>: an document related to the entry or feed.
 *  - <tt>self</tt>: the feed itself.
 *  - <tt>via</tt>: the source of the information provided in the entry.
 * @default Default value is <tt>alternate</tt>.
 */
@property (copy) NSString* rel;

/// Indicates the media type of the resource.
@property (copy) NSString* type;

/// Indicates the language of the referenced resource.
@property (copy) NSString* hreflang;

/// Human readable information about the link, typically for display purposes.
@property (copy) NSString* title;

/// Length the length of the resource, in bytes.
@property (copy) NSString* length;

@end

