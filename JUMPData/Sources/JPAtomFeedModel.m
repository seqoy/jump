//
//  JPAtomFeedModel
//  JUMPData
//
//  Created by Viridian Mobile Development Workstation on 5/3/11.
//  Copyright 2011 CME Group. All rights reserved.
//

#import "JPAtomFeedModel.h"
#import "JPAtomEntryModel.h"

@implementation JPAtomFeedModel
@synthesize feedId, xmlns, title, subtitle, updated, icon, logo, rights, links, entry;
@synthesize author, category, contributor;


/////// ////// ////// ////// ////// ////// ////// ////// ////// /////// ////// ////// ////// ////// ////// ////// ////// ////// 
#pragma mark -
#pragma mark Init Methods
/////// ////// ////// ////// ////// ////// ////// ////// ////// /////// ////// ////// ////// ////// ////// ////// ////// ////// 
+(JPAtomFeedModel*)initWithDictionary:(NSDictionary*)anDictionary {
	JPAtomFeedModel *instance = [[JPAtomFeedModel new] autorelease];
	
	// Load.
	instance = [instance loadFeedFromDictionary:anDictionary];
	
	// Return instance.
	return instance;
}

/////// ////// ////// ////// ////// ////// ////// ////// ////// /////// ////// ////// ////// ////// ////// ////// ////// ////// 
- (void) dealloc {
	[feedId release];
	[xmlns release];
	[title release];
	[subtitle release];
	[updated release];
	[icon release];
	[logo release];
	[rights release];
	[links release];
	[entry release];
	[author release];
	[category release];
	[contributor release];
	[super dealloc];
}

/////// ////// ////// ////// ////// ////// ////// ////// ////// /////// ////// ////// ////// ////// ////// ////// ////// ////// 
#pragma mark -
#pragma mark JPDataPopulatorDelegate Methods
/////// ////// ////// ////// ////// ////// ////// ////// ////// /////// ////// ////// ////// ////// ////// ////// ////// ////// 
// When the Data Populator can't automatically convert some specific type. He will call this method  and let you extend the class converting you specific type.
-(id)tryToConvert:(id)object ofClass:(Class)objectClass toClass:(Class)convertToClass {
	
	// Converted.
	id converted = nil;
	
	//// //// //// //// //// //// //// //// //// //// 
	// Rights, Content, Summary or Title Model Class.
	if ( convertToClass == [JPAtomRightsModel class] || convertToClass == [JPAtomTitleModel class] ||
		 convertToClass == [JPAtomContentModel class] || convertToClass == [JPAtomSummaryModel class] ) {
		
		// Init new object.
		converted = [[convertToClass new] autorelease];
		
		// String?
		if ( [object isKindOfClass:[NSString class]] ) {
			[converted setText:object];
		}
	}
	
	///////// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ////
	// Person map.
	NSDictionary *personMap = [NSDictionary dictionaryWithObjectsAndKeys:
																   @"name",		@"name",
																   @"email",	@"email",
																   @"uri",		@"uri", nil];
	
	//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// ////  //// //// //// //// //// ////  //// //// //// //// //// ////  
	// Author Collection.
	if ( convertToClass == [JPAtomAuthorCollection class] ) {
		
		///////// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ////
		// Convert and populate.
		converted = [self populateCollection:[JPAtomAuthorCollection class] withObject:[JPAtomAuthorModel class]
									usingMap:personMap withData:object];
	}

	//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// ////  //// //// //// //// //// ////  //// //// //// //// //// ////  
	// Contributor Collection.
	if ( convertToClass == [JPAtomContributorCollection class] ) {
		
		///////// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ////
		// Convert and populate.
		converted = [self populateCollection:[JPAtomContributorCollection class] withObject:[JPAtomContributorModel class]
									usingMap:personMap withData:object];
	}
	
	
	//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// ////  //// //// //// //// //// ////  //// //// //// //// //// ////  
	// Link Collection.
	if ( convertToClass == [JPAtomLinksCollection class] ) {
		
		///////// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ////
		// Links map.
		NSDictionary *linksMap = [NSDictionary dictionaryWithObjectsAndKeys:
																		   @"href",			@"href",
																		   @"rel",			@"rel",
																		   @"type",			@"type",
																		   @"hreflang",		@"hreflang",
																		   @"title",		@"title",
																		   @"lenght",		@"lenght", nil];
		
		// Convert and populate.
		converted = [self populateCollection:[JPAtomLinksCollection class] withObject:[JPAtomLinkModel class]
									usingMap:linksMap withData:object];
	}

	//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// ////  //// //// //// //// //// ////  //// //// //// //// //// ////  
	// Category Collection.
	if ( convertToClass == [JPAtomCategoryCollection class] ) {
		
		///////// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ////
		// Links map.
		NSDictionary *categoryMap = [NSDictionary dictionaryWithObjectsAndKeys:
																		  @"term",		@"term",
																		  @"scheme",	@"scheme",
																		  @"label",		@"label", nil];
		
		// Convert and populate.
		converted = [self populateCollection:[JPAtomCategoryCollection class] withObject:[JPAtomCategoryModel class]
									usingMap:categoryMap withData:object];
	}

	//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// ////  //// //// //// //// //// ////  //// //// //// //// //// ////  
	// Entry Collection.
	if ( convertToClass == [JPAtomEntryCollection class] ) {
		
		///////// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ////
		// Links map.
		NSDictionary *entryMap = [NSDictionary dictionaryWithObjectsAndKeys:
																		@"entryId",		@"id",
																		@"updated",		@"updated",
																		@"published",	@"published",
																		@"content",		@"content",
																		@"summary",		@"summary",
																		@"title",		@"title",
																		@"link",		@"link",
																		@"author",		@"author",
																		@"category",	@"category",
																		@"contributor",	@"contributor", nil];

		
		// Convert and populate.
		converted = [self populateCollection:[JPAtomEntryCollection class] withObject:[JPAtomEntryModel class]
									usingMap:entryMap withData:object];
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
	NSDictionary *feed = [self validateElement:[anDictionary objectForKey:@"feed"] 
									   ofClass:[NSDictionary class] 
									withErrors:[NSArray arrayWithObjects:@"'feed' Atom (XML) element doesn't exist!",
												@"'feed' Atom (XML) element contains invalid data.", nil]];
	
	///////// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ////
	// All properties map.
	NSDictionary *feedMap = [NSDictionary dictionaryWithObjectsAndKeys:
																	@"feedId",		@"id",
																	@"xmlns",		@"xmlns",
																	@"updated",		@"updated",
																	@"icon",		@"icon",
																	@"logo",		@"logo",
																	@"rights",		@"rights",
																	@"title",		@"title",
																	@"subtitle",	@"subtitle", 
																	@"links",		@"link", 
																	@"category",	@"category", 
																	@"contributor",	@"contributor", 
																	@"entry",		@"entry", 
																	@"author",		@"author", nil];
	// Populate all properties.
	return [JPDataPopulator populateObject:self withData:feed usingMap:feedMap withDelegate:self];	
}

@end
