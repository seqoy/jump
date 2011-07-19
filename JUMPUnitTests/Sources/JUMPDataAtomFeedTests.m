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
#import "JPXMLParserXPath.h"
#import "JPJSONProcesser.h"
#import "JPAtomFeedModel.h"
#import "JPAtomCollections.h"

#import "JPFeedPipelineHandler.h"
#import "JPDefaultHandlerContext.h"

@interface JUMPDataAtomFeedTests : GHTestCase {
	// If some error ocurr will store here.
	NSError *parseError;
	JPFeedPipelineHandler *handler;
	JPDefaultHandlerContext *context;
}
@end

//////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// 
#pragma mark -
@implementation JUMPDataAtomFeedTests

//////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// 
#pragma mark -
// Run at start of all tests in the class
- (void)setUpClass {
	// Configure the Factory Class.
	[JUMPLoggerConfig setLoggerFactoryClass:[JPLog4CocoaFactory class]];
	SetGlobalLogLevel( JPLoggerAllLevel );
}

-(void)tearDown {
	parseError = nil;
	[handler release];
	[context release];
}

- (void)setUp {
	// Context.
	context = [JPDefaultHandlerContext new];
	
	// Handler.
	handler = [JPFeedPipelineHandler new];
}


////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// 
-(void)executeAtomFeedTestWithFeed:(JPAtomFeedModel*)feed andResultToCompare:(NSDictionary*)result {
	GHAssertNotNULL( feed, @"Feed Model wasn't created correctly.");
	
	// Test simple values.
	GHAssertEqualStrings( [result objectOnXMLPath:@"feed/updated"], feed.updated, @"'updated' key wasn't parsed correctly");
	GHAssertEqualStrings( [result objectOnXMLPath:@"feed/id"], feed.feedId, @"'feedId' key wasn't parsed correctly");
	GHAssertEqualStrings( [result objectOnXMLPath:@"feed/xmlns"], feed.xmlns, @"'xmlns' key wasn't parsed correctly");
	GHAssertEqualStrings( [result objectOnXMLPath:@"feed/title"], feed.title.text, @"'title.text' key wasn't parsed correctly");
	GHAssertEqualStrings( [result objectOnXMLPath:@"feed/subtitle"], feed.subtitle.text, @"'subtitle.text' key wasn't parsed correctly");
	GHAssertEqualStrings( [result objectOnXMLPath:@"feed/rights"], feed.rights.text, @"'rights.text' key wasn't parsed correctly");
	
	// Test Author.
	GHAssertEqualStrings( [result objectOnXMLPath:@"feed/author/name"], feed.author.firstObject.name, @"'author.name' key wasn't parsed correctly");
	GHAssertEqualStrings( [result objectOnXMLPath:@"feed/author/email"], feed.author.firstObject.email, @"'author.email' key wasn't parsed correctly");
	
	// Test Link.
	GHAssertEqualStrings( [result objectOnXMLPath:@"feed/link/href"], feed.links.firstObject.href, @"'link.href' key wasn't parsed correctly");
	GHAssertEqualStrings( [result objectOnXMLPath:@"feed/link/rel"], feed.links.firstObject.rel, @"'link.rel' key wasn't parsed correctly");
	
	// Test Category
	GHAssertEqualStrings( [result objectOnXMLPath:@"feed/category/term"], feed.category.firstObject.term, @"'category.term' key wasn't parsed correctly");
	GHAssertEqualStrings( [result objectOnXMLPath:@"feed/category/scheme"], feed.category.firstObject.scheme, @"'category.scheme' key wasn't parsed correctly");
	GHAssertEqualStrings( [result objectOnXMLPath:@"feed/category/label"], feed.category.firstObject.label, @"'category.label' key wasn't parsed correctly");
	
	// Test Contributor.
	GHAssertEqualStrings( [result objectOnXMLPath:@"feed/contributor/name"], feed.contributor.firstObject.name, @"'contributor.name' key wasn't parsed correctly");
	GHAssertEqualStrings( [result objectOnXMLPath:@"feed/contributor/email"], feed.contributor.firstObject.email, @"'contributor.email' key wasn't parsed correctly");
	
	///////// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// 
	// Test Entry.
	GHAssertEqualStrings( [result objectOnXMLPath:@"feed/entry/title"], feed.entry.firstObject.title.text, @"'entry.title.text' key wasn't parsed correctly");
	GHAssertEqualStrings( [result objectOnXMLPath:@"feed/entry/summary"], feed.entry.firstObject.summary.text, @"'entry.summary.text' key wasn't parsed correctly");
	GHAssertEqualStrings( [result objectOnXMLPath:@"feed/entry/id"], feed.entry.firstObject.entryId, @"'entry.entryId (id)' key wasn't parsed correctly");
	GHAssertEqualStrings( [result objectOnXMLPath:@"feed/entry/updated"], feed.entry.firstObject.updated, @"'entry.updated' key wasn't parsed correctly");
	
	// Entry Link.
	GHAssertEqualStrings( [result objectOnXMLPath:@"feed/entry/link/rel"], feed.entry.firstObject.link.firstObject.rel, @"'entry.link.rel' key wasn't parsed correctly");
	GHAssertEqualStrings( [result objectOnXMLPath:@"feed/entry/link/type"], feed.entry.firstObject.link.firstObject.type, @"'entry.link.type' key wasn't parsed correctly");
	GHAssertEqualStrings( [result objectOnXMLPath:@"feed/entry/link/href"], feed.entry.firstObject.link.firstObject.href, @"'entry.link.href' key wasn't parsed correctly");
	
	// Entry Category.
	GHAssertEqualStrings( [result objectOnXMLPath:@"feed/entry/category/term"], feed.entry.firstObject.category.firstObject.term, @"'entry.category.term' key wasn't parsed correctly");
	GHAssertEqualStrings( [result objectOnXMLPath:@"feed/entry/category/scheme"], feed.entry.firstObject.category.firstObject.scheme, @"'entry.category.scheme' key wasn't parsed correctly");
	GHAssertEqualStrings( [result objectOnXMLPath:@"feed/entry/category/label"], feed.entry.firstObject.category.firstObject.label, @"'entry.category.label' key wasn't parsed correctly");
	
	// Entry Author.
	GHAssertEqualStrings( [result objectOnXMLPath:@"feed/entry/author/name"], feed.entry.firstObject.author.firstObject.name, @"'entry.author.name' key wasn't parsed correctly");
	GHAssertEqualStrings( [result objectOnXMLPath:@"feed/entry/author/email"], feed.entry.firstObject.author.firstObject.email, @"'entry.author.email' key wasn't parsed correctly");
	
	// Entry Contributor.
	GHAssertEqualStrings( [result objectOnXMLPath:@"feed/entry/contributor/name"], feed.entry.firstObject.contributor.firstObject.name, @"'entry.contributor.name' key wasn't parsed correctly");
	GHAssertEqualStrings( [result objectOnXMLPath:@"feed/entry/contributor/email"], feed.entry.firstObject.contributor.firstObject.email, @"'entry.contributor.email' key wasn't parsed correctly");
	
}

////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// 
-(NSDictionary*)loadAndParseXML {
	// File URL.
	NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"JPAtomFeedsExampleOneItem" withExtension:@"xml"];
	
	//////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// 
	// Parse XML.
	return [JPXMLParser convertFromXMLFile:fileURL error:&parseError];
}

////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// 
#pragma mark -
#pragma mark Tests Methods. 
////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// 
-(void)testLoadAtomFeedModelWithOneItem {
	// Parse XML.
	NSDictionary* result = [self loadAndParseXML];
	
	// Load feed from parsed data.
	JPAtomFeedModel *feed = [JPAtomFeedModel initWithDictionary:result];
	
	// Execute common tests.
	[self executeAtomFeedTestWithFeed:feed andResultToCompare:result];	
}

////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// 
-(void)testAtomFeedPipelineHandler {
	// Parse XML.
	NSDictionary* result = [self loadAndParseXML];
	
	// Message.
	JPPipelineSimpleMessageEvent *message = [JPPipelineSimpleMessageEvent initWithMessage:result];
	
	// Handle (decode).
	[handler messageReceived:context withMessageEvent:message];
	
	// Decoded is on message, so grab it.
	JPAtomFeedModel *feed = [message getMessage];
	
	// Execute common tests.
	[self executeAtomFeedTestWithFeed:feed andResultToCompare:result];	
}

////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// 
-(void)testSimpleAtomFeedVersusJSONParse {
	NSString *json = @"{  \"feed\": {    \"link\": [      {        \"rel\": \"self\",        \"href\": \"http://example.org/feed/\"      },      {        \"href\": \"http://example.org/\"      }    ],    \"xmlns\": \"http://www.w3.org/2005/Atom\",    \"id\": \"urn:uuid:60a76c80-d399-11d9-b91C-0003939e0af6\",    \"author\": {      \"name\": \"John Doe\",      \"email\": \"johndoe@example.com\"    },    \"updated\": \"2003-12-13T18:30:02Z\",    \"entry\": {      \"title\": \"Atom-Powered Robots Run Amok\",      \"id\": \"urn:uuid:1225c695-cfb8-4ebb-aaaa-80da344efa6a\",      \"link\": [        {          \"href\": \"http://example.org/2003/12/13/atom03\"        },        {          \"rel\": \"alternate\",          \"type\": \"text/html\",          \"href\": \"http://example.org/\"        },        {          \"rel\": \"edit\",          \"href\": \"http://example.org/2003/12/13/atom03/edit\"        }      ],      \"updated\": \"2003-12-13T18:30:02Z\",      \"summary\": \"Some text.\"    },    \"subtitle\": \"A subtitle.\",    \"title\": \"Example Feed\"  }}";
	
	/// Parse XML.
	NSDictionary* result = [self loadAndParseXML];
	
	// Parse JSON
	NSDictionary *jsonResult = [JPJSONProcesser convertFromJSON:json];
	
	//////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// 
	// Check the result.
	//GHAssertTrue( [result isEqualToDictionary:jsonResult], @"Parsed XML isn't correct!");
	
	// Log Result.
	GHTestLog( @"Parsed: %@", [JPJSONProcesser convertToJSON:result humanReadable:YES] );
}

////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// 
-(void)testLoadAtomFeedModelWithManyItens {
	// File URL.
	NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"JPAtomFeedsExample" withExtension:@"xml"];
	
	//////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// 
	// Parse XML.
	NSDictionary* result = [JPXMLParser convertFromXMLFile:fileURL error:&parseError];
	
	// Load feed from parsed data.
	JPAtomFeedModel *feed = [JPAtomFeedModel initWithDictionary:result];
	GHAssertNotNULL( feed, @"Feed Model wasn't created correctly.");
	
	// Test Author.
	NSArray *authors = [result objectOnXMLPath:@"feed/author"];
	GHAssertEqualStrings( [[authors objectAtIndex:0] objectOnXMLPath:@"name"], [feed.author objectAtIndex:0].name, @"'feed/author' element 1 key wasn't parsed correctly");	
	GHAssertEqualStrings( [[authors objectAtIndex:1] objectOnXMLPath:@"name"], [feed.author objectAtIndex:1].name, @"'feed/author' element 2 key wasn't parsed correctly");	

	// Test Links.
	NSArray *link = [result objectOnXMLPath:@"feed/link"];
	GHAssertEqualStrings( [[link objectAtIndex:0] objectOnXMLPath:@"href"], [feed.links objectAtIndex:0].href, @"'feed/link' element 1 key wasn't parsed correctly");	
	GHAssertEqualStrings( [[link objectAtIndex:1] objectOnXMLPath:@"href"], [feed.links objectAtIndex:1].href, @"'feed/link' element 2 key wasn't parsed correctly");	

	// Test Contributor.
	NSArray *contributor = [result objectOnXMLPath:@"feed/contributor"];
	GHAssertEqualStrings( [[contributor objectAtIndex:0] objectOnXMLPath:@"name"], [feed.contributor objectAtIndex:0].name, @"'feed/contributor' element 1 key wasn't parsed correctly");	
	GHAssertEqualStrings( [[contributor objectAtIndex:1] objectOnXMLPath:@"name"], [feed.contributor objectAtIndex:1].name, @"'feed/contributor' element 2 key wasn't parsed correctly");	

	// Test Category.
	NSArray *category = [result objectOnXMLPath:@"feed/category"];
	GHAssertEqualStrings( [[category objectAtIndex:0] objectOnXMLPath:@"term"], [feed.category objectAtIndex:0].term, @"'feed/category' element 1 key wasn't parsed correctly");	
	GHAssertEqualStrings( [[category objectAtIndex:1] objectOnXMLPath:@"term"], [feed.category objectAtIndex:1].term, @"'feed/category' element 2 key wasn't parsed correctly");	

	// Test Entry.
	NSArray *entry = [result objectOnXMLPath:@"feed/entry"];
	GHAssertTrue( [entry count] == [feed.entry.collection count], @"'feed/entry doesn't have the correct number of elements.");
	
	// Test Entry Author 0.
	NSArray *entryAuthors = [[entry objectAtIndex:0] objectOnXMLPath:@"author"];
	GHAssertEqualStrings( [[entryAuthors objectAtIndex:1] objectOnXMLPath:@"name"], [[feed.entry objectAtIndex:0].author objectAtIndex:1].name, @"");

	// Test Entry Author 1.
	entryAuthors = [[entry objectAtIndex:1] objectOnXMLPath:@"author"];
	GHAssertEqualStrings( [[entryAuthors objectAtIndex:1] objectOnXMLPath:@"email"], [[feed.entry objectAtIndex:1].author objectAtIndex:1].email, @"");
	
}
@end