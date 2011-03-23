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
#import "JPCore.h"
#import "MyEntity.h"

#import "JPLog4CocoaLogger.h"
#import "JPLog4CocoaFactory.h"
#import "JPLoggerShortcuts.h"
#import "JUMPLoggerConfig.h"

/**
 * JUMP Database Module Unit Tests
 */
@interface JUMPDBManagerActionTests : GHTestCase { 
	NSString *entity;
	NSString *orderKey;
	NSString *orderKey2;
	NSString *fetchTemplate;
	JPDBManager *DBManager;
	JPDBManagerAction *action;
}
@end

//////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// 
#pragma mark -
@implementation JUMPDBManagerActionTests

// Run at start of all tests in the class
- (void)setUpClass {
	
	// Configure the Factory Class.
	[JUMPLoggerConfig setLoggerFactoryClass:[JPLog4CocoaFactory class]];
	SetGlobalLogLevel( JPLoggerAllLevel );
	
	entity = @"MyEntity";
	orderKey = @"name";
	orderKey2 = @"code";
	fetchTemplate = @"MyFilter";
	
	// Init Manager.
	DBManager = [[JPDBManager initAndStartCoreData] retain];
	GHAssertNotNil( DBManager, @"Manager Instance doesn't initialize correctly." );
}

// Run at end of all tests in the class
- (void)tearDownClass {
	[entity release];
	[orderKey release];
	[DBManager closeCoreData];
	[DBManager release];
}

// Run before each test method
- (void)setUp {
	action = [[DBManager getDatabaseAction] retain];
}

// Run after each test method
- (void)tearDown {
	NSReleaseSafely( action );
}  

//////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// 
#pragma mark -
#pragma mark Tests

-(void)testSetProperties {

	action.returnObjectsAsFault = YES;
	GHAssertEquals( YES, action.returnObjectsAsFault, @"'returnObjectsAsFault' property wasn't setted correctly" );
	
	action.commitTransaction = YES;
	GHAssertEquals( YES, action.commitTransaction, @"'commitTransaction' property wasn't setted correctly" );
	
	action.returnActionAsArray = NO;
	GHAssertEquals( NO, action.returnActionAsArray, @"'returnActionAsArray' property wasn't setted correctly" );
	
	action.ascendingOrder = NO;
	GHAssertEquals( NO, action.ascendingOrder, @"'ascendingOrder' property wasn't setted correctly" );
}

-(void)testApplyParameters {
	JPDBManagerAction *anAction;
	NSSortDescriptor *sorter;

	///////////////	///////////////	///////////////	///////////////
	#pragma mark Test applyEntity:

	anAction = [action applyEntity:entity];
	GHAssertNotNil( anAction, @"'applyEntity:' MUST return a non nin object");
	GHAssertEqualObjects( anAction, action, @"'applyEntity:' MUST return itselfs");
	GHAssertEqualStrings( entity, action.entity, @"Entity wasn't setted correctly" );						

	///////////////	///////////////	///////////////	///////////////
	#pragma mark Test applyFetchTemplate:

	anAction = [action applyFetchTemplate:fetchTemplate];
	GHAssertNotNil( anAction, @"'applyFetchTemplate:' MUST return a non nin object");
	GHAssertEqualObjects( anAction, action, @"'applyFetchTemplate:' MUST return itselfs");
	GHAssertEqualStrings( fetchTemplate, action.fetchTemplate, @"Fetch Template wasn't setted correctly" );	

	///////////////	///////////////	///////////////	///////////////
	#pragma mark Test applyFetchReplaceWithVariables:
	
	anAction = [action applyFetchReplaceWithVariables:@"value1", @"key1", nil];
	GHAssertNotNil( anAction, @"'applyFetchReplaceWithVariables:' MUST return a non nin object");
	GHAssertEqualObjects( anAction, action, @"'applyFetchReplaceWithVariables:' MUST return itselfs");
	GHAssertNotNil( [[action variablesListAndValues] objectForKey:@"key1"], @"'variablesListAndValues' wasn't setted correclty");
	
	///////////////	///////////////	///////////////	///////////////
	#pragma mark Test applyFetchReplaceWithVariables:
	anAction = [anAction applyOrderKey:orderKey];
	GHAssertNotNil( anAction, @"'applyOrderKey:' MUST return a non nin object");
	GHAssertEqualObjects( anAction, action, @"'applyOrderKey:' MUST return itselfs");
	GHAssertTrue( 1 == [[anAction sortDescriptors] count], @"'applyOrderKey:' doesn't add one item");
	
	sorter = [[anAction sortDescriptors] objectAtIndex:0];
	GHAssertEqualObjects( sorter.key, orderKey, @"Added key isn't correctly");
	
	///////////////	///////////////	///////////////	///////////////
	#pragma mark Test addOrderKey:
	anAction = [anAction addOrderKey:orderKey2];
	GHAssertNotNil( anAction, @"'addOrderKey:' MUST return a non nin object");
	GHAssertEqualObjects( anAction, action, @"'addOrderKey:' MUST return itselfs");
	GHAssertTrue( 2 == [[anAction sortDescriptors] count], @"'addOrderKey:' doesn't add one item");

	sorter = [[anAction sortDescriptors] objectAtIndex:1];
	GHAssertEqualObjects( sorter.key, orderKey2, @"Added key isn't correctly");
	
	///////////////	///////////////	///////////////	///////////////
	#pragma mark Test applyOrderKeys:
	anAction = [anAction applyOrderKeys:orderKey, orderKey2, nil];
	GHAssertNotNil( anAction, @"'applyOrderKeys:' MUST return a non nin object");
	GHAssertEqualObjects( anAction, action, @"'applyOrderKeys:' MUST return itselfs");

	sorter = [[anAction sortDescriptors] objectAtIndex:0];
	GHAssertEqualObjects( sorter.key, orderKey, @"Added key isn't correctly");
	sorter = [[anAction sortDescriptors] objectAtIndex:1];
	GHAssertEqualObjects( sorter.key, orderKey2, @"Added key isn't correctly");

	///////////////	///////////////	///////////////	///////////////
	#pragma mark Test ascendingOrder property replacing NSSortDescriptor's
	BOOL newOrder = !action.ascendingOrder;
	action.ascendingOrder = newOrder;
	GHAssertEquals( newOrder, action.ascendingOrder, @"'ascendingOrder' property wasn't setted correctly" );

	sorter = [[anAction sortDescriptors] objectAtIndex:0];
	GHAssertEquals( newOrder, sorter.ascending, @"Saved NSSortDescriptor wasn't changed correctly");
	sorter = [[anAction sortDescriptors] objectAtIndex:1];
	GHAssertEquals( newOrder, sorter.ascending, @"Saved NSSortDescriptor wasn't changed correctly");
	
	///////////////	///////////////	///////////////	///////////////
	#pragma mark Test removeOrderKey:
	[anAction removeOrderKey:orderKey];
	GHAssertTrue( 1 == [[anAction sortDescriptors] count], @"'removeOrderKey:' doesn't remove one item");
	
	sorter = [[anAction sortDescriptors] objectAtIndex:0];
	GHAssertEqualObjects( sorter.key, orderKey2, @"Removed key isn't correctly");
}

-(void)testCreateAndDelete {
	// Create New Record.
	MyEntity *record = [action createNewRecordForEntity:entity];
	GHAssertNotNil( record, @"'createNewRecordForEntity:' doesn't create an object" );
	// Delete it.
	[action deleteRecord:record andCommit:YES];
}	

-(void)testRunAction {
	// Create New Record.
	MyEntity *record = [action createNewRecordForEntity:entity];
	GHAssertNotNil( record, @"'createNewRecordForEntity:' doesn't create an object" );
	record.name = @"Name";
	record.code = @"Code";
	[DBManager commit];
	
	// Apply Action Data.
	[[[action applyEntity:entity] applyFetchTemplate:fetchTemplate] applyOrderKeys: orderKey, orderKey2, nil];
	
	// Run the action.
	NSArray *result = [action runAction];
	GHAssertNotNil( result, @"Action returns an NIL result");
	GHAssertTrue( 1 == [result count], @"Action doesn't return correct number of itens");

	// Delete it.
	[action deleteRecord:record andCommit:YES];
}

////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// 
#define testFailure( __action ) 	GHAssertThrowsSpecificNamed( __action,\
																 NSException,\
																 JPDBManagerActionException,\
															 	 @"Operation must fail!");
-(void)testFailures {	
	testFailure( [action runAction] );
	testFailure( [action applyArrayOfSortDescriptors:[NSArray arrayWithObject:orderKey]] );
	testFailure( [action applyOrderKey:orderKey] );
	testFailure( [action addOrderKey:orderKey] );
}

@end