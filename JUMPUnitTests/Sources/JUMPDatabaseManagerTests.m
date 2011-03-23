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
#import "JPDBManager.h"
#import "JPDBManagerDefinitions.h"
#import "JPDBManagerAction.h"

#import "JPLog4CocoaLogger.h"
#import "JPLog4CocoaFactory.h"
#import "JPLoggerShortcuts.h"
#import "JUMPLoggerConfig.h"

/**
 * JUMP Database Module Unit Tests
 */
@interface JUMPDBManagerTests : GHTestCase { 
	NSString *entity;
	NSString *attribute;
	JPDBManager *DBManager;
}
@end

//////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// 
#pragma mark -
@implementation JUMPDBManagerTests

// By default NO, but if you have a UI test or test dependent on running on the main thread return YES
- (BOOL)shouldRunOnMainThread {
	return NO;
}

// Run at start of all tests in the class
- (void)setUpClass {
	// Configure the Factory Class.
	[JUMPLoggerConfig setLoggerFactoryClass:[JPLog4CocoaFactory class]];
	SetGlobalLogLevel( JPLoggerAllLevel );
	
	entity = @"MyEntity";
	attribute = @"name";
	
	// Init Manager.
	DBManager = [[JPDBManager initAndStartCoreData] retain];
	GHAssertNotNil( DBManager, @"Manager Instance doesn't initialize correctly." );
	GHAssertNotNil( DBManager.managedObjectContext, @"Managed Object Context wasn't created correctly." );
	GHAssertNotNil( DBManager.managedObjectModel, @"Managed Object Model wasn't created correctly." );
	GHAssertNotNil( DBManager.persistentStoreCoordinator, @"Persistent Store Coordinator. wasn't created correctly." );
	  
}

// Run at end of all tests in the class
- (void)tearDownClass {
	[entity release];
	[attribute release];
	[DBManager closeCoreData];
	[DBManager release];
}

// Run before each test method
- (void)setUp {
	
}

// Run after each test method
- (void)tearDown {
	
}  

//////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// 
#pragma mark -
#pragma mark Tests

-(void)testStartCoreData {
	JPDBManager *instance = [DBManager startCoreData];
	GHAssertNotNil( instance, @"startCoredta method must return an Instance");
	GHAssertNotNil( instance.managedObjectContext, @"Managed Object Context wasn't created correctly." );
	GHAssertNotNil( instance.managedObjectModel, @"Managed Object Model wasn't created correctly." );
	GHAssertNotNil( instance.persistentStoreCoordinator, @"Persistent Store Coordinator. wasn't created correctly." );
}

-(void)testInitAndStartCoreData {
	JPDBManager *instance = [JPDBManager init];
	GHAssertNotNil( instance, @"JPDBManager doesn't init correctly");
}

-(void)testExistEntity {
	BOOL exist = [DBManager existEntity:entity];
	GHAssertTrue( exist, @"'%@' must exist on the model.", entity);	
}

-(void)testExistAttribute {
	BOOL exist = [DBManager existAttribute:attribute inEntity:entity];
	GHAssertTrue( exist, @"'%@' attribute must exist in '%@' Entity.", attribute, entity);	
}

-(void)testSetAutomaticallyCommit {
	[DBManager setAutomaticallyCommit:YES];
	GHAssertTrue( DBManager.automaticallyCommit, @"'automaticallyCommit' property doesn't set correctly");
}

-(void)testGetDatabaseAction {
	[DBManager setAutomaticallyCommit:YES];
	JPDBManagerAction *action = [DBManager getDatabaseAction];
	GHAssertNotNil( action, @"'getDatabaseAction' doesn't return an proper Database Action Object");
	GHAssertTrue( action.commitTransaction, @"Database Action commit MUST be true" );
	GHAssertEqualObjects( action.manager, DBManager, @"Database Action MANAGER isn't correctly setted");
}
@end