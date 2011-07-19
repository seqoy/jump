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
#import <Foundation/Foundation.h>

//////// ////// ////// ////// ////// ////// ////// 
@interface JPSyncConfigModel : NSObject {
	NSString *key;
	NSString *map;
	NSString *toEntity;
	NSString *deleteKey;
	NSString *updateKey;
}

//////// ////// ////// ////// ////// ////// ////// 
// Properties.
@property(copy) NSString *key;
@property(copy) NSString *map;
@property(copy) NSString *toEntity;
@property(copy) NSString *deleteKey;
@property(copy) NSString *updateKey;

//////// ////// ////// ////// ////// ////// ////// 
// Init Methods.
+(id)initWithData:(NSDictionary*)data;
+(id)init;

/**
 * Set the Key, the Map Name and the Entity.
 */
-(void)setKey:(NSString*)anDataKey map:(NSString*)anMap toEntity:(NSString*)anEntityName;

@end
