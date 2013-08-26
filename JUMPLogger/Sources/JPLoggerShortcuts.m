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
#import "JPLoggerShortcuts.h"

//// //// //// //// //// //// //// //// //// //// //// ///
void JPLogIfYouCan( SEL method, const char *file, NSString* domain, Class logToClass, id caller, NSString *anMethodName, int lineNumber, NSString* message, NSException* anException ) {

	// Compiler condition to disable all logs.
	#ifndef JPLOGGER_DISABLE_ALL
	
		// Get Factory Class.
		Class loggerFactoryClass = [JUMPLoggerConfig loggerFactoryClass];
	
		//// //// //// //// /// //// //// //// //// ///
		// If not defined, do nothing.
		if ( !loggerFactoryClass )
			return;
	
		//// //// //// //// /// //// //// //// //// ///
		// Must implement the Logger Factory Interface.
		if ( ! [loggerFactoryClass conformsToProtocol:@protocol(JPLoggerFactoryInterface)] ) {
			[NSException raise:@"JPLoggerException"
						format:@"Logger Factory doesn't implement the 'JPLoggerFactoryInterface' protocol."];
		}
			
		//// //// //// //// /// //// //// //// //// ///
		// Retrieve the logger.
		id<JPLoggerInterface> logger = [loggerFactoryClass getLogger];
	
		//// //// //// //// /// //// //// //// //// ///
		// If doesn't return an logger, do nothing.
		if ( logger == nil )
			return;

		/// //// //// /// //// //// //// //// ///
		// If some domain specified, set log for this domain.
		if ( domain ) 
			[logger setKeyForLog:domain];

		/// //// //// /// //// //// //// //// ///
		// If no domain specified, use set log to specific class.
		else 
			[logger setKeyForLog:logToClass];

		//// //// //// //// /// //// //// //// //// ///
		// Create Log Metadata.
		JPLoggerMetadata *metadata = [JPLoggerMetadata initWithMessage:message];
	
		metadata.caller		= caller;
		metadata.domain		= domain;
		metadata.fileName   = [NSString stringWithUTF8String:file];
		metadata.className  = NSStringFromClass(logToClass);
		metadata.methodName = anMethodName;
		metadata.lineNumber = [NSNumber numberWithInt:lineNumber];
		metadata.exception  = anException;

		//// //// //// //// //// //// ///
		// Log.
		[(id)logger performSelector:method withObject:metadata];
    
        // Release metadata.
	#endif
}
