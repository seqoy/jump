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
#import "JPRSSItemModel.h"

/////////// /////////// /////////// /////////// /////////// /////////// /////////// /////////// /////////// /////////// /////////// /////////// 
@implementation JPRSSItemModel

/////////// /////////// /////////// /////////// /////////// /////////// /////////// /////////// /////////// /////////// /////////// /////////// 
// Properties.
@synthesize author, category, description, comments, link, pubDate, title, enclosure, guid, source;

- (void) dealloc {
	[author release];
	[category release];
	[comments release];
	[link release];
	[pubDate release];
	[description release];
	[title release];
	[enclosure release];
	[guid release];
	[source release];
	[super dealloc];
}

@end
