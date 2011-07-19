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
#import "JPXMLProcesser.h"

////////////// ////////////// ////////////// ////////////// 
@implementation JPXMLProcesser

////////////// ////////////// ////////////// ////////////// 
// Convert from XML String to an Dictionary Object.
+(id)convertFromXML:(NSString*)anXMLString {
	// If some error ocurr will store here.
	NSError *parseError = nil;
	
	// Parse.
	id result = [JPXMLParser convertFromXMLString:anXMLString error:&parseError];
	
	// Some error? Raise exception.
	if ( parseError ) {
		NSException *exception = [NSException exceptionWithName:parseError.domain
														 reason:[parseError localizedDescription]
													   userInfo:[NSDictionary dictionaryWithObject:parseError forKey:@"parserError"]    // Store the NSError.
								  ];
		[exception raise];
	}
	
	// Return parsed.
	return result;
}

////////////// ////////////// ////////////// ////////////// 
// Convert to an Dictionary to an XML String.
+(NSString*)convertToXML:(NSDictionary*)anXMLDictionary {
	// Not supported.
	[NSException raise:NSObjectNotAvailableException format:@"JPXMLProcesser doesn't support convert to XML."];
	return nil;
}
@end
