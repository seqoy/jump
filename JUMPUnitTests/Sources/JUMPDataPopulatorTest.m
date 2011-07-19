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
#import "JPDataPopulator.h"
#import "JPLogger.h"
#import "mockObject.h"
#import "JPFunctions.h"

/**
 * JUMP DAta Populator Unit Tests
 */
@class mockObject;
@interface JUMPDataPopulator : GHTestCase {
	mockObject *anObject;
}
@end

//////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// 
#pragma mark -
@implementation JUMPDataPopulator

//////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// 
#pragma mark -
#pragma mark Tests

// Run at start of all tests in the class
- (void)setUpClass {
	// Logger.
	[JUMPLoggerConfig setLoggerFactoryClass:[JPLog4CocoaFactory class]];
	SetGlobalLogLevel( JPLoggerAllLevel );
}

- (void)setUp {
	// Create mock Object to populate.
	anObject = [[[mockObject alloc] init] autorelease];
}

-(void)testPopulateObjectFromJSONString {
	// Create an Map.
	NSDictionary *anMap = [NSDictionary dictionaryWithObjectsAndKeys:  @"attribute", @"data1",
																	   @"value",	 @"data3",
																	   @"property",  @"data2", nil];
	
	// JSON Data.
	NSString *JSONdata = @"{\"data1\": \"valor1\", \"data3\": 5, \"data2\": \"valor2\"}";

	// Populate.
	[JPDataPopulator populateObject:anObject withJSONString:JSONdata usingMap:anMap];
	
	//////////// //////////// //////////// //////////// ////
	// Check population.
	GHAssertEqualStrings( @"valor1", anObject.attribute, @"'attribute' wasn't populated correctly");
	GHAssertEqualStrings( @"valor2", anObject.property, @"'property' wasn't populated correctly");
	GHAssertTrue( 5 == [[anObject value] intValue], @"'value' wasn't populated correctly");
}

-(void)testPopulateObject {
	// Create an Map.
	NSDictionary *anMap = [NSDictionary dictionaryWithObjectsAndKeys:  @"attribute", @"data1",
																	   @"value",	 @"data3",
																	   @"property",  @"data2", nil];
	
	// Create data.
	NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys: @"valor1", @"data1",
																	 NSAInt( 5 ), @"data3",
																	 @"valor2", @"data2", nil];

	// Populate.
	[JPDataPopulator populateObject:anObject withData:data usingMap:anMap];

	//////////// //////////// //////////// //////////// ////
	// Check population.
	GHAssertEqualStrings( @"valor1", anObject.attribute, @"'attribute' wasn't populated correctly");
	GHAssertEqualStrings( @"valor2", anObject.property, @"'property' wasn't populated correctly");
	GHAssertTrue( 5 == [[anObject value] intValue], @"'value' wasn't populated correctly");
}

-(void)testPopulateObjectWithConversions {
	// Create an Map.
	NSDictionary *anMap = [NSDictionary dictionaryWithObjectsAndKeys: @"value", @"data3", nil];
	
	// Create data.
	NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:  @"5", @"data3", nil];
	
	// Populate.
	[JPDataPopulator populateObject:anObject withData:data usingMap:anMap];
	
	//////////// //////////// //////////// //////////// ////
	// Check population.
	GHAssertTrue( 5 == [[anObject value] intValue], @"'value' wasn't populated correctly");
}	
@end


