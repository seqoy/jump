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
#import <GHUnitIOS/GHUnit.h> 
#import "JPXMLParserXPath.h"

@interface JUMPDataDictionaryXPathTests : GHTestCase {}
@end

//////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// 
#pragma mark -
@implementation JUMPDataDictionaryXPathTests

//////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// 
#pragma mark -
#pragma mark Tests - XML examples from http://www.w3schools.com/xml/xml_examples.asp

-(void)testRetrieveAllPaths {
	NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:[NSDictionary dictionaryWithObject:@"Value1" forKey:@"Level21"], @"Level11",
                                                                                                                                @"Value2", @"Level12", nil];
    
    // Retrieve Paths.
    NSArray *paths = [dictionary allPaths];
    GHAssertNotNil( paths, @"Retrived Paths result should't be NULL." );
    
    // Loop testing retrieve results.
    for ( NSString *path in paths ) {
        id value = [dictionary objectOnPath:path];
        GHAssertNotNil( value, @"Can't retrieve path '%@' from *allPaths result.", path );
    }
}


@end