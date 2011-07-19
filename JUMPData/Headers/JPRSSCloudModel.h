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


@interface JPRSSCloudModel : NSObject {
	NSString* domain;
	NSString* path;
	NSString* port;
	NSString* protocol;
	NSString* registerProcedure;
	NSString* value;
}

/// The domain attribute identifies the host name or IP address of the web service that monitors updates to the feed.
@property (copy) NSString* domain;

/// The path attribute provides the web service's path.
@property (copy) NSString* path;

/// The port attribute identifies the web service's TCP port.
@property (copy) NSString* port;

/// The protocol attribute MUST contain the value "xml-rpc" if the service employs XML-RPC or "soap" if it employs SOAP.
@property (copy) NSString* protocol;

/// The registerProcedure attribute names the remote procedure to call when requesting notification of updates.
@property (copy) NSString* registerProcedure;

/*
 * The cloud element indicates that updates to the feed can be monitored 
 * using a web service that implements the <a href="http://www.rssboard.org/rsscloud-interface">RssCloud application programming interface</a>.
 */
@property (copy) NSString* value;

@end








