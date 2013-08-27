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

@class JPDBManager;

/**
 \class JPDBManagerAction
 \nosubgrouping 
 <b>Database Manager Action</b> pack all data and settings to perform some database operation.
 Database operations isn't called directy to the manager. Instead we create one instance of the JPDBManagerAction class,
 configure the data and settings to perform some <a href="http://en.wikipedia.org/wiki/Create,_read,_update_and_delete">CRUD</a> operation and finally run this action.
 Yes, looks like a lot of work, but actually is not. Let's see some examples:
 \code
 id newRecord = [JPDatabaseManager createNewRecordForEntity:@"MyEntity"];
 \endcode
 This is was really simple, isn't? Let's see this same operation on a more custom fashion:
 \code
 JPDBManagerAction *anAction = [[JPDBManagerSingleton sharedInstance] getDatabaseAction];
 [anAction setCommitTransaction:YES];
 id newRecord = [anAction createNewRecordForEntity:@"MyEntity"];
 \endcode
 Well this looks a litle bit more complicated. Let's understand this two processes: The first one uses the <b>JPDatabaseManager</b>
 convenient macro shortcut that returns an JPDBManagerAction instance and perform this method in only one pass, is pure convenience.
 This macro is declared in the JPDBManagerDefinitions.h file.
 <br>
 <br>
 The second way needs more steps, but you should use that way when you need more control of the all process, for example, you can configure
 if you want to automatically commit the operation or create some more dinamically code on your database operations.
 <br>
 */
@interface JPDBManagerAction : NSObject {
	
	// Manager Instance.
	JPDBManager *__weak manager;
	
	// Fetch Limits.
	int fetchOffset;
	int fetchLimit;
	
	// Order Sequence.
	BOOL ascendingOrder;
	
	// Faults.
	BOOL returnObjectsAsFault;
	
	// Return Result.
	BOOL returnActionAsArray;
	
	// Should commit this transaction.
	BOOL commitTransaction;

	//// //// //// //// //// //// //// //// //// /
	// Action Data.
	NSString *entity;
	NSString *fetchTemplate;
	NSMutableDictionary *variablesListAndValues;
	NSMutableArray *sortDescriptors;
	NSPredicate  *predicate;
}

////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// 
#pragma mark -
#pragma mark Init Methods.
////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// 
/** @name Init Methods
 */
///@{ 

/**
 * Init with an \link JPDBManager Database Manager\endlink to process this Database Action.
 * @param anManager An \link JPDBManager Database Manager\endlin
 * @return An autoreleseable instance.
 */
+(id)initWithManager:(JPDBManager*)anManager;

/**
 * Init with an \link JPDBManager Database Manager\endlink to process this Database Action.
 * @param anManager An \link JPDBManager Database Manager\endlin
 * @return An retained instance.
 */
-(id)initWithManager:(JPDBManager*)anManager;

///@}
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Properties.
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 

/// The entity to perform this action.
@property(readonly) NSString *entity;

/// The Fetch Template to perform this action.
@property(readonly) NSString *fetchTemplate;

/// Values to replace on the pre formatted Fetch Template.
@property(readonly) NSMutableDictionary* variablesListAndValues;

/// Array of Sort Descriptors (<b>NSSortDescriptor</b>) to sort the result of this acion.
@property(readonly) NSMutableArray* sortDescriptors;

@property(readonly) NSPredicate *predicate;

/**
 * Instance of the Manager to perform this Database Action.
 */
@property(weak) JPDBManager *manager;

/**
 * Set if the Manager should commit this transaction immediatelly or not.<br>
 * Default value is <b>NO</b>.
 */
@property(assign) BOOL commitTransaction;

/**
 * Define if the Result objects of some query should be as Core Data Fault.
 * Default value is <b>NO</b>.
 */
@property(assign) BOOL returnObjectsAsFault;

/**
 * Define if the order of the results of some query should be Ascending or Descending.
 * Note that by performance you should set this value before apply any Key sort attribute.
 * You can do it after, but the manager will recreate every sort key again.
 * Default value is <b>YES</b>.
 */
@property(assign,nonatomic) BOOL ascendingOrder;

/**
 * Set if the Result of this action should be an <b>NSArray</b> or an <b>NSFetchedResultsController</b> object.<br>
 * Default value is <b>YES</b>.
 */
@property(assign) BOOL returnActionAsArray;

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Set Query Limits.
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
/** @name Set Query Limits
 */
///@{ 

/**
 * Set the initial row result to return from Query Methods results.
 * Combine this set with the #limitFetchResults property.<br>
 * Default value is <b>0</b>.
 */
@property(assign) int startFetchInLine;

/**
 * Set the maximum rows to return from Query Methods results.
 * Combine this set with the #startFetchInLine property.<br>
 * Default value is <b>0</b>, it means that all rows in the Entity will be retrieved.
 */
@property(assign) int limitFetchResults;

/**
 * Convenient method to set the #startFetchInLine and #limitFetchResults properties at the same time.
 */
-(void)setStartFetchInLine:(int)anValue setLimitFetchResults:(int)anValue2; 

/**
 * Reset the default Fetch Limits values.
 */
-(void)resetFetchLimits;

/**
 * Reset this Action Settings to default values.
 */
-(void)resetDefaultValues;

///@}
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Set Action Data Methods.
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
/** @name Action Data Methods
 */
///@{ 

/**
 * Set an Entity to perform this action.
 * @param anEntityName The Entity Name.
 * @return Return itself.
 */
-(id)applyEntity:(NSString*)anEntity;

/**
 * Set an Fetch Template name to perform this action.
 * @param anFetchRequest An Fetch Template to perform the query.
 * @return Return itself.
 */
-(id)applyFetchTemplate:(NSString*)anFetchTemplate;

/**
 * Set the Values to replace on the pre formatted Fetch Template.
 * @param anDictionary An Dictionary with Keys and Values to replace on the pre formatted Fetch Template
 * @return Return itself.
 */
-(id)applyFetchReplaceWithDictionary:(NSDictionary*)anDictionary;

/**
 * Set the Values to replace on the pre formatted Fetch Template.
 * @param variableList Keys and Values to replace on the pre formatted Fetch Template.<br>
 * <b>Example:</b><br>
 * \code[anAction applyFetchReplaceWithVariables:@"value1", @"key1", @"value2", @"key2", nil];\endcode
 * @return Return itself.
 */
-(id)applyFetchReplaceWithVariables:(id)variableList, ... NS_REQUIRES_NIL_TERMINATION;

-(id)applyPredicate:(NSPredicate*)anPredicate;

/**
 * Run this action on the associated 
 * \ref JPDBManager Database Manager\endlink.
 */
-(id)runAction;

///@}
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Order Keys Methods.
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
/** @name Order Keys Methods
 */
///@{ 

/**
 * Set the Key attributes to sort the result of this acion.
 * @param anArrayOfSortDescriptors An Array with defined <b>NSSortDescriptors</b> to sort the result.
 * @throw An  \ref JPDBManagerActionException exception if the array contains an objects that doesn't is an <b>NSSortDescriptors</b>. See \ref errors for more informations.
 * @return Return itself.
 */
-(id)applyArrayOfSortDescriptors:(NSArray*)anArray;

/**
 * Set the Key attributes to sort the result of this acion.
 * @param listOfKeys Accept one or more Key Attributes to sort the result. Doesn't forget to terminate the list with an 'nil' token.
 * @return Return itself.
 * @throw An  \ref JPDBManagerActionException  exception if the #entity property isn't defined. See \ref errors for more informations.
 */
-(id)applyOrderKeys:(id)listOfKeys, ... NS_REQUIRES_NIL_TERMINATION;

/**
 * Set the Key attribute to sort the result of this acion.
 * @param anKey An Key Attribute to sort the result.
 * @return Return itself.
 * @throw An  \ref JPDBManagerActionException  exception if the #entity property isn't defined. See \ref errors for more informations.
 */
-(id)applyOrderKey:(id)anKey;

/**
 * Add a new Key attribute to sort the result of this action.
 * @param anKey An Key Attribute to sort the result.
 * @return Return itself.
 * @throw An  \ref JPDBManagerActionException  exception if the #entity property isn't defined. See \ref errors for more informations.
 */
-(id)addOrderKey:(id)anKey;

/**
 * Remove an Key attribute from the sorter list.
 * @param anKey An Key Attribute to remove.
 */
-(void)removeOrderKey:(id)anKey;

///@}
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Query All Data Methods.
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
/** @name Query All Data Methods
 */
///@{ 

/**
 * Query all data of the specified Entity.
 * @param anEntityName The Entity Name.
 * @return One unordered collection with queried data Objects. The Class of this collection is setted by #returnQueryAsArray property.
 */
-(id)queryAllDataFromEntity:(NSString*)anEntityName;

/**
 * Query all data of the specified Entity.
 * The #defaultOrderIsAscending property determines if is an Ascending or Descending order.
 * @param anEntityName The Entity Name.
 * @param anKey One Key attribute to sort the result.
 * @return One unordered collection with queried data Objects. The Class of this collection is setted by #returnQueryAsArray property.
 */
-(id)queryAllDataFromEntity:(NSString*)anEntityName orderWithKey:(id)anKey;

/**
 * Query all data of the specified Entity.
 * @param anEntityName The Entity Name.
 * @param listOfKeys Accept one or more Key Attributes to sort the result. Doesn't forget to terminate the list with an 'nil' token.
 * @return One unordered collection with queried data Objects. The Class of this collection is setted by #returnQueryAsArray property.
 */
-(id)queryAllDataFromEntity:(NSString*)anEntityName orderWithKeys:(id)listOfKeys, ... NS_REQUIRES_NIL_TERMINATION;

//@}
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Query Data With Fetch Templates Methods. 
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
/** @name Query Data With Fetch Templates Methods
 */
///@{ 

/**
 * Query specified Entity using one specified Fetch Template name.
 * @param anEntityName The Entity Name.
 * @param anFetchName An Fetch Template to perform the query.
 * @return One unordered collection with queried data Objects. The Class of this collection is setted by #returnQueryAsArray property.
 */
-(id)queryEntity:(NSString*)anEntityName withFetchTemplate:(NSString*)anFetchName;

/**
 * Query specified Entity using one specified Fetch Template name.
 * @param anEntityName The Entity Name.
 * @param anFetchName An Fetch Template to perform the query.
 * @param anKey One Key attribute to sort the result.
 * @return One unordered collection with queried data Objects. The Class of this collection is setted by #returnQueryAsArray property.
 */
-(id)queryEntity:(NSString*)anEntityName withFetchTemplate:(NSString*)anFetchName orderWithKey:(id)anKey;

/**
 * Query specified Entity using one specified Fetch Template name.
 * @param anEntityName The Entity Name.
 * @param anFetchName An Fetch Template to perform the query.
 * @param listOfKeys Accept one or more Key Attributes to sort the result. Doesn't forget to terminate the list with an 'nil' token.
 * @return One unordered collection with queried data Objects. The Class of this collection is setted by #returnQueryAsArray property.
 */
-(id)queryEntity:(NSString*)anEntityName withFetchTemplate:(NSString*)anFetchName orderWithKeys:(id)listOfKeys, ... NS_REQUIRES_NIL_TERMINATION;

//@}
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Query Data With Fetch Templates and Fetch Parameters Methods. 
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
/** @name Query Data With Fetch Templates and Fetch Parameters Methods
 */
///@{ 

/**
 * Query specified Entity using one specified Fetch Template name.
 * @param anEntityName The Entity Name.
 * @param anFetchName An Fetch Template to perform the query.
 * @param variableList Keys and Values to replace on the pre formatted Fetch Template.<br>
 * <b>Example:</b><br>
 * \code[manager queryEntity:@"Entity" 
 *   withFetchTemplate:@"FetchAll"
 *       withVariables:@"value1", @"key1", @"value2", @"key2", nil];\endcode
 * @return One unordered collection with queried data Objects. The Class of this collection is setted by #returnQueryAsArray property.
 */
-(id)queryEntity:(NSString*)anEntityName withFetchTemplate:(NSString*)anFetchName withVariables:(id)variableList, ... NS_REQUIRES_NIL_TERMINATION;

/**
 * Query specified Entity using one specified Fetch Template name.
 * @param anEntityName The Entity Name.
 * @param anFetchName An Fetch Template to perform the query.
 * @param anKey One Key attribute to sort the result.
 * @param variableList Keys and Values to replace on the pre formatted Fetch Template.<br>
 * <b>Example:</b><br>
 * \code[manager queryEntity:@"Entity" 
 *   withFetchTemplate:@"FetchAll"
 *        orderWithKey:@"id" 
 *       withVariables:@"value1", @"key1", @"value2", @"key2", nil];\endcode
 * @return One unordered collection with queried data Objects. The Class of this collection is setted by #returnQueryAsArray property.
 */
-(id)queryEntity:(NSString*)anEntityName withFetchTemplate:(NSString*)anFetchName orderWithKey:(id)anKey withVariables:(id)variableList, ... NS_REQUIRES_NIL_TERMINATION;

/**
 * Query specified Entity using one specified Fetch Template name.
 * @param anEntityName The Entity Name.
 * @param anFetchName An Fetch Template to perform the query.
 * @param variablesListAndValues An Dictionary with Keys and Values to replace on the pre formatted Fetch Template.
 * @return One unordered collection with queried data Objects. The Class of this collection is setted by #returnQueryAsArray property.
 */
-(id)queryEntity:(NSString*)anEntityName withFetchTemplate:(NSString*)anFetchName replaceFetchWithDictionary:(NSDictionary*)variablesListAndValues;

/**
 * Query specified Entity using one specified Fetch Template name.
 * @param anEntityName The Entity Name.
 * @param anFetchName An Fetch Template to perform the query.
 * @param variablesListAndValues An Dictionary with Keys and Values to replace on the pre formatted Fetch Template.
 * @param anKey One Key attribute to sort the result.
 * @return One unordered collection with queried data Objects. The Class of this collection is setted by #returnQueryAsArray property.
 */
-(id)queryEntity:(NSString*)anEntityName withFetchTemplate:(NSString*)anFetchName replaceFetchWithDictionary:(NSDictionary*)variablesListAndValues orderWithKey:(id)anKey;

/**
 * Query specified Entity using one specified Fetch Template name.
 * @param anEntityName The Entity Name.
 * @param anFetchName An Fetch Template to perform the query.
 * @param variablesListAndValues An Dictionary with Keys and Values to replace on the pre formatted Fetch Template.
 * @param listOfKeys Accept one or more Key Attributes to sort the result. Doesn't forget to terminate the list with an 'nil' token.
 * @return One unordered collection with queried data Objects. The Class of this collection is setted by #returnQueryAsArray property.
 */
-(id)queryEntity:(NSString*)anEntityName withFetchTemplate:(NSString*)anFetchName replaceFetchWithDictionary:(NSDictionary*)variablesListAndValues orderWithKeys:(id)listOfKeys, ... NS_REQUIRES_NIL_TERMINATION;

/**
 * Query specified Entity using one specified Fetch Template name.
 * @param anEntityName The Entity Name.
 * @param anFetchName An Fetch Template to perform the query.
 * @param variablesListAndValues An Dictionary with Keys and Values to replace on the pre formatted Fetch Template.
 * @param anArrayOfSortDescriptors An Array of Key attributes to sort the result.
 * @return One unordered collection with queried data Objects. The Class of this collection is setted by #returnQueryAsArray property.
 */
-(id)queryEntity:(NSString*)anEntityName withFetchTemplate:(NSString*)anFetchName replaceFetchWithDictionary:(NSDictionary*)variablesListAndValues  arrayOfSortDescriptors:(NSArray*)anArrayOfSortDescriptors;

-(id)queryEntity:(NSString*)anEntityName withFetchTemplate:(NSString*)anFetchName replaceFetchWithDictionary:(NSDictionary*)variablesListAndValues  arrayOfSortDescriptors:(NSArray*)anArrayOfSortDescriptors customPredicate:(NSPredicate*)anPredicate;

//@}
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Query Data Methods With Custom Predicates.
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
/** @name Query Data Methods With Custom Predicates
 */
///@{ 

/**
 * Query specified Entity using one custom NSPredicate Object.
 * @param anEntityName The Entity Name.
 @ @param anPredicate An <b>NSPredicate</b> object defining the query.
 * @return One unordered collection with queried data Objects. The Class of this collection is setted by #returnQueryAsArray property.
 */
-(id)queryEntity:(NSString*)anEntityName withPredicate:(NSPredicate*)anPredicate;

/**
 * Query specified Entity using one custom NSPredicate Object.
 * @param anEntityName The Entity Name.
 * @param anPredicate An <b>NSPredicate</b> object defining the query.
 * @param anKey One Key attribute to sort the result.
 * @return One unordered collection with queried data Objects. The Class of this collection is setted by #returnQueryAsArray property.
 */
-(id)queryEntity:(NSString*)anEntityName withPredicate:(NSPredicate*)anPredicate orderWithKey:(id)anKey;

/**
 * Query specified Entity using one custom NSPredicate Object.
 * @param anEntityName The Entity Name.
 * @param anPredicate An <b>NSPredicate</b> object defining the query.
 * @param listOfKeys Accept one or more Key Attributes to sort the result. Doesn't forget to terminate the list with an 'nil' token.
 * @return One unordered collection with queried data Objects. The Class of this collection is setted by #returnQueryAsArray property.
 */
-(id)queryEntity:(NSString*)anEntityName withPredicate:(NSPredicate*)anPredicate orderWithKeys:(id)listOfKeys, ... NS_REQUIRES_NIL_TERMINATION;

/**
 * Query specified Entity using one custom NSPredicate Object.
 * @param anEntityName The Entity Name.
 * @param anPredicate An <b>NSPredicate</b> object defining the query.
 * @param anArrayOfSortDescriptors An Array of Key attributes to sort the result.
 * @return One unordered collection with queried data Objects. The Class of this collection is setted by #returnQueryAsArray property.
 */
-(id)queryEntity:(NSString*)anEntityName withPredicate:(NSPredicate*)anPredicate arrayOfSortDescriptors:(NSArray*)anArrayOfSortDescriptors;

//@}
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Remove Data Methods. 
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
/** @name Remove Data Methods
 */
///@{ 

/**
 * Delete specified Record from his Entity on the Database.
 * This method will use the #commitTransaction property to decide if commit automatically this change.
 * @param anObject Record object to delete.
 */
-(void)deleteRecord:(id)anObject;

/**
 * Delete specified Record from his Entity on the Database.
 * @param anObject Record object to delete.
 * @param commit Specify if you want to commit or not this operation immediattelly.
 */
-(void)deleteRecord:(id)anObject andCommit:(BOOL)commit;

/**
 * Delete all records queried by the specified Fetch Template.
 * This method will use the #commitTransaction property to decide if commit automatically this change.
 * @param anEntityName The Entity Name.
 * @param anFetchName An Fetch Template to perform the query.
 */
-(void)deleteRecordsFromEntity:(NSString*)anEntityName withFetchTemplate:(NSString*)anFetchName; 

/**
 * Delete all Records from specified Entity.
 * This could be a consuming operation on large databases.
 * @param anEntityName The Entity Name.
 */
-(void)deleteAllRecordsFromEntity:(NSString*)anEntityName;

//@}
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Write Data Methods. 
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
/** @name Write Data Methods
 */
///@{ 

/**
 * Create and return a new record for specified Entity.
 * @param anEntityName The Entity Name.
 * @return New empty Record.
 */
-(id)createNewRecordForEntity:(NSString*)anEntityName;

//@}
@end
