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
#import <CoreData/CoreData.h>
#import "JPDBManagerDefinitions.h"

// Logger.
#import "JPLogger.h"

/**
 * \class JPDBManager
 * \nosubgrouping 
 *
 * Database Manager are one Facade around <b>Core Data</b> classes that 
 * facilitate the main operations around the <b>Core Data Framework<b>.
 * See the \ref basic_uses to learn the basic concepts about this class.
 * Also consult \ref errors and \ref queries.
 */
@class JPDBManagerAction;
@interface JPDBManager : NSObject {
	
	// Core Data Objects.
	NSManagedObjectModel *managedObjectModel;
	NSManagedObjectContext *managedObjectContext;		
	NSPersistentStoreCoordinator *persistentStoreCoordinator;

	// Automatically Commit.
	BOOL automaticallyCommit;
	
	NSString *loadModelNamed;
}
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark Properties.

/**
 * Core Data Managed Object Model
 */
@property(readonly) NSManagedObjectModel *managedObjectModel;

/**
 * Core Data Managed Object Context
 */
@property(readonly) NSManagedObjectContext *managedObjectContext;		

/**
 * Core Data Persistent Store Coordinator
 */
@property(readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

/**
 * Configure the manager to automatically commit every operation.
 * Default value is <b>NO</b>. See \subpage basic_uses for more information.
 * 
 */
//See \ref commit_operation for more information.<br>
@property(assign) BOOL automaticallyCommit;

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Init Methods.
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
/** @name Init Methods
 */
///@{ 

/**
 * Init and Alloc the Database Manager Class. 
 * @return One autoreleseable instance.
 */
+(id)init;

/**
 * Init and Alloc the Database Manager Class. 
 * Automatically Start all Core Data Engine.
 * @return One autoreleseable instance.
 */
+(id)initAndStartCoreData;

///@}
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Start and Stop Methods.
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
/** @name Start and Stop Methods
 */
///@{ 

/** 
 * Start Core Data Databases.
 * Will merge ALL models in your bundle and try to recreate missed parameters.
 * Use #startCoreDataWithModel: if you need to use an specific model.
 * @throw An \ref JPDBManagerStartException  exception is raised if some error ocurrs. See \ref errors  for more informations.
 * @return Return itself.
 */ 
-(id)startCoreData;

/** 
 * Start Core Data Databases. 
 * @param modelName Specific Model Name.
 * @throw An \ref JPDBManagerStartException  exception is raised if some error ocurrs. See \ref errors  for more informations.
 * @return Return itself.
 */ 
-(id)startCoreDataWithModel:(NSString*)modelName;

/** 
 * Close Core Data Databases, commit pendent updates and release resources.
 */ 
-(void)closeCoreData;

///@}
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Get Info Methods. 
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
/** @name Get Info Methods
 */
///@{ 

/**
 * Test if specified Entity exist on the model.
 * @param anEntityName The Entity Name.
 * @return YES if specified Entity exist on the model.
 */
-(BOOL)existEntity:(NSString*)anEntityName;

/**
 * Test if specified Attribute exist on specified Entity.
 * @param anAttributeName The Attribute name.
 * @param anEntityName The Entity name.
 * @return <b>YES</b> if specified Attribute exist on specified Entity.
 */
-(BOOL)existAttribute:(NSString*)anAttributeName inEntity:(NSString*)anEntityName;

/**
 * Helper method to retrieve an \link JPDBManagerAction Database Action\endlink object.
 * The manager is automatically associcated to this object.
 */
-(JPDBManagerAction*)getDatabaseAction;

///@}
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Write Data Methods. 
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
/** @name Write Data Methods
 */
///@{ 

/**
 * Commit al pendent operations to the persistent store.
 */
-(void)commit;

///@}
@end
