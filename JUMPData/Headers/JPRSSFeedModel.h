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
#import "JPFeedAbstractModel.h"

#import "JPDataPopulator.h"

#import "JPRSSCollections.h"
#import "JPRSSChannelModel.h"

/// /// /// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ///
#undef JPFeedLoadException
#define JPFeedLoadException @"JPRSSFeedLoadException"

/**
 * Missing description.
 */
@interface JPRSSFeedModel : JPFeedAbstractModel {
	NSString				*version;
	JPRSSChannelModel		*channel;
}
/////// ////// ////// ////// ////// ////// ////// ////// ////// /////// ////// ////// ////// ////// ////// ////// ////// ////// 
#pragma mark -
#pragma mark Properties.
/////// ////// ////// ////// ////// ////// ////// ////// ////// /////// ////// ////// ////// ////// ////// ////// ////// ////// 
/// This RSS feed version.
@property (copy) NSString *version;

/**
 * An JPRSSChannelModel containing the channel element, that describes the RSS feed, 
 * providing such information as its title and description, and contains items that 
 * represent discrete updates to the web content represented by the feed. 
 */
@property (retain) JPRSSChannelModel *channel;

/////// ////// ////// ////// ////// ////// ////// ////// ////// /////// ////// ////// ////// ////// ////// ////// ////// ////// 
#pragma mark -
#pragma mark Init Methods
/////// ////// ////// ////// ////// ////// ////// ////// ////// /////// ////// ////// ////// ////// ////// ////// ////// ////// 
+(JPRSSFeedModel*)initWithDictionary:(NSDictionary*)anDictionary;

@end
