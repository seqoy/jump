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
#import "JPSyncManagerHandler.h"
#import "JPSyncConfigModel.h"
#import "JPDBManagerAction.h"

/// /// /// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ///
// Convenient macro shortcut that returns an JPDBManagerAction instance. 
#define JPLocalDBManager [_backgroundThreadDatabaseManager getDatabaseAction]

/// /// /// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ///
@implementation JPSyncManagerHandler
@synthesize  maps, configs, readKeyOrder, delegate, currentProgress;
@synthesize databaseManager = _backgroundThreadDatabaseManager;

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Init Methods. 
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
+(id)init {
	// Invalid Constructor.
	[NSException raise:@"NSInvalidConstructor" format:@"Invalid use of constructor. Please use [%@ initWithMaps:andConfigs:]", NSStringFromClass([self class]) ];
	return nil;
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
+(id)initWithMaps:(NSMutableDictionary*)anMaps andConfigs:(NSMutableDictionary*)anConfigs {
	return [[[self alloc] initWithMaps:anMaps andConfigs:anConfigs] autorelease];
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// /
-(id)initWithMaps:(NSMutableDictionary*)anMaps andConfigs:(NSMutableDictionary*)anConfigs { 
	self = [super init];
	if (self != nil) {
		// Correct parameters.
		if (anMaps == nil) {
			[NSException raise:NSInvalidArgumentException format:@"Maps Dictionary is null."];
        }
		if (anConfigs == nil) {
			[NSException raise:NSInvalidArgumentException format:@"Configs Dictionary is null."];
        }
		
		////// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// 
		// Retain values.
		self.maps	  = anMaps;
		self.configs  = anConfigs;
	}
	return self;
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
// Attach one Database Manager.
-(void)attachMainDatabaseManager:(JPDBManager*)anManager {
    if ( _mainThreadDatabaseManager )
        [_mainThreadDatabaseManager release];
    _mainThreadDatabaseManager = [anManager retain];
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Private Methods. 
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
-(NSMutableDictionary*)getMapNamed:(NSString*)anName {
	NSMutableDictionary *anMap = [maps objectForKey:anName];
	
	// Warn if doesn't exist.
	if ( anMap == nil ) 
		Warn( @"The map '%@' doesn't exist. Ignoring...", anName );
	
	// Return data.
	return anMap;
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
-(JPSyncConfigModel*)getConfigModelForKey:(NSString*)anKey {
	
	// Retrieve the configuration model.
	JPSyncConfigModel *config = (JPSyncConfigModel*)[configs objectForKey:anKey]; 
	
	// Check if exist this configuration.
	if ( config == nil ) {
		Warn( @"The key '%@' isn't configured. Ignoring...", anKey );
	}
	
	// Return Model.
	return config;
}
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
-(NSMutableDictionary*)grabAnMapForKey:(NSString*)anKey {
	
	// Retrieve the configuration for this Map.
	JPSyncConfigModel *config = [self getConfigModelForKey:anKey];
	
	// If doesn't exist, do nothing.
	if ( config == nil )
		return nil;

	//// //// //// //// //// //// //// //// //// //// //// ///
	// Get the map.
	NSMutableDictionary *anMap = [self getMapNamed:config.map];

	// Return the data.
	return anMap;
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
-(NSString*)grabDeleteKeyFromConfiguredKey:(NSString*)anKey {

	// Retrieve the configuration model.
	JPSyncConfigModel *config = [self getConfigModelForKey:anKey];
	
	// Check if exist this configuration.
	if ( config == nil ) 
		return nil;
	
	// Return deleteKey, if exist.
	return config.deleteKey;
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
-(NSString*)grabUpdateKeyFromConfiguredKey:(NSString*)anKey {
	
	// Retrieve the configuration model.
	JPSyncConfigModel *config = [self getConfigModelForKey:anKey];
	
	// Check if exist this configuration.
	if ( config == nil ) 
		return nil;
	
	// Return updateKey, if exist.
	NSString *updateKey = config.updateKey;
	
	// Throw ERROR if not exist.
	if ( ! updateKey ) {
		[NSException raise:JPSyncManagerHandlerException
					format:@"**Update Key doesn't exist for configured Key: %@", anKey];
	}
	
	return updateKey;
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
-(NSMutableDictionary*)createNewFullCopyOfDictionary:(NSMutableDictionary *)anDictionary {
	
	// Create a empty dictionary
	NSMutableDictionary *copiedDictionary = [NSMutableDictionary new];
	
	// Loop on all elements.
	for ( id key in anDictionary ) {
		
		//// //// //// //// //// //// //// //// //// //// //// //
		
		// Test if this element are one class of Dictionary.
		if ( [ [anDictionary objectForKey:key] isMemberOfClass: [NSDictionary class] ] ||
			 [ [anDictionary objectForKey:key] isMemberOfClass: [NSMutableDictionary class] ] ) {
			
			// Call this same method to convert this class of Dictionary.
			NSMutableDictionary *convertedObject = [self createNewFullCopyOfDictionary:[anDictionary objectForKey:key]];

            // Converted are autoreleseable.
            [convertedObject autorelease];
			
			//// //// //// //// //// //// //// //// //// //// //// //
			
			// Use setObject to set this converted element.
			[copiedDictionary setObject:convertedObject forKey:key ];
			
			// If not, just add on the new Dictionary.
		} else {
			
			// Copy this element. 
			[copiedDictionary setObject:[[[anDictionary objectForKey:key] mutableCopy] autorelease] forKey:key ]; 
		}
	}
	
	// Return converted dictionary.
	return copiedDictionary;
	
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
//-(NSDictionary*)grabAnBridgedKey:(NSString*)anKey {
//	
//	// Check if this class is bridged.
//	if ( ! [keys objectForKey:anKey] ) {
//		[NSException raise:JPSyncManagerHandlerException
//					format:@"JPSyncManager can't found a bridged class. The Key (%@) isn't bridged.", anKey];
//	}
//	
//	// Return the class data.
//	return [keys objectForKey:anKey];
//}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
-(NSMutableDictionary*)grabAnMapForMethod:(NSString*)anMethodName {
	
	// Check if doesn't exist this map.
	if ( ! [maps objectForKey:anMethodName] ) {
		[NSException raise:JPSyncManagerHandlerException
					format:@"JPSyncManager can't found a map. Map for external method (%@) doesn't exist on mapped methods.", anMethodName];
	}
	
	// Return an copy.
	return [[self createNewFullCopyOfDictionary:[maps objectForKey:anMethodName]] autorelease];
}


//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
-(id)tryToGrabDataKey:(NSString*)anKey fromBridgedMap:(NSDictionary*)bridgedMap {
	
	// Try To Graba Data Key
	NSString *dataKey = [bridgedMap objectForKey:anKey];
	
	// Test if this key exist on map.     
	if ( dataKey )
		return dataKey;
	
	///////////// 	///////////// 	///////////// 	///////////// 	///////////// 	///////////// 
	
	// If don't, fail with error.
	[NSException raise:JPSyncManagerHandlerException
				format:@"Update/Insert data to parse is invalid. Can't found the KEY (%@) on Bridged Map.", anKey];
	
	///
	return nil;
}

//// //// //// //// //// //// //// //// //// //// //// //////// //// //// //// //// //// //// //// //// //// //// ////
-(void)deleteWithData:(id)data withServerKey:(id)serverDataKey {
	
	// Deletion Data should be an ARRAY - with keys to delete. Assert if isn't an Array.
	if ( ! [data isKindOfClass:[NSArray class]] ) {
		[NSException raise:JPSyncManagerHandlerException
					format:@"Delete data to parse is invalid. **DATA should be an ARRAY of values."];
	}
	
	// Grab one map for the current server data packet.
	//NSDictionary *bridgetEntityMap = [self grabAnMapForKey:serverDataKey];
	
	// Delete by Key:
	NSString *deletionKey = [self grabDeleteKeyFromConfiguredKey:serverDataKey];
	
	// Loop deleting using the deletion Key. 
	for ( id value in (NSArray*)data ) {
		
		// Predicate to Query the DB.
		NSPredicate *query = [NSPredicate predicateWithFormat:@"%K == %@", deletionKey, value];
		
		// Grab from DB this object using the key.
		NSArray *result = [JPLocalDBManager queryEntity:[self getConfigModelForKey:serverDataKey].toEntity
									withPredicate:query];
		
		//// //// //// //// //// //// //// //// //// //// //// ////
		// Loop deleting.
		for ( id obj in result ) {
			//////// //////// //////// //////// //////// //////// 
			// Warn delegate that WILL delete.
			if ( delegate )
				if ( [(id)delegate respondsToSelector:@selector(willDeleteTheObject:ofEntity:)] )
					[delegate willDeleteTheObject:obj 
										 ofEntity:[self getConfigModelForKey:serverDataKey].toEntity];
			
			//////// //////// //////// //////// //////// //////// //////// //////// //////// 
			// Delete.
			[JPLocalDBManager deleteRecord:obj];
			
			//////// //////// //////// //////// //////// //////// 
			// Warn delegate that DID delete.
			if ( delegate )
				if ( [(id)delegate respondsToSelector:@selector(didDeleteOneObjectOfEntity:)] )
					[delegate didDeleteOneObjectOfEntity:[self getConfigModelForKey:serverDataKey].toEntity];
			
		}
	}
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Processing Methods. 
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
// Merge the changes performed locally on the Database Manager to another Database Manager attached.
- (void)mergeChanges:(NSNotification *)notification
{
    // If don't have an attached Database Manager to merge, do nothing.
    if ( !_mainThreadDatabaseManager )
        return;
    
    // Retrieve the Managed Object Context from the attached Database Manager.
	NSManagedObjectContext *mainContext = _mainThreadDatabaseManager.managedObjectContext;
	
	// Merge changes into the main context on the main thread.
	[mainContext performSelectorOnMainThread:@selector(mergeChangesFromContextDidSaveNotification:)	
                                  withObject:notification
                               waitUntilDone:YES];
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
// Invoked when the Sync Manager finish to process data.
-(void)processDataFinished {
    
    //// //// //// //// //// //// //// //// //// //// //// //// ////
    // Process Finish only on Main Thread.
    if ([NSThread currentThread] != [NSThread mainThread]) {
        [self performSelectorOnMainThread:@selector(processDataFinished) withObject:nil waitUntilDone:NO];
        return;
    }

    ///// //// //// //// //// //// //// //// //// //// //// //// 
	// Follow the chain.
	[_context sendUpstream:_event];
    
    // Release local retained.
    [(id)_context release];
    [(id)_event release];
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
-(void)processData:(NSDictionary*)resultData {

    //// //// //// //// //// //// //// //// //// //// //// //// ////
    // Create an Autorelease Pool.
    NSAutoreleasePool *anPool = [NSAutoreleasePool new];

    Debug( @"Starting to process...");
    
	//////////// /////////// /////////// /////////// /////////// /////////// /////////// 
	// Warn the delegate that will start to process.
	if ( delegate )
		if ( [(id)delegate respondsToSelector:@selector(syncManagerWillStartToProcess)] )
             [(id)delegate performSelectorOnMainThread:@selector(syncManagerWillStartToProcess)
                                        withObject:nil waitUntilDone:NO];
    

    /////////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// 
    // Create an local Database Manager.
    
    Debug( @"Creating local Database Manager on background thread...");

    // We have one specific model?
    NSString *specificModel;
    
    // We have an Main Database attached?
    if ( _mainThreadDatabaseManager ) {
        // Load the specific model of this manager...
        specificModel = _mainThreadDatabaseManager.loadedModelName;
    }

    // Create local Database Manager.
    _backgroundThreadDatabaseManager = [[JPDBManager init] retain];
    
    // Main Database is using Thread Safe Context?
    _backgroundThreadDatabaseManager.enableThreadSafeOperation = _mainThreadDatabaseManager && _mainThreadDatabaseManager.enableThreadSafeOperation;
    
    // Start Engine.
    // If we have one specific model, load him.
    if ( specificModel ) {
        [_backgroundThreadDatabaseManager startCoreDataWithModel:specificModel];
    } else {
        [_backgroundThreadDatabaseManager startCoreData];
    }
    
    // Set Core Data to merges conflicts between the persistent store’s version of the object 
    // and the current in-memory version, giving priority to in-memory changes.
    [_backgroundThreadDatabaseManager.managedObjectContext setMergePolicy:NSMergeByPropertyObjectTrumpMergePolicy];
	
    //////////// /////////// /////////// /////////// /////////// /////////// /////////// 
    // Start to monitor when the Database Manager perform changes.
	[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(mergeChanges:)
                                                 name:NSManagedObjectContextDidSaveNotification
                                               object:_backgroundThreadDatabaseManager.managedObjectContext];
	
	//// //// //// //// //// //// //// //// //// //// //// ////
	id loopProcessing;
	
	//// //// //// //// //// //// //// //// //// //// //// ////
	// If are defined one ORDERED SEQUENCE to read, we'll force the specified order.
	// Other itens that aren't specified will remain unordered.
	if ( readKeyOrder ) {
		
		// Server Keys (Unordered).
		NSMutableArray* actualKeys = [[[resultData allKeys] mutableCopy] autorelease];
		
		// Remove readKeyOrder elements.
		[actualKeys removeObjectsInArray:readKeyOrder];
		
		// Make a copy of ReadKeyOrder.
		loopProcessing = [[readKeyOrder mutableCopy] autorelease];
		
		// Add Unordered at the bottom.
		[loopProcessing addObjectsFromArray:actualKeys];
	}
	
	/////////// /////////// /////////// /////////// /////////// /////////// 
	// If aren't defined, will process on any order:
	//	  This is because the NSDictionary, doesn't maintain any particular order. 
	//	  So, the order that come from server isn't respected at all
	else {
		loopProcessing = [resultData allPaths];
	}
	
	/////////// /////////// /////////// /////////// /////////// /////////// 
	// Update and Insert of new records, aren't commited at this point.
	// Commit are an expensive processing to do for every record.
	// So we keep the changes on memory, and commit at the end of the loop.
	_backgroundThreadDatabaseManager.automaticallyCommit = NO;
    
	//// //// //// //// //// //// //// //// //// //// //// ////
	Debug( @"Looping Data Packets.");
	//// //// //// //// //// //// //// //// //// //// //// ////
	for ( id serverDataKey in loopProcessing ) {
		
		// Grab one map for the current server data packet.
		NSDictionary *bridgetEntityMap = [self grabAnMapForKey:serverDataKey];
        
        // Get Server Data Key Object Class.
        id object = [resultData objectOnPath:serverDataKey];
        
		// /////////// /////////// /////////// /////////// /////////// 
		// Try...
		if ( bridgetEntityMap						// ...Has an one map for it.
			&& object                               // ...Exist on Server Data Packet.
			) 
		{
            
            // Advise that the Sync Manager Will Start to Process some specific server key.
            if ( delegate ) {
                if ( [(id)delegate respondsToSelector:@selector(syncManagerWillStartToProcessTheKey:)] ) {
                    [delegate syncManagerWillStartToProcessTheKey:serverDataKey];
                }
                if ( [(id)delegate respondsToSelector:@selector(syncManagerWillStartToProcessTheKey:inDatabaseManager:)] ) {
                    [delegate syncManagerWillStartToProcessTheKey:serverDataKey inDatabaseManager:_backgroundThreadDatabaseManager];
                }
            }

			// DB action.
			NSDictionary *databaseActions;

			//// //// //// //// //// //// //// //// //// //// //// ////
			// If Dictionary, we'll check if have an UPDATE / DELETE section.
			if ( [object isKindOfClass:[NSDictionary class] ] ) {
				
				// If no UPDATE / DELETE packets, assume all data as UPDATE.
				if ( ! [object objectForKey:@"update"] && ! [object objectForKey:@"delete"] ) {
					databaseActions = [NSDictionary dictionaryWithObject:object forKey:@"update"];
				} 
				
				/////////// /////////// /////////// /////////// /////////// /////////// /////////// 
				// If have this keys, just assume.
				else {
					databaseActions = object;
				}
			}
			
			//// //// //// //// //// //// //// //// //// //// //// ////
			// If Array, automatically assume as UPDATE.
			else {
				databaseActions = [NSDictionary dictionaryWithObject:object forKey:@"update"];
			}

			//// //// //// //// //// //// //// //// //// //// //// ////
            // Actions to process.
            NSArray *actions = [databaseActions allKeys];
            
            //// //// //// //// //// //// //// //// //// //// //// //////// //// //// //// //// //// //// //// //// //// //// ////
            // For optimization, we do a first query for all lines. 
            // This Query is made using "fault", so we don't load every data to memory.
            JPDBManagerAction *anAction = [_backgroundThreadDatabaseManager getDatabaseAction];
            anAction.returnObjectsAsFault = YES;
            NSArray *allData = [anAction queryAllDataFromEntity:[self getConfigModelForKey:serverDataKey].toEntity];
            
            // If the DB is empty, we don't wave to test for updates.
            BOOL shouldQueryEveryRecord = [allData count] > 0;
            
			//// //// //// //// //// //// //// //// //// //// //// ////
			// Loop on DB Actions.
			for ( NSString *action in actions ) {

                Debug(@"Processing %i records from Server Key: %@", [object count], serverDataKey);
                Debug(@"Exist %i records in the Entity: %@", [allData count], [self getConfigModelForKey:serverDataKey].toEntity);
                
				///////// 	///////// 	///////// 	///////// 	///////// 	///////// 	///////// ///////// 	///////// 	///////// 	///////// 	///////// 	///////// 	///////// 
				// If action are UPDATE (INSERT).
				if ( [action isEqualToString:@"update"] ) {
					
					NSMutableArray* dataPacket = [NSMutableArray array];
					
					id object = [databaseActions objectForKey:action];
					
					// Only process if aren't NIL or NULL (NSNull).
					if( ! object || object != [NSNull null] ) {
						
						//// //// //// //// //// //// //// //// //// //// //// ////
						// If more than one packet of data....
						if ( [object isKindOfClass:[NSArray class] ] ) {
							// Isolate data packet to process.
							dataPacket = object;
							
						}
						
						//// //// //// //// //// //// //// //// //// //// //// ////
						// else.. Just one packet.
						else {
							// Data packet is the result inself.
							[dataPacket addObject:object];
						}
                        
                        //// //// //// //// //// //// //// //// //// //// //// ////
                        // Increment percentage unit.
                        float incrUnit = 100.0 / [loopProcessing count] / [actions count] / [dataPacket count];
						
						//// //// //// //// //// //// //// //// //// //// //// ////
						// Loop all records on this data packet.
						for ( id record in dataPacket ) {
                            
							// Update by value.
							NSString *updateKey = [self grabUpdateKeyFromConfiguredKey:serverDataKey];
							
							// Server value.
							id value = [record objectForKey:updateKey];
							
							// If can't found one value for this Update Key. Throw error.
							if ( !value ) {
								[NSException raise:JPSyncManagerHandlerException
											format:@"**Value for Update Key (%@) is NULL. Probably the result from server doesn't contain this key or his value is NULL.", updateKey];
							}
							
							// Local correspondent key.
							NSString *updateLocalKey = [self tryToGrabDataKey:updateKey
															   fromBridgedMap:bridgetEntityMap];
							
                            
                            ///// /////////// /////////// /////////// /////////// /////////// 
                            // Result init as empty Array.
                            NSArray *result = nil;
                            
                            ///// /////////// /////////// /////////// /////////// /////////// 
                            // Should query to check updates?
                            if ( shouldQueryEveryRecord ) {
                                
                                //// /////////// /////////// ////// /////////// /////////// // /////////// /////////// 
                                // Believe or not is faster to do this kind of search that a Core Data Query.
                                for ( id dataItem in allData ) {
                                    BOOL found = [[dataItem valueForKey:updateLocalKey] isEqual:value];
                                    if ( found ) {
                                        result = [NSArray arrayWithObject:dataItem];
                                        break;
                                    }
                                }
                                
                                /* We're not using this query anym  ore because is too slow.
                                // Predicate to Query the DB.
                                NSPredicate *query = [NSPredicate predicateWithFormat:@"%K == %@", updateLocalKey, value];
                                
                                // Grab from DB this object using the key.
                                result = [JPLocalDBManager queryEntity:[self getConfigModelForKey:serverDataKey].toEntity
                                                     withFetchTemplate:nil
                                            replaceFetchWithDictionary:nil
                                                arrayOfSortDescriptors:nil
                                                       customPredicate:query];
                                 */
                            }
                            
							// Data to Populate.
							id coreDataRecord;
							
							/////////// /////////// /////////// /////////// /////////// /////////// 
							// If dont't exist, create New Record.
							if ( result == nil || [result count] == 0 ) {
								
								//////////// /////////// /////////// /////////// /////////// /////////// /////////// 
								// Warn the delegate that will INSERT data.
								if ( delegate )
									if ( [(id)delegate respondsToSelector:@selector(willInsertTheData:inEntity:)] )
										 [delegate willInsertTheData:record 
														   inEntity:[self getConfigModelForKey:serverDataKey].toEntity ];
								
								//////////// /////////// /////////// /////////// /////////// /////////// /////////// 
								// Create new Core Data record for this entity.
								coreDataRecord = [JPLocalDBManager createNewRecordForEntity:[self getConfigModelForKey:serverDataKey].toEntity];
								
							} 
                            //// //// //// //// //// //// //// //// 
                            // Else Just will update.
							else {
								
								//// //// //// //// //// //// //// //// //// //// 
								// Core Data is the one that was retrieved.
								coreDataRecord = [result objectAtIndex:0];
								
								//////////// /////////// /////////// /////////// /////////// /////////// /////////// 
								// Warn the delegate that will UPDATE data.
								if ( delegate ) {
									if ( [(id)delegate respondsToSelector:@selector(willUpdateTheData:inObject:forEntity:)] )
										[delegate willUpdateTheData:record
														   inObject:coreDataRecord
														  forEntity:[self getConfigModelForKey:serverDataKey].toEntity ];
									if ( [(id)delegate respondsToSelector:@selector(willUpdateTheData:inObject:forEntity:inDatabaseManager:)] )
										[delegate willUpdateTheData:record
														   inObject:coreDataRecord
														  forEntity:[self getConfigModelForKey:serverDataKey].toEntity
                                                  inDatabaseManager:_backgroundThreadDatabaseManager];
                                }
								
							}
							
							// Parse Dictonary Data to Core Data Record.
							coreDataRecord = [JPDataPopulator populateObject:coreDataRecord
																	withData:record
																	usingMap:[self grabAnMapForKey:serverDataKey]];
							
							//////////// /////////// /////////// /////////// /////////// /////////// /////////// 
							// Warn the delegate that will UPDATE data.
							if ( delegate ) {
								if ( [(id)delegate respondsToSelector:@selector(didUpdateOrInsertTheObject:withData:forEntity:)] )
									 [delegate didUpdateOrInsertTheObject:coreDataRecord
																withData:record
															   forEntity:[self getConfigModelForKey:serverDataKey].toEntity ];
                                if ( [(id)delegate respondsToSelector:@selector(didUpdateOrInsertTheObject:withData:forEntity:inDatabaseManager:)] )
                                    [delegate didUpdateOrInsertTheObject:coreDataRecord
																withData:record
															   forEntity:[self getConfigModelForKey:serverDataKey].toEntity
                                                       inDatabaseManager:_backgroundThreadDatabaseManager];

                            }
                            
                            //////////// /////////// /////////// /////////// /////////// /////////// /////////// 
                            // Calculate the progress.
                            float calcProgress = ( currentProgress == nil ? 0.00 : [currentProgress floatValue] ) + incrUnit;
                            if ( currentProgress ) [currentProgress release];
                            currentProgress = [[NSNumber numberWithFloat:calcProgress] retain];
                            
                            // Inform to delegate the progress of our task, if needed.
                            // Performoed in Main Thread.
                            if (delegate)
                                if ([(id)delegate respondsToSelector:@selector(syncOperationProgress:)]) {
                                    [(id)delegate performSelectorOnMainThread:@selector(syncOperationProgress:) 
                                                                   withObject:currentProgress
                                                                waitUntilDone:NO];
                                }
                            
                            // Inform to the context the progress of our handler.
                            [_context setProgress:currentProgress withEvent:_event];
						}
						
					}
				}
				
				///////// 	///////// 	///////// 	///////// 	///////// 	///////// 	///////// ///////// 	///////// 	///////// 	///////// 	///////// 	///////// 	///////// 
				// If action are DELETE.
				else if ( [action isEqualToString:@"delete"] ) {
					[self deleteWithData:[databaseActions objectForKey:action] withServerKey:serverDataKey];
				}
				
				///////// 	///////// 	///////// 	///////// 	///////// 	///////// 	///////// ///////// 	///////// 	///////// 	///////// 	///////// 	///////// 	///////// 
				// Pass action to delegate.
				else {
					if ( delegate )
						if ( [(id)delegate respondsToSelector:@selector(unhandledAction:withData:serverDataKey:)] )
							[delegate unhandledAction:action
											 withData:[databaseActions objectForKey:action]
										serverDataKey:serverDataKey];
				}
			}
            
            // Advise that the Sync Manager Did Finish to Process some specific server key.
            if ( delegate ) {
                if ( [(id)delegate respondsToSelector:@selector(syncManagerDidFinishToProcessTheKey:)] ) {
                    [delegate syncManagerDidFinishToProcessTheKey:serverDataKey];
                }
                
                if ( [(id)delegate respondsToSelector:@selector(syncManagerDidFinishToProcessTheKey:inDatabaseManager:)] ) {
                    [delegate syncManagerDidFinishToProcessTheKey:serverDataKey inDatabaseManager:_backgroundThreadDatabaseManager];
                }
            }
		}
		
		////////// ///////// ///////// ///////// ///////// ///////// ///////// ///////// ///////// ///////// /////////
		// Maybe the delegate can handle it...
		else {
			if ( delegate ) {
				if ( [(id)delegate respondsToSelector:@selector(unhandledServerKey:withData:)] ) {
					 [delegate unhandledServerKey:serverDataKey withData:object];
                }

                if ( [(id)delegate respondsToSelector:@selector(unhandledServerKey:withData:inDatabaseManager:)] ) {
                     [delegate unhandledServerKey:serverDataKey withData:object inDatabaseManager:_backgroundThreadDatabaseManager];
                }
            }
		}
	}
	
	/////////// /////////// /////////// /////////// /////////// /////////// 
	Debug( @"Final Commit of all processing.");
	/////////// /////////// /////////// /////////// /////////// /////////// 
    // Commit all changes.
	[_backgroundThreadDatabaseManager commit];
	
    // Clean up the progress, no operation is running.
    [currentProgress release]; currentProgress = nil;
    
    // Stop listening for notifications.
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    // Release the local Database Manager.
    [_backgroundThreadDatabaseManager release];
    
    //////////// /////////// /////////// /////////// /////////// /////////// ///////////
	// Warn the delegate that did finish to process.
	if ( delegate ) {
		if ( [(id)delegate respondsToSelector:@selector(syncManagerDidFinishToProcess)] )
             [(id)delegate performSelectorOnMainThread:@selector(syncManagerDidFinishToProcess) 
                                           withObject:nil
                                        waitUntilDone:NO];
    }
    
    // Flush and release the Pool.
    [anPool release];
    
    // Nullify after autorelease.
    _backgroundThreadDatabaseManager = nil;
    
    // Finish processing, so we'll pass the control to the next handler.
    [self processDataFinished];
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Methods. 
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
// Invoked when a message object was received.
-(void)messageReceived:(id<JPPipelineHandlerContext>)ctx withMessageEvent:(id<JPPipelineMessageEvent>)e {
	
    // Store the context and the event for later.
    _context = [(id)ctx retain];
    _event   = [(id)e retain];

    // Message to process.
    id message = [e getMessage];

    //// //// //// //// //// //// //// //// //// //// //// //// //// //// //////// //// //// //// //// //// //// ////
    // If we're receiving a JSONRPC Model...
    if ( [message isKindOfClass:[JPJSONRPCModel class]] ) {
        JPJSONRPCModel *model = message;
        
        // If the model contain an ERROR, just pass to the next handler.
        if ( model.error ) {
            [self processDataFinished];
            return;
        }

        // Get the RESULT from the Model and assign as message, we're discarding all other data.
        message = model.result;
    }
    
    //// //// //// //// //// //// //// //// //// //// //// //// //// //// //////// //// //// //// //// //// //// ////
	// Make sure we can handle the message.
	if ( [message isKindOfClass:[NSDictionary class]] ) {
        
        //// //// //// //// //// //// //// //// //// //// //// //// ////
        // Process Message Event Data in background if called from main.
        if ([NSThread currentThread] == [NSThread mainThread])
            [self performSelectorInBackground:@selector(processData:) withObject:(NSDictionary*)message];
        
        // If we're on background, just process.
        else 
            [self processData:(NSDictionary*)message];
	}
    
    //// //// //// //// //// //// //// //// //// //// //// //// //// //// ////
    // If can't just pass to the next handler.
    else 
        [self processDataFinished];
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
// Invoked when some Send data is requested.
//-(void)sendRequestedWithContext:(<JPPipelineHandlerContext>)ctx withMessageEvent:(<JPPipelineMessageEvent>)e {
//	
//	// Make sure we can handle the message.
//	if ([(id)e conformsToProtocol:@protocol( JPSyncManagerHandlerEvent )]) {
//		
//		// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
//		// Cast Message.
//		<JPSyncManagerHandlerEvent> message = (<JPSyncManagerHandlerEvent>)e;
//		
//		// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
//		// Grab Class Data
//		NSDictionary *bridgedClassData = [self grabAnBridgedKey:[message syncEntityKey]];
//	
//		// Grab An Map based on asked class.
//		NSMutableDictionary *anMap = [self grabAnMapForMethod: [bridgedClassData objectForKey:@"method"] ];
//		
//		// Call Processer, pass data.
//		anMap = [JPDataPopulator populateJSONDictionary:anMap withData:[message parameters]];
//		
//		// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
//		// Send Processed Message Downstream.
//		[ctx sendDownstream:[JPJSONRPCEventFactory newEventWithMethod:[bridgedClassData objectForKey:@"method"]
//														andParameters:[NSArray arrayWithObject:anMap]  
//																andId:[NSNumber numberWithInt:1]
//															andFuture:[e getFuture]]];
//	}
//
//	// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
//	// If can't, just send the message DownStream.
//	else
//		[ctx sendDownstream:e];
//}


//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Memory Management Methods. 
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
- (void) dealloc {
	[maps release], maps = nil;
	[configs release], configs = nil;
	[readKeyOrder release], readKeyOrder = nil;
    [currentProgress release], currentProgress= nil;
    [_backgroundThreadDatabaseManager release], _backgroundThreadDatabaseManager = nil;
    [_mainThreadDatabaseManager release];
	[super dealloc];
}

@end
