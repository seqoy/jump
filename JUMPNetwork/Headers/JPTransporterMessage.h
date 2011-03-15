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
#import "JPPipelineMessageEvent.h"

/**
 * A Event which represent the fundamental information to the \ref transporter_page.
 */
@protocol JPTransporterMessage
@required

/**
 * Returns the URL to connect and communicate.
 */
-(NSURL*)transportURL;

/**
 * Data to transport.
 */
-(NSData*)dataToSend;

/**
 * Set Data to transport.
 */
-(void)setDataToSend:(NSData*)data;

@end
