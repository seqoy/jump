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

/**
 * \file JPStringFunctions.h
 * Collection of convenient Macro-Functions that are shortcut to NSString methods.
 */


/**
 * Create an autoreleseable NSString with defined format. 
 * This function is one shortcut to the <b>[NSString stringWithFormat:]</b> method.
 */
#define NSFormatString( __stringValue, ... ) ( [NSString stringWithFormat:__stringValue, ##__VA_ARGS__] )

/**
 * Remove empty spaces on both side of one <b>NSString</b>.
 */
#define NSAllTrim( __Object__ ) [__Object__ stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet] ]

/**
 * Remove empty spaces on both side of one <b>NSString</b>.
 */
#define NSTrim( __Object__ ) NSAllTrim( __Object__ )


