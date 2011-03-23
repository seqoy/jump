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
#import "JPDBManagerSingleton.h"
#import "JPDBManagerDefinitions.h"

#import "JPLog4CocoaLogger.h"
#import "JPLog4CocoaFactory.h"
#import "JPLoggerShortcuts.h"
#import "JUMPLoggerConfig.h"

/**
 * JUMP Database Module Unit Tests
 */
@interface JUMPDBManagerSingletonTests : GHTestCase {}
@end

//////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// 
#pragma mark -
@implementation JUMPDBManagerSingletonTests

//////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// 
#pragma mark -
#pragma mark Tests

// Run at start of all tests in the class
- (void)setUpClass {
	// Configure the Factory Class.
	[JUMPLoggerConfig setLoggerFactoryClass:[JPLog4CocoaFactory class]];
	SetGlobalLogLevel( JPLoggerAllLevel );
}

-(void)testSingletonInstance {
	JPDBManagerSingleton *singletonA = [JPDBManagerSingleton sharedInstance];
	GHAssertNotNil( singletonA, @"'sharedInstance' return an nil object");
	JPDBManagerSingleton *singletonB = [JPDBManagerSingleton sharedInstance];
	GHAssertNotNil( singletonB, @"'sharedInstance' return an nil object");
	GHAssertEqualObjects( singletonA, singletonB, @"Singleton MUST return the same object everytime");
}

-(void)testProtecteInitiators {
	GHAssertThrowsSpecificNamed( [JPDBManagerSingleton initAndStartCoreData],
								 NSException,
								 JPDBInvalidInitiator,  
								 @"'initAndStartCoreData' or 'init' MUST fail on Singleton Class");
}
@end
