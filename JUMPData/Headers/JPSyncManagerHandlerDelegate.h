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
 * Advise that the Sync Manager did Finish to Process.
 */
-(void)syncManagerDidFinishToProcess;

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
#pragma mark Unhandled Actions

// Sync can't handle this action, can you?
- (void)unhandledAction:(NSString*)action withData:(id)data serverDataKey:(NSString*)serverKey;

// Sync can't handle this key, can you?
- (void)unhandledServerKey:(NSString*)key withData:(id)data;

@end
