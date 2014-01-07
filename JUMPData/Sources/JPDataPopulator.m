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
#import "JPDataPopulator.h"
#import "JPLogger.h"

////////////// ////////////// ////////////// ////////////// 
@implementation JPDataPopulator
@synthesize delegate;

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Private Methods.
///////////// 	///////////// 	///////////// 	///////////// 	///////////// 	///////////// // 	///////////// 	///////////// 
-(NSString*)capitalizeFirstLetter:(NSString*)anString {
	
	NSString *firstLetter = [ [anString substringWithRange:NSMakeRange(0, 1)] uppercaseString];
	NSString *rest		  = [anString substringFromIndex:1];
	
	// Return formatted String.
	return [NSString stringWithFormat:@"%@%@", firstLetter, rest];
	
}

///////////// 	///////////// 	///////////// 	///////////// 	///////////// 	///////////// // 	///////////// 	///////////// 
-(void)processRelationshipParametersFor:(id)anObject usingData:(NSMutableDictionary*)relationshipParameters {
	
	// If data is empty, return..
	if ( ! relationshipParameters ) return;
	
	// Loop all dictionary.
	for ( id key in relationshipParameters ) {
		
		// Method Name for corresponding relationship key.
		NSString *relationshipKey = [NSString stringWithFormat:@"add%@:", [self capitalizeFirstLetter:key]];
		
		// Selector for this element.
		SEL anSelector = NSSelectorFromString( relationshipKey  );
		
		//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
		// Check if object responds to this ADD selector.
		if ( [anObject respondsToSelector:anSelector] ) {
			[anObject performSelector:anSelector withObject:[relationshipParameters objectForKey:key ]];				// Set Value.
			
		}
		
		//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 	
		// If not, error and crash bum bang!	
		else {
			Warn( @"Object (%@) doesn't respond to Relationship add method (%@).", NSStringFromClass([anObject class]) , NSStringFromSelector(anSelector) );
		}
	}
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
-(id)tryToGrabDataKey:(NSString*)anKey fromMap:(NSDictionary*)anMap {
	
	// Try To Graba Data Key
	NSString *dataKey = [anMap objectForKey:anKey];				// [self keyForObject:anKey inDictionary:anMap];
	
	// Test if this key exist on map.     
	if ( dataKey )
		return dataKey;
	
	///////////// 	///////////// 	///////////// 	///////////// 	///////////// 	///////////// 
	
	// If don't return nothing on the loop (Doens't exist). Warning and ignore error.
	Warn( @"Data key '%@' isn't mapped. Ignoring...", anKey );
	
	// If don't return nothing, will return NIL. (Doens't exist).
	return nil;
	
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //
+(Class)grabTheClassOfProperty:(NSString*)anProperty onObject:(id)anObject {
	///////////// 	///////////// 	///////
	// Return Property Class.
	return [[JPDataPopulator grabDescriptorOfProperty:anProperty onObject:anObject] propertyClass];
}

///////////// 	///////////// 	///////////// 	///////////// 	///////////// 	///////////// // 	///////////// 	/////////////
+(JPPropertyDescriptor*)grabDescriptorOfProperty:(NSString*)anProperty onObject:(id)anObject {
    JPPropertyDescriptor *anDescriptor = [[[JPPropertyDescriptor alloc] init] autorelease];
    
    // Property Name.
    anDescriptor.propertyName = anProperty;
    
    //	///////////// 	///////////// 	///////////// 	///////////// 	/////////////
	/*
	 * To correct compile, you need to ADD the libobjc.A.dylib framework to your target. And also #import the <objc/runtime.h>
	 */
    
    Class propertyClass;

	// Get the property (Method) attributes.
	objc_property_t property = class_getProperty([anObject class], [anProperty UTF8String]);
	
	// Test if some data was returned, first.
	if ( property != NULL ) {
        
        // The attribute type will be filled as NSString.
        NSString *type;
        
        //////// ////// ////// ////// ////// ////// ////// ////// ////// //////
        // Figure out the type from attributes. Code from Apple Source: http://stackoverflow.com/questions/754824/get-an-object-attributes-list-in-objective-c
        const char *attributes = property_getAttributes(property);
        char buffer[1 + strlen(attributes)];
        char encode[1 + strlen(attributes)];
        strcpy(buffer, attributes);
        strcpy(encode, attributes);
        char *state = buffer, *attribute;
        
        //////////// ///////// ///////// ///////// /////////
        // Set attribute.
        char *attr     = encode;
        char *stripped = strsep(&attr, ",");
        int len = strlen(stripped);
        
        anDescriptor.propertyEncode = [NSData dataWithBytes:(void*)stripped length:len];

        //////////// ///////// ///////// ///////// ///////// ///////// ///////// ///////// ///////// /////////
        while ((attribute = strsep(&state, ",")) != NULL) {
            if (attribute[0] == 'T') {
                
                // Convert to NSString.
                type = [[NSString alloc] initWithBytes:(attribute + 3)
                                                length:strlen(attribute) - 4
                                              encoding:NSUTF8StringEncoding];
                break;
            }
        }
		
		// Convert type String to Class.
		propertyClass = NSClassFromString(type);
        
        // Release string type.
        [type release];
	}
    
    // Set Class.
    anDescriptor.propertyClass = propertyClass;
    
    // Set value.
    anDescriptor.propertyValue = [anObject valueForKey:anProperty];
	
	///////////// 	///////////// 	///////
	return anDescriptor;
}

///////////// 	///////////// 	///////////// 	///////////// 	///////////// 	///////////// // 	///////////// 	/////////////
-(Class)grabTheClassOfProperty:(NSString*)firstKey onObject:(id)firstObject {
    return [JPDataPopulator grabTheClassOfProperty:firstKey onObject:firstObject];
}

///////////// 	///////////// 	///////////// 	///////////// 	///////////// 	///////////// // 	///////////// 	/////////////
// Check if the *firstKey* (Method) type of the Object **anObject** (Class) is the same that the secondKey (Method) secondObject (Class).
-(BOOL)checkIfObject:(id)firstObject ofKey:(NSString*)firstKey
	   hasSameTypeOf:(id)secondObject ofKey:(NSString*)secondKey {
	
	// Class of the First Key.
	Class firstKeyClass = [self grabTheClassOfProperty:firstKey onObject:firstObject];
	
	// Check if the class types match.
	if ( [secondObject isKindOfClass:firstKeyClass] ) return YES;
	
	///////////// 	///////////// 	///////////// 	///////////// 	///////////// 	///////////// 
	
	// Warning error.
	Warn( @"Data key '%@' of Class '%@' and Mapped Data key '%@' of Class '%@' doesn't match. Will try to convert...", secondKey, NSStringFromClass([secondObject class]), firstKey, NSStringFromClass(firstKeyClass) );
	
	// If can't decode or isn't same type, return NO!
	return NO;
}

///////////// 	///////////// 	///////////// 	///////////// 	///////////// 	///////////// 
// Try to convert the **fistObject** to the same type of the **secondObject**.
-(id)tryToConvert:(id)firstObject ofKey:(NSString*)firstKey
 toTheSameClassOf:(id)secondObject ofKey:(NSString*)secondKey withDateFormat:(NSString*)anDateFormatter{
	
	// Class of the Second Key.
	Class secondKeyClass = [self grabTheClassOfProperty:secondKey onObject:secondObject];
	
	// Converted value.
	id converted = nil;
	
	///////////// 	///////////// 	////////
	// If desired value are an NSString.
	if ( secondKeyClass == [NSString class] ) 
		converted = [JPDataConverter convertToNSStringThisObject:firstObject];
	
	// If desired value are an NSNumber.
	if ( secondKeyClass == [NSNumber class] ) 
		converted = [JPDataConverter convertToNSNumberThisObject:firstObject];
	
	// If desired value are an NSDate.
	if ( secondKeyClass == [NSDate class] ) 
		converted = [JPDataConverter convertToNSDateThisObject:firstObject];	// withAdditionalDateFormat:dateFormatToConvert ];
	
	// Maybe the delegate can conver it...
	if ( delegate ) 
		if ( [(id)delegate respondsToSelector:@selector(tryToConvert:ofClass:toClass:) ] ) 
			converted = [delegate tryToConvert:firstObject ofClass:[firstObject class] toClass:secondKeyClass];
	
	// If converted are NIL, can't convert. So display warning error.
	if ( ! converted ) {
		Warn( @"Can't convert key (%@) of Class (%@) TO key (%@) of Class (%@)... Will ignore.", firstKey, NSStringFromClass([firstObject class]), secondKey, NSStringFromClass(secondKeyClass) );
	}
	
	// Return converted.
	return converted;
	
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
-(id)populateObject:(id)anObject withData:(NSDictionary*)anDictionary usingMap:(NSDictionary*)anMap andRelationshipParameters:(NSMutableDictionary*)relationshipParameters { 
	
	// Process relationship Parameters for this object.
	[self processRelationshipParametersFor:anObject usingData:relationshipParameters];
	
	//// //// //// //// //// //// //// //// //// //// //// ////
	// Loop every property on this JSON record.
	for ( id property in anDictionary ) {
		
		// Try to find corresponding bridget Core Data key for the Data Server Key.
		NSString *dataKey = [self tryToGrabDataKey:property fromMap:anMap];			
		
		// Only process if found.
		if ( dataKey ) {
			
            /////////// //////// //////// //////// //////// //////// //////// //////// //////// //////// //////// //////// //////// //////// 
            // Proceed trying to set some value on this object.
            @try {
                
                // First check if the object isn't a NULL value.
                if ( [[anDictionary objectForKey:property] isKindOfClass:[NSNull class]]) {
                    [NSException raise:NSStringFromClass([self class])
                                format:@"Value for data server key (%@) is NULL. Ignoring...", property];
                    return nil;
                }
            
				// Second, convert from Java Util Date type, if needed.										
				id serverData = [JPDataConverter convertFromJavaUtilDateIfNeeded:[anDictionary objectForKey:property]];	
				
				//// //// //// //// //// //// //// //// //// //// //// //// //// //// ////
				// Check if Server Data has the same type of Core Data Object.
				//// //// //// //// //// //// ///// //// // //// //// //// ///////
				if ( ! [self checkIfObject:anObject       ofKey:dataKey		    //
								 hasSameTypeOf:serverData ofKey:property] )     //
				{														        //
					//// //// //// //// //// ////// //////// /////////////////////
					// if DONT → Try to convert. ➘ (Oh yeah!)		
					//// //// //// //// //// ////// //////// ////// //////// ////////// //////// ////// ////// ////// ////// ////// ////
					serverData =  [self  tryToConvert:serverData    ofKey:property													  //
									 toTheSameClassOf:anObject      ofKey:dataKey   withDateFormat:nil];							  //
																																	  //
					// Converted value, will be NIL if can't convert.						///// ////// ////// ////// ////// ////// ///
					if ( serverData != nil )                                                //
						Warn( @"Converted succesfully.");                                   //
				}                                                                           //
				//// //// //// //// //// //// //// //// //// //////// //// //////// //// /////
				// Set Value if isn't NIL. Will raise an exception if can't do it.
				//// //// //// ////// //// //// //// //// //// //////// //// //////// //// ///
				if ( serverData != nil ) {                                                  //
					[anObject setValue:serverData forKey:dataKey];                          //
				}                                                                           //
            }                                                                               //
                                                                                            //
            //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// // 	
            // Some Exception ocurr and WARNING.. will don't crash this time pal.
            //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// // 	
            @catch (NSException *exception) {
                
				//////  //// //// ////// //// ////// //// ///////////
				// Error string.                                    //
				NSString *errorMessage;                             //////// //// //// //// //// //// 
                                                                                                   //
				// Error Message.
                errorMessage = [NSString stringWithFormat:@"Can't set the key-value (%@) for Object (%@).\nMore Info: %@", dataKey, NSStringFromClass([anObject class]), [exception reason]];
				
				// Print error.	
				Warn( @"%@", errorMessage );
			}
			
			//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
		}	
	}
	
	// Return populated object.
	return anObject;
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
-(id)populateDictionary:(NSMutableDictionary*)newPopulated withData:(NSDictionary*)data usingMap:(NSDictionary*)anMap {
	
	// Start an loop on the map.
	for ( id key in [anMap allValues] ) {
		
		//// //// //// //// //// //// //// //// //// //// //// ////
		// If the element is not nil, process.
		if ( [data objectForKey:key] ) {
			
			// Transport elemnt.
            [newPopulated setObject:[data objectForKey:key] forKey:key];
		}
	}
	
	// Return populated map (Dictionary).
	return newPopulated;	
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
+(NSDictionary*)retrievePropertiesFromObject:(id)anObject {

	///////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// 
    // Get a list of all properties of the Seconds Class.
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([anObject class], &outCount);
    
	///////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// 
    // Format a NSDictionary with this properties.
    NSMutableDictionary *extractedData = [[NSMutableDictionary new] autorelease];
    
	///////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// 
    for(i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        
        // Property Name.
        const char *propName = property_getName(property);
        NSString *propertyName = [NSString stringWithCString:propName encoding:NSUTF8StringEncoding];
        
        if(propName) {
            // Property value.
            id anValue = [anObject valueForKey:propertyName];
            
            // If value is 'nil', replace for NSNull object.
            anValue = ( anValue == nil ? [NSNull null] : anValue);
            
            // Assign to Dictionary.
            [extractedData setObject:anValue forKey:propertyName];
        }
    }
    // Free the properties.
    free(properties);
    
    return extractedData;
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Populate Methods.
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
+(id)populateObject:(id)anObject withPropertiesOfObject:(id)anSecondObject usingMap:(NSDictionary*)anMap withDelegate:(id<JPDataPopulatorDelegate>)anDelegate {
	// Create an instance.
	JPDataPopulator *anInstance = [[[self alloc] init] autorelease];
	// Set delegate.
	anInstance.delegate = anDelegate;
    
	
	///////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// 
	return [anInstance populateObject:anObject 
							 withData:[self retrievePropertiesFromObject:anSecondObject]
							 usingMap:anMap 
			andRelationshipParameters:nil];
}


//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
+(id)populateDictionary:(NSMutableDictionary*)anDictionary withPropertiesOfObject:(id)anSecondObject usingMap:(NSDictionary*)anMap {
	// Create an instance.
	JPDataPopulator *anInstance = [[[self alloc] init] autorelease];
	
	/////////////
	
	return [anInstance populateDictionary:anDictionary 
                                 withData:[self retrievePropertiesFromObject:anSecondObject]
                                 usingMap:anMap];
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
+(id)populateObject:(id)anObject withPropertiesOfObject:(id)anSecondObject usingMap:(NSDictionary*)anMap {
	return [JPDataPopulator populateObject:anObject withPropertiesOfObject:anSecondObject usingMap:anMap withDelegate:nil];    
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
+(id)populateObject:(id)anObject withData:(NSDictionary*)anDictionary usingMap:(NSDictionary*)anMap withDelegate:(id<JPDataPopulatorDelegate>)anDelegate {
	// Create an instance.
	JPDataPopulator *anInstance = [[[self alloc] init] autorelease];
	// Set delegate.
	anInstance.delegate = anDelegate;
	
	/////////////
	
	return [anInstance populateObject:anObject 
							 withData:anDictionary 
							 usingMap:anMap 
			andRelationshipParameters:nil];
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// /
// Populate the informed object with data.
+(id)populateObject:(id)anObject withData:(NSDictionary*)anDictionary usingMap:(NSDictionary*)anMap {
	return [self populateObject:anObject withData:anDictionary usingMap:anMap withDelegate:nil];
}

///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ////
// Populate the informed object with data from a JSON String.
+(id)populateObject:(id)anObject withJSONString:(NSString*)anJSONString usingMap:(NSDictionary*)anMap withDelegate:(id<JPDataPopulatorDelegate>)anDelegate {

	return [self populateObject:anObject
					   withData:[JPJSONProcesser convertFromJSON:anJSONString] 
					   usingMap:anMap
				   withDelegate:anDelegate];
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// /
// Populate the informed object with data.
+(id)populateObject:(id)anObject withJSONString:(NSString*)anJSONString usingMap:(NSDictionary*)anMap {
	return [self populateObject:anObject withJSONString:anJSONString usingMap:anMap withDelegate:nil];
}

@end
///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ////
