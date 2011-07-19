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
#import "JPAtomCollections.h"

////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// 
#pragma mark -
@implementation JPAtomPersonCollection
@synthesize collection;

////////// ////////// ////////// ////////// ////////// /
-(JPAtomPersonModel*)firstObject {
	return [self objectAtIndex:0];
}

////////// ////////// ////////// ////////// ////////// /
-(id)objectAtIndex:(NSInteger)anIndex {
	// Have elements and element at this index?
	if ( self.collection != nil && [self.collection count]-1 >= anIndex ) {
		return [collection objectAtIndex:anIndex];
	}
	// Nothing, return null.
	return nil;
}

////////// ////////// ////////// ////////// ////////// /
-(void)addObject:(id)anObject {
	// If isn't alloced.
	if ( collection == nil )
	 	 self.collection = [[NSMutableArray new] autorelease];

	// Add object.
	[collection addObject:anObject];
}

////////// ////////// ////////// ////////// ////////// /
- (void) dealloc {
	[collection release], collection = nil;
	[super dealloc];
}

@end


////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// 
#pragma mark -
@implementation JPAtomAuthorCollection
-(JPAtomAuthorModel*)firstObject {
	return [super firstObject];
}
-(void)addObject:(JPAtomAuthorModel*)anObject {
	[super addObject:anObject];
}
-(JPAtomAuthorModel*)objectAtIndex:(NSInteger)anIndex {
	return [super objectAtIndex:anIndex];
}
@end

////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// 
#pragma mark -
@implementation JPAtomLinksCollection 
-(JPAtomLinkModel*)firstObject {
	return [super firstObject];
}
-(void)addObject:(JPAtomLinkModel*)anObject {
	[super addObject:anObject];
}
-(JPAtomLinkModel*)objectAtIndex:(NSInteger)anIndex {
	return [super objectAtIndex:anIndex];
}
@end

////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// 
#pragma mark -
@implementation JPAtomEntryCollection 
-(JPAtomEntryModel*)firstObject {
	return [super firstObject];
}
-(void)addObject:(JPAtomEntryModel*)anObject {
	[super addObject:anObject];
}
-(JPAtomEntryModel*)objectAtIndex:(NSInteger)anIndex {
	return [super objectAtIndex:anIndex];
}
@end

////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// 
#pragma mark -
@implementation JPAtomCategoryCollection 
-(JPAtomCategoryModel*)firstObject {
	return [super firstObject];
}
-(void)addObject:(JPAtomCategoryModel*)anObject {
	[super addObject:anObject];
}
-(JPAtomCategoryModel*)objectAtIndex:(NSInteger)anIndex {
	return [super objectAtIndex:anIndex];
}
@end

////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// 
#pragma mark -
@implementation JPAtomContributorCollection 
-(JPAtomContributorModel*)firstObject {
	return [super firstObject];
}
-(void)addObject:(JPAtomContributorModel*)anObject {
	[super addObject:anObject];
}
-(JPAtomContributorModel*)objectAtIndex:(NSInteger)anIndex {
	return [super objectAtIndex:anIndex];
}
@end

