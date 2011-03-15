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
#import "JPJSONProcesser.h"

////////////// ////////////// ////////////// ////////////// 
@implementation JPJSONProcesser

////////////// ////////////// ////////////// ////////////// 
// Convert from JSON String to an Dictionary Object.
+(id)convertFromJSON:(NSString*)anJSONString {
	SBJsonParser *anProcesser = [[[SBJsonParser alloc] init] autorelease];
	return [anProcesser objectWithString:anJSONString];
}

////////////// ////////////// ////////////// ////////////// 
// Convert to an Dictionary to an JSON String. Not human readable.
+(NSString*)convertToJSON:(NSDictionary*)anJSONDictionary {
	return [JPJSONProcesser convertToJSON:anJSONDictionary humanReadable:NO];
}

////////////// ////////////// ////////////// ////////////// 
// Convert an Dictionary to an JSON String. Human readable or not defined by parameter.
+(NSString*)convertToJSON:(NSDictionary*)anJSONDictionary humanReadable:(BOOL)humanReadable {
	SBJsonWriter *anProcesser = [[[SBJsonWriter alloc] init] autorelease];
	anProcesser.humanReadable = humanReadable;
	return [anProcesser stringWithObject:anJSONDictionary];
}

@end
