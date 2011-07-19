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
#import "JPAtomCategoryModel.h"

/////////// /////////// /////////// /////////// /////////// /////////// /////////// /////////// /////////// /////////// /////////// /////////// 
@implementation JPAtomCategoryModel

/////////// /////////// /////////// /////////// /////////// /////////// /////////// /////////// /////////// /////////// /////////// /////////// 
// Properties.
@synthesize term, scheme, label;

////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// 
// Init Methods.
+(id)initWithTerm:(NSString*)anTerm scheme:(NSString*)anScheme label:(NSString*)anLabel {
	JPAtomCategoryModel *instance = [[JPAtomCategoryModel new] autorelease];
	
	// Load data.
	instance.term	= anTerm;
	instance.scheme	= anScheme;
	instance.label	= anLabel;
	
	// Return instance.
	return instance;
}

////////// ////////// ////////// ////////// ////////// ////////// ////////// //////////
- (void) dealloc
{
	[term release];
	[scheme release];
	[label release];
	[super dealloc];
}


@end
