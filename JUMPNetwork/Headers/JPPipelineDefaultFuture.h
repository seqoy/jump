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
#import "JPPipelineNotification.h"
#import "JPLogger.h"

@interface JPPipelineDefaultFuture : NSObject <JPPipelineFuture> {
	NSMutableArray* listeners;

    // Flalgs.
	BOOL cancelled;
	BOOL success;
	BOOL started;
	NSError *cause;

    // Progress.
    NSNumber *progress;
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark Properties.
@property(nonatomic,retain, setter=setFailure:, getter=getCause) NSError *cause;

@property(nonatomic,copy, getter=getProgress) NSNumber *progress;

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Init Methods. 
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
+(id)initWithListener:(id<JPPipelineFutureListener>)anListener;
@end
