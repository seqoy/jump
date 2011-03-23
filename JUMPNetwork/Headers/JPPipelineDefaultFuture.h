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
//	27/01/11 --- Created by Paulo Oliveira
// 
/// /// /// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ///
#import <Foundation/Foundation.h>
#import "JPPipelineFutureListener.h"
#import "JPPipelineFuture.h"
#import "JPPipelineListener.h"
#import "JPLogger.h"

@interface JPPipelineDefaultFuture : NSObject <JPPipelineFuture> {
	<JPPipelineFutureListener>firstListener;
	NSMutableArray* otherListeners;

	BOOL cancelled;
	BOOL success;
	BOOL started;
	NSError *cause;

    int waiters;
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark Properties.
@property(retain, setter=setFailure, getter=getCause) NSError *cause;

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Init Methods. 
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
+(id)initWithListener:(<JPPipelineFutureListener>)anListener;
@end
