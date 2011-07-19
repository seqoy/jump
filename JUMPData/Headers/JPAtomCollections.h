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
#import "JPAtomPersonModel.h"
#import "JPAtomLinkModel.h"
#import "JPAtomEntryModel.h"
#import "JPAtomCategoryModel.h"

////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// 
#pragma mark -
@interface JPAtomPersonCollection : NSObject {
	NSMutableArray *collection;
}

/**
 * Internal collection.
 */
@property (retain) NSMutableArray *collection;

/**
 * Return the first object of this collection, or <tt>nil</tt> if is empty.
 */
@property (readonly) id firstObject;

/**
 * Add an object to this collection.
 */
-(void)addObject:(id)anObject;

/**
 * Returns the object located at <tt>anIndex</tt> or <tt>nil</tt> if isn't defined.
 */
-(id)objectAtIndex:(NSInteger)anIndex;

@end

////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// 
#pragma mark -
@interface JPAtomAuthorCollection : JPAtomPersonCollection {}
@property (readonly) JPAtomAuthorModel* firstObject;
-(void)addObject:(JPAtomAuthorModel*)anObject;
-(JPAtomAuthorModel*)objectAtIndex:(NSInteger)anIndex;
@end

////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// 
#pragma mark -
@interface JPAtomLinksCollection : JPAtomPersonCollection {}
@property (readonly) JPAtomLinkModel* firstObject;
-(void)addObject:(JPAtomLinkModel*)anObject;
-(JPAtomLinkModel*)objectAtIndex:(NSInteger)anIndex;
@end

////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// 
#pragma mark -
@interface JPAtomEntryCollection : JPAtomPersonCollection {}
@property (readonly) JPAtomEntryModel* firstObject;
-(void)addObject:(JPAtomEntryModel*)anObject;
-(JPAtomEntryModel*)objectAtIndex:(NSInteger)anIndex;
@end

////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// 
#pragma mark -
@interface JPAtomCategoryCollection : JPAtomPersonCollection {}
@property (readonly) JPAtomCategoryModel* firstObject;
-(void)addObject:(JPAtomCategoryModel*)anObject;
-(JPAtomCategoryModel*)objectAtIndex:(NSInteger)anIndex;
@end

////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// 
#pragma mark -
@interface JPAtomContributorCollection : JPAtomPersonCollection {}
@property (readonly) JPAtomContributorModel* firstObject;
-(void)addObject:(JPAtomContributorModel*)anObject;
-(JPAtomContributorModel*)objectAtIndex:(NSInteger)anIndex;
@end
