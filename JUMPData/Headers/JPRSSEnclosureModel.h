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

@interface JPRSSEnclosureModel : NSObject {
	NSString* length;
	NSString* type;
	NSString* url;
}

/// The length attribute indicates the size of the file in bytes.
@property (copy) NSString* length;

/// The type attribute identifies the file's MIME media type.
@property (copy) NSString* type;

/// The url attribute identifies the URL of the file
@property (copy) NSString* url;

@end

