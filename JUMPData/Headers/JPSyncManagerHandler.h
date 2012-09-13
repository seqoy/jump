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
#import "JPJSONRPCModel.h"
#import "JPXMLParserXPath.h"

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
	id<JPSyncManagerHandlerDelegate> delegate;
	
    //// //// //// //// //// //// //// //// //// //// 
    //
	// Background thread Database Manager.
    // Our handler uses an internal Database Manager in order to perform
    // operations on a separated Thread.
    // See this article for more info About Core Data and Multithread:
    // http://developer.apple.com/library/ios/#documentation/cocoa/conceptual/CoreData/Articles/cdConcurrency.html
    //
    JPDBManager *_backgroundThreadDatabaseManager;
    
    // Main thread Database Manager is stored here, so we can merge the changes between the two Database Manager later.
    JPDBManager *_mainThreadDatabaseManager;

    //// //// //// //// //// //// //// //// //// //// 
    // Current Progress of running task.
    NSNumber *currentProgress;
    
    // Local storage.
    id<JPPipelineHandlerContext> _context;
    id<JPPipelineMessageEvent> _event;
}
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark Properties.
@property(retain) NSMutableDictionary *maps;
@property(retain) NSMutableDictionary *configs;
@property(retain) NSArray *readKeyOrder;

@property(assign) id<JPSyncManagerHandlerDelegate> delegate;

/**
 * All Core Data operations of JPSyncManagerHandler is performed on a separated thread (background)
 * in order to don't lock the Main Thread (or UI Thread). Our handler uses a internal 
 * <b>Database Manager</b> (JPDBManager) to perform this operations. This property
 * allows you to acess this <b>Database Manager</b>. You always should perform <b>Database Operations</b>
 * using this <b>Database Manager</b>.
 */
@property(readonly) JPDBManager* databaseManager;

/**
 * Progress of current running task. This property contain values from 0 to 100 
 * indicating the percentage completed or <tt>nil</tt> if no task is running.
 */
@property (readonly) NSNumber *currentProgress;

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Init Methods. 
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// /
/** @name Init Methods
 */
///@{ 

+(id)initWithMaps:(NSMutableDictionary*)anMaps andConfigs:(NSMutableDictionary*)anConfigs;
-(id)initWithMaps:(NSMutableDictionary*)anMaps andConfigs:(NSMutableDictionary*)anConfigs;

/**
 * Attach one Database Manager that will be merged 
 * with all operations performed on the local Database Manager on the background 
 * thread when finisehd.
 */
-(void)attachMainDatabaseManager:(JPDBManager*)anManager;

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
