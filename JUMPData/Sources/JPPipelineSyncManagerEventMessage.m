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
#import "JPPipelineSyncManagerEventMessage.h"
/// /// /// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ///
@implementation JPPipelineSyncManagerEventMessage
@synthesize syncEntityKey, parameters;

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Init Methods. 
+(id)initWithEntityKey:(NSString*)anKey withParameters:(NSMutableArray*)arrayOfParameters {
	return [[[self alloc] initWithEntityKey:anKey withParameters:arrayOfParameters withFuture:nil] autorelease];
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
+(id)initWithEntityKey:(NSString*)anKey withParameters:(NSMutableArray*)arrayOfParameters withFuture:(id<JPPipelineFuture>)anFuture {
	return [[[self alloc] initWithEntityKey:anKey withParameters:arrayOfParameters withFuture:anFuture] autorelease];
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
-(id)initWithEntityKey:(NSString*)anKey withParameters:(NSMutableArray*)arrayOfParameters withFuture:(id<JPPipelineFuture>)anFuture {
	self = [super initWithMessage:@"" andFuture:anFuture];
	if (self != nil) {
		// Check Parameters.
		if ( anKey == nil ) {
			[NSException raise:NSInvalidArgumentException format:@"Entity Key is null."];
		}
		if ( arrayOfParameters == nil ) {
			[NSException raise:NSInvalidArgumentException format:@"Parameters is null."];
		}
		
		// Retain values.
		self.syncEntityKey = anKey;
		self.parameters    = arrayOfParameters;
	}
	return self;
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Memory Management Methods. 
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
- (void) dealloc {
	[syncEntityKey release], syncEntityKey = nil;
	[parameters release], parameters = nil;
	[super dealloc];
}

@end
