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
#import "JPFeedAbstractModel.h"


/////// ////// ////// ////// ////// ////// ////// ////// ////// /////// ////// ////// ////// ////// ////// ////// ////// ////// 
@implementation JPFeedAbstractModel

/////// ////// ////// ////// ////// ////// ////// ////// ////// /////// ////// ////// ////// ////// ////// ////// ////// ////// 
#pragma mark -
#pragma mark Process Methods
/////// ////// ////// ////// ////// ////// ////// ////// ////// /////// ////// ////// ////// ////// ////// ////// ////// ////// 
-(id)validateElement:(id)anElement ofClass:(Class)anClass withErrors:(NSArray*)anErrorList {
	
	// Is valid?
	if (anElement == nil) 
		[NSException raise:JPFeedLoadException format:@"%@", [anErrorList objectAtIndex:0]];
	
	// Is correct class?
	if ( ! [anElement isKindOfClass:anClass] )
		[NSException raise:JPFeedLoadException format:@"%@", [anErrorList objectAtIndex:1]];
	
	// Return the element if everything is ok.
	return anElement;
}

/////// ////// ////// ////// ////// ////// ////// ////// ////// /////// ////// ////// ////// ////// ////// ////// ////// ////// 
-(id)populateCollection:(Class)collectionClass withObject:(Class)objectClass usingMap:(NSDictionary*)anMap withData:(id)object {
	// Init new object.
	id populate = [[collectionClass new] autorelease];
	
	// Dictionary?
	if ( [object isKindOfClass:[NSDictionary class]] ) {
		// Convert to array.
		object = [NSArray arrayWithObject:object];
	}
	
	// Loop all elements.
	for ( NSDictionary* item in object ) {
		
		// Create new item.
		id element = [[objectClass new] autorelease];
		
		// Populate.
		element = [JPDataPopulator populateObject:element withData:item usingMap:anMap withDelegate:self];	
		
		// Add to Collection.
		[populate addObject:element];
	}
	
	// Return populated.
	return populate;
}

/////// ////// ////// ////// ////// ////// ////// ////// ////// /////// ////// ////// ////// ////// ////// ////// ////// ////// 
#pragma mark -
#pragma mark JPDataPopulatorDelegate Methods
/////// ////// ////// ////// ////// ////// ////// ////// ////// /////// ////// ////// ////// ////// ////// ////// ////// ////// 
// When the Data Populator can't automatically convert some specific type. He will call this method  and let you extend the class converting you specific type.
-(id)tryToConvert:(id)object ofClass:(Class)objectClass toClass:(Class)convertToClass {
	Warn( @"[%@ %@] isn't implemented!",  NSStringFromClass([self class]), NSStringFromSelector(_cmd));
	return nil;
}

/////// ////// ////// ////// ////// ////// ////// ////// ////// /////// ////// ////// ////// ////// ////// ////// ////// ////// 
#pragma mark -
#pragma mark Load Data Methods
/////// ////// ////// ////// ////// ////// ////// ////// ////// /////// ////// ////// ////// ////// ////// ////// ////// ////// 
-(id)loadFeedFromDictionary:(NSDictionary*)anDictionary {
	Warn( @"[%@ %@] isn't implemented!", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
	return nil;
}

@end
