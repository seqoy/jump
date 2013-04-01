/*
 * Copyright (c) 2013 - SEQOY.org and Paulo Oliveira ( http://www.seqoy.org )
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
#import "JPPropertyDescriptor.h"

@implementation JPPropertyDescriptor
@synthesize propertyClass, propertyName, propertyValue, propertyEncode;


-(BOOL)propertyIsAnObject {
    return (propertyClass != nil);
}

-(char *)cEncode {
    return (char*)[propertyEncode bytes];
}

//////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// ////////////
#pragma mark -
#pragma mark Property Helpers.
//////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// ////////////
-(BOOL)isBoolean {
    
    if (!propertyEncode) return NO;
    
    //////// /////// /////// /////// /////// /////// /////// ///////
    // BOOL attribute code.
    char *objC_bool_encode = @encode(BOOL);
    char attribute_bool_encode[sizeof(objC_bool_encode)+1];
    strcpy(attribute_bool_encode, "T");
    strcat(attribute_bool_encode, objC_bool_encode);
    
    /////// /////// /////// /////// /////// /////// /////// /////// ///////
    // Compare two codes.
    return ( strcmp([self cEncode], attribute_bool_encode) == 0 );  // 0 means equal.
}

//////////// //////////// //////////// //////////// //////////// //////////// //////////// ////
// Check is is of informed class.
-(BOOL)isOfClass:(Class)anClass {
    return ( self.propertyClass == anClass );
}

//////////// //////////// //////////// //////////// //////////// //////////// //////////// ////
// Check if the stored property is of Class NSString.
-(BOOL)isString {
    return [self isOfClass:[NSString class]];
}

//////////// //////////// //////////// //////////// //////////// //////////// //////////// ////
// Check if the stored property is of Class NSDate.
-(BOOL)isDate {
    return [self isOfClass:[NSDate class]];
}

//////////// //////////// //////////// //////////// //////////// //////////// //////////// ////
// Check if the stored property is of Class NSArray.
-(BOOL)isArray {
    return [self isOfClass:[NSArray class]];
}

//////////// //////////// //////////// //////////// //////////// //////////// //////////// ////
// Check if the stored property is of Class NSNumber.
-(BOOL)isNumber {
    return [self isOfClass:[NSNumber class]];
}

//////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// ////////////
#pragma mark -
#pragma mark Memory Methods.
//////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// ////////////
- (void)dealloc
{
    [propertyClass release];
    [propertyValue release];
    [propertyName release];
    [propertyEncode release];
    [super dealloc];
}
@end
