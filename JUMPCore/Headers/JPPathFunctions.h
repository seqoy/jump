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
 * \file JPPathFunctions.h
 * \brief Collection of convenient Macro-Functions to perform different tasks.
 */

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Path Functions. 
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 

/**
 * \def JPExistFile( anFile )
 * Return YES if exist the file on specified path.
 * @param anFile <b>NSString</b> parameter with the full path of the file.
 */
#define JPExistFile( anFile )\
\
[[NSFileManager defaultManager] fileExistsAtPath:anFile]

/**
 * Return an <b>NSString</b> with the Bundle Resources Path.
 */
#define JPBundlePath()\
\
[[NSBundle mainBundle] bundlePath]

/**
 * Return an <b>NSString</b> with the Documents Path.
 */
#define JPDocumentsPath()\
\
[NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

/**
 * Copy the specified file from the Bundle Folder to the Documents folder if needed.
 * This is useful to files thar are bundled (read-only) and needs to be modified. 
 * @param anFile <b>NSString</b> parameter with the full path of the file.
 */ 
void copyItemFromBundleToDocumentsPath( NSString* anFile );

