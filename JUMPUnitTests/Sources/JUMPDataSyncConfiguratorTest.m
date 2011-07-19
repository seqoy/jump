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
#import "JPSyncManagerConfigurator.h"

/**
 * JUMP Database Module Unit Tests
 */
@interface JUMPDataSyncConfiguratorTest : GHTestCase {}
@end

//////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// 
#pragma mark -
@implementation JUMPDataSyncConfiguratorTest

//////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// 
#pragma mark -
#pragma mark Tests

// Run at start of all tests in the class
- (void)setUpClass {
	// Configure the Factory Class.
	[JUMPLoggerConfig setLoggerFactoryClass:[JPLog4CocoaFactory class]];
	SetGlobalLogLevel( JPLoggerAllLevel );
}

//////////// //////////// //////////// //////////// //////////// //////////// //
-(void)testLoadConfigFromFile {

	// File URL.
	NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"JPSyncConfiguration" withExtension:@"xml"];

	// Load configuration file.
	JPSyncManagerConfigurator *configurator = [JPSyncManagerConfigurator initAndConfigureFromXMLFile:fileURL];
	
	// Map can't be empty.
	GHAssertTrue( 2 == [[configurator maps] count], @"Maps wasn't readed correctly!");
	// Confs can't be empty.
	GHAssertTrue( 2 == [[configurator configs] count], @"Configs wasn't readed correctly!");
	
}

//////////// //////////// //////////// //////////// //////////// //////////// //
-(void)testLoadConfigFromFileWithOnlyOneItem {
	
	// File URL.
	NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"JPSyncConfigurationOneItem" withExtension:@"xml"];
	
	// Load configuration file.
	JPSyncManagerConfigurator *configurator = [JPSyncManagerConfigurator initAndConfigureFromXMLFile:fileURL];
	
	// Map can't be empty.
	GHAssertTrue( 1 == [[configurator maps] count], @"Maps wasn't readed correctly!");
	// Confs can't be empty.
	GHAssertTrue( 1 == [[configurator configs] count], @"Configs wasn't readed correctly!");
	
}
@end