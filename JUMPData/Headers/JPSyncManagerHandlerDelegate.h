/// /// /// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ///
//
//	SEQOY™ Development and Consulting
//	Copyright © 2011, SEQOY™ Development. All rights reserved.
//	http://www.seqoy.com
//
///////////////
//
//	History:
//
//	27/01/11 --- Created v.2.0 - Working as a pipeliner handler.
//
/// /// /// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ///
#import <Foundation/Foundation.h>

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// ////
@protocol JPSyncManagerHandlerDelegate
@optional

/**
 * Advise that the Sync Manager Will Start to Process.
 */
-(void)syncManagerWillStartToProcess;

/**
 * Advise that the Sync Manager Will Start to Process some specific server key.
 */
-(void)syncManagerWillStartToProcessTheKey:(NSString*)anKey;

/**
 * Advise that the Sync Manager Will Start to Process some specific server key.
 * If you gonna update some object or commit some change you should use this manager,
 * because all operation is used on a separate DB Manager in the background thread.
 */
-(void)syncManagerWillStartToProcessTheKey:(NSString*)anKey inDatabaseManager:(JPDBManager*)dbManager;

/**
 * Advise that the Sync Manager did Finish to Process.
 */
-(void)syncManagerDidFinishToProcess;

/**
 * Advise that the Sync Manager did Finish to Process some specific server key.
 */
-(void)syncManagerDidFinishToProcessTheKey:(NSString*)anKey;

/**
 * Advise that the Sync Manager Will Start to Process some specific server key.
 * If you gonna update some object or commit some change you should use this manager,
 * because all operation is used on a separate DB Manager in the background thread.
 */
-(void)syncManagerDidFinishToProcessTheKey:(NSString*)anKey inDatabaseManager:(JPDBManager*)dbManager;


//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// ////
#pragma mark -
#pragma mark Delete warnings.

/**
 * Will delete some object.
 */
- (void)willDeleteTheObject:(id)object ofEntity:(NSString*)entity;

/**
 * Did delete some object.
 */
- (void)didDeleteOneObjectOfEntity:(NSString*)entity;

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// ////
#pragma mark -
#pragma mark Insert warnings.

/**
 * Warn that will insert some data.
 */
- (void)willInsertTheData:(id)object inEntity:(NSString*)entity;

/**
 * Warn that will update some data.
 */
- (void)willUpdateTheData:(id)object inObject:(id)object forEntity:(NSString*)entity;

/**
 * Did Update or Insert some object.
 */
- (void)didUpdateOrInsertTheObject:(id)object withData:(id)data forEntity:(NSString*)entity;

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// ////
#pragma mark -
#pragma mark Insert warnings.

/**
 * Warn that will insert some data. Optionally send the JPDBManager that this object was created.
 * If you gonna update this object you should use this manager, 
 * because all operation is used on a separate DB Manager in the background thread.
 */
- (void)willInsertTheData:(id)object inEntity:(NSString*)entity inDatabaseManager:(JPDBManager*)dbManager;

/**
 * Warn that will update some data. Optionally send the JPDBManager that this object was created.
 * If you gonna update this object you should use this manager,
 * because all operation is used on a separate DB Manager in the background thread.
 */
- (void)willUpdateTheData:(id)object inObject:(id)object forEntity:(NSString*)entity inDatabaseManager:(JPDBManager*)dbManager;

/**
 * Did Update or Insert some object. Optionally send the JPDBManager that this object was created.
 * If you gonna update this object, if you gonna update this object you should use this manager,
 * because all operation is used on a separate DB Manager in the background thread.
 */
- (void)didUpdateOrInsertTheObject:(id)object withData:(id)data forEntity:(NSString*)entity inDatabaseManager:(JPDBManager*)dbManager;


//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// ////
#pragma mark -
#pragma mark Progress.

/**
 * Implement this method to keep progress of the sync operation. 
 * This method will receive a float value from 0 to 100 informing the percentage
 * completed of the sync task. <b>This method always will be called on the Main Thread.</b>
 */
-(void)syncOperationProgress:(NSNumber*)progress;

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// ////
#pragma mark -
#pragma mark Unhandled Actions

/**
 * Sync can't handle this action, can you?
 */
- (void)unhandledAction:(NSString*)action withData:(id)data serverDataKey:(NSString*)serverKey;

/**
 * Sync can't handle this key, can you?
 */
- (void)unhandledServerKey:(NSString*)key withData:(id)data;
- (void)unhandledServerKey:(NSString*)key withData:(id)data inDatabaseManager:(JPDBManager*)dbManager;

@end
