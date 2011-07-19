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

#import "JPDataPopulator.h"
#import "JPDataPopulatorDelegate.h"
#import "JPLogger.h"
/// /// /// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ///
#define JPFeedLoadException @"JPFeedLoadException"

/**
 * Missing description.
 */
@interface JPFeedAbstractModel : NSObject <JPDataPopulatorDelegate> {}

/////// ////// ////// ////// ////// ////// ////// ////// ////// /////// ////// ////// ////// ////// ////// ////// ////// ////// 
#pragma mark -
#pragma mark Process Methods (Internal use only, don't call this methods directly).
/////// ////// ////// ////// ////// ////// ////// ////// ////// /////// ////// ////// ////// ////// ////// ////// ////// ////// 
-(id)validateElement:(id)anElement ofClass:(Class)anClass withErrors:(NSArray*)anErrorList;
-(id)populateCollection:(Class)collectionClass withObject:(Class)objectClass usingMap:(NSDictionary*)anMap withData:(id)object;

/////// ////// ////// ////// ////// ////// ////// ////// ////// /////// ////// ////// ////// ////// ////// ////// ////// ////// 
#pragma mark -
#pragma mark Load Data Methods
/////// ////// ////// ////// ////// ////// ////// ////// ////// /////// ////// ////// ////// ////// ////// ////// ////// ////// 
-(id)loadFeedFromDictionary:(NSDictionary*)anDictionary;


@end
