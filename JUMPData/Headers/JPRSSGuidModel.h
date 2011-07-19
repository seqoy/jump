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

@interface JPRSSGuidModel : NSObject {
	NSString* value;
	NSString* permaLink;
}

/// An item's guid element provides a string that uniquely identifies the item.
@property (copy) NSString* value;

/**
 * If the guid's <b><i>isPermaLink</b></i> attribute has the value "false", 
 * the guid MAY employ any syntax the feed's publisher has devised for
 * ensuring the uniqueness of the string, such as the <a href="http://www.faqs.org/rfcs/rfc4151.html">Tag URI scheme</a>
 * described in RFC 4151.
 */
@property (copy) NSString* permaLink;

@end

