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
void JPLogIfYouCan( SEL method, NSString* message, NSException* anException  ) {
	#ifdef JPLOGGER_FACTORY_CLASS
		// Get Logger.
		id logger = [JPLOGGER_FACTORY_CLASS getLogger];

		//// //// //// //// /// //// //// //// //// ///
		// If not defined.
		if ( !logger )
			[NSException raise:@"JPLoggerException" format:@"Factory doesn't return an logger!"];

		//// //// //// //// /// //// //// //// //// ///
		// Must implement the Logger Factory Interface.
		if ( ! [logger conformsToProtocol:@protocol(JPLoggerFactoryInterface)] ) {
			[NSException raise:@"JPLoggerException" format:@"Logger Factory doesn't implement the 'JPLoggerFactoryInterface' protocol."];
	
		//// //// //// //// //// //// ///
		// Logger with Exception.
		if (anException)
			[logger performSelector:method withObject:message withObject:anException];

		//// //// //// //// //// //// ///
		// Logger without Exception.
		else
			[logger performSelector:method withObject:message];
	#endif
	// If isn't setted, do nothing.
}
