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
#import "JPRSSCollections.h"

////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// 
#pragma mark -
@implementation JPRSSSkipDaysCollection
@synthesize collection;

////////// ////////// ////////// ////////// ////////// /
-(NSString*)firstObject {
	return [self objectAtIndex:0];
}

////////// ////////// ////////// ////////// ////////// /
-(NSString*)objectAtIndex:(NSInteger)anIndex {
	// Have elements and element at this index?
	if ( self.collection != nil && [self.collection count]-1 >= anIndex ) {
		return [collection objectAtIndex:anIndex];
	}
	// Nothing, return null.
	return nil;
}

////////// ////////// ////////// ////////// ////////// /
-(void)addObject:(NSString*)anObject {
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
@implementation JPRSSSkipHoursCollection
@end

////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// 
#pragma mark -
@implementation JPRSItemCollection

////////// ////////// ////////// ////////// ////////// /
-(JPRSSItemModel*)firstObject {
	return [super firstObject];
}

////////// ////////// ////////// ////////// ////////// /
-(JPRSSItemModel*)objectAtIndex:(NSInteger)anIndex {
	return [super objectAtIndex:anIndex];
}

////////// ////////// ////////// ////////// ////////// /
-(void)addObject:(JPRSSItemModel*)anObject {
	[super addObject:anObject];
}

@end


