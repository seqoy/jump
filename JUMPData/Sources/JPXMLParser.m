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
#import "JPXMLParser.h"

///////////////////////////////////////////////////////////////////////////////////////////////////
#define kElementEmpty [NSNull null]

//////// //////// //////// //////// //////// //////// //////// //////// //////// //////// //////// 
@implementation JPXMLParser
@synthesize parsedObject = _parsedObject;

//////// //////// //////// //////// //////// //////// //////// //////// //////// //////// //////// 
#pragma mark -
#pragma mark Init Methods.
//////// //////// //////// //////// //////// //////// //////// //////// //////// //////// //////// 
- (void)dealloc {
	[_parsedObject release], _parsedObject = nil;
	[super dealloc];
}

////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// 
// Starts the event-driven parsing operation.
- (BOOL)parse {
	
	// Stacks.
	_objectStack	  = [[NSMutableArray alloc] init];
	_objectStackName  = [[NSMutableArray alloc] init];
	
	// NSXMLParserDelegate is ourselves.
	self.delegate = self;
	
	// NSXMLParser parse!
	BOOL result = [super parse];
	
	// Release stacks.
	[_objectStack release], _objectStack = nil;
	[_objectStackName release], _objectStackName = nil;
	
	// Return if ok.
	return result;
}

//////// //////// //////// //////// //////// //////// //////// //////// //////// //////// //////// //////// //////// //////// //////// //////// 
#pragma mark -
#pragma mark Private Methods.
-(NSString*)cleanString:(NSString*)anString {
	return [anString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

//////// //////// //////// //////// //////// //////// //////// //////// //////// //////// //////// //////// //////// //////// //////// //////// 
#pragma mark -
#pragma mark Stack Methods.
//////// //////// //////// //////// //////// //////// //////// //////// //////// //////// //////// //////// //////// //////// //////// //////// 
-(void)popLastStackLevel {
	[_objectStack removeLastObject];
	[_objectStackName removeLastObject];
}
/////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// 
-(void)newStackLevelWithElement:(JPXMLParserElement)anElement {
	[_objectStack addObject:anElement.object];
	[_objectStackName addObject:anElement.name];
}

/////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// 
-(JPXMLParserElement)currentElement {
	return (JPXMLParserElement)
	{
		[_objectStack lastObject],
		[_objectStackName lastObject]
	};
}

/////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// /////// 
-(JPXMLParserElement)parentElement {
	// Last element index.
	int lastElementIndex = [_objectStack count]-1;
	
	// If exist, return it.
	if( [_objectStack count] > 1 ) {
		return (JPXMLParserElement)
		{
			[_objectStack objectAtIndex:lastElementIndex-1],
			[_objectStackName objectAtIndex:lastElementIndex-1]
		};
	} 
	
	// Else return empty.
	else {
		return (JPXMLParserElement) { nil, nil };
	}
}

//////// //////// //////// //////// //////// //////// //////// //////// //////// //////// //////// //////// //////// //////// //////// //////// 
#pragma mark -
#pragma mark Parse Helpers
//////// //////// //////// //////// //////// //////// //////// //////// //////// //////// //////// //////// //////// //////// //////// //////// 

-(JPXMLParserElement)startElementOfName:(NSString*)elementName {
	return (JPXMLParserElement)
	{
		[NSMutableDictionary dictionaryWithObject:kElementEmpty forKey:elementName],
		elementName
	};
}

///////// ///////// ///////// ///////// ///////// ///////// ///////// ///////// ///////// ///////// ///////// ///////// ///////// 
-(void)finishElementOfName:(NSString*)elementName {
	
	// Current element.
	JPXMLParserElement currentElement = [self currentElement];
	
	// Parent element.
	JPXMLParserElement parentElement = [self parentElement];
	
	// Value.
	id parentObjectValue = [parentElement.object objectForKey:parentElement.name];
	
	///////// ///////// ///////// ///////// ///////// ///////// /
	// Empty? Just assign value.
	if ( parentObjectValue == kElementEmpty ) {
		[parentElement.object setValue:currentElement.object forKey:parentElement.name];
	}
	
	///////// ///////// ///////// ///////// ///////// ///////// /
	// Not empty.
	else {
		
		///////// ///////// ///////// ///////// ///////// ///////// ////////// ///////// ///////// ///////// ///////// ///////// 
		// Dictionary?
		if ( [parentObjectValue isKindOfClass:[NSDictionary class]] ) {
			
			// Retrieve value.
			id parentObjectChildValue = [parentObjectValue objectForKey:elementName];
			
			///////// ///////// ///////// ///////// ////
			// Exist current key?
			if ( parentObjectChildValue ) {
				
				///// ///////// ///////// ///////// ///////////// ///////////// ////
				if ( [parentObjectChildValue isKindOfClass:[NSDictionary class]] ||		// Dictionary?
					 [parentObjectChildValue isKindOfClass:[NSString class]] )			// String?
				{
					// Convert on array.
					NSMutableArray* array = [NSMutableArray arrayWithObjects:[parentObjectValue objectForKey:elementName], 
																			 [currentElement.object objectForKey:elementName], nil];
					// Set.
					[parentObjectValue setValue:array forKey:elementName];
					
				}

				///////// ///////// ///////// ///////// ///////// ///////// ////////// ///////// ///////// ///////// ///////// ///////// /
				// Array?
				else if ( [parentObjectChildValue isKindOfClass:[NSArray class]] ) {
					// Append data.
					[parentObjectChildValue addObject:[currentElement.object objectForKey:elementName]];
				}
			}
			
			///////// ///////// ///////// ///////// ////
			// Append new data.
			else {
				[parentObjectValue addEntriesFromDictionary:currentElement.object];
			}
		}
	}
}

///////// ///////// ///////// ///////// ///////// ///////// ///////// ///////// ///////// ///////// ///////// ///////// 
-(id)appendCharacters:(NSString*)characters toObject:(id)currentValue {
	
	// If isn't defined yet or is empty: Init as string.
	if (nil == currentValue || currentValue == kElementEmpty) {
		currentValue = @"";
	}
	
	return [currentValue stringByAppendingString:characters];
}

//////// //////// //////// //////// //////// //////// //////// //////// //////// //////// //////// //////// //////// //////// //////// //////// 
#pragma mark -
#pragma mark NSXMLParser Delegate Events.
//////// //////// //////// //////// //////// //////// //////// //////// //////// //////// //////// //////// //////// //////// //////// //////// 
// Sent by a parser object to its delegate when it encounters a start tag for a given element.
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
	
	// Create new element and Add to stacks.
	[self newStackLevelWithElement:[self startElementOfName:elementName]];
	
	// Set all attributes.
	for (id key in attributeDict) {
		
		// Attributes are parsed as any normal element.
		[self newStackLevelWithElement:[self startElementOfName:key]];
		[self parser:parser foundCharacters:[attributeDict objectForKey:key]];
		[self parser:parser didEndElement:key namespaceURI:namespaceURI qualifiedName:qualifiedName];
	}
}


//////// //////// //////// //////// //////// //////// //////// //////// //////// //////// //////// //////// //////// //////// //////// ////////  
// Sent by a parser object to provide its delegate with a string representing all or part of the characters of the current element.
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)anString {
	
	// Only append if has some data.
	NSString *characters = [self cleanString:anString];
	if ( [characters isEqualToString:@""] ) 
		return;
	
	// Current element.
	JPXMLParserElement currentElement = [self currentElement];
	
	// Current value.
	id currentValue = [currentElement.object objectForKey:currentElement.name];
	
	// String or Null??
	if ( [currentValue isKindOfClass:[NSString class]] || currentValue == kElementEmpty) {
		
		// Append data.
		[currentElement.object setObject:[self appendCharacters:characters toObject:currentValue] 
								  forKey:currentElement.name];
		
	}
	
	// Dictionary?
	else {
		id someValue = [currentValue objectForKey:currentElement.name];
		[currentValue setObject:[self appendCharacters:characters toObject:someValue]
						 forKey:currentElement.name];
	}
	
}

//////// //////// //////// //////// //////// //////// //////// //////// //////// //////// //////// //////// //////// //////// //////// ////////  
// Sent by a parser object to its delegate when it encounters an end tag for a specific element.
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	
	// Somethign to finish?
	if ( [_objectStack count] > 1 ) 
		[self finishElementOfName:elementName];
	
	// Last element.
	if ([_objectStack count] == 1) {
		[_parsedObject release], _parsedObject = nil;
		_parsedObject = [[_objectStack lastObject] retain];
	}
	
	// Now that we've finished a node, let's step back up the tree.
	[self popLastStackLevel];
}


//////// //////// //////// //////// //////// //////// //////// //////// //////// //////// //////// //////// //////// //////// //////// ////////  
// Sent by a parser object to its delegate when it encounters a fatal error.
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
	NSLog(@"Error parsing the XML: %@", [parseError localizedDescription]);
}

//////// //////// //////// //////// //////// //////// //////// //////// //////// //////// //////// 
#pragma mark -
#pragma mark Process Methods.
//////// //////// //////// //////// //////// //////// //////// //////// //////// //////// //////// 
+ (NSDictionary *)convertFromXMLData:(NSData *)data error:(NSError **)error {
	
	/////// //////// //////// //////// //////// //////// //////// //////// 
	// If doesn't have data.
	if ( data == nil ) {
        [NSException raise:@"JPXMLReaderException" format:@"Can't process NULL data."];
        return nil;
    }
		
	/////// //////// //////// //////// //////// //////// //////// //////// 
	// Init.
	JPXMLParser *parserInstance = [[JPXMLParser alloc] initWithData:data];
	
	// Process.
	BOOL success = [parserInstance parse];

    // Will autorelease the parser later.
	[parserInstance autorelease];
	
	// If some error.
	if ( !success && [parserInstance parserError]) {
		*error = [parserInstance parserError];
		return nil;
	}

	// If ok, return processed...
    return [parserInstance parsedObject];
}
//////// //////// //////// //////// //////// //////// //////// //////// //////// //////// //////// 
+ (NSDictionary *)convertFromXMLFile:(NSURL *)fileURL error:(NSError **)error {

	//////// //////// //////// //////// //////// ////////// //////// //////// //////// //////// //
    // Correct mapping around iOS versions.
    NSUInteger mapping;
    #if __IPHONE_4_0 && __IPHONE_4_0 <= __IPHONE_OS_VERSION_MAX_ALLOWED
        mapping = NSMappedRead;
    #else
        mapping = NSDataReadingMapped;
    #endif
    
	/////// //////// //////// //////// //////// //////// /////// //////// //////// /////// //////// //////// /////// //////// //////// //////// //////// 
	// Data from file. The data readed will be cached.
    NSData *data = [NSData dataWithContentsOfFile:[fileURL path] options:mapping error:error];
	
	/////// //////// //////// //////// //////// //////// //////// //////// 
	// If don't have data or some error ocurr.
	if ( data == nil || *error != nil ) 
		[NSException raise:@"JPXMLReaderException" format:@"Can't retrieve data from file: %@.\nPossible reason: %@", fileURL, [*error localizedDescription]];
	
	// Process it.
	return [JPXMLParser convertFromXMLData:data error:error];
}

//////// //////// //////// //////// //////// //////// //////// //////// //////// //////// //////// 
+ (NSDictionary *)convertFromXMLString:(NSString *)string error:(NSError **)error {
	
	// If doesn't have data.
	if ( string == nil ) 
		[NSException raise:@"JPXMLReaderException" format:@"Can't process NULL String."];
	
	NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    return [JPXMLParser convertFromXMLData:data error:error];
}



@end
