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
#import <GHUnitIOS/GHUnit.h> 
#import "JPXMLDecoderHandler.h"
#import "JPXMLProcesser.h"
#import "JPDefaultHandlerContext.h"
#import "JPPipelineSimpleMessageEvent.h"

/**
 * JUMP Database Module Unit Tests
 */
@interface JUMPXMLDecoderTest : GHTestCase {
	NSString *attributeXML;
	JPDefaultHandlerContext *context;
	JPPipelineSimpleMessageEvent *message;
	JPXMLDecoderHandler *handler;
}
@end

//////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// 
#pragma mark -
@implementation JUMPXMLDecoderTest

//////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// 
#pragma mark -
#pragma mark Tests

// Run at start of all tests in the class
- (void)setUpClass {
	// Configure the Factory Class.
	[JUMPLoggerConfig setLoggerFactoryClass:[JPLog4CocoaFactory class]];
	SetGlobalLogLevel( JPLoggerAllLevel );
}

- (void)setUp {
	// XML.
	attributeXML = @"<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?><root><element attribute1=\"value1\" attribute2=\"value2\"></element></root>";
	
	// Context.
	context = [[[JPDefaultHandlerContext alloc] init] autorelease];
	
	// Message.
	message = [JPPipelineSimpleMessageEvent initWithMessage:attributeXML];
	
	// Handler.
	handler = [JPXMLDecoderHandler initWithXMLDecoderClass:[JPXMLProcesser class]];
}

//////////// //////////// //////////// //////////// //////////// //////////// //
-(void)testHandleXMLData {
	
	// Handle (decode).
	[handler messageReceived:context withMessageEvent:message];
	
	// Decoded is on message, so grab it.
	NSDictionary *result = [message getMessage];
	GHAssertNotNil( result, @"Parse result should't be NULL." );
	
	// Check Dictionary results.
	GHAssertTrue( [result isKindOfClass:[NSDictionary class]], @"Result should be an DICTIONARY.");
	
	// Retrieve first element.
	NSDictionary *first = [result objectForKey:@"root"];
	GHAssertNotNil( first, @"First node 'root' should't be NULL." );
	GHAssertTrue( [first isKindOfClass:[NSDictionary class]], @"First node 'root' should be an DICTIONARY.");
	
	// Retrieve element.
	NSDictionary *element = [first objectForKey:@"element"];
	GHAssertNotNil( element, @"First node 'element' should't be NULL." );
	GHAssertTrue( [element isKindOfClass:[NSDictionary class]], @"Node 'element' should be an DICTIONARY.");
	
	// Check every first node elemenents.
	GHAssertEqualStrings( @"value1", [element objectForKey:@"attribute1"], @"Attribute 'attribute1' wasn't parsed correctly");
	GHAssertEqualStrings( @"value2", [element objectForKey:@"attribute2"], @"Attribute 'attribute2' wasn't parsed correctly");
	
	// Log Result.
	GHTestLog( @"Parsed: %@", result );
}
@end