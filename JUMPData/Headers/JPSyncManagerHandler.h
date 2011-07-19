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
#import "JPSimplePipelineHandler.h"
#import "JPPipelineHandlerContext.h"
#import "JPPipelineMessageEvent.h"
#import "JPDataPopulator.h"
#import "JPDBManager.h"
#import "JPSyncManagerHandlerDelegate.h"
#import "JPSyncManagerHandlerEvent.h"
#import "JPJSONRPCEventFactory.h"

/// /// /// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ///
#define JPSyncManagerHandlerException @"JPSyncManagerHandlerException"
/// /// /// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ///
@interface JPSyncManagerHandler : JPSimplePipelineHandler {
	
	//// //// //// //// //// //// //// //// //// //// ////
	// Bridget Data.
	NSMutableDictionary *maps;
	NSMutableDictionary *configs;
	NSArray *readKeyOrder;

	//// //// //// //// //// //// //// //// //// //// 
	<JPSyncManagerHandlerDelegate> delegate;
	
	//// //// //// //// //// //// //// //// //// //// 
	// Database Manager.
	JPDBManager *databaseManager;
}
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark Properties.
@property(retain) NSMutableDictionary *maps;
@property(retain) NSMutableDictionary *configs;
@property(retain) NSArray *readKeyOrder;

@property(assign) id<JPSyncManagerHandlerDelegate> delegate;

@property(assign) JPDBManager* databaseManager;

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Init Methods. 
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// /
/** @name Init Methods
 */
///@{ 

+(id)initWithMaps:(NSMutableDictionary*)anMaps andConfigs:(NSMutableDictionary*)anConfigs;
-(id)initWithMaps:(NSMutableDictionary*)anMaps andConfigs:(NSMutableDictionary*)anConfigs;

///@}
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Retrieve Data.
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// /
/** @name Retrieve Data
 */
///@{ 

/**
 */
-(NSMutableDictionary*)getMapNamed:(NSString*)anName;

///@}
@end
