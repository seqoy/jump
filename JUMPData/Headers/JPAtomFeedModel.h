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

#import "JPAtomCollections.h"
#import "JPAtomPersonModel.h"
#import "JPAtomCategoryModel.h"
#import "JPAtomLinkModel.h"
#import "JPAtomTextModel.h"
/// /// /// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ///
#undef JPFeedLoadException
#define JPFeedLoadException @"JPAtomFeedLoadException"

/**
 * Missing description.
 */
@interface JPAtomFeedModel : JPFeedAbstractModel {
	/////// ////// ////// ////// ////// ////// ////// ////// ////// 
	// Header elements.
	NSString				*feedId;
	NSString				*xmlns;
	NSString				*updated;
	NSString				*icon;
	NSString				*logo;
	JPAtomRightsModel		*rights;
	JPAtomTitleModel		*title;
	JPAtomTitleModel		*subtitle;

	/////// ////// ////// ////// ////// ////// ////// ////// ////// 
	JPAtomAuthorCollection				*author;
	JPAtomLinksCollection				*links;
	JPAtomEntryCollection				*entry;
	JPAtomCategoryCollection			*category;
	JPAtomContributorCollection			*contributor;
}
/////// ////// ////// ////// ////// ////// ////// ////// ////// /////// ////// ////// ////// ////// ////// ////// ////// ////// 
#pragma mark -
#pragma mark Properties.
/////// ////// ////// ////// ////// ////// ////// ////// ////// /////// ////// ////// ////// ////// ////// ////// ////// ////// 
@property (copy) NSString				*xmlns;

/** 
 * Identifies the feed using a universally unique and permanent URI.
 */
@property (copy) NSString				*feedId;

/**
 * An JPAtomTitleModel object that contains a human readable title for the feed.
 * Often the same as the title of the associated website. This value should not be blank.
 */
@property (retain) JPAtomTitleModel		*title;

/// An JPAtomTitleModel object that contains a human-readable description or subtitle for the feed. 
@property (retain) JPAtomTitleModel		*subtitle;

/// Indicates the last time the feed was modified in a significant way.
@property (copy) NSString				*updated;

/// Identifies a small image which provides iconic visual identification for the feed. Icons should be square.
@property (copy) NSString				*icon;

/// Identifies a larger image which provides visual identification for the feed. Images should be twice as wide as they are tall.
@property (copy) NSString				*logo;

/// An JPAtomRightsModel object that conveys information about rights, e.g. copyrights, held in and over the feed.
@property (retain) JPAtomRightsModel		*rights;

/// An collection (JPAtomAuthorCollection) of authors (JPAtomAuthorModel) of the entry. An feed may have multiple authors.
@property (retain) JPAtomAuthorCollection* author;

/// An collection (JPAtomLinksCollection) of links (JPAtomLinkModel) of the entry. Identifies a related Web page.
@property (retain) JPAtomLinksCollection* links;

/// An collection (JPAtomCategoryCollection) of the category. An feed may have multiple category elements.
@property (retain) JPAtomCategoryCollection* category;

/// An collection (JPAtomContributorCollection) of the contributor. An entry may have multiple contributor elements.
@property (retain) JPAtomContributorCollection* contributor;

/// An collection (JPAtomEntryCollection) of the entry. An entry may have multiple contributor elements.
@property (retain) JPAtomEntryCollection *entry;

/////// ////// ////// ////// ////// ////// ////// ////// ////// /////// ////// ////// ////// ////// ////// ////// ////// ////// 
#pragma mark -
#pragma mark Init Methods
/////// ////// ////// ////// ////// ////// ////// ////// ////// /////// ////// ////// ////// ////// ////// ////// ////// ////// 
+(JPAtomFeedModel*)initWithDictionary:(NSDictionary*)anDictionary;

@end
