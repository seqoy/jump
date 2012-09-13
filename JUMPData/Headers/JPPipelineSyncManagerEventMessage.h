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
//	26/01/11 --- Created by Paulo Oliveira
// 
/// /// /// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ///
#import <Foundation/Foundation.h>
#import "JPSyncManagerHandlerEvent.h"
#import "JPPipelineDowstreamMessageEvent.h"
#import "JPPipelineFutureListener.h"
#import "JPPipelineFuture.h"

/// /// /// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ///
/**
 * The default upstream Mesaage Event implementation.
 */
@interface JPPipelineSyncManagerEventMessage : JPPipelineDowstreamMessageEvent <JPSyncManagerHandlerEvent> {
	NSString *syncEntityKey;
	NSArray  *parameters;
}
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark Properties.
@property (copy)   NSString *syncEntityKey; 
@property (retain) NSArray  *parameters;

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Init Methods. 
+(id)initWithEntityKey:(NSString*)anKey withParameters:(NSMutableArray*)arrayOfParameters;
+(id)initWithEntityKey:(NSString*)anKey withParameters:(NSMutableArray*)arrayOfParameters withFuture:(id<JPPipelineFuture>)anFuture;
-(id)initWithEntityKey:(NSString*)anKey withParameters:(NSMutableArray*)arrayOfParameters withFuture:(id<JPPipelineFuture>)anFuture;

@end
