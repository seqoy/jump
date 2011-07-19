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

#import "JPRSSEnclosureModel.h"
#import "JPRSSGuidModel.h"
#import "JPRSSSourceModel.h"
#import "JPRSSCategoryModel.h"

@interface JPRSSItemModel : NSObject {
	NSString* author;
	NSString* comments;
	NSString* link;
	NSString* pubDate;
	NSString* title;
	NSString* description;
	
	JPRSSCategoryModel* category;
	JPRSSEnclosureModel* enclosure;
	JPRSSGuidModel* guid;
	JPRSSSourceModel* source;
}

/// An item's title element holds character data that provides the item's headline. 
@property (copy) NSString* title;

/**
 * An item's author element provides the <a href="http://www.rssboard.org/rss-profile#data-types-email">e-mail address</a> 
 * of the person who wrote the item.
 */
@property (copy) NSString* author;

/// An item's comments element identifies the URL of a web page that contains comments received in response to the item.
@property (copy) NSString* comments;

/*
 * An item's description element holds character data that contains the item's full
 * content or a summary of its contents, a decision entirely at the discretion
 * of the publisher.
 */
@property (copy) NSString* description;

/// An item's link element identifies the URL of a web page associated with the item.
@property (copy) NSString* link;

/** An item's pubDate element indicates the publication 
 * <a href=""http://www.rssboard.org/rss-profile#data-types-datetime">date and time of the item.
 */
@property (copy) NSString* pubDate;

/**
 * An JPRSSEnclosureModel object with enclosure element data that associates a media
 * object such as an audio or video file with the item.
 */
@property (retain) JPRSSEnclosureModel* enclosure;

/**
 * An JPRSSGuidModel object that provides a string that uniquely identifies the item. 
 * The guid MAY include an isPermaLink attribute.
 */
@property (retain) JPRSSGuidModel* guid;

/**
 * An JPRSSGuidModel object that indicates the fact that the item
 * has been republished from another RSS feed. 
 * The element MUST have a url attribute that identifies the URL of the source feed.
 */
@property (retain) JPRSSSourceModel* source;

/// An JPRSSCategoryModel object that identifies a category or tag to which the item belongs.
@property (retain) JPRSSCategoryModel* category;

@end








