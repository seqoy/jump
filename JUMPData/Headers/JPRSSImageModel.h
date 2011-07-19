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


@interface JPRSSImageModel : NSObject {
	NSString* link;
	NSString* title;
	NSString* url;
	NSString* description;
	NSString* height;
	NSString* width;
}

/// The image's link element identifies the URL of the web site represented by the image.
@property (copy) NSString* link;

/// The image's title element holds character data that provides a human-readable description of the image.
@property (copy) NSString* title;

/// This element SHOULD have the same text as the channel's title element and be suitable for use as the alt attribute of the img tag in an HTML rendering.
@property (copy) NSString* url;

/// The image's description element holds character data that provides a human-readable characterization of the site linked to the image.
@property (copy) NSString* description;

/// The image's height element contains the height, in pixels, of the image.
@property (copy) NSString* height;

/// The image's width element contains the width, in pixels, of the image.
@property (copy) NSString* width;

@end








