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


@interface JPRSSTextInputModel : NSObject {
	NSString* description;
	NSString* link;
	NSString* name;
	NSString* title;
}

/// The input form's description element holds character data that provides a human-readable label explaining the form's purpose.
@property (copy) NSString* description;

/// The input form's link element identifies the URL of the CGI script that handles the query.
@property (copy) NSString* link;

/// The input form's name element provides the name of the form component that contains the query.
@property (copy) NSString* name;

/// The input form's title element labels the button used to submit the query.
@property (copy) NSString* title;

@end






