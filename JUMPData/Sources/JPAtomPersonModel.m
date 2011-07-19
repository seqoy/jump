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
#import "JPAtomPersonModel.h"

////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// 
#pragma mark -
@implementation JPAtomPersonModel

/////////// /////////// /////////// /////////// /////////// /////////// /////////// /////////// /////////// /////////// /////////// /////////// 
// Properties.
@synthesize name, email, uri;

////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// 
// Init Methods.
+(id)initWithName:(NSString*)anName {
	JPAtomPersonModel *instance = [[JPAtomPersonModel new] autorelease];
	
	// Load data.
	instance.name	= anName;
	
	// Return instance.
	return instance;
}

////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// 
+(id)initWithName:(NSString*)anName email:(NSString*)anMail uri:(NSString*)anUri {
	JPAtomAuthorModel *instance = [JPAtomPersonModel initWithName:anName];
	
	// Load data.
	instance.email	= anMail;
	instance.uri	= anUri;
	
	// Return instance.
	return instance;
}

////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// 
- (void) dealloc
{
	[name release];
	[email release];
	[uri release];
	[super dealloc];
}


@end


////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// 
#pragma mark -
@implementation JPAtomContributorModel
@end



////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// 
#pragma mark -
@implementation JPAtomAuthorModel
@end
