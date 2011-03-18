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
void JPLogIfYouCan( SEL method, NSString* message, NSException* anException, Class logToClass  ) {

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

		// Set log to specific class.
		[logger setKeyForLog:logToClass];

		//// //// //// //// //// //// ///
		// Logger with Exception.
		if (anException)
			[(id)logger performSelector:method withObject:anException withObject:message];

		//// //// //// //// //// //// ///
		// Logger without Exception.
		else
			[(id)logger performSelector:method withObject:message];
	#endif
}
