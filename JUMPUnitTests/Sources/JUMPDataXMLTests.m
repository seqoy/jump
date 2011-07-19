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
#import "JPXMLProcesser.h"

/**
 * JUMP Database Module Unit Tests
 */
@interface JUMPDataXMLTests : GHTestCase {}
@end

//////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// 
#pragma mark -
@implementation JUMPDataXMLTests

//////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// 
#pragma mark -
#pragma mark Tests - XML examples from http://www.w3schools.com/xml/xml_examples.asp

-(void)testSimpleXMLParse {
	NSString *simpleXML = @"<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?><!-- Edited by XMLSpy® --><note><to>Tove</to><from>Jani</from><heading>Reminder</heading><body>Don't forget me this weekend!</body></note>";
	NSDictionary *result = [JPXMLProcesser convertFromXML:simpleXML];
	GHAssertNotNil( result, @"Parse result should't be NULL." );

	// Check Dictionary results.
	GHAssertTrue( [result isKindOfClass:[NSDictionary class]], @"Result should be an DICTIONARY.");
	
	// Retrieve first element.
	NSDictionary *first = [result objectForKey:@"note"];
	GHAssertNotNil( first, @"First node 'note' should't be NULL." );
	GHAssertTrue( [first isKindOfClass:[NSDictionary class]], @"First node 'note' should be an DICTIONARY.");

	// Check every first node elemenents.
	GHAssertEqualStrings( @"Tove", [first objectForKey:@"to"], @"Element 'to' wasn't parsed correctly");
	GHAssertEqualStrings( @"Jani", [first objectForKey:@"from"], @"Element 'from' wasn't parsed correctly");
	GHAssertEqualStrings( @"Reminder", [first objectForKey:@"heading"], @"Element 'heading' wasn't parsed correctly");
	GHAssertEqualStrings( @"Don't forget me this weekend!", [first objectForKey:@"body"], @"Element 'body' wasn't parsed correctly");
	
	// Log Result.
	GHTestLog( @"Parsed: %@", result );
}

////////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// ////////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //
-(void)testCatalogXMLParse {
	NSString *catalogXML = @"<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?><!-- Edited by XMLSpy® --><CATALOG><CD><TITLE>Empire Burlesque</TITLE><ARTIST>Bob Dylan</ARTIST><COUNTRY>USA</COUNTRY><COMPANY>Columbia</COMPANY><PRICE>10.90</PRICE><YEAR>1985</YEAR></CD><CD><TITLE>Hide your heart</TITLE><ARTIST>Bonnie Tyler</ARTIST><COUNTRY>UK</COUNTRY><COMPANY>CBS Records</COMPANY><PRICE>9.90</PRICE><YEAR>1988</YEAR></CD><CD><TITLE>Greatest Hits</TITLE><ARTIST>Dolly Parton</ARTIST><COUNTRY>USA</COUNTRY><COMPANY>RCA</COMPANY><PRICE>9.90</PRICE><YEAR>1982</YEAR></CD></CATALOG>";
	NSDictionary *result = [JPXMLProcesser convertFromXML:catalogXML];
	GHAssertNotNil( result, @"Parse result should't be NULL." );
	// Check Dictionary results.
	GHAssertTrue( [result isKindOfClass:[NSDictionary class]], @"Result should be an DICTIONARY.");

	// Log Result.
	GHTestLog( @"Parsed: %@", result );	GHTestLog( @"Parsed: %@", result );

	// Check root element.
	NSDictionary *rootElement = [result objectForKey:@"CATALOG"];
	GHAssertNotNil( rootElement, @"rootElement 'CATALOG' should't be NULL." );
	GHAssertTrue( [rootElement isKindOfClass:[NSDictionary class]], @"Result should be an DICTIONARY.");
	
	// Retrieve Array of elements.
	NSArray *first = [rootElement objectForKey:@"CD"];
	GHAssertNotNil( first, @"First node 'CD' should't be NULL." );
	GHAssertTrue( [first isKindOfClass:[NSArray class]], @"First node 'CD' should be an ARRAY.");
	
	// Check first element on parsed array.
	NSDictionary *firstElement = [first objectAtIndex:0];
	GHAssertEqualStrings( @"Bob Dylan", [firstElement objectForKey:@"ARTIST"], @"Element 'ARTIST' wasn't parsed correctly");
	GHAssertEqualStrings( @"Columbia", [firstElement objectForKey:@"COMPANY"], @"Element 'COMPANY' wasn't parsed correctly");
	GHAssertEqualStrings( @"USA", [firstElement objectForKey:@"COUNTRY"], @"Element 'COUNTRY' wasn't parsed correctly");
	GHAssertEqualStrings( @"10.90", [firstElement objectForKey:@"PRICE"], @"Element 'PRICE' wasn't parsed correctly");
	GHAssertEqualStrings( @"Empire Burlesque", [firstElement objectForKey:@"TITLE"], @"TITLE 'body' wasn't parsed correctly");
	GHAssertEqualStrings( @"1985", [firstElement objectForKey:@"YEAR"], @"Element 'YEAR' wasn't parsed correctly");

	// Check second element on parsed array.
	NSDictionary *secondElement = [first objectAtIndex:1];
	GHAssertEqualStrings( @"Bonnie Tyler", [secondElement objectForKey:@"ARTIST"], @"Element 'ARTIST' wasn't parsed correctly");
	GHAssertEqualStrings( @"CBS Records", [secondElement objectForKey:@"COMPANY"], @"Element 'COMPANY' wasn't parsed correctly");
	GHAssertEqualStrings( @"UK", [secondElement objectForKey:@"COUNTRY"], @"Element 'COUNTRY' wasn't parsed correctly");
	GHAssertEqualStrings( @"9.90", [secondElement objectForKey:@"PRICE"], @"Element 'PRICE' wasn't parsed correctly");
	GHAssertEqualStrings( @"Hide your heart", [secondElement objectForKey:@"TITLE"], @"TITLE 'body' wasn't parsed correctly");
	GHAssertEqualStrings( @"1988", [secondElement objectForKey:@"YEAR"], @"Element 'YEAR' wasn't parsed correctly");
	
	// Check third element on parsed array.
	NSDictionary *thirdElement = [first objectAtIndex:2];
	GHAssertEqualStrings( @"Dolly Parton", [thirdElement objectForKey:@"ARTIST"], @"Element 'ARTIST' wasn't parsed correctly");
	GHAssertEqualStrings( @"RCA", [thirdElement objectForKey:@"COMPANY"], @"Element 'COMPANY' wasn't parsed correctly");
	GHAssertEqualStrings( @"USA", [thirdElement objectForKey:@"COUNTRY"], @"Element 'COUNTRY' wasn't parsed correctly");
	GHAssertEqualStrings( @"9.90", [thirdElement objectForKey:@"PRICE"], @"Element 'PRICE' wasn't parsed correctly");
	GHAssertEqualStrings( @"Greatest Hits", [thirdElement objectForKey:@"TITLE"], @"TITLE 'body' wasn't parsed correctly");
	GHAssertEqualStrings( @"1982", [thirdElement objectForKey:@"YEAR"], @"Element 'YEAR' wasn't parsed correctly");
}	

////////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// ////////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //
-(void)testWithAttributes {
	NSString *attributeXML = @"<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?><root><element attribute1=\"value1\" attribute2=\"value2\"></element></root>";
	NSDictionary *result = [JPXMLProcesser convertFromXML:attributeXML];
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