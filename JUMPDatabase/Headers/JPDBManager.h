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
#import <UIKit/UIKit.h>
#import "JPDBManagerDefinitions.h"

// Logger.
#import "JPLogger.h"

// Thread Safe Extension
#import "IAThreadSafeContext.h"
#import "IAThreadSafeManagedObject.h"

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
	
	NSString *loadedModelName;
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
 * Current full path of Loaded Model. If you don't specify one model manually using startCoreDataWithModel:
 * this value will be <tt>nil</tt>.
 */
@property (readonly) NSString *loadedModelName;

/**
 * Configure the manager to automatically commit every operation.
 * Default value is <b>NO</b>. See \subpage basic_uses for more information.
 * 
 */
//See \ref commit_operation for more information.<br>
@property(assign) BOOL automaticallyCommit;

/**
 * Set as 'YES' to enable thread safe operation in the Database Manager. This method will use 'coredata-threadsafe' extension to
 * Core Data that provides drop-in replacements for the standard (non-thread-safe) classes.
 * 
 * If you enabled this option, you should be aware that at least some caveats/limitations have been identified.
 * Please refer to https://github.com/adam-roth/coredata-threadsafe documentation.
 */
@property(assign) BOOL enableThreadSafeOperation;

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
 * Start Core Data elements (managedObjectModel, managedObjectContext, persistentStoreCoordinator) and
 * <b>will merge ALL models</b> in your bundle.<br>
 * Database Manager initiate the Managed Object Context and set the <b>Merge Policy</b>
 * to <tt><b>NSMergeByPropertyObjectTrumpMergePolicy</b></tt> in 
 * order to merge conflicts between the persistent store’s version of the object and the current in-memory 
 * version, giving priority to in-memory changes.<br>
 * <br>
 * Use #startCoreDataWithModel: if you need to use an specific model or model version.
 * @throw An \ref JPDBManagerStartException exception is raised if some error ocurrs. See \ref errors  
 * for more informations.
 * @return Return itself.
 */ 
-(id)startCoreData;

/** 
 * Start Core Data elements (managedObjectModel, managedObjectContext, persistentStoreCoordinator). Database Manager initiate
 * the Managed Object Context and set the <b>Merge Policy</b> to <tt><b>NSMergeByPropertyObjectTrumpMergePolicy</b></tt> in 
 * order to merge conflicts between the persistent store’s version of the object and the current in-memory 
 * version, giving priority to in-memory changes.<br>
 * You should inform the Model that you want to use with name and extension. 
 * <br>
 * @param modelName Specific Model Name including the extension. Usually the model has the extension .momd on the bundle.
 * @throw An \ref JPDBManagerStartException exception is raised if some error ocurrs. See \ref errors  for more informations.
 * @return Return itself.
 */ 
-(id)startCoreDataWithModel:(NSString*)modelName;

/** 
 * Close Core Data Databases, commit pendent updates and release resources.
 */ 
-(void)closeCoreData;

/**
 * Close Core Data and remove the persistent store.
 */
-(void)removePersistentStore;

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

/**
 * Return an NSURL object that contains where the SQLite file is located.
 */
-(NSURL*)SQLiteFilePath;

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
