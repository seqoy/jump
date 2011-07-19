/// /// /// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ///
//
//	SEQOY™ Development and Consulting
//	Copyright © 2011, SEQOY™ Development. All rights reserved.
//	http://www.seqoy.com
//
//
///////////////
//
//	History:
//
//	27/01/11 --- Created by Paulo Oliveira
//
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// ////
#import "JPPipelineMessageEvent.h"

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
/**
 * A Event which represent the Sync Manager Dowstream Process Event.
 */
@protocol JPSyncManagerHandlerEvent <JPPipelineMessageEvent>
@required

/**
 * Sync Entity Key.
 */
-(NSString*)syncEntityKey;

/**
 * Sync Manager Parameters.
 */
-(NSArray*)parameters;

@end
