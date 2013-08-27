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
#import "JPCore.h"
#import "JPDBManagerAction.h"
#import "JPDBManager.h"
#import "JPDBManagerDefinitions.h"

///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// /////
@implementation JPDBManagerAction

///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// 
#pragma mark -
#pragma mark Properties.
///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// 
@synthesize returnObjectsAsFault, returnActionAsArray, ascendingOrder, commitTransaction;
@synthesize limitFetchResults = fetchLimit, startFetchInLine = fetchOffset;

@synthesize entity, fetchTemplate, variablesListAndValues, sortDescriptors, predicate;
@synthesize manager;

////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// 
#pragma mark -
#pragma mark Init Methods.
////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// 
+(id)initWithManager:(JPDBManager*)anManager {
	return [[self alloc] initWithManager:anManager];
}
////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// 
-(id)initWithManager:(JPDBManager*)anManager {
	self = [super init];
	if (self != nil) {
		
		// Initializations.
		self.manager = anManager;
		[self resetDefaultValues];
	}
	return self;
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Getters and Setters.
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
-(void)setAscendingOrder:(BOOL)newValue {
	// If no changes, do nothing..
	if ( self.ascendingOrder == newValue )
		return;

	// Sorter descriptors can't be changed once it's created, so we'll allocate everybody again.
	NSMutableArray *newSorters = [NSMutableArray arrayWithCapacity:[sortDescriptors count]];

	// Recreate...
	for ( NSSortDescriptor *sorter in sortDescriptors ) {
		
		// Alloc new sorter with same values except order and store it.
		[newSorters addObject:[NSSortDescriptor sortDescriptorWithKey:sorter.key 
															ascending:newValue 
															 selector:sorter.selector]];
	}
	
	// Store new sorters.
	sortDescriptors = newSorters;
	
	// New General value.
	ascendingOrder = newValue;
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Private Methods. 
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
-(JPDBManager*)getManagerOrDie {
	if ( ! self.manager ) {
		[NSException raise:JPDBManagerActionException
					format:@"You must define an Database Manager before perform any action."];
		return nil;
	}
	
	// Return instance.
	return manager;
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
-(BOOL)existEntity:(NSString*)anEntityName {
	return [[self getManagerOrDie] existEntity:anEntityName];
}
-(BOOL)existAttribute:(NSString*)anAttributeName inEntity:(NSString*)anEntityName {
	return [[self getManagerOrDie] existAttribute:anAttributeName inEntity:anEntityName];
}
-(void)throwExceptionWithCause:(NSString*)anCause {
	[NSException raise:JPDBManagerActionException format:@"%@", anCause];
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Memory Management Methods. 
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -

#define JPDatabaseCreateArrayOfKeys( ____listName, ____arrayName, ____entityName  ) \
												NSMutableArray *____arrayName = [[NSMutableArray alloc] init];\
												va_list args;\
												va_start(args, ____listName);\
												for (id arg = ____listName; arg != nil; arg = va_arg(args, id))\
												{\
												if ( _NOT_ [self existAttribute:arg inEntity:____entityName] ) \
												{	\
													[self throwExceptionWithCause:NSFormatString( @"The attribute '%@' doesn't exist on '%@' Entity.", arg, ____entityName)];\
												}\
												[____arrayName addObject:[[NSSortDescriptor alloc] initWithKey:arg ascending:ascendingOrder]];\
												}\
												va_end(args);\


//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 

#define JPDatabaseCreateDictionaryOfVariables( ____listName, ____dictionaryName  ) \
												NSMutableDictionary *____dictionaryName = [[NSMutableDictionary alloc] init];\
												id value = nil;\
												va_list args;\
												va_start(args, ____listName);\
												for (id arg = ____listName; arg != nil; arg = va_arg(args, id))\
												{\
												if	( _NOT_ value ) { value = arg; }\
												else { [____dictionaryName setObject:value forKey:arg]; value = nil; }\
												}\
												va_end(args);

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Fetch Data Methods With Custom Predicates.
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 

-(id)queryEntity:(NSString*)anEntityName withPredicate:(NSPredicate*)anPredicate {
	return [self queryEntity:anEntityName withPredicate:anPredicate orderWithKey:nil];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-(id)queryEntity:(NSString*)anEntityName withPredicate:(NSPredicate*)anPredicate orderWithKey:(id)anKey {
	return [self queryEntity:anEntityName withPredicate:anPredicate orderWithKeys:anKey, nil];	
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-(id)queryEntity:(NSString*)anEntityName withPredicate:(NSPredicate*)anPredicate orderWithKeys:(id)listOfKeys, ... {
	
	// Create one Array of Sort Descriptors.
	JPDatabaseCreateArrayOfKeys( listOfKeys, arrayOfSorter, anEntityName );
	
	//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
	
	// Call Next Processing.
	return [self queryEntity:anEntityName withPredicate:anPredicate arrayOfSortDescriptors:arrayOfSorter ];
	
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
-(id)queryEntity:(NSString*)anEntityName withPredicate:(NSPredicate*)anPredicate arrayOfSortDescriptors:(NSArray*)anArrayOfSortDescriptors {
	
	return [self queryEntity:anEntityName withFetchTemplate:nil replaceFetchWithDictionary:nil 
	  arrayOfSortDescriptors:anArrayOfSortDescriptors customPredicate:anPredicate];
	
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Fetch Data Methods. 
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 

-(id)queryAllDataFromEntity:(NSString*)anEntityName {
	return [self queryEntity:anEntityName withFetchTemplate:nil];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-(id)queryAllDataFromEntity:(NSString*)anEntityName orderWithKey:(id)anKey {
	return [self queryAllDataFromEntity:anEntityName orderWithKeys:anKey, nil];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-(id)queryAllDataFromEntity:(NSString*)anEntityName orderWithKeys:(id)listOfKeys, ... {
	
	// Create one Array of Sort Descriptors.
	JPDatabaseCreateArrayOfKeys( listOfKeys, arrayOfSorter, anEntityName );
	
	//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
	
	// Call Next Processing.
	return [self queryEntity:anEntityName 
		   withFetchTemplate:nil
  replaceFetchWithDictionary:nil
 	  arrayOfSortDescriptors:arrayOfSorter ];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-(id)queryEntity:(NSString*)anEntityName withFetchTemplate:(NSString*)anFetchName  {
	return [self queryEntity:anEntityName withFetchTemplate:anFetchName withVariables:nil];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-(id)queryEntity:(NSString*)anEntityName withFetchTemplate:(NSString*)anFetchName orderWithKey:(id)anKey {
	return [self queryEntity:anEntityName withFetchTemplate:anFetchName orderWithKeys:anKey, nil];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-(id)queryEntity:(NSString*)anEntityName withFetchTemplate:(NSString*)anFetchName orderWithKeys:(id)listOfKeys, ... {
	
	// Create one Array of Sort Descriptors.
	JPDatabaseCreateArrayOfKeys( listOfKeys, arrayOfSorter, anEntityName );
	
	//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
	
	// Call Next Processing.
	return [self queryEntity:anEntityName  
		   withFetchTemplate:anFetchName 
  replaceFetchWithDictionary:nil
 	  arrayOfSortDescriptors:arrayOfSorter ];
}

-(id)queryEntity:(NSString*)anEntityName withFetchTemplate:(NSString*)anFetchName orderWithKey:(id)anKey withVariables:(id)variableList, ... {
	
	// Create one Dictionary with Variable Arguments.
	JPDatabaseCreateDictionaryOfVariables( variableList, createdDictionary );
	
	//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
	
	// Call Next Processing.
	return [self queryEntity:anEntityName 
		   withFetchTemplate:anFetchName 
  replaceFetchWithDictionary:createdDictionary 
			   orderWithKeys:anKey, nil];
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-(id)queryEntity:(NSString*)anEntityName withFetchTemplate:(NSString*)anFetchName withVariables:(id)variableList, ...  {
	
	// Create one Dictionary with Variable Arguments.
	JPDatabaseCreateDictionaryOfVariables( variableList, createdDictionary );
	
	//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
	
	// Call Next Processing.
	return [self queryEntity:anEntityName 
		   withFetchTemplate:anFetchName
  replaceFetchWithDictionary:createdDictionary];
	
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-(id)queryEntity:(NSString*)anEntityName withFetchTemplate:(NSString*)anFetchName replaceFetchWithDictionary:(NSDictionary*)anDictionary {
	return [self queryEntity:anEntityName 
		   withFetchTemplate:anFetchName 
  replaceFetchWithDictionary:anDictionary 
	  arrayOfSortDescriptors:nil];
	
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-(id)queryEntity:(NSString*)anEntityName withFetchTemplate:(NSString*)anFetchName replaceFetchWithDictionary:(NSDictionary*)anDictionary orderWithKey:(id)anKey {
	return [self queryEntity:anEntityName 
		   withFetchTemplate:anFetchName
  replaceFetchWithDictionary:anDictionary 
			   orderWithKeys:anKey, nil];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-(id)queryEntity:(NSString*)anEntityName withFetchTemplate:(NSString*)anFetchName 
replaceFetchWithDictionary:(NSDictionary*)anDictionary orderWithKeys:(id)listOfKeys, ... {
	
	// Create one Array of Sort Descriptors.
	JPDatabaseCreateArrayOfKeys( listOfKeys, arrayOfSorter, anEntityName );
	
	//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
	// Call Next Processing.
	return [self queryEntity:anEntityName 
		   withFetchTemplate:anFetchName 
  replaceFetchWithDictionary:anDictionary 	
	  arrayOfSortDescriptors:arrayOfSorter ];
	
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-(id)queryEntity:(NSString*)anEntityName withFetchTemplate:(NSString*)anFetchName 
replaceFetchWithDictionary:(NSDictionary*)anDictionary  arrayOfSortDescriptors:(NSArray*)anArrayOfSortDescriptors {
	
	return [self queryEntity:anEntityName withFetchTemplate:anFetchName replaceFetchWithDictionary:anDictionary 
	  arrayOfSortDescriptors:anArrayOfSortDescriptors customPredicate:nil];
	
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-(id)queryEntity:(NSString*)anEntityName withFetchTemplate:(NSString*)anFetchName 
replaceFetchWithDictionary:(NSDictionary*)anDictionary  arrayOfSortDescriptors:(NSArray*)anArrayOfSortDescriptors
 customPredicate:(NSPredicate*)anPredicate {
	
	// Apply All Data.
	[[[self applyEntity:anEntityName] applyFetchTemplate:anFetchName] applyFetchReplaceWithDictionary:anDictionary];
	[[self applyArrayOfSortDescriptors:anArrayOfSortDescriptors] applyPredicate:anPredicate];
	
	// Perform this action on the mananger.
	return [self runAction];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Perform this action on the manager.
-(id)runAction {
	// This is a private call.
	return [[self getManagerOrDie] performSelector:@selector(performDatabaseAction:)
										withObject:self];
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Set Action Data Methods.

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
-(id)applyEntity:(NSString*)anEntity {
    entity = [anEntity copy];
	return self;
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// ////
-(id)applyFetchTemplate:(NSString*)anFetchRequest {
    fetchTemplate = anFetchRequest;
	return self;
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// ////
-(id)applyFetchReplaceWithDictionary:(NSDictionary*)anDictionary {
    variablesListAndValues = [anDictionary mutableCopy];
	return self;
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// ////
-(id)applyFetchReplaceWithVariables:(id)variableList, ... {

	// Create one Dictionary with Variable Arguments.
	JPDatabaseCreateDictionaryOfVariables( variableList, createdDictionary );
	
	//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// ////
	return [self applyFetchReplaceWithDictionary:createdDictionary];
}	

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// ////
-(id)applyPredicate:(NSPredicate*)anPredicate {
    predicate = anPredicate;
	return self;
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// ////
#pragma mark -
#pragma mark Order Keys Methods
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// ////
-(id)applyOrderKeys:(id)listOfKeys, ... {
	// Must have an entity defined at this point.
	if ( !entity ) 
		[self throwExceptionWithCause:NSFormatString( @"You must define one Entity first. Use [%@ applyEntity:].", NSStringFromClass([self class]))];
	
	// Create one Array of Sort Descriptors.
	JPDatabaseCreateArrayOfKeys( listOfKeys, createdArray, entity );

	// Store it.
	return [self applyArrayOfSortDescriptors:createdArray];
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// ////
-(id)applyArrayOfSortDescriptors:(NSArray*)anArray {
	// Check elements.
	for ( id element in anArray ) {
		if ( _NOT_ [element isKindOfClass:[NSSortDescriptor class]] ) {
			NSString *cause = NSFormatString( @"The array passed as parameter on [%@ %@] must contain only 'NSSortDescriptor' objects. An '%@' class object was passed.",
											 NSStringFromClass([self class]),
											 NSStringFromSelector(_cmd), 
											 NSStringFromClass([element class]));
			//// //// //// //// //// ////// //// //// //// //// ////// //// //// //// //// //
			[self throwExceptionWithCause:cause];
		}
	}
	
	//// //// ////// //// //// //// //// ////// //// //// //// //// //
    sortDescriptors = [anArray mutableCopy];
	return self;
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// ////
-(id)applyOrderKey:(id)anKey {
	return [self applyOrderKeys:anKey, nil];
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// ////
-(id)addOrderKey:(id)anKey {
	// Must have an entity defined at this point.
	if ( !entity ) 
		[self throwExceptionWithCause:NSFormatString( @"You must define one Entity first. Use [%@ applyEntity:].", NSStringFromClass([self class]))];
	
	// Check attribute.
	if ( _NOT_ [self existAttribute:anKey inEntity:entity] )
		[self throwExceptionWithCause:NSFormatString( @"The attribute '%@' doesn't exist on '%@' Entity.", anKey, entity)];

	// Alloc if needed it.
	if ( _NOT_ sortDescriptors ) 
		sortDescriptors = [NSMutableDictionary dictionary];
	
	// Add it.
	[sortDescriptors addObject:[NSSortDescriptor sortDescriptorWithKey:anKey ascending:ascendingOrder]];
		
	// Return it self.
	return self;
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// ////
-(void)removeOrderKey:(id)anKey {
	// If are empty, do nothing.
	if ( _NOT_ sortDescriptors _OR_ [sortDescriptors count] == 0 ) 
		return;

	/////////////////
	NSSortDescriptor *found = nil;
	
	//// //// //// //// //// //// //// //// //// //// //// //// //// //// 
	// Search him.
	for ( NSSortDescriptor *sorter in sortDescriptors ) {
		if ( sorter.key == anKey ) {
			found = sorter;
			break;
		}
	}
	
	// //// //// //// //// //// //// //// //// // //// //// //// //// //// //// //// //// 
	// Remove it if found.
	if ( found ) 
		[sortDescriptors removeObject:found];
}
	
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Query Limits.
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
-(void)setStartFetchInLine:(int)anValue setLimitFetchResults:(int)anValue2 {
	fetchLimit = anValue2; fetchOffset = anValue;
}
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
-(void)resetFetchLimits { 	 fetchLimit = fetchOffset = 0; }
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
-(void)resetDefaultValues { 
	//LogWhereCommentTo(SEQOYDBManager, @"Resetting Default Values")
	
	[self resetFetchLimits];
	////
	returnObjectsAsFault = NO;
	ascendingOrder = YES;
	returnActionAsArray = YES;
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Write Data Methods. 
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
// Create and return a new empty Record for specified Entity.
-(id)createNewRecordForEntity:(NSString*)anEntityName {
	// Store the Entity.
	[self applyEntity:anEntityName];
	
	// Perform creation. This is a private call.
	id result = [[self getManagerOrDie] performSelector:@selector(createNewRecordForEntity:)
										withObject:anEntityName];
	
	// Commit after creation if needed.
	if ( commitTransaction )
		[[self getManagerOrDie] commit];
	
	// Return result.
	return result;	
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Remove Data Methods. 
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// ///
// Delete all Records from specified entity.
-(void)deleteAllRecordsFromEntity:(NSString*)anEntityName {
	[self deleteRecordsFromEntity:anEntityName withFetchTemplate:nil];
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// ///
// Delete all records returnedan Fetch Template query for an specified entity.
-(void)deleteRecordsFromEntity:(NSString*)anEntityName withFetchTemplate:(NSString*)anFetchName {
	id entityData = [self queryEntity:anEntityName withFetchTemplate:anFetchName];
	
	/////// /////// /////// /////// /////// /////// /////// 
	// Loop deleting records.
	for ( id object in entityData ) 
		[self deleteRecord:object andCommit:NO];
	
	// Commit after delete if needed.
	if ( commitTransaction )
		 [[self getManagerOrDie] commit];
} 

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
// Delete an record of database. Use the Default Setting to Commit Automatically decision.
-(void)deleteRecord:(id)anObject {
	[self deleteRecord:anObject andCommit:commitTransaction];
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
// Delete an record of database. Inform if commit automatically.
-(void)deleteRecord:(id)anObject andCommit:(BOOL)shouldCommit {
	//LogWhereCommentTo(SEQOYDBManager, NSFormatString( @"Deleting [[%@]] %@", [[anObject objectID] URIRepresentation], (commit ? @"[COMMIT]" : @"") ) )
	
	// Delete Record From Managed Context. This is a private call.
	[[self getManagerOrDie] performSelector:@selector(deleteRecord:) withObject:anObject];

	// Commit if asked...
	if( shouldCommit )
		[[self getManagerOrDie] commit];
}


@end
