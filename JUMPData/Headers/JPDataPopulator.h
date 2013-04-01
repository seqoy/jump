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
#import <objc/runtime.h>
#import <Foundation/Foundation.h>
#import "JPDataConverter.h"
#import "JPJSONProcesser.h"
#import "JPDataPopulatorDelegate.h"
#import "JPPropertyDescriptor.h"

/**
 * \nosubgrouping 
 * JPDataPopulator is used to populate Model Objects with Data contained in dictionaries.
 */
@interface JPDataPopulator : NSObject {
	id<JPDataPopulatorDelegate> delegate;
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Properties.
/**
 * 
 */
@property (assign) id<JPDataPopulatorDelegate> delegate;

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Populate Methods.
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
//// //// //// //// //// //// //// //// //// //// //// //// //// //// ////
/** @name Populate Methods
 */
///@{ 

/**
 * Populate the informed object with data.
 * @param anObject The object to populate.
 * @param withData An <tt>NSDictionary</tt> with data.
 * @param usingMap An <tt>NSDictionary</tt> that represent an map that describe how to populate the object.
 */
+(id)populateObject:(id)anObject withData:(NSDictionary*)anDictionary usingMap:(NSDictionary*)anMap;

/**
 * Populate the informed object with data.
 * @param anObject The object to populate.
 * @param withData An <tt>NSDictionary</tt> with data.
 * @param usingMap An <tt>NSDictionary</tt> that represent an map that describe how to populate the object.
 * @param anDelegate to extend the JPDataPopulator class. See JPDataPopulatorDelegate documentation for more information.
 */
+(id)populateObject:(id)anObject withData:(NSDictionary*)anDictionary usingMap:(NSDictionary*)anMap withDelegate:(id<JPDataPopulatorDelegate>)anDelegate;

/**
 * Populate the informed object with data from a JSON String.
 * @param anObject The object to populate.
 * @param withJSONString An <tt>NSString</tt> that contains an JSON formatted string that represent the data.
 * @param usingMap An <tt>NSDictionary</tt> that represent an map that describe how to populate the object.
 */
+(id)populateObject:(id)anObject withJSONString:(NSString*)anJSONString usingMap:(NSDictionary*)anMap;

/**
 * Populate the informed object with data from a JSON String.
 * @param anObject The object to populate.
 * @param withJSONString An <tt>NSString</tt> that contains an JSON formatted string that represent the data.
 * @param usingMap An <tt>NSDictionary</tt> that represent an map that describe how to populate the object.
 * @param anDelegate to extend the JPDataPopulator class. See JPDataPopulatorDelegate documentation for more information.
 */
+(id)populateObject:(id)anObject withJSONString:(NSString*)anJSONString usingMap:(NSDictionary*)anMap withDelegate:(id<JPDataPopulatorDelegate>)anDelegate;

/**
 * Populate the informed object with data from a second object. This method will populate the first object
 * reading the properties of a second object following the instructions based on some map.
 * @param anObject The object to populate.
 * @param anSecondObject An object that contains data to populate the first object.
 * @param usingMap An <tt>NSDictionary</tt> that represent an map that describe how to populate the object.
 */
+(id)populateObject:(id)anObject withPropertiesOfObject:(id)anSecondObject usingMap:(NSDictionary*)anMap;

/**
 * Populate the informed object with data from a second object. This method will populate the first object
 * reading the properties of a second object following the instructions based on some map.
 * @param anObject The object to populate.
 * @param anSecondObject An object that contains data to populate the first object.
 * @param usingMap An <tt>NSDictionary</tt> that represent an map that describe how to populate the object.
 * @param anDelegate to extend the JPDataPopulator class. See JPDataPopulatorDelegate documentation for more information.
 */
+(id)populateObject:(id)anObject withPropertiesOfObject:(id)anSecondObject usingMap:(NSDictionary*)anMap withDelegate:(id<JPDataPopulatorDelegate>)anDelegate;

/**
 * Populate the informed dictionary with data from a second object. This method will populate the dictionary
 * reading the properties of a second object following the instructions based on some map.
 * @param anDictionary The dictionary to populate.
 * @param anSecondObject An object that contains data to populate the first object.
 * @param usingMap An <tt>NSDictionary</tt> that represent an map that describe how to populate the object.
 * @param anDelegate to extend the JPDataPopulator class. See JPDataPopulatorDelegate documentation for more information.
 */
+(id)populateDictionary:(NSMutableDictionary*)anDictionary withPropertiesOfObject:(id)anSecondObject usingMap:(NSDictionary*)anMap;

/**
 * Return an Dictionary with all properties of giving object. The dictionary contain
 * keys for the properties names and values for every property value. If the 
 * value of some property is 'nil' or can't be decoded will 
 * @param anObject An object to retrieve properties for.
 */
+(NSDictionary*)retrievePropertiesFromObject:(id)anObject;

/**
 * Return the <tt>Class</tt> of an specified property of the informed object.
 * @param anProperty The name of the property.
 * @param anObject The object that contain the property to retrieve.
 * @return The <tt>Class</tt> of specified property, or <tt>nil</tt> if some error ocurr.
 */
+(Class)grabTheClassOfProperty:(NSString*)anProperty onObject:(id)anObject;

/**
 * Return an <tt>JPPropertyDescriptor</tt> instance filled with properties data.
 * @param anProperty The name of the property.
 * @param anObject The object that contain the property to retrieve.
 */
+(JPPropertyDescriptor*)grabDescriptorOfProperty:(NSString*)anProperty onObject:(id)anObject;

///@}
///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// 
#pragma mark -
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
/*
-(id)populateObject:(id)anObject withData:(NSDictionary*)anDictionary usingMap:(NSDictionary*)anMap andRelationshipParameters:(NSMutableDictionary*)relationshipParameters;

///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// 
+(NSError*)populateNSErrorWithJSONDictionary:(NSDictionary*)anDictionary;
-(NSError*)populateNSErrorWithJSONDictionary:(NSDictionary*)anDictionary;
*/

///@}
@end

