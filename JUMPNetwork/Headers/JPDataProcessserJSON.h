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

/**
 * An JSON processer interface. Should be implemented by some wrapper that process JSON decode and encode.
 */
@protocol JPDataProcessserJSON
@required

/**
 * Convert from JSON String to an Object.
 * @param anJSONString An JSON String to be converted.
 * @return Could be a string, number, boolean, null, array or dictionary.
 */
+(id)convertFromJSON:(NSString*)anJSONString;


/**
 * Convert from JSON Data (NSData) to an Object.
 * @param anJSONData An NSData object with the JSON to be converted.
 * @return Could be a string, number, boolean, null, array or dictionary.
 */
+(id)convertFromJSONData:(NSData*)anJSONData;

/**
 * Convert an Dictionary to an JSON String. Not human readable.
 * @param anJSONDictionary An dictionary to be converted.
 * @return A non human readable string.
 */
+(NSString*)convertToJSON:(NSDictionary*)anJSONDictionary;

/**
 * Convert an Dictionary to an JSON String.
 * @param anJSONDictionary An dictionary to be converted.
 * @param humanReadable If is an "human readable" string or not.
 */
+(NSString*)convertToJSON:(NSDictionary*)anJSONDictionary humanReadable:(BOOL)humanReadable;

@end
