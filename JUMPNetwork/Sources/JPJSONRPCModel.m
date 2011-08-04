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
#import "JPJSONRPCModel.h"

/////// ////// ////// ////// ////// ////// ////// ////// ////// /////// ////// ////// ////// ////// ////// ////// ////// ////// 
@implementation JPJSONRPCModel
@synthesize theId, version, result, error;

/////// ////// ////// ////// ////// ////// ////// ////// ////// /////// ////// ////// ////// ////// ////// ////// ////// ////// 
#pragma mark -
#pragma mark Init Methods.
/////// ////// ////// ////// ////// ////// ////// ////// ////// /////// ////// ////// ////// ////// ////// ////// ////// ////// 
+ (id) init {
    return [[[self alloc] init] autorelease];
}

/////// ////// ////// ////// ////// ////// ////// ////// ////// /////// ////// ////// ////// ////// ////// ////// ////// ////// 
#pragma mark -
#pragma mark Getters & Setters.
/////// ////// ////// ////// ////// ////// ////// ////// ////// /////// ////// ////// ////// ////// ////// ////// ////// ////// 
-(void)setError:(NSError *)anError {
    // No changes.
    if ( anError == error )
        return;
    
    // If exist, release.
    if ( error ) [error release];
    
    // Assign new value, retaining.
    error = [anError retain];
    
    // If is no nil, invalidate the result.
    if ( anError != nil )
        [self setResult:nil];
}

/////// ////// ////// ////// ////// ////// ////// ////// ////// /////// ////// ////// ////// ////// ////// ////// ////// ////// 
-(void)setResult:(id)anResult {
    // No changes.
    if ( anResult == result )
        return;
    
    // If exist, release.
    if ( result ) [result release];
    
    // Assign new value, retaining.
    result = [anResult retain];
    
    // If is no nil, invalidate the error.
    if ( anResult != nil )
        [self setError:nil];
}

/////// ////// ////// ////// ////// ////// ////// ////// ////// /////// ////// ////// ////// ////// ////// ////// ////// ////// 
#pragma mark -
#pragma mark Memory Methods.
/////// ////// ////// ////// ////// ////// ////// ////// ////// /////// ////// ////// ////// ////// ////// ////// ////// ////// 
- (void) dealloc
{
    [theId release];
    [version release];
    [result release];
    [error release];
    [super dealloc];
}

@end
