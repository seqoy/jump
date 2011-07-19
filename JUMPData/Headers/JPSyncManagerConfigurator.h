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
#import "JPSyncManagerHandler.h"
#import "JPSyncConfigModel.h"
#import "JPXMLParser.h"
#import "JPDBManager.h"

/// /// /// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ///
#define JPSyncManagerConfiguratorException @"JPSyncManagerConfiguratorException"
#define JPSyncManagerLoadXMLException @"JPSyncManagerLoadXMLException"
/// /// /// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ///
@class JPDBManagerSingleton;

/*
 * \nosubgrouping 
 */
@interface JPSyncManagerConfigurator : NSObject {

	//// //// //// //// //// //// //// //// //// //// ////
	// Bridget Data.
	NSMutableDictionary *maps;
	NSMutableDictionary *configs;
	NSArray *readKeyOrder;
	
	//// //// //// //// //// //// //// //// //// //// 
	// Database Manager.
	JPDBManagerSingleton *databaseManager;
}
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark Properties.
@property(assign) JPDBManagerSingleton* databaseManager;

@property(retain) NSMutableDictionary *maps;
@property(retain) NSMutableDictionary *configs;
@property(retain) NSArray *readKeyOrder;

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Init Methods. 
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// /
/** @name Init Methods
 */
///@{ 

/**
 * Init the Manager Configurator 
 */
+(id)init;

/**
 * Init the Manager Configurator and load configurations from external XML file.<br>
 * Please refer to JPSyncManagerConfigurator documentation to see how to write this XML file.
 * @param anFileURL An <tt>NSURL</tt> with the path of the file to load.
 * @thrown JPSyncManagerLoadXMLException if can't load or parse the XML file.
 */
+(id)initAndConfigureFromXMLFile:(NSURL*)anFileURL;

///@}
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Build Manager.
/** @name Build Manager Method.
 */
///@{ 

-(JPSyncManagerHandler*)getManager;

///@}
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Add Data Methods. 
//// //// //// //// //// //// //// //// //// //// //// //// //// //// ////
/** @name Add Data Methods.
 */
///@{ 

/**
 * Load configurations from external XML file.<br>
 * Please refer to JPSyncManagerConfigurator documentation to see how to write this XML file.
 * @param anFileURL An <tt>NSURL</tt> with the path of the file to load.
 * @thrown JPSyncManagerLoadXMLException if can't load or parse the XML file.
 */
-(void)loadConfigurationFromXMLFile:(NSURL*)anFileURL;

/**
 * TODO: Missing desc.
 * @param anMap An <tt>NSMutableDictionary<tt> with map definitions.
 * @param anMapName An <b>unique</b> name to identify this map.
 */
-(void)addMap:(NSMutableDictionary *)anMap withName:(NSString *)anMapName;

/**
 * TODO: Missing desc.
 */
-(void)configWithModel:(JPSyncConfigModel*)anModel;

/**
 * TODO: Missing desc. Prefered Key 
 Order to Process
 */
-(void)setPreferedKeyOrderToProcess:(NSArray*)orderArray;

///@}
@end
