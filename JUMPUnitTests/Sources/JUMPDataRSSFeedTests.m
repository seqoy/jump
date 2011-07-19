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
#import "JPRSSFeedModel.h"
#import "JPLogger.h"

#import "JPFeedPipelineHandler.h"
#import "JPDefaultHandlerContext.h"

@interface JUMPDataRSSFeedTests : GHTestCase {
	// If some error ocurr will store here.
	NSError *parseError;
	JPFeedPipelineHandler *handler;
	JPDefaultHandlerContext *context;
}
@end

//////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// 
#pragma mark -
@implementation JUMPDataRSSFeedTests

//////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// 
#pragma mark -

// Run at start of all tests in the class
- (void)setUpClass {
	// Logger.
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


//////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// 
#pragma mark -
#pragma mark Tests - RSS Feed Example from http//:www.rssboard.org/files/sample-rss-2.xml
////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// 
-(void)executeRSSFeedTestWithFeed:(JPRSSFeedModel*)rss andResultToCompare:(NSDictionary*)result {
	
	GHAssertNotNULL( rss, @"RSS Feed Model wasn't created correctly.");
	
	// Test simple values.
	GHAssertEqualStrings( [result objectOnXMLPath:@"rss/version"], rss.version, @"'version' key wasn't parsed correctly");
	
	// Test Channel.
	GHAssertEqualStrings( [result objectOnXMLPath:@"rss/channel/description"], rss.channel.description, @"'channel/description' key wasn't parsed correctly");
	GHAssertEqualStrings( [result objectOnXMLPath:@"rss/channel/link"], rss.channel.link, @"'channel/link' key wasn't parsed correctly");
	GHAssertEqualStrings( [result objectOnXMLPath:@"rss/channel/title"], rss.channel.title, @"'channel/title' key wasn't parsed correctly");
	GHAssertEqualStrings( [result objectOnXMLPath:@"rss/channel/language"], rss.channel.language, @"'channel/language' key wasn't parsed correctly");
	GHAssertEqualStrings( [result objectOnXMLPath:@"rss/channel/pubDate"], rss.channel.pubDate, @"'channel/pubDate' key wasn't parsed correctly");
	GHAssertEqualStrings( [result objectOnXMLPath:@"rss/channel/lastBuildDate"], rss.channel.lastBuildDate, @"'channel/lastBuildDate' key wasn't parsed correctly");
	GHAssertEqualStrings( [result objectOnXMLPath:@"rss/channel/copyright"], rss.channel.copyright, @"'channel/copyright' key wasn't parsed correctly");
	GHAssertEqualStrings( [result objectOnXMLPath:@"rss/channel/generator"], rss.channel.generator, @"'channel/generator' key wasn't parsed correctly");
	GHAssertEqualStrings( [result objectOnXMLPath:@"rss/channel/managingEditor"], rss.channel.managingEditor, @"'channel/managingEditor' key wasn't parsed correctly");
	GHAssertEqualStrings( [result objectOnXMLPath:@"rss/channel/rating"], rss.channel.rating, @"'channel/rating' key wasn't parsed correctly");
	GHAssertEqualStrings( [result objectOnXMLPath:@"rss/channel/ttl"], rss.channel.ttl, @"'channel/ttl' key wasn't parsed correctly");
	GHAssertEqualStrings( [result objectOnXMLPath:@"rss/channel/webMaster"], rss.channel.webMaster, @"'channel/webMaster' key wasn't parsed correctly");
	
	// Test Channel Category.
	GHAssertEqualStrings( [result objectOnXMLPath:@"rss/channel/category/domain"], rss.channel.category.domain, @"'channel/category/domain' key wasn't parsed correctly");
	GHAssertEqualStrings( [result objectOnXMLPath:@"rss/channel/category/category"], rss.channel.category.value, @"'channel/category/category' key wasn't parsed correctly");
	
	// Test Channel Cloud.
	GHAssertEqualStrings( [result objectOnXMLPath:@"rss/channel/cloud/domain"], rss.channel.cloud.domain, @"'channel/cloud/domain' key wasn't parsed correctly");
	GHAssertEqualStrings( [result objectOnXMLPath:@"rss/channel/cloud/path"], rss.channel.cloud.path, @"'channel/cloud/path' key wasn't parsed correctly");
	GHAssertEqualStrings( [result objectOnXMLPath:@"rss/channel/cloud/port"], rss.channel.cloud.port, @"'channel/cloud/port' key wasn't parsed correctly");
	GHAssertEqualStrings( [result objectOnXMLPath:@"rss/channel/cloud/protocol"], rss.channel.cloud.protocol, @"'channel/cloud/protocol' key wasn't parsed correctly");
	GHAssertEqualStrings( [result objectOnXMLPath:@"rss/channel/cloud/registerProcedure"], rss.channel.cloud.registerProcedure, @"'channel/cloud/registerProcedure' key wasn't parsed correctly");
	GHAssertEqualStrings( [result objectOnXMLPath:@"rss/channel/cloud/cloud"], rss.channel.cloud.value, @"'channel/cloud/cloud' key wasn't parsed correctly");
	
	// Test Channel Image.
	GHAssertEqualStrings( [result objectOnXMLPath:@"rss/channel/image/link"], rss.channel.image.link, @"'channel/image/link' key wasn't parsed correctly");
	GHAssertEqualStrings( [result objectOnXMLPath:@"rss/channel/image/title"], rss.channel.image.title, @"'channel/image/title' key wasn't parsed correctly");
	GHAssertEqualStrings( [result objectOnXMLPath:@"rss/channel/image/url"], rss.channel.image.url, @"'channel/image/url' key wasn't parsed correctly");
	GHAssertEqualStrings( [result objectOnXMLPath:@"rss/channel/image/description"], rss.channel.image.description, @"'channel/image/description' key wasn't parsed correctly");
	GHAssertEqualStrings( [result objectOnXMLPath:@"rss/channel/image/height"], rss.channel.image.height, @"'channel/image/height' key wasn't parsed correctly");
	GHAssertEqualStrings( [result objectOnXMLPath:@"rss/channel/image/width"], rss.channel.image.width, @"'channel/image/width' key wasn't parsed correctly");
	
	// Test Channel Text Input.
	GHAssertEqualStrings( [result objectOnXMLPath:@"rss/channel/textInput/description"], rss.channel.textInput.description, @"'channel/textInput/description' key wasn't parsed correctly");
	GHAssertEqualStrings( [result objectOnXMLPath:@"rss/channel/textInput/link"], rss.channel.textInput.link, @"'channel/textInput/link' key wasn't parsed correctly");
	GHAssertEqualStrings( [result objectOnXMLPath:@"rss/channel/textInput/name"], rss.channel.textInput.name, @"'channel/textInput/name' key wasn't parsed correctly");
	GHAssertEqualStrings( [result objectOnXMLPath:@"rss/channel/textInput/title"], rss.channel.textInput.title, @"'channel/textInput/title' key wasn't parsed correctly");
	
	/////////// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// 
	// Test Channel Collections.
	// Skip Days.
	NSArray *skipDays = [result objectOnXMLPath:@"rss/channel/skipDays/day"];
	GHAssertEqualStrings( [skipDays objectAtIndex:0], [rss.channel.skipDays objectAtIndex:0], @"'rss/channel/skipDays' element 1 key wasn't parsed correctly");	
	GHAssertEqualStrings( [skipDays objectAtIndex:1], [rss.channel.skipDays objectAtIndex:1], @"'rss/channel/skipDays' element 2 key wasn't parsed correctly");	
	
	// Skip Hours.
	NSArray *skipHours = [result objectOnXMLPath:@"rss/channel/skipHours/hour"];
	GHAssertEqualStrings( [skipHours objectAtIndex:0], [rss.channel.skipHours objectAtIndex:0], @"'rss/channel/skipDays' element 1 key wasn't parsed correctly");	
	GHAssertEqualStrings( [skipHours objectAtIndex:1], [rss.channel.skipHours objectAtIndex:1], @"'rss/channel/skipDays' element 2 key wasn't parsed correctly");	
	GHAssertEqualStrings( [skipHours objectAtIndex:2], [rss.channel.skipHours objectAtIndex:2], @"'rss/channel/skipDays' element 3 key wasn't parsed correctly");	
	
	/////////// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// 
	// Test Channel Item.
	GHAssertEqualStrings( [result objectOnXMLPath:@"rss/channel/item/author"], rss.channel.item.firstObject.author, @"'channel/item/author' key wasn't parsed correctly");
	GHAssertEqualStrings( [result objectOnXMLPath:@"rss/channel/item/comments"], rss.channel.item.firstObject.comments, @"'channel/item/comments' key wasn't parsed correctly");
	GHAssertEqualStrings( [result objectOnXMLPath:@"rss/channel/item/link"], rss.channel.item.firstObject.link, @"'channel/item/link' key wasn't parsed correctly");
	GHAssertEqualStrings( [result objectOnXMLPath:@"rss/channel/item/pubDate"], rss.channel.item.firstObject.pubDate, @"'channel/item/pubDate' key wasn't parsed correctly");
	GHAssertEqualStrings( [result objectOnXMLPath:@"rss/channel/item/title"], rss.channel.item.firstObject.title, @"'channel/item/title' key wasn't parsed correctly");
	GHAssertEqualStrings( [result objectOnXMLPath:@"rss/channel/item/description"], rss.channel.item.firstObject.description, @"'channel/item/description' key wasn't parsed correctly");
	
	GHAssertEqualStrings( [result objectOnXMLPath:@"rss/channel/item/category"], rss.channel.item.firstObject.category.value, @"'channel/item/category' key wasn't parsed correctly");
	GHAssertEqualStrings( [result objectOnXMLPath:@"rss/channel/item/guid"], rss.channel.item.firstObject.guid.value, @"'channel/item/guid' key wasn't parsed correctly");
	
	// Test Channel Item Enclosure.
	GHAssertEqualStrings( [result objectOnXMLPath:@"rss/channel/item/enclosure/length"], rss.channel.item.firstObject.enclosure.length, @"'channel/item/enclosure/length' key wasn't parsed correctly");
	GHAssertEqualStrings( [result objectOnXMLPath:@"rss/channel/item/enclosure/type"], rss.channel.item.firstObject.enclosure.type, @"'channel/item/enclosure/type' key wasn't parsed correctly");
	GHAssertEqualStrings( [result objectOnXMLPath:@"rss/channel/item/enclosure/url"], rss.channel.item.firstObject.enclosure.url, @"'channel/item/enclosure/url' key wasn't parsed correctly");
	
	// Test Channel Item Source.
	GHAssertEqualStrings( [result objectOnXMLPath:@"rss/channel/item/source/url"], rss.channel.item.firstObject.source.url, @"'channel/item/source/url' key wasn't parsed correctly");
	GHAssertEqualStrings( [result objectOnXMLPath:@"rss/channel/item/source/source"], rss.channel.item.firstObject.source.value, @"'channel/item/source/source' key wasn't parsed correctly");
}

////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// 
-(NSDictionary*)loadAndParseXML {
	// File URL.
	NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"JRSSFeedsExampleOneItem" withExtension:@"xml"];
	
	//////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// 
	// Parse XML.
	return [JPXMLParser convertFromXMLFile:fileURL error:&parseError];
}

////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// 
-(void)testLoadRSSFeedModelWithOneItem {

	// Parse XML.
	NSDictionary* result = [self loadAndParseXML];
	
	// Log Result.
	//GHTestLog( @"Parsed: %@", [JPJSONProcesser convertToJSON:result humanReadable:YES] );
	
	// Load feed from parsed data.
	JPRSSFeedModel *rss = [JPRSSFeedModel initWithDictionary:result];
	
	/////////// //////// //////// //////// //////// //////// //////// //////// //////// //////// //////// //////// //////// 
	// Execute Common Tests.
	[self executeRSSFeedTestWithFeed:rss andResultToCompare:result];
}

////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// 
-(void)testRSSFeedPipelineHandler {
	// Parse XML.
	NSDictionary* result = [self loadAndParseXML];
	
	// Message.
	JPPipelineSimpleMessageEvent *message = [JPPipelineSimpleMessageEvent initWithMessage:result];
	
	// Handle (decode).
	[handler messageReceived:context withMessageEvent:message];
	
	// Decoded is on message, so grab it.
	JPRSSFeedModel *feed = [message getMessage];
	
	// Execute common tests.
	[self executeRSSFeedTestWithFeed:feed andResultToCompare:result];	
}


////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// 
-(void)testLoadRSSFeedModelWithManyItens {
	// File URL.
	NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"JRSSFeedsExample" withExtension:@"xml"];
	
	//////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// 
	// Parse XML.
	NSDictionary* result = [JPXMLParser convertFromXMLFile:fileURL error:&parseError];
	
	// Log Result.
	GHTestLog( @"Parsed: %@", [JPJSONProcesser convertToJSON:result humanReadable:YES] );
	
	// Load feed from parsed data.
	JPRSSFeedModel *rss = [JPRSSFeedModel initWithDictionary:result];
	GHAssertNotNULL( rss, @"RSS Feed Model wasn't created correctly.");
		
	// Test Item.
	NSArray *item = [result objectOnXMLPath:@"rss/channel/item"];
	GHAssertEqualStrings( [[item objectAtIndex:0] objectOnXMLPath:@"link"], [rss.channel.item objectAtIndex:0].link, @"'rss/channel/item' element 1 key wasn't parsed correctly");	
	GHAssertEqualStrings( [[item objectAtIndex:1] objectOnXMLPath:@"link"], [rss.channel.item objectAtIndex:1].link, @"'rss/channel/item' element 2 key wasn't parsed correctly");	
}
@end