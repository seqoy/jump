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
#import <Foundation/Foundation.h>

/**
 * \nosubgrouping
 * JPPropertyDescriptor is used by JPDataPopulator to better describe an property of some Class.
 */
@interface JPPropertyDescriptor : NSObject {
    Class propertyClass;
    id propertyValue;
    NSString *propertyName;
    NSData *propertyEncode;
}

/**
 * The <tt>Class</tt> of this property. If is the property is an <tt>iVar</tt> this value is <tt>nil</tt>.
 */
@property (retain) Class propertyClass;

/**
 * The value setted on this property.
 */
@property (retain) id propertyValue;

/**
 * The name of this property.
 */
@property (retain) NSString *propertyName;

/**
 * An <tt>NSData</tt> object that has an Obj-C encode value of this property. You can use the <tt>@encode</tt> compiler expresion
 * to retrieve the encode of some Obj-C type and compare. This class implement some methods that will help you to easily
 * check more used types without so much boilerplate.
 */
@property (retain) NSData *propertyEncode;

/**
 * Return <tt>YES</tt> if this property is an Object (inherited from NSObject).
 */
-(BOOL)propertyIsAnObject;

/**
 * Return the <tt>propertyEncode</tt> data as an <tt>char *</tt> value. This is
 * useful to use the compiler <tt>@encode</tt> function to perform quick tests.
 */
-(char *)cEncode;

//////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// ////////////
#pragma mark -
#pragma mark Property Helpers.
//////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// ////////////

/**
 * Check if the store property is the same of the informed <tt>Class</tt>.
 */
-(BOOL)isOfClass:(Class)anClass;

/**
 * Check if the stored property is of type <tt>BOOL</tt>. This method check the <tt>propertyEncode</tt> against the <tt>BOOL</tt> ObjC type.
 */
-(BOOL)isBoolean;

/**
 * Check if the stored property is of Class <tt>NSString</tt>.
 */
-(BOOL)isString;

/**
 * Check if the stored property is of Class <tt>NSDate</tt>.
 */
-(BOOL)isDate;

/**
 * Check if the stored property is of Class <tt>NSArray</tt>.
 */
-(BOOL)isArray;

/**
 * Check if the stored property is of Class <tt>NSNumber</tt>.
 */
-(BOOL)isNumber;



@end
