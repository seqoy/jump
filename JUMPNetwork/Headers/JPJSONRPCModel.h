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

/**
 * Missing description.
 */
@interface JPJSONRPCModel : NSObject {
    id theId;
    NSString *version;
    id result;
    NSError* error;
}

/////// ////// ////// ////// ////// ////// ////// ////// ////// /////// ////// ////// ////// ////// ////// ////// ////// ////// 
#pragma mark Properties.
/////// ////// ////// ////// ////// ////// ////// ////// ////// /////// ////// ////// ////// ////// ////// ////// ////// ////// 

/**
 * A request identifier. This member is essentially maintained for
 * backward compatibility with version 1.0 of the specification where it was used to correlate a
 * response with its request. 
 */
@property (retain) id theId;

/**
 * A String specifying the version of the JSON-RPC protocol to which the client conforms. 
 */
@property (retain) NSString *version;

/**
 * The value that was returned by the procedure upon a successful invocation. Usually is a 
 * <tt>NSDictionary</tt> but could contain other JSON Objects returned by the server.
 * This member contains <tt>nil</tt> in case there was an error invoking the procedure.
 */
@property (nonatomic,retain) id result;

/**
 * An <tt>NSError</tt> containing error information about the fault that occured before, 
 * during or after the call. This member contains <tt>nil</tt>if there was no error.
 * The JSON-RPC Meta Data about this error is stored on the <tt>userInfo</tt> dictionary, use the <tt>JPJSONRPCError...</tt> keys to
 * extract this data according to the JSON-RPC version. 
 * See <a href="http://json-rpc.org/wd/JSON-RPC-1-1-WD-20060807.html#ErrorObject">JSON-RPC 1.1 Error Object</a> definitions
 * and <a href="http://groups.google.com/group/json-rpc/web/json-rpc-2-0">JSON-RPC 2.0 Error Object</a> definitions for more info.
 */
@property (nonatomic,retain) NSError* error;

/////// ////// ////// ////// ////// ////// ////// ////// ////// /////// ////// ////// ////// ////// ////// ////// ////// ////// 
#pragma mark -
#pragma mark Init Methods.
/////// ////// ////// ////// ////// ////// ////// ////// ////// /////// ////// ////// ////// ////// ////// ////// ////// ////// 
+ (id)init;

@end
