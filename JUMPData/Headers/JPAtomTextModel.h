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

////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// 
#pragma mark -
@interface JPAtomTextModel : NSObject {
	NSString* text;
	NSString* type;
}

/// Contain human-readable text, usually in small quantities.
@property (copy) NSString* text;

/**
 * Determines how this information is encoded, see more info <a href="http://www.atomenabled.org/developers/syndication/#text">here</a>.
 *
 * - If type is <tt>text</tt>, then this element contains plain text with no entity escaped html.
 * - If type is <tt>html</tt>, then this element contains entity escaped html.
 * - If type is <tt>xhtml</tt>, then this element contains inline xhtml, wrapped in a div element.
 * @default Default type is <tt>text</tt>.
 */
@property (copy) NSString* type;
@end

////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// 
#pragma mark -
@interface JPAtomTitleModel : JPAtomTextModel {}
@end

////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// 
#pragma mark -
@interface JPAtomSummaryModel : JPAtomTextModel {}
@end

////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// 
#pragma mark -
@interface JPAtomContentModel : JPAtomTextModel {}
@end

////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// 
#pragma mark -
@interface JPAtomRightsModel : JPAtomTextModel {}
@end
