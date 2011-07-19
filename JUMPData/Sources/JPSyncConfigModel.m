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
#import "JPSyncConfigModel.h"

@implementation JPSyncConfigModel

///////// ///////// ///////// ///////// ///////// ///////// ///////// ///////// 
@synthesize key, toEntity, map, deleteKey, updateKey;

//////// ////// ////// ////// ////// ////// ////// 
// Init Methods.
+(id)initWithData:(NSDictionary*)data {
	JPSyncConfigModel *instance = [self init];
	// Set data.
	instance.key		= [data objectForKey:@"key"];
	instance.toEntity	= [data objectForKey:@"toEntity"];
	instance.map		= [data objectForKey:@"map"];
	instance.deleteKey	= [data objectForKey:@"deleteKey"];
	instance.updateKey	= [data objectForKey:@"updateKey"];
	// Return.
	return instance;
}

+(id)init {
	return [[[self alloc] init] autorelease];
}

///////// ///////// ///////// ///////// ///////// ///////// ///////// ///////// 
// Set the Key, the Map Name and the Entity.
-(void)setKey:(NSString*)anDataKey map:(NSString*)anMap toEntity:(NSString*)anEntityName {
	self.key = anDataKey;
	self.map = anMap;
	self.toEntity = anEntityName;
}

///////// ///////// ///////// ///////// ///////// ///////// ///////// ///////// 
- (void) dealloc {
	[key release], key = nil;
	[toEntity release], toEntity = nil;
	[map release], map = nil;
	[deleteKey release], deleteKey = nil;
	[updateKey release], updateKey = nil;
	[super dealloc];
}

@end
