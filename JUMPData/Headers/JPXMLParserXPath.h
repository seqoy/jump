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

/////////// /////////// /////////// /////////// /////////// /////////// /////////// /////////// /////////// /////////// /////////// 
/**
 * Additions for NSDictionary alowwing accessing JPXMLParser results using simplified XPath notation.
 */
@interface NSDictionary (JPXMLAdditions)

/**
 * Locate some specific parsed XML data using a very simplified XPath notation.
 * This simplified version only supports direct path to some specific element. Let's see an example:
 * \code
 * <xml>
 *    <child>
 *       <value>childValue</value>
 *    </child>
 *    <more>
 *       moreValue
 *    </more>
 * </xml>
 * \encode
 * <p>
 * To retrieve the value of <tt><value</tt> item. You use:
 * \code
 * [result XMLObjectOnPath:@"xml/child/value"];
 * \endcode
 */
- (id)objectOnXMLPath:(NSString*)basicPath;

@end