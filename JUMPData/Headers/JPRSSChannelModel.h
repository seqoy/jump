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

#import "JPRSSCategoryModel.h"
#import "JPRSSCloudModel.h"
#import "JPRSSImageModel.h"
#import "JPRSSTextInputModel.h"

#import "JPRSSCollections.h"

/**
 * Missing description.
 */
@interface JPRSSChannelModel : NSObject {
	NSString *description;
	NSString *link;
	NSString *title;
	NSString *copyright;
	NSString *docs;
	NSString *generator;
	NSString *language;
	NSString *lastBuildDate;
	NSString *managingEditor;
	NSString *pubDate;
	NSString *rating;
	NSString *ttl;
	NSString *webMaster;

	/////// ////// 
	JPRSSCategoryModel				*category;
	JPRSSCloudModel					*cloud;
	JPRSSImageModel					*image;
	JPRSSTextInputModel				*textInput;

	/////// ////// 
	JPRSSSkipDaysCollection			*skipDays;
	JPRSSSkipHoursCollection		*skipHours;
	
	/////// ////// 
	JPRSItemCollection			*item;
}
/////// ////// ////// ////// ////// ////// ////// ////// ////// /////// ////// ////// ////// ////// ////// ////// ////// ////// 
#pragma mark -
#pragma mark Properties.
/////// ////// ////// ////// ////// ////// ////// ////// ////// /////// ////// ////// ////// ////// ////// ////// ////// ////// 

/// The description element holds character data that provides a human-readable characterization or summary of the feed.
@property (copy) NSString				*description;

/// The link element identifies the URL of the web site associated with the feed.
@property (copy) NSString				*link;

/// The title element holds character data that provides the name of the feed (REQUIRED).
@property (copy) NSString				*title;

/// The copyright element declares the human-readable copyright statement that applies to the feed.
@property (copy) NSString				*copyright;

/// The docs element identifies the URL of the RSS specification implemented by the software that created the feed.
@property (copy) NSString				*docs;

/// The generator element credits the software that created the feed.
@property (copy) NSString				*generator;

/// The channel's language element identifies the natural language employed in the feed.
@property (copy) NSString				*language;

/// The channel's lastBuildDate element indicates the last date and time the content of the feed was updated.
@property (copy) NSString				*lastBuildDate;

/// The channel's managingEditor element provides the e-mail address of the person to contact regarding the editorial content of the feed.
@property (copy) NSString				*managingEditor;

/// The channel's pubDate element indicates the publication date and time of the feed's content.
@property (copy) NSString				*pubDate;

/// The channel's ttl element represents the feed's time to live (TTL): the maximum number of minutes to cache the data before an aggregator requests it again.
@property (copy) NSString				*ttl;

/// The channel's webMaster element provides the e-mail address of the person to contact about technical issues regarding the feed (OPTIONAL).
@property (copy) NSString				*webMaster;

/**
 * The channel's rating element supplies an advisory label for the content in a feed, formatted according 
 * to the specification for the <a href="http://www.w3.org/PICS">Platform for Internet Content Selection (PICS)</a>.
 */
@property (copy) NSString				*rating;

/**
 * This element contains an JPRSSSkipDaysCollection that identifies a category or tag to which the feed belongs.
 */
@property (retain) JPRSSCategoryModel *category;

/**
 * The JPRSSCloudModel object contains an cloud element indicates that updates to the feed can be monitored using 
 * a web service that implements the <a href="http://www.rssboard.org/rsscloud-interface">RssCloud application programming interface</a>. 
 */
@property (retain) JPRSSCloudModel *cloud;

/**
 * The textInput element defines a form to submit a text query to the feed's publisher over the Common Gateway Interface (CGI).
 */
@property (retain) JPRSSTextInputModel *textInput;

/// An JPRSSImageModel that contains the data for the image element. The image element supplies a graphical logo for the feed.
@property (retain) JPRSSImageModel		*image;

/**
 * The channel's skipDays element identifies days of the week during which the feed is not updated.
 * This element contains an JPRSSSkipDaysCollection object with up to seven day elements identifying the days to skip.
 */
@property (retain) JPRSSSkipDaysCollection *skipDays;

/**
 * The channel's skipHours element identifies the hours of the day during which the feed is not updated.
 * This element contains an JPRSSSkipDaysCollection object with individual hour elements identifying the hours to skip. 
 */
@property (retain) JPRSSSkipHoursCollection *skipHours;

/**
 * An item element represents distinct content published in the feed such 
 * as a news article, weblog entry or some other form of discrete update. 
 * JPRSItemCollection contains an collection JPRSSItemModel itens.
 */
@property (retain) JPRSItemCollection *item;

@end
