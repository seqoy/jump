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
#import "JPXMLParserXPath.h"

//////// //////// //////// //////// //////// //////// //////// //////// //////// //////// //////// 
@implementation NSDictionary (JPXMLAdditions)

- (id)objectOnPath:(NSString*)basicPath {
	// Divide Components.
	NSArray *componentes = [basicPath componentsSeparatedByString:@"/"];
	
	//////////////////////////////
	// Initial Element to parse.
	id parseElement = self;
	
	//////////////////////////////
	// Loop finding keys.
	for ( NSString *key in componentes ) {
      
      // NULL is nul..
      parseElement = (parseElement == [NSNull null] ? nil : parseElement );
      
      // Retrieve.
      parseElement = [parseElement objectForKey:key];
		
      // If no elements, break the search and will return nil (not found).
      if ( ! parseElement )
         break;
	}
	
	////////////////////////////////////////////////////////////
	// Return retrieved value.
	return parseElement;
	
}

////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// 
- (id)objectOnXMLPath:(NSString*)basicPath {
    return [self objectOnPath:basicPath];
}

////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// 
- (NSArray*)allPaths {
    // All Paths.
    NSMutableArray *allPaths = [[NSMutableArray alloc] init];
    
    // All Keys.
    NSArray *allKeys = [self allKeys];
    
    //////////////////////////////////////////////////////////////////////////////////////////
    // Loop All Keys.
    for ( NSString* key in allKeys ) {
        
        // Key must be a String.
        if ( ![key isKindOfClass:[NSString class]] ) {
            [NSException raise:NSInternalInconsistencyException
                        format:@"[%@ allPaths] can't process Dictionary *keys that isn't NSString.", NSStringFromClass([self class])];
        }
        
        // Retrieve the value.
        id value = [self objectForKey:key];
        
        //////////////////////////////
        // Value is a Dictionary? 
        if ( [value isKindOfClass:[NSDictionary class]] ) {
            
            // Process Paths inside the Dictionary.
            NSArray *newKeys = [value allPaths];
            
            // Loop adding to our paths.
            for ( NSString *newKey in newKeys ) {
                NSString *formattedKey = [NSString stringWithFormat:@"%@/%@", key, newKey ];
                [allPaths addObject:formattedKey]; 
            }
        }
        
        // Assign the plain key too.
        [allPaths addObject:key];
    }
    
    // Autorelease.
    [allPaths autorelease];
    
    // Return.
    return allPaths;
}

@end


