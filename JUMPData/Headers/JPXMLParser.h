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
#import "JPXMLParser.h"

typedef struct JPXMLParserElement {
	__unsafe_unretained id object;
	__unsafe_unretained NSString* name;
} JPXMLParserElement;

/**
 * JPXMLParser is a simple XML parser. It only parse XML documents into a <tt>NSDictionary</tt> or <tt>NSArray</tt>.
 * It does not support any fanciness like Namespaces, DTDs, etc. Also this class has not been optimized for speed
 * or memory usage, and for small XML files.
 * <p>
 * JPXMLParser is an subclass of <a href="http://developer.apple.com/library/mac/#documentation/Cocoa/Reference/Foundation/Classes/NSXMLParser_Class/Reference/Reference.html">NSXMLParser</a>,
 * see more documentation about this class for more information.
 * <p>
 * When a duplicate key is encountered, the key's value is turned into an array 
 * and both the original item and the new duplicate item are added to the array, as follow:
 * \code
 * <root>
 *   <element>
 *       <data>Element 1</data>
 *   </element>
 *   <element>
 *       <data>Element 2</data>
 *   </element>
 * </root> 
 * \endcode
 * Will become an <tt>NSDictionary</tt> as follow:
 * \code
 * Dictionary = { root: [ {data: "element1"}, {data: "element2"} ] }
 * \endcode
 * <p>
 * <b>Attributes will be included on the Dictionary, as follow:</b>
 * \code
 * <root>
 *    <element attribute="value1">
 *         Element value.
 *    </element>
 * </root>
 * \endcode
 * Will become an <tt>NSDictionary</tt> as follow:
 * \code
 * Dictionary = { root: { element: { attribute: "value1", element: "Element value." } } }
 * \endcode
 * <br>
 * <br>
 */
@interface JPXMLParser : NSXMLParser <NSXMLParserDelegate> {
    NSError * __autoreleasing *errorPointer;
	
	id              _parsedObject;
	
	NSMutableArray* _objectStack;
	NSMutableArray* _objectStackName;
}

/** 
 * Will return an <tt>NSDictionary</tt> or <tt>NSArray</tt> after successful parsing (After the <tt>parse</tt> method is executed).
 */
@property (nonatomic, readonly) id    parsedObject;

/**
 * Parse an XML from a file to an <tt>NSDictionary</tt> or <tt>NSArray</tt>.
 * @param fileURL An <tt>NSURL</tt> specifying an file with XML data.
 * @param errorPointer An <tt>NSError</tt> pointer. If some XML parser error ocurr will fill this pointer.
 * @return An <tt>NSDictionary</tt> or <tt>NSArray</tt> with parsed data.
 */
+ (id)convertFromXMLFile:(NSURL *)fileURL error:(NSError **)errorPointer;

/**
 * Parse an XML from a <tt>NSData</tt> representation to an <tt>NSDictionary</tt> or <tt>NSArray</tt>.
 * @param data An <tt>NSData</tt> specifying the XML data to parse.
 * @param errorPointer An <tt>NSError</tt> pointer. If some XML parser error ocurr will fill this pointer.
 * @return An <tt>NSDictionary</tt> or <tt>NSArray</tt> with parsed data.
 */
+ (id)convertFromXMLData:(NSData *)data error:(NSError **)errorPointer;

/**
 * Parse an XML from a <tt>NSString</tt> representation to an <tt>NSDictionary</tt> or <tt>NSArray</tt>.
 * @param data An <tt>NSString</tt> specifying the XML data to parse.
 * @param errorPointer An <tt>NSError</tt> pointer. If some XML parser error ocurr will fill this pointer.
 * @return An <tt>NSDictionary</tt> or <tt>NSArray</tt> with parsed data.
 */
+ (id)convertFromXMLString:(NSString *)string error:(NSError **)errorPointer;

@end
