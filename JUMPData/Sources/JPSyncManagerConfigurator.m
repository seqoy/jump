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
#import "JPSyncManagerConfigurator.h"
#import "JPFunctions.h"
#import "JPXMLParserXPath.h"


/// /// /// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ///
@implementation JPSyncManagerConfigurator
@synthesize databaseManager, maps, configs, readKeyOrder;

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Init Methods. 
+(id)init {
	return [[[self alloc] init] autorelease];
}
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
- (id) init {
	self = [super init];
	if (self != nil) {
		maps		 = [[NSMutableDictionary alloc] init];
		configs		 = [[NSMutableDictionary alloc] init]; 
	}
	return self;
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
// Init the Manager Configurator and load configurations from external XML file.
+(id)initAndConfigureFromXMLFile:(NSURL*)anFileURL {
	// Init an instance.
	JPSyncManagerConfigurator *anInstance = [JPSyncManagerConfigurator init];
	// Configure from file.
	[anInstance loadConfigurationFromXMLFile:anFileURL];
	// Return.
	return anInstance;
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Build Manager.
-(JPSyncManagerHandler*)getManager {
	// Create Instance.
	JPSyncManagerHandler *instance = [JPSyncManagerHandler initWithMaps:maps andConfigs:configs];

	// Set correct key order.
	instance.readKeyOrder = readKeyOrder;
    
    // Attach our Database Manager to be synced.
    [instance attachMainDatabaseManager:(JPDBManager*)self.databaseManager];
	
	// Return builded instance.
	return instance;
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Add Bridged Data Methods. 

-(id)validateElement:(id)anElement ofClass:(Class)anClass withErrors:(NSArray*)anErrorList {
	
	// Is valid?
	if (anElement == nil) 
		[NSException raise:JPSyncManagerLoadXMLException format:@"%@", [anErrorList objectAtIndex:0]];
	
	// Is correct class?
	if ( ! [anElement isKindOfClass:anClass] )
		[NSException raise:JPSyncManagerLoadXMLException format:@"%@", [anErrorList objectAtIndex:1]];
	
	// Return the element if everything is ok.
	return anElement;
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
-(void)processLoadedConfiguration:(NSDictionary*)configuration {
	
	//// //// //// //// //// //// //// //// //// //// //// //// //// //// //
	// Validate configuration.
	[self validateElement:configuration 
				  ofClass:[NSDictionary class] 
			   withErrors:[NSArray arrayWithObjects:@"No data was loaded from XML file. It is empty?",
													@"Invalid data loaded from XML file.", nil]];

	//// //// //// //// //// //// //// //// //// //// //// //// //// //// //
	// Grab the first element (root) and validate.
	NSDictionary *root = [self validateElement:[configuration objectForKey:@"root"] 
									   ofClass:[NSDictionary class] 
									withErrors:[NSArray arrayWithObjects:@"'root' XML element doesn't load!",
																		 @"'root' XML element contains invalid data.", nil]];
	
		
	//// //// //// //// //// //// //// //// //// //// //// //// //// //// //
	// Has prefered Key Order?
	NSArray *preferedKeyOrder = [root objectOnPath:@"preferedKeyOrder/key"];
	
	if ( preferedKeyOrder ) {
		Debug( @"Loading Prefered Key Order...");
        
        /////////// ////////////////////// ////////////////////// ////////////////////// ///////////
		// If preferedKeyOrder is an String, only ONE order was defined. So convert to array.
		if ( [preferedKeyOrder isKindOfClass:[NSString class]] ) {
			// Convert to array.
			preferedKeyOrder = [NSArray arrayWithObject:preferedKeyOrder];
		}
		
		// Validate.
		[self validateElement:preferedKeyOrder ofClass:[NSArray class]
				   withErrors:[NSArray arrayWithObjects:[NSNull null],
							   @"'preferedKeyOrder.key(s)' XML element contains invalid data.", nil]];
		
		
		// Load.
		[self setPreferedKeyOrderToProcess:preferedKeyOrder];
	}
	
	//// //// //// //// //// //// //// //// //// //// //// //// //// //// //
	// Has Maps?
	id loadedMaps = [root objectOnPath:@"maps/map"];

	if ( loadedMaps ) {
		Debug( @"Loading Maps...");
		
		/////////// ////////////////////// ////////////////////// ////////////////////// ///////////
		// If maps is an Dictionary, only ONE map was defined. So convert to array.
		if ( [loadedMaps isKindOfClass:[NSDictionary class]] ) {
			// Convert to array.
			loadedMaps = [NSArray arrayWithObject:loadedMaps];
		}
		
		// Validate.
		[self validateElement:loadedMaps ofClass:[NSArray class]
				   withErrors:[NSArray arrayWithObjects:[NSNull null],
														@"'maps' XML element contains invalid data.", nil]];
		/////////// ///////////
		// Load all maps.
		for ( NSDictionary* definition in loadedMaps ) {
			
			////// ///////////////// ///////////////// //////////// ///// //////////////// //////////////// //////////////// //////////////// ///////////
			// Load definitions and validate.
			NSString *name = [self validateElement:[definition objectForKey:@"name"]
										   ofClass:[NSString class] 
										withErrors:[NSArray arrayWithObjects:@"Some defined 'map' doesn't have an defined name!",
																			 @"Some defined 'map' doesn't have valid data for 'name'!", nil]];
			
			////// ///////////////// ///////////////// //////////// ///// //////////////// //////////////// //////////////// //////////////// ///////////
			NSMutableDictionary *mapDefs = [self validateElement:[definition objectForKey:@"mapDefinition"]
												  ofClass:[NSMutableDictionary class] 
											   withErrors:[NSArray arrayWithObjects:NSFormatString( @"The map '%@' doesn't have definitions!", name),
																					NSFormatString( @"The map '%@' doesn't have valid definition data!", name), nil]];
			
			////// ///////////////// ///////////////// //////////// ///// //////////////// //////////////// //////////////// //////////////// ///////////
			// Set map.
			[self addMap:mapDefs withName:name];			 
		}
	}
	
	//// //// //// //// //// //// //// //// //// //// //// //// //// //// //
	// Has Configurations?
	id loadedConf = [root objectOnPath:@"configuration/config"];
	
	if ( loadedConf ) {
		Debug( @"Loading Configurations...");
		
		/////////// ////////////////////// ////////////////////// ////////////////////// ///////////
		// If maps is an Dictionary, only ONE configuration was defined. So convert to array.
		if ( [loadedConf isKindOfClass:[NSDictionary class]] ) {
			// Convert to array.
			loadedConf = [NSArray arrayWithObject:loadedConf];
		}
		
		// Validate.
		[self validateElement:loadedConf ofClass:[NSArray class]
				   withErrors:[NSArray arrayWithObjects:[NSNull null],
							   @"'configuration' XML element contains invalid data.", nil]];
		
		/////////// ///////////
		// Load all configurations.
		for ( NSDictionary* configuration in loadedConf ) {
			[self configWithModel:[JPSyncConfigModel initWithData:configuration]];
		}
	}
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
// Load configurations from external XML file.
-(void)loadConfigurationFromXMLFile:(NSURL*)anFileURL {

	// If some error ocurr loading or parsing, will store here.
	NSError *parseError = nil;
	
	// Load and Parse.
	NSDictionary* xmlLoaded = [JPXMLParser convertFromXMLFile:anFileURL error:&parseError];
	
	// Some error? Raise exception.
	if ( parseError ) 
		[NSException raise:JPSyncManagerLoadXMLException format:@"%@", parseError];
	
	//// //// //// //// //// //// //// //// //// //// //// //// //// ////
	// Loaded Ok, let's start to process...
	[self processLoadedConfiguration:xmlLoaded];
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
-(void)configWithModel:(JPSyncConfigModel*)anModel {
	// Validate model key.
	[self validateElement:anModel.key ofClass:[NSString class]
			   withErrors:[NSArray arrayWithObjects:@"Informed model doesn't have an 'key' property defined!", [NSNull null], nil]];
	
	// Validate model map.
	[self validateElement:anModel.map ofClass:[NSString class]
			   withErrors:[NSArray arrayWithObjects:@"Informed model doesn't have an 'map' property defined!", [NSNull null], nil]];
	
	// Map exists?
	if ( ! [maps objectForKey:anModel.map] ) 
		[NSException raise:JPSyncManagerConfiguratorException format:@"Informed map '%@' isn't defined!", anModel.map];
	
	// Config.
	[configs setObject:anModel forKey:anModel.key];
}

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
-(void)setPreferedKeyOrderToProcess:(NSArray*)orderArray {
	// If Array is empty, do nothing.
	if ( ! orderArray || [orderArray count] == 0 ) 
		return;
	
	// If is the same, do nothing.
	if ( readKeyOrder == orderArray )
		return;
	
	// Dealloc and re-set, if needed.
	if( readKeyOrder ) 
		[readKeyOrder release];
	
	// Assign.
	readKeyOrder = [orderArray retain];
}


//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
-(void)addMap:(NSMutableDictionary *)anMap withName:(NSString *)anMapName {
	// Add to maps.
	[maps setObject:anMap forKey:anMapName];
}

// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Memory Management Methods. 
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
- (void) dealloc {
	[maps release], maps = nil;
	[readKeyOrder release], readKeyOrder = nil;
	[configs release], configs = nil;
	[super dealloc];
}
@end
