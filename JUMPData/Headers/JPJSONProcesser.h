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
#import "SBJson.h"
#import "JPDataProcessserJSON.h"

/**
 * Default implementation of the <b>JPDataProcessserJSON</b> protocol. This header is part of the
 * <b>JUMP Network module</b>, check the documentation of this module to learn more about it.
 * This class is an wrapper to the <b>JSON Framework from Stig's</b>: https://github.com/stig/json-framework
 * and is included with this module.
 */
@interface JPJSONProcesser : NSObject <JPDataProcessserJSON> {}
@end


/**
 JSON Framework - https://github.com/stig/json-framework
 Copyright (C) 2009-2010 Stig Brautaset. All rights reserved.

 See JSON.h file for more information about copyright and distribution.
 */