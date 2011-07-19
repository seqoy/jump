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
#import "JPRSSItemModel.h"

////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// 
#pragma mark -
@interface JPRSSSkipDaysCollection : NSObject {
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
@interface JPRSSSkipHoursCollection : JPRSSSkipDaysCollection {}
@end


////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// 
#pragma mark -
@interface JPRSItemCollection : JPRSSSkipDaysCollection {}

/**
 * Return the first object of this collection, or <tt>nil</tt> if is empty.
 */
@property (readonly) JPRSSItemModel* firstObject;

/**
 * Add an object to this collection.
 */
-(void)addObject:(JPRSSItemModel*)anObject;

/**
 * Returns the object located at <tt>anIndex</tt> or <tt>nil</tt> if isn't defined.
 */
-(JPRSSItemModel*)objectAtIndex:(NSInteger)anIndex;

@end