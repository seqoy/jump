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
#import "JPAtomTextModel.h"

// Weak referecend.
@class JPAtomLinksCollection, JPAtomAuthorCollection, JPAtomCategoryCollection, JPAtomContributorCollection;

// Interface.
@interface JPAtomEntryModel : NSObject {
	NSString* entryId;
	NSString* updated;
	NSString* published;

	JPAtomContentModel* content;
	JPAtomSummaryModel* summary;
	JPAtomTitleModel* title;

	JPAtomLinksCollection *link;
	JPAtomAuthorCollection *author;
	JPAtomCategoryCollection *category;
	JPAtomContributorCollection *contributor;
}

/// Identifies the entry using a universally unique and permanent URI. 
@property (copy) NSString* entryId;

/// Indicates the last time the entry was modified in a significant way.
@property (copy) NSString* updated;

/// Contains the time of the initial creation or first availability of the entry.
@property (copy) NSString* published;

/// An JPAtomTitleModel object that contains a human readable title for the entry. This value should not be blank.
@property (retain) JPAtomTitleModel* title;

/// An JPAtomSummaryModel object that identifies the category.
@property (retain) JPAtomSummaryModel* summary;

/*
 * An JPAtomContentModel object that conveys a short summary, abstract, or excerpt of the entry.
 * Summary should be provided if there either is no content provided for the entry, 
 * or that content is not inline (i.e., contains a src attribute), 
 * or if the content is encoded in base64. More info <a href="http://www.atomenabled.org/developers/syndication/#link">here</a>.
 */
@property (retain) JPAtomContentModel* content;

/// A list of links (JPAtomLinkModel) of the entry. Identifies a related Web page.
@property (retain) JPAtomLinksCollection* link;

/// A list of authors (JPAtomAuthorModel) of the entry. An entry may have multiple authors.
@property (retain) JPAtomAuthorCollection* author;

/// A list of categories (JPAtomCategoryModel) of the entry. An entry may have multiple category elements.
@property (retain) JPAtomCategoryCollection* category;

/// A list of contributors (JPAtomContributorModel) of the entry. An entry may have multiple contributor elements.
@property (retain) JPAtomContributorCollection* contributor;


@end
