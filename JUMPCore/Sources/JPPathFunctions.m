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
#import "JPPathFunctions.h"
#import "JPStringFunctions.h"
#import "JPOperatorsShortcuts.h"

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Utitly Functions. 
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 

/// /// /// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// /// /// /// /// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ///
// Copy the specified file from the Bundle Folder to the Documents folder if needed.
void copyItemFromBundleToDocumentsPath( NSString* anFile ) {
	
	// Mount Path.
	NSString *pathForBundle = NSFormatString( @"%@/%@", JPBundlePath(), anFile );
    NSString *pathForDocuments = NSFormatString( @"%@/%@", JPDocumentsPath(), anFile );
	
	// If no exist copy from Bundle.
	if ( _NOT_ [[NSFileManager defaultManager] fileExistsAtPath:pathForDocuments] ) 
		[[NSFileManager defaultManager] copyItemAtPath:pathForBundle toPath:pathForDocuments error:NULL];
}
