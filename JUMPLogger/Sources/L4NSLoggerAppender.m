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
#import "L4NSLoggerAppender.h"

@implementation L4NSLoggerAppender
@synthesize shouldLogExceptions, shouldLogTrace;

//////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// 
#pragma mark -
#pragma mark Init Methods.
//////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// 
- (id) initWithLayout:(L4Layout *)aLayout {
	self = [self init];
	if (self != nil) {
		[self setLayout: aLayout];
		
		//////////// //////////// //////////// //////////// //////////// 
		// Create and remember the logger instance.
		logger = LoggerInit();
		
		// Default Configuration.
		[self setOptions:kLoggerOption_BufferLogsUntilConnection |
						 kLoggerOption_BrowseBonjour |
						 kLoggerOption_BrowseOnlyLocalDomain];
		
		// Log Everything.
		shouldLogTrace = shouldLogExceptions = YES;
		
		// Configure the logger.
		LoggerStart(logger);
	}
	return self;
}

//////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// 
// Appends an event to the log.
- (void) append: (L4LoggingEvent *)anEvent {
	
	// Translate logger level to NSLogger constants.
	int nsloggerLogLevel = [JPLog4CocoaFactory convertL4Level:anEvent.level] - 1;
	
	//////////// //////////// ///////////// //////////// ///////////// //////////// 
	// Format Message base.
	NSMutableString *anMessage;
	anMessage = [NSMutableString stringWithString:[layout format: anEvent]]; 

	//////////// //////////// ///////////// //////////// ///////////// //////////// 
	// Exception attached ans Ok to print it.
	if ( anEvent.exception && shouldLogExceptions ) {
		// Add Exceptions Info.
		[anMessage appendFormat:@"Exception '%@' with reason '%@'.\n", anEvent.exception.name, anEvent.exception.reason];
		
		// Should print stack?
		if ( shouldLogTrace ) 
			for ( NSString* item in [anEvent.exception callStackSymbols] ) 
				[anMessage appendFormat:@"	   %@\n", item];
	}
	
	// //////////// ///////////// //////////// ///////////// //////////// 
	// Domain.
	NSString *domain = [[[anEvent.logger name] stringByReplacingOccurrencesOfString:@"." withString:@"/"] lastPathComponent];
	
	//////////// //////////// ///////////// //////////// ///////////// //////////// 
	// Log.
	LogMessageToF_va(logger,								// NSLogger to log.
					 [anEvent.fileName UTF8String],			// File Name.
					 [anEvent.lineNumber intValue],			// Line Number.
					 [anEvent.methodName UTF8String],		// Method Name.
					 domain,								// Domain (Class Name).  @Todo: something.
					 nsloggerLogLevel,						// Log Level
					 anMessage, nil);						// Formatted Message.
}

//////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// 
-(void)setOptions:(uint32_t)options {
	LoggerSetOptions(logger, options);
}

//////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// 
#pragma mark -
#pragma mark Dealloc Methods.
//////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// 
- (void) dealloc {
	LoggerStop( logger );
}


@end
