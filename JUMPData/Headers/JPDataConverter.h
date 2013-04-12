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
#import <Foundation/Foundation.h>

/**
 * \nosubgrouping 
 * This class contains an collection of methods to convert different Objective C objects.
 */
@interface JPDataConverter : NSObject {}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Setters and Getters.
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// /
/** @name Setters and Getters
 */
///@{ 

/**
 * Set the collection of knowed date formats used to "try to convert".
 * You could add new elements to this array or replace it to add your own formats.
 * @param knowedDateFormats An array of knowed date formats. 
  \see #knowedDateFormats 
 */
+(void)setKnowedDateFormats:(NSMutableArray*)knowedDateFormats;

/**
 * Retrieve the collection of knowed date formats used to "try to convert". The default knowed
 * formats are:
 *		- @"yyyy-MM-dd HH:mm:ss"<br>
 *
 *		- @"yyyy-MM-dd"<br>
 *
 *		- @"YYYY-MM-DD HH:MM:SS ±HHMM"<br>
 * @return An array with all setted formats.
 */
+(NSMutableArray*)knowedDateFormats;

///@}
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// /
#pragma mark -
#pragma mark Convert Methods. 
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// ///
/** @name Convert Methods
 */
///@{ 

/**
 * Take an <b>NSNumber</b> or <b>NSString</b> Object and try to convert to <b>NSDate</b>.
 * The convertion is performed based on one Array of knowed formats.
 * See #knowedDateFormats property for more inforation.
 *
 * @param anObject An <b>NSNumber</b> or <b>NSString</b> Object and try to convert to <b>NSDate</b>.
 * @return Converted object or if an conversion isn't possible will return <b>nil</b>.
 */
+(NSDate*)convertToNSDateThisObject:(id)anObject;

/**
 * Take an <b>NSNumber</b> or <b>NSString</b> Object and try to convert to <b>NSDate</b>.
 * The convertion is performed based on one Array of knowed formats.
 * See #knowedDateFormats property for more inforation.<br>
 *<br>
 * This method also accept one additional format that will be processed but not added to the
 * "knowed formats" array.
 * @param anObject An <b>NSNumber</b> or <b>NSString</b> Object and try to convert to <b>NSDate</b>.
 * @param anDateFormatter An additional format.
 * @return Converted object or if an conversion isn't possible will return <b>nil</b>.
 */
+(NSDate*)convertToNSDateThisObject:(id)anObject withAdditionalDateFormat:(NSString*)anDateFormatter;

/**
 * Take an <b>NSNumber</b> or <b>NSString</b> Object and try to convert to <b>NSDate</b>.
 * The convertion is performed using the "Date Format" parameter informed.
 *
 * @param anObject An <b>NSNumber</b> or <b>NSString</b> Object and try to convert to <b>NSDate</b>.
 * @param anDateFormatter An date format.
 * @return Converted object or if an conversion isn't possible will return <b>nil</b>.
 */
+(NSDate*)convertToNSDateThisObject:(id)anObject withDateFormat:(NSString*)anDateFormatter;

/**
 * Take an <b>NSString</b> Object that suppoed to be a Internet Date and Time string (RFC822 or RFC3339)
 * and try to convert to <b>NSDate</b>.
 * More info of this date formats at RFC822  http://www.ietf.org/rfc/rfc822.txt 
 * and RFC3339 http://www.ietf.org/rfc/rfc3339.txt
 * @param anDateString An <b>NSString</b> Object and try to convert to <b>NSDate</b>.
 * @return Converted object or if an conversion isn't possible will return <b>nil</b>.
 */
+(NSDate*)convertToNSDateThisInternetDateTimeString:(NSString *)anDateString;

/**
 * Take an <b>NSString</b> Object and try to convert to <b>NSNumber</b>.
 * @param anObject An <b>NSString</b> to try to convert.
 * @return Converted object or if an conversion isn't possible will return <b>nil</b>.
 */
+(NSNumber*)convertToNSNumberThisObject:(id)anObject;

/**
 * Take an <b>NSNumber</b> or <b>NSDate</b> Object and try to convert to <b>NSString</b>. 
 * @param anObject An <b>NSNumber</b> or <b>NSDate</b> to try to convert.
 * @return Converted object or if an conversion isn't possible will return <b>nil</b>.
 */
+(NSString*)convertToNSStringThisObject:(id)anObject;

/**
 * This method convert an <b>Java Util Date Dictionary</b> to <b>NSDate</b>.
 * Usually used to decode this kind of date paserd from a <b>JSON Object</b>.<br>
 * <br>
 * Check this post for more information: http://weblogs.asp.net/bleroy/archive/2008/01/18/dates-and-json.asp
 * <br>
 * @param anObject An object to try to convert.
 * @return This method actually test if needs an conversion and converts if needed. If no convertion
 * is needed will return the object passed as parameter with no changes.
 */
+(id)convertFromJavaUtilDateIfNeeded:(id)anObject;

/**
 * Not implementend.
 */
//+(id)convertToJavaUtilDateIfNeeded:(id)anObject;

///@}
@end

