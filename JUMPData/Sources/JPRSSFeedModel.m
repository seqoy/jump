//
//  JPRSSFeedModel
//  JUMPData
//
//  Created by Viridian Mobile Development Workstation on 5/3/11.
//  Copyright 2011 CME Group. All rights reserved.
//

#import "JPRSSFeedModel.h"
#import "JPRSSChannelModel.h"
#import "JPRSSCloudModel.h"
#import "JPRSSImageModel.h"
#import "JPRSSTextInputModel.h"
#import "JPRSSCollections.h"
#import "JPRSSItemModel.h"
#import "JPRSSEnclosureModel.h"
#import "JPRSSGuidModel.h"
#import "JPRSSSourceModel.h"

@implementation JPRSSFeedModel
@synthesize version, channel;

/////// ////// ////// ////// ////// ////// ////// ////// ////// /////// ////// ////// ////// ////// ////// ////// ////// ////// 
#pragma mark -
#pragma mark Init Methods
/////// ////// ////// ////// ////// ////// ////// ////// ////// /////// ////// ////// ////// ////// ////// ////// ////// ////// 
+(JPRSSFeedModel*)initWithDictionary:(NSDictionary*)anDictionary {
	JPRSSFeedModel *instance = [[JPRSSFeedModel new] autorelease];
	
	// Load.
	instance = [instance loadFeedFromDictionary:anDictionary];
	
	// Return instance.
	return instance;
}

/////// ////// ////// ////// ////// ////// ////// ////// ////// /////// ////// ////// ////// ////// ////// ////// ////// ////// 
- (void) dealloc {
	[version release];
	[channel release];
	[super dealloc];
}

/////// ////// ////// ////// ////// ////// ////// ////// ////// /////// ////// ////// ////// ////// ////// ////// ////// ////// 
#pragma mark -
#pragma mark Private Methods
/////// ////// ////// ////// ////// ////// ////// ////// ////// /////// ////// ////// ////// ////// ////// ////// ////// ////// 
-(NSMutableDictionary*)buildMaps {
	NSMutableDictionary *maps = [[NSMutableDictionary new] autorelease];
	

	///////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// 
	// Map for Channel Model.
	[maps setObject: 
			[NSDictionary dictionaryWithObjectsAndKeys:
											@"description",				@"description",
											@"link",					@"link",
											@"title",					@"title",
											@"copyright",				@"copyright",
											@"docs",					@"docs",
											@"generator",				@"generator",
											@"language",				@"language",
											@"lastBuildDate",			@"lastBuildDate",
											@"managingEditor",			@"managingEditor",
											@"pubDate",					@"pubDate",
											@"rating",					@"rating",
											@"ttl",						@"ttl",
											@"webMaster",				@"webMaster",
											@"category",				@"category",
											@"cloud",					@"cloud",
											@"image",					@"image",
											@"textInput",				@"textInput",
											@"skipDays",				@"skipDays",
											@"skipHours",				@"skipHours",
											@"item",					@"item",
											nil]
			 forKey:[JPRSSChannelModel class]];
	
	///////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// 
	// Map for Cloud Model.
	[maps setObject: 
		[NSDictionary dictionaryWithObjectsAndKeys:  
											  @"domain",				@"domain",
											  @"path",					@"path",
											  @"domain",				@"domain",
											  @"port",					@"port",
											  @"protocol",				@"protocol",
											  @"registerProcedure",		@"registerProcedure",
											  @"value",					@"cloud",		
											  nil]
			 forKey:[JPRSSCloudModel class]];
	
	///////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// 
	// Map for Item Model.
	[maps setObject: 
		 [NSDictionary dictionaryWithObjectsAndKeys:  
											  @"author",			@"author",
											  @"category",			@"category",
											  @"comments",			@"comments",
											  @"link",				@"link",
											  @"pubDate",			@"pubDate",
											  @"title",				@"title",
											  @"enclosure",			@"enclosure",
											  @"guid",				@"guid",
											  @"source",			@"source",
											  @"description",		@"description",		nil]
			 forKey:[JPRSSItemModel class]];
	
	//////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// 
	// Map for Item Model.
	[maps setObject: 
		 [NSDictionary dictionaryWithObjectsAndKeys:  
											  @"link",					@"link",
											  @"title",					@"title",
											  @"url",					@"url",
											  @"description",			@"description",
											  @"height",				@"height",
											  @"width",					@"width",		nil]
			 forKey:[JPRSSImageModel class]];
	
	//////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// 
	// Map for Item Model.
	[maps setObject: 
		 [NSDictionary dictionaryWithObjectsAndKeys:  
											  @"link",					@"link",
											  @"title",					@"title",
											  @"name",					@"name",
											  @"description",			@"description", nil] 
			 forKey:[JPRSSTextInputModel class]];

	//////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// 
	// Map for Enclosure Model.
	[maps setObject: 
		 [NSDictionary dictionaryWithObjectsAndKeys:  
											  @"length",	@"length",
											  @"type",		@"type",
											  @"url",		@"url",
											  nil] 
			 forKey:[JPRSSEnclosureModel class]];

	//////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// 
	// Map for Guid Model.
	[maps setObject: 
		 [NSDictionary dictionaryWithObjectsAndKeys:  
											  @"value",			@"guid",
											  @"permaLink",		@"permaLink",
											 nil] 
			 forKey:[JPRSSGuidModel class]];

	//////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// 
	// Map for Source Model.
	[maps setObject: 
		 [NSDictionary dictionaryWithObjectsAndKeys:  
											  @"value",			@"source",
											  @"url",			@"url",
											  nil] 
			 forKey:[JPRSSSourceModel class]];
	
	//////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// 
	// Map for Category Model.
	[maps setObject: 
		 [NSDictionary dictionaryWithObjectsAndKeys: 
											@"domain",			@"domain",
											@"value",			@"category",		nil] 
			 forKey:[JPRSSCategoryModel class]];

	// Return builded. 
	return maps;
}

/////// ////// ////// ////// ////// ////// ////// ////// ////// /////// ////// ////// ////// ////// ////// ////// ////// ////// 
-(NSDictionary*)mapForClass:(Class)anClass {
	return [[self buildMaps] objectForKey:anClass];
}

/////// ////// ////// ////// ////// ////// ////// ////// ////// /////// ////// ////// ////// ////// ////// ////// ////// ////// 
-(id)convertToClass:(Class)anClass usingMap:(NSDictionary*)anMap withData:(id)data {
	id element = [[anClass new] autorelease];
	
	// If Data is an String. This will happens when elements that have OPTIONAL attributes doesn't have this attributes.
	// In this case our element is an String, not a Dictionary. What we have to do is create this Dictionary on the fly.
	if ( [data isKindOfClass:[NSString class]] ) {
		
		// Find the data key.
		NSArray *keys = [anMap allKeysForObject:@"value"];
		NSString *key = @"unknown";
		if ( keys && [keys count] > 0 ) 
			 key = [keys objectAtIndex:0];
		
		// Create Data Dictionary.
		data = [NSDictionary dictionaryWithObject:data forKey:key];
	}
	
	// Populate all properties.
	return [JPDataPopulator populateObject:element withData:data usingMap:anMap withDelegate:self];	
}

/////// ////// ////// ////// ////// ////// ////// ////// ////// /////// ////// ////// ////// ////// ////// ////// ////// ////// 
-(id)populateCollection:(Class)collectionClass withArray:(NSArray*)array {
	// Init new object.
	id populate = [[collectionClass new] autorelease];
	
	// Loop all elements.
	for ( NSString* item in array ) 
		[populate addObject:item];
	
	// Return populated.
	return populate;
}

/////// ////// ////// ////// ////// ////// ////// ////// ////// /////// ////// ////// ////// ////// ////// ////// ////// ////// 
#pragma mark -
#pragma mark JPDataPopulatorDelegate Methods
/////// ////// ////// ////// ////// ////// ////// ////// ////// /////// ////// ////// ////// ////// ////// ////// ////// ////// 
// When the Data Populator can't automatically convert some specific type. He will call this method  and let you extend the class converting you specific type.
-(id)tryToConvert:(id)object ofClass:(Class)objectClass toClass:(Class)convertToClass {

	// Converted.
	id converted = nil;
	
	//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
	// Itens Collection.
	if ( convertToClass == [JPRSItemCollection class] ) {
		
		// Convert and populate.
		converted = [self populateCollection:[JPRSItemCollection class] 
								  withObject:[JPRSSItemModel class]
									usingMap:[self mapForClass:[JPRSSItemModel class]] 
									withData:object];
	}
	
	//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
	// Skip Days Collections.
	if ( convertToClass == [JPRSSSkipDaysCollection class] ) {
		if ( [object objectForKey:@"day"] ) 
			converted = [self populateCollection:convertToClass withArray:[object objectForKey:@"day"]];
	}
	
	// Skip Hours Collections.
	if ( convertToClass == [JPRSSSkipHoursCollection class] ) {
		if ( [object objectForKey:@"hour"] ) 
			converted = [self populateCollection:convertToClass withArray:[object objectForKey:@"hour"]];
	}

	//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
	// Models Convert
	if ( convertToClass == [JPRSSChannelModel class] ||
		 convertToClass == [JPRSSCategoryModel class] ||
		 convertToClass == [JPRSSCloudModel class] ||
		 convertToClass == [JPRSSItemModel class] ||
		 convertToClass == [JPRSSImageModel class] ||
		 convertToClass == [JPRSSGuidModel class] ||
		 convertToClass == [JPRSSEnclosureModel class] ||
		 convertToClass == [JPRSSSourceModel class] ||
		 convertToClass == [JPRSSTextInputModel class] )
	{
		 converted = [self convertToClass:convertToClass usingMap:[self mapForClass:convertToClass] withData:object];
	}
	
	// Return converted.
	return converted;
}

/////// ////// ////// ////// ////// ////// ////// ////// ////// /////// ////// ////// ////// ////// ////// ////// ////// ////// 
#pragma mark -
#pragma mark Load Data Methods
/////// ////// ////// ////// ////// ////// ////// ////// ////// /////// ////// ////// ////// ////// ////// ////// ////// ////// 
-(id)loadFeedFromDictionary:(NSDictionary*)anDictionary {
	
	//// //// //// //// //// //// //// //// //// //// //// //// //// //// /////// ///// ///// ///// ///// ///// ///// ////////
	// Grab the first element (feed) and validate.
	NSDictionary *feed = [self validateElement:[anDictionary objectForKey:@"rss"] 
									   ofClass:[NSDictionary class] 
									withErrors:[NSArray arrayWithObjects:@"'rss' RSS 2.0 element doesn't exist!",
												@"'rss' RSS 2.0 element contains invalid data.", nil]];
	
	///////// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ////
	// All properties map.
	NSDictionary *feedMap = [NSDictionary dictionaryWithObjectsAndKeys:	@"version",		@"version",
																		@"channel",		@"channel", nil];
	// Populate all properties.
	return [JPDataPopulator populateObject:self withData:feed usingMap:feedMap withDelegate:self];	
}

@end
